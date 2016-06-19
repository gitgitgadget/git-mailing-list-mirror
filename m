Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654E81FEAA
	for <e@80x24.org>; Sun, 19 Jun 2016 07:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcFSHLr (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 03:11:47 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35032 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcFSHLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 03:11:47 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rXQCL4rQ8z3hjkP;
	Sun, 19 Jun 2016 09:11:42 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rXQCL3ZTHzvh1w;
	Sun, 19 Jun 2016 09:11:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Jb1eKle5A6LB; Sun, 19 Jun 2016 09:11:41 +0200 (CEST)
X-Auth-Info: 9LYhkMmTuepzfwwljjbvs6O8Qy2slmnUUHs3Naw3m8uTMisWkV6n9+E6zzHZE4wz
Received: from linux.local (ppp-88-217-14-243.dynamic.mnet-online.de [88.217.14.243])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 19 Jun 2016 09:11:41 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 93C281E541B; Sun, 19 Jun 2016 09:11:38 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] prune: keep files created after process start
References: <20160619031338.GA5161@dcvr.yhbt.net>
X-Yow:	I'm reporting for duty as a modern person.  I want to do
 the Latin Hustle now!
Date:	Sun, 19 Jun 2016 09:11:38 +0200
In-Reply-To: <20160619031338.GA5161@dcvr.yhbt.net> (Eric Wong's message of
	"Sun, 19 Jun 2016 03:13:38 +0000")
Message-ID: <m2wpllhcut.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> @@ -21,7 +22,7 @@ static int prune_tmp_file(const char *fullpath)
>  	struct stat st;
>  	if (lstat(fullpath, &st))
>  		return error("Could not stat '%s'", fullpath);
> -	if (st.st_mtime > expire)
> +	if (st.st_mtime > expire || st.st_ctime >= start)

That will also mean objects created (or their inode changed) up to a
second before the start of prune will not be removed.  For example,
objects ejected out of a pack by a previous repack may be affected.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
