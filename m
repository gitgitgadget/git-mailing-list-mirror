From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Convert 'git blame' to parse_options()
Date: Sun, 22 Jun 2008 23:35:02 -0700
Message-ID: <7vr6aoirqh.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 08:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAfet-00058N-Bs
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 08:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbYFWGfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 02:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbYFWGfR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 02:35:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbYFWGfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 02:35:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 439E420402;
	Mon, 23 Jun 2008 02:35:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AD3D820400; Mon, 23 Jun 2008 02:35:09 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 22 Jun 2008 22:15:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 88CEEBFE-40EE-11DD-9AA5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85838>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That builtin-blame option parsing is really ugly,...

Yeah, but wasn't it because it needed to be compatible with both annotate
syntax and rev-list style "range" notation at the same time?

> +static int blame_bottomtop_callback(const struct option *option, const char *arg, int unset)
> +{
> +	const char **bottomtop = option->value;
> +	if (!arg)
> +		return -1;
> +	if (*bottomtop)
> +		die("More than one '-L n,m' option given");
> +	*bottomtop = arg;
> +	return 0;
> +}

Hmmmm.  I actually wanted to eventually allow more than one -L so that we
can blame two functions inside a file, for example.  Would this make it
even harder, I have to wonder...
