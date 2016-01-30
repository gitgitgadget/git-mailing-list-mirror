From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: fast-import fails in read-only tree
Date: Sat, 30 Jan 2016 10:05:45 +0100
Message-ID: <m2oac31lp2.fsf@linux-m68k.org>
References: <jwvfuxhz72e.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<20160129060802.GA23106@sigill.intra.peff.net>
	<jwv7fisxyhz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<20160130051340.GA1677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Monnier <monnier@iro.umontreal.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 10:06:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPRUG-0000ML-8z
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 10:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbcA3JF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 04:05:58 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:48420 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbcA3JFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 04:05:54 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3psqQ80gqLz3hjhT;
	Sat, 30 Jan 2016 10:05:51 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3psqQ644TGzvh2G;
	Sat, 30 Jan 2016 10:05:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id awowKoRp4bFt; Sat, 30 Jan 2016 10:05:49 +0100 (CET)
X-Auth-Info: 2ENdbxwW2jw8AOYYdvA8YHqrnbL2JbnQJHvhc59EUiFz7FoONtoE/5wXdbcxdcZs
Received: from linux.local (host-188-174-209-95.customer.m-online.net [188.174.209.95])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 30 Jan 2016 10:05:49 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 482541E5462; Sat, 30 Jan 2016 10:05:45 +0100 (CET)
X-Yow: Content:  80% POLYESTER, 20% DACRON..  The waitress's
 UNIFORM sheds TARTAR SAUCE like an 8'' by 10'' GLOSSY..
In-Reply-To: <20160130051340.GA1677@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 30 Jan 2016 00:13:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285108>

Jeff King <peff@peff.net> writes:

> If you're really going to do a lot of interactive back-and-forth access
> of objects, though, I think you want to set up pipes to cat-file. It's a
> little tedious to allocate fifos, but something like:

With bash's coproc it's a bit less tedious:

>   mkfifo in out
>   (exec git cat-file --batch <in >out) &
>   exec 8>in
>   exec 9<out
>   echo $sha >&8
>   read mode type size <&9

    coproc CAT_FILE git cat-file --batch
    echo $sha >&${CAT_FILE[1]}
    read mode type size <&${CAT_FILE[0]}

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
