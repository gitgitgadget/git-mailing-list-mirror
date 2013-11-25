From: Heikki Hokkanen <hoxu@users.sf.net>
Subject: Re: [PATCH] bash prompt: add option to disable for a repository
Date: Mon, 25 Nov 2013 18:38:56 +0200
Message-ID: <CAOpY_XvKkdU+2uxj3K4ZgTq+6qniLYH=bwbQZ6jyrDM7+dZAxg@mail.gmail.com>
References: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
	<20131123163559.GB13824@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Nov 25 17:39:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkzBf-0008CX-7y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 17:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165Ab3KYQi7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 11:38:59 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:35837 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757142Ab3KYQi6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 11:38:58 -0500
Received: by mail-bk0-f43.google.com with SMTP id mz12so2081433bkb.2
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=uolSpxK7J17Ygjmt507DN3c7T1nq4dZbUgCcRC6NFKA=;
        b=B1BPFi8g+INmHQEu+eyvUm5mxZ6Q79ZymVOFskgEd7UFXE0t0j7nAi4c/0v/MhqBYx
         5VamO7/NDd+eFUoZNiPzIoUwA2s++c+Yepk69XOYbN0j/Asbcx/7x1VlFG2uwj5smwZb
         jmCfnbi6GMCePhlPUgjwsar7XUa8jmXT06X3sKsSV/MxO4SkU92Gh1RXYE/bISFi3oNn
         lCKpDUOszpr2zgNOgj+y2Q7xEoK+EwdusCC8SX1GFL26fnoVEwktecp3neCZhl7UxgQR
         712VWZL6q7/vLrr4hv4cWzCjbuc5hYFGHheJQRi3EvydtPWWbc8BJsne21dCcSckG4fL
         8ssA==
X-Received: by 10.204.100.193 with SMTP id z1mr1879985bkn.53.1385397537014;
 Mon, 25 Nov 2013 08:38:57 -0800 (PST)
Received: by 10.205.4.6 with HTTP; Mon, 25 Nov 2013 08:38:56 -0800 (PST)
In-Reply-To: <20131123163559.GB13824@goldbirke>
X-Google-Sender-Auth: EBujlILRwgt7eRcId44PgIDb5us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238322>

Hello,

On Sat, Nov 23, 2013 at 6:35 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Hm, strange.  I wonder what can cause performance problems in big
> repositories.
>
> Sure, there are status indicators that can be expensive, in particula=
r
> the indicators for dirty index/worktree, untracked files, and
> divergence from upstream.  However, these must be enabled globally by
> environment variables and even then can already be disabled on a
> per-repo basis by configuration variables.  And the rest of the promp=
t
> code should perform pretty much independently from the repository
> size.

You are right. The performance issue seems to be indeed fixed by settin=
g
bash.showDirtyState and bash.showUntrackedFiles to false. And I feel a
bit stupid for not realizing those were the only reason :)

Now the only remaining issue for me is that I wouldn't like to see git
prompt under the home directory repository, because then it's turned
on pretty much everywhere.

> I spent quite some time eliminating fork()s and exec()s from the
> prompt, so a fork() for the command substitution's subshell and a
> fork()+exec() for running a git command in the main code path saddens
> me deeply ;)

Seeing how the dirty state/untracked files/upstream configs are
implemented, I'm thinking, what if "bash.prompt" setting was checked
similarly only when something like GIT_PS1_PERREPOBASIS was set?

It would keep the default execution path free from added forks, but
still allow people to disable git prompt on a per-repository basis.

Regards,

--=20
Heikki Hokkanen
