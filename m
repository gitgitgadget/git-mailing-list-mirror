From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Mon, 25 May 2009 23:12:15 -0700
Message-ID: <7vr5ycqtog.fsf@alter.siamese.dyndns.org>
References: <1243316165-99065-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 08:12:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8pto-0002ek-8F
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 08:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbZEZGMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 02:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbZEZGMP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 02:12:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46298 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbZEZGMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 02:12:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090526061215.RXJF20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 May 2009 02:12:15 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id w6CF1b0014aMwMQ046CFtY; Tue, 26 May 2009 02:12:15 -0400
X-Authority-Analysis: v=1.0 c=1 a=g2Kvswfn6DYA:10 a=VsK4u529S6UA:10
 a=pGLkceISAAAA:8 a=I3zk1-lpvWoYkjb_qu8A:9 a=JqJ7JJWTQ4R_GZUCyQ-NoevIc6cA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1243316165-99065-1-git-send-email-davvid@gmail.com> (David Aguilar's message of "Mon\, 25 May 2009 22\:36\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119997>

David Aguilar <davvid@gmail.com> writes:

> Naturally, prep_temp_blob() did not care about filenames.
> As a result, scripts that use GIT_EXTERNAL_DIFF ended up
> with filenames such as ".diff_XXXXXX".
>
> This specializes the GIT_EXTERNAL_DIFF code to generate
> prettier filenames.
>
> Diffing "name.ext" now generates "name.XXXX.ext".
> Diffing files with no extension now generates "name_XXXX".
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>
> I renamed a few variables and unrolled the inner loop in
> git_mkstemps() since the last patch to make things easier to read/review.

Thanks.

I actually think using mkstemps() where the function is natively
available, and using compat/mkstemps.c implementation where it is not, is
a saner approach.

It would make the implementation of git_mkstemps() easier to read, because
the interface to mkstemps(), even though it may not be in POSIX (nor in
glibc), is a well known quantity and people do not need to follow into its
implementation when they want to follow the logic of higher level code.
