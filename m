From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 27 Jun 2013 22:31:22 -0400
Message-ID: <51CCF57A.3020900@gmail.com>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk> <20130626223552.GA12785@sigill.intra.peff.net> <20130626224336.GA22486@sigill.intra.peff.net> <51CCC397.3060705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jun 28 04:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsOTJ-0007z1-D9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 04:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300Ab3F1Cb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 22:31:28 -0400
Received: from mail-qe0-f54.google.com ([209.85.128.54]:48441 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab3F1Cb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 22:31:27 -0400
Received: by mail-qe0-f54.google.com with SMTP id ne12so509918qeb.27
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 19:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ncz+HrgWpizOC4UV5tSGhIS1aDtDr49Q962mO6Wv46M=;
        b=w0wfJgag9hVF99e9sQLwZ0IrsKHaFyGiggaTLMwtNTGVEtX/oM0huCAKDyNqfkzid0
         vYzzmYxR9og0IRovwfv5TbM0BtxTv7iF74O6SL3pNeg2XHFr7fEDnynqrqRAyRyk0+QI
         OdrtRkTQzcVG/J57nbh7OvuTYy3Bmhs8KBCu3lC0DtYqLD9j0OG/16X9PX8E5+e0cfgq
         q3Zmrj4Armz8jF2A8bl7GkKG6Dp9JBQ7AyuAZkLt8Qi2LxeHKAAdvRiH3pIE01OSvsiQ
         LgpJPNsYiWqZzj+9fiQwRRm92Eomn4Xep8mQTgE/WXpsKVTpPBoTRy9OmB5IGr7Yktsg
         MXPw==
X-Received: by 10.224.79.203 with SMTP id q11mr1619523qak.35.1372386687081;
        Thu, 27 Jun 2013 19:31:27 -0700 (PDT)
Received: from mark-laptop.lan (pool-173-79-104-160.washdc.fios.verizon.net. [173.79.104.160])
        by mx.google.com with ESMTPSA id j9sm8797661qas.3.2013.06.27.19.31.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 19:31:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
In-Reply-To: <51CCC397.3060705@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229173>

On 06/27/2013 06:58 PM, Ramsay Jones wrote:

> This is why I tried the "cygwin: Remove the Win32 l/stat()
> functions" patch first; I think this is the correct approach
> to fixing this problem (and similar *future* problems).
I adamantly agree.
> However, since that is no longer an option, on performance
> grounds, I have other ideas I want to try. (see later email)

Correctness first, speed later.

1) Keep the patch to remove the buggy and unreliable stat / lstat.
2) We fix the remaining test failures.
3) With the test suite passing, stat optimization(s) that cause no 
failures / regressions can be accepted.

With the msys/mingw git available for years now, there really is not a 
reason to make Cygwin's git violate the Posix expectations of that 
platform. msys makes no such promises, so is the right tool for those on 
Windows who just want git as fast as possible on Windows (still 
slooooow) and don't care about file modes, softlinks, etc.

I'm keeping your patch in my tree.

Mark
