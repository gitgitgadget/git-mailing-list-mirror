From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-daemon whitelist issue
Date: Mon, 26 May 2008 11:06:11 +0200
Message-ID: <483A7D83.2000501@op5.se>
References: <4838208A.6020205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jose Luis Rivas Contreras <ghostbar38@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 11:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Yfb-0002mD-BN
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 11:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYEZJGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 05:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYEZJGQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 05:06:16 -0400
Received: from mail.op5.se ([193.201.96.20]:43010 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbYEZJGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 05:06:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 125C41B80BFB;
	Mon, 26 May 2008 11:04:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tb3qaDkNEq2d; Mon, 26 May 2008 11:04:11 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id B66341B80BE6;
	Mon, 26 May 2008 11:04:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <4838208A.6020205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82910>

Jose Luis Rivas Contreras wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> [Please CC me, I'm not subscribed]
> 
> Hi, I know this will be a dummy question but I cannot find how to solve
> this trying in several ways but none of them work. The issue is that
> when I try to clone I get:
> 
> May 24 09:25:39 jooga git-daemon: [14724]
> '/home/repo/git/xscreensaver.git': not in whitelist
> 
> My git-daemon conf is this:
> 8< -----
> service git
> {
>         disable         = no
>         type            = UNLISTED
>         socket_type     = stream
>         protocol        = tcp
>         user            = nobody
>         wait            = no
>         server          = /usr/bin/git-daemon
>         server_args     = --inetd --export-all
> }
> 8< -----
> 
> I've tried with `--inetd --export-all /home/repo/git', `--inetd
> - --export-all --base-path=/home/repo/git /home/repo/git', with
> interpolated to with a symlink but nothing works, I'm trying with:
> 

Specifying a symlinked path won't work. git-daemon (being of the
one-shot-fork school of programs) simply does a chdir() to the
requested directory and then getcwd(), which will never consider
symlinks. This is a security feature, since directory recursion
attacks will never ever work.

> git clone git://repo.ghostbar.ath.cx/home/repo/git/xscreensaver.git noseless
> 

When you specify base-path, you tell git-daemon to prepend the
base-path to the directory the user requests.

Start git-daemon like this:

git-daemon --base-path=/home/repo/git --export-all

then do

git clone git://repo.ghostbar.ath.cx/xscreensaver.git

and it should work, assuming /home/repo/git/xscreensaver.git
has no symlinks in it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
