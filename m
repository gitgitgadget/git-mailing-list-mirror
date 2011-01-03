From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-daemon serving repos with repo.git/git-daemon-export-ok
Date: Mon, 3 Jan 2011 17:55:01 -0600
Message-ID: <20110103235501.GA32262@burratino>
References: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org>
 <4D224475.1090805@ecosensory.com>
 <20110103231153.GA10733@burratino>
 <4D225DFA.50805@ecosensory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Griessen <john@ecosensory.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 00:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZuFI-00088u-Gc
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 00:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861Ab1ACXzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 18:55:18 -0500
Received: from mail-yx0-f194.google.com ([209.85.213.194]:57317 "EHLO
	mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1ACXzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 18:55:17 -0500
Received: by yxd5 with SMTP id 5so3300307yxd.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 15:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kQjGTjzYwk6PYbagpD03euRCYp3XVkARTvKgEsYJ7JI=;
        b=o7P2PJmKhi8cPjjaJj0KorEWAj4imD00Dj/UBqbUPjbu+4VwSy4aqvcl9FBszALiiq
         D9rowk8PDeIxeTGaQTzYMHIQNMNLsYoCY2ejsBI6TSizc3/Y8sF4H1a9erb4NVHwiEOG
         7o2GV+hA5igWB3dnY2nMQ6IweCKeYIcVt1rb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AQV+IxincR7BJLD7jB9vw5wHLVBPj8ZzXefHTGvmb/Z6lPZL9nVxLwAG7f5yqU2DSk
         V8Ow2GW+jFJ9L096X99dsfJ8XupPNnL0joIOMskKpv1S0RoRYXz9qG1fymT2IQDyS4Qq
         ebgUvgHaauP+DlKQKjLuPDi7sTlx/yMkCfhUs=
Received: by 10.91.11.11 with SMTP id o11mr13204632agi.131.1294098916638;
        Mon, 03 Jan 2011 15:55:16 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id c34sm28746890anc.10.2011.01.03.15.55.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 15:55:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D225DFA.50805@ecosensory.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164464>

John Griessen wrote:

> git version 1.7.2.3

Good.

> vking@mail:/etc/sv$ sv stat git-daemon
> fail: git-daemon: unable to change to service directory: file does not exist

Ah, you switched to running git daemon directly.

> I can push to these repos with gitosis, and the permissions are:
>
> vking@mail:/srv/gitosis/repositories$ ll
> total 16
> drwxr-xr-x 7 gitosis gitosis 4096 Dec 30 12:32 extrudator.data.git

So the gitdaemon user (used by git-daemon-run) wouldn't be able to
access them.

> vking@mail:/etc/sv$ cat strace.out
> execve("/usr/lib/git-core/git-daemon",
> ["/usr/lib/git-core/git-daemon", "--verbose", "--strict-paths",
> "--user=git", "--group=gitosis", "/srv/gitosis/repositories"], [/*
> 10 vars */]) = 0

In this case simple --verbose output would probably be more useful.
(That's what cat-ing /var/log/git-daemon/current would have given
if git-daemon-run were still installed.)

Thanks for the strace.  I should have mentioned that strace -f can
help by following child processes, though that doesn't seem to be
an issue here.  It looks like another git-daemon process is running at
the same time?  (One can check with "netstat -t -a".)
