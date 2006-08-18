From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC diff-tree -c with copy/rename]
Date: Thu, 17 Aug 2006 21:09:16 -0700
Message-ID: <7v3bbuelcj.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550608170402w25b9eaeaqe69665bdddaead3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 06:09:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDvfh-0002KC-PD
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 06:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWHREJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 00:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWHREJT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 00:09:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41699 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030400AbWHREJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 00:09:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818040916.GHJZ6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 00:09:16 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25624>

"Marco Costalba" <mcostalba@gmail.com> writes:

> As example
>
> 'R093MM	checkout-index.c builtin-checkout-index.c'
>
> instead of current
>
> 'RM	builtin-checkout-index.c'

I am not particularly opposed to have an option to do this.  I
originally did not show this because I did not particularly find
it interesting (and I still don't).  The output would become a
very long line, not for human consumption, though.

But it should not be too involved if you want to do this.  We
already compute all the information necessary to do so before
combine-diff.c::intersect_paths() converts the usual <from,to>
representation (struct diff_filepair) into <result, list of
parents' blobs> representation (struct combine_diff_path), which
is used by combine-diff.c routines.

We currently do not retain that information when this conversion
happens to be used for the output.  You would need to add a few
fields to record the preimage filename, similarity score and
status in struct combine_diff_parent and populate them in
intersect_paths() and adjust the output routines.
