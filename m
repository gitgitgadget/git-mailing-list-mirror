From: "Morten Welinder" <mwelinder@gmail.com>
Subject: git-annotate efficiency
Date: Fri, 24 Feb 2006 10:37:10 -0500
Message-ID: <118833cc0602240737i42acdc90sb8f93dde1a1bc035@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Feb 24 16:37:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCf0O-0003HA-8i
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 16:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWBXPhM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 10:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWBXPhM
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 10:37:12 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:52811 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932275AbWBXPhL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 10:37:11 -0500
Received: by pproxy.gmail.com with SMTP id n25so407960pyg
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 07:37:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sGAMtNk1RLcStIZrzX35FFKMLM6RiAb+GhOceKw98kRk4a3P3UStT+p0eZAOZumngQUZt7N+uSqlGjL6H31bnYwXDG7jGX3A2RR0v1dJYT4otQXd707uCc1u+timZF+jeeq3IBC2Vdlg8h7NHhBMlZty6Q1dmEcbeuH3NvWkS6E=
Received: by 10.35.91.10 with SMTP id t10mr227465pyl;
        Fri, 24 Feb 2006 07:37:10 -0800 (PST)
Received: by 10.35.39.13 with HTTP; Fri, 24 Feb 2006 07:37:10 -0800 (PST)
To: "GIT Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16708>

So I wanted to give git-annotate a spin and typed...

    git annotate Makefile

Bad idea.  It's been ten minutes and no output yet.  While the script only
appears to use ~20% of cpu according to top, an strace shows that it
spins off a huge number of very short-lived subprocesses.

Morten




...
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
waitpid(1539, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 1539
--- SIGCHLD (Child exited) @ 0 (0) ---
rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, NULL, 8) = 0
pipe([3, 4])                            = 0
pipe([5, 6])                            = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x401db708) = 1540
close(6)                                = 0
close(4)                                = 0
read(5, "", 4)                          = 0
close(5)                                = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfffc718) = -1 EINVAL
(Invalid argument)
_llseek(3, 0, 0xbfffc760, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
read(3, "diff --git a/Makefile b/Makefile"..., 4096) = 63
read(3, "--- a/Makefile\n+++ b/Makefile\n@@"..., 4096) = 203
--- SIGCHLD (Child exited) @ 0 (0) ---
read(3, "", 4096)                       = 0
close(3)                                = 0
rt_sigaction(SIGHUP, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
...
