From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] http-push: trim trailing newline from remote symref
Date: Tue, 13 Jan 2015 08:26:31 -0800
Message-ID: <4E1001F7-2D26-483A-9339-E2570559ECF0@gmail.com>
References: <20150113022857.GA4087@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB4Ik-0003LF-G0
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 17:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbbAMQ0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 11:26:36 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57256 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbAMQ0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 11:26:35 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so4588073pab.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=e3PKM6vQvmdbmpdqwqQL7MnfqWLZTDGGccKwcNsFdZY=;
        b=HNUHifmHdnhSBdPIoJkWwkj84SskZhDNf/SxM6hhNi8T8L5bT1BPISwDt47hXHKahw
         CEs0ZfYrdR2FIHINqsvRi1BSkGejIZytKoMws5KWjkGLdvd+eN1ZJjtS2OCDdMkYED54
         +fN2tSpiVjIm8dVkHsbK3RiO2qhcjQM3XFy3v2g1bTEB4SylHSbYumg4YqX7FwkS2I/Y
         6f/4wfjYsfrwkmzbEXY2zM32VcTBgOXejA30LCPqZg0ApT73sQQCTAOs2MACDkbrEG69
         H7vkgjT3Bg2mm/WDsi6snL4lmCnxjOpFb8rnS2GhoOUaXDRe+ZGoxYD72jOXkMuBzGEy
         Qqug==
X-Received: by 10.70.32.133 with SMTP id j5mr41487993pdi.5.1421166394797;
        Tue, 13 Jan 2015 08:26:34 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id z5sm17391005pbt.89.2015.01.13.08.26.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 13 Jan 2015 08:26:33 -0800 (PST)
In-Reply-To: <20150113022857.GA4087@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262338>

On Jan 12, 2015, at 18:28, Jeff King wrote:

> When we fetch a symbolic ref file from the remote, we get
> the whole string "ref: refs/heads/master\n", recognize it by
> skipping past the "ref: ", and store the rest. We should
> chomp the trailing newline.
> [..]
> This is a regression in v2.1.0.
>
> It was causing t5540 to fail, but I realized I have been building with
> NO_EXPAT for a while, so I didn't notice. Frankly, I'm kind of  
> surprised
> and disturbed that nobody noticed it before now. More evidence that we
> can kill off dumb http-push? I would have thought somebody else would
> have noticed the test failure, though.

I have this line in my 2.1.4 test output log:

t5540-http-push-webdav.sh .......................... ok

And again in my 2.2.2 test output log:

t5540-http-push-webdav.sh .......................... ok

Running the 2.2.2 version with -v I get:

t5540-http-push-webdav.sh ..
ok 1 - setup remote repository
ok 2 - create password-protected repository
ok 3 - setup askpass helper
ok 4 - clone remote repository
ok 5 - push to remote repository with packed refs
ok 6 - push already up-to-date
ok 7 - push to remote repository with unpacked refs
ok 8 - http-push fetches unpacked objects
ok 9 - http-push fetches packed objects
ok 10 - create and delete remote branch
ok 11 - MKCOL sends directory names with trailing slashes
ok 12 - PUT and MOVE sends object to URLs with SHA-1 hash suffix
ok 13 - non-fast-forward push fails
ok 14 - non-fast-forward push show ref status
ok 15 - non-fast-forward push shows help message
not ok 16 - force with lease aka cas # TODO known breakage
ok 17 - push to password-protected repository (user in URL)
not ok 18 - user was prompted only once for password # TODO known  
breakage
not ok 19 - push to password-protected repository (no user in URL) #  
TODO known breakage
# still have 3 known breakage(s)
# passed all remaining 16 test(s)
1..19
ok

I also get the same results using v2.3.0-rc0.

I do not build with NO_EXPAT.  This is running the tests on OS X  
without this patch applied.  Is something else required to get a  
failure?

-Kyle
