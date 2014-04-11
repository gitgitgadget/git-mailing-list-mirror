From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git push race condition?
Date: Fri, 11 Apr 2014 09:46:28 +0200
Message-ID: <vpqob08qpez.fsf@anie.imag.fr>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<20140324225434.GB17080@sigill.intra.peff.net>
	<557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
	<CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
	<20140325145700.GA10132@sigill.intra.peff.net>
	<CAAyEjTO3JTNDxDWpX+k_Z-O9=8-Vu5uyT_1eK-A8nFXWVcyD6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Scott Sandler <scott.m.sandler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 09:46:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYWAl-0007m4-T7
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 09:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbaDKHqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 03:46:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56427 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993AbaDKHqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 03:46:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3B7kRAN021428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Apr 2014 09:46:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3B7kSem026721;
	Fri, 11 Apr 2014 09:46:28 +0200
In-Reply-To: <CAAyEjTO3JTNDxDWpX+k_Z-O9=8-Vu5uyT_1eK-A8nFXWVcyD6w@mail.gmail.com>
	(Scott Sandler's message of "Thu, 10 Apr 2014 15:14:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 11 Apr 2014 09:46:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3B7kRAN021428
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397807188.05957@R7LUWzhGrhllhbBgVG656g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246066>


> This finally happened again. Here's what the reflog looks like:
>
> 2805f68 master@{0}: push
> 96eebc0 master@{1}: push
> 75bd4a6 master@{2}: push
> abc30da master@{3}: push
> eba874f master@{4}: push
> 10981e7 master@{5}: push
> 76b3957 master@{6}: push
> 2e3ea06 master@{7}: push
> 9d4e778 master@{8}: push
> dbd70ae master@{9}: push
> 508ab4f master@{10}: push
> 36a0ce4 master@{11}: push
> ddc258e master@{12}: push
> cf025de master@{13}: push
> dbd70ae master@{14}: push
> 95d33eb master@{15}: push
> 75b8e9a master@{16}: push

You can have a look at the actual reflog (.git/logs/refs/heads/master)
which contains a bit more information. It will show you the pairs
(source, destination) for each change.

Normally, the destination of a push is the source of the next one, but
that would be worth checking.

> One interesting thing to note is that dbd70ae shows up at two separate
> points in the reflog though, one being directly before the 9d4e778
> commit that won the race. According to Gitlab's event log that commit
> was just pushed once, right after 95d33eb and before cf025de as it
> shows in master@{14} there. The fact that the same commit shows up
> again in master@{9} is interesting.

My interpretation is that someone/something did a non-fast forward push
at master@{9}, which reverted the history back to dbd70ae, and then
master@{8} did a fast-forward, non-race condition, absolutely normal
push.

Look at the complete reflog line corresponding to master@{9}, it may
give you more information.

> Now that it has happened again and I've got this data, I'm going to
> upgrade git but let me know if this provides any insight in the mean
> time.

If I were you, I'd keep a copy of the complete repo (including reflog &
all) in case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
