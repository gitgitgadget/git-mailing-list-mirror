From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Tue, 8 Feb 2011 19:28:41 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102081916330.9042@debian>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com> <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com> <alpine.DEB.2.00.1102081320350.4475@debian> <20110208220505.GA17981@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 01:29:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmxvW-0003yO-3S
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 01:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab1BIA2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 19:28:49 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57733 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1BIA2s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 19:28:48 -0500
Received: by vxb37 with SMTP id 37so2886444vxb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 16:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=SZ709hZMokW+020aIFjO/CkN58RemYi/P+PIAZsYhWo=;
        b=M8o7ZTpYZ2TkajiQhm9Fza0ob9Q/fUL5C6sRS71ld/9ERUvVpTGjqPNLtdP5dq8hFt
         rXWswix/4SBD5dJkm3vVGn5pRXyN3e7d8X9eMy4XLgyLkaoUvH6XPbreJDgptLoucSYq
         iRMk0xlTlX9qQ1ckAwZ57LbaUPvHMfpDUITzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=gXhtYNacGCaMudzPPT+hSewCPCRKpTCITiAy9+/V5HognAAkQPm7NHXU6xCJrMfwno
         lRTRPQwap1mQ4boPlSQcOESnVU7Qurlc5Wk1kLkUc8yZji3I5Q25pyga52k9gul7epwy
         9rBur+SMVLWyOQUBs0oNlak0UUU9qWY6yDM5o=
Received: by 10.220.202.134 with SMTP id fe6mr4754262vcb.245.1297211327587;
        Tue, 08 Feb 2011 16:28:47 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e18sm60634vbm.5.2011.02.08.16.28.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 16:28:46 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20110208220505.GA17981@elie>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166381>

On Tue, 8 Feb 2011, Jonathan Nieder wrote:

> Martin von Zweigbergk wrote:
> > On Tue, 8 Feb 2011, Sverre Rabbelier wrote:
> 
> >> I particularly like that you explain to the user clearly what they
> >> have to do to make this work (e.g., configure the upstream). Nice.
> >
> > Thanks, but that was stolen from git-pull.sh ;-)
> 
> Doesn't that suggest it might belong in some common git-upstream--lib.sh
> (or git-sh-setup.sh)?

Maybe it does... For comparison, I pasted the two sections below.

git-rebase.sh (after my patch):

	if test -z "$branch_name"
	then
		die "You are not currently on a branch, so I cannot use any
'branch.<branchname>.merge' in your configuration file.
Please specify which upstream branch you want to use on the command
line and try again (e.g. 'git rebase <upstream branch>').
See git-rebase(1) for details."
	else
		die "You asked me to rebase without telling me which branch you
want to rebase against, and 'branch.${branch_name#refs/heads/}.merge' in
your configuration file does not tell me, either. Please
specify which branch you want to use on the command line and
try again (e.g. 'git rebase <upstream branch>').
See git-rebase(1) for details."
	fi

git-pull.sh:

	elif [ -z "$curr_branch" ]; then
		echo "You are not currently on a branch, so I cannot use any"
		echo "'branch.<branchname>.merge' in your configuration file."
		echo "Please specify which remote branch you want to use on the command"
		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
		echo "See git-pull(1) for details."
	elif [ -z "$upstream" ]; then
		echo "You asked me to pull without telling me which branch you"
		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' in"
		echo "your configuration file does not tell me, either. Please"
		echo "specify which branch you want to use on the command line and"
		echo "try again (e.g. 'git pull <repository> <refspec>')."
		echo "See git-pull(1) for details."
		echo
		echo "If you often $op_type $op_prep the same branch, you may want to"
		echo "use something like the following in your configuration file:"
		echo
		echo "    [branch \"${curr_branch}\"]"
		echo "    remote = <nickname>"
		echo "    merge = <remote-ref>"
		test rebase = "$op_type" &&
			echo "    rebase = true"
		echo
		echo "    [remote \"<nickname>\"]"
		echo "    url = <url>"
		echo "    fetch = <refspec>"
		echo
		echo "See git-config(1) for details."


I had forgotten that I trimmed the last part of it. Maybe I should
have also included that? Then it would make even more sense to extract
this piece of code.


/Martin
