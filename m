From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sat, 5 May 2012 10:54:23 -0500
Message-ID: <20120505155423.GA14684@burratino>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 17:54:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQhJj-0007Er-TF
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 17:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab2EEPye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 11:54:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44862 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107Ab2EEPyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 11:54:33 -0400
Received: by yhmm54 with SMTP id m54so3507199yhm.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+R4e6kDoo5VUwCAyOcGIN+HpERAl0zBhxdXVTuCJ8o4=;
        b=VgQsIASeO+5xPVCUSaZcj7s1ko2i/U9t7Z1wlaaEaYBaqA3yuYmXBLGHXm7W5+2J4o
         des+O7OURfB5d0WD/h4kHw3VN7r+KgkwlQBmOWe+7FxUZby504oGXhnuGmRzK+fpnahw
         plyxSSgZWuGMy2BiacTV+0rfO70z+jSm9WBirW3t3mtQ/FXVp0DUrCi8AnN88sDSB7I1
         JD6CdYpFJSVjYzanysv1vquFtCfsgxUAZxjt+vOl3sqU77FCmlyHCLfboDZQPf8xT5J2
         SM2hziQSomLJgugsoxcxmtwrewMGIFk4AUhlZKCu5ItOTY3+44SzfoblE+Vlxb90Hz7N
         a18w==
Received: by 10.50.183.137 with SMTP id em9mr4720907igc.58.1336233272670;
        Sat, 05 May 2012 08:54:32 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vp3sm3274289igb.3.2012.05.05.08.54.31
        (version=SSLv3 cipher=OTHER);
        Sat, 05 May 2012 08:54:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197119>

=46elipe Contreras wrote:

> Since v3:
>
>  * Rename to _GIT_complete to follow bash completion "guidelines"
>  * Get rid of foo_wrap name

Thanks.  G=C3=A1bor, does the "all caps _GIT_ prefix for public API
functions" convention look like one we should adopt?  If I understand
correctly, previously contrib/completion/git-completion.bash used
leading double underscores for everything except completion functions,
so this is a change.

=46ollowing a convention similar to the bash-completion project's
proposed future convention doesn't really help compatibility.  If we
want to be able to include this function in that project without
change some day, we'd have to call it _BC_git_complete. :)

I personally would be happier with a git_complete function provided
by another script, like this:

	contrib/completion/git-completion.bash:

		__git_complete () {
			...
		}

	contrib/completion/bash-helpers.bash:

		git_complete () {
			__git_complete "$@"
		}

One might object that if the user includes bash-helpers.bash (name is
just a strawman) in .bashrc for interactive shells because he is
defining some custom completion functions,

	git<TAB>

would show the git_complete function.  I think that's fine.  Maybe
the user would enjoy the reminder.  git<TAB> also shows any
dashed-form git commands that happen to be on the $PATH.

Please don't take this as a strong objection.  Maybe the
user-unfriendly version would be called _GIT_complete and someone
interested can provide the friendly git_complete and git_ps1 wrappers
separately, for example.  I just think it is worth thinking carefully
and being consistent about.

Hope that helps,
Jonathan
