From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/3] improve symbolic-ref robustness
Date: Tue, 29 Dec 2015 09:25:06 +0100
Message-ID: <56824362.30903@alum.mit.edu>
References: <20151220072637.GA22102@sigill.intra.peff.net>
 <20151229055558.GA12848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 09:25:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDpal-00089c-DV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 09:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbbL2IZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 03:25:11 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47033 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753096AbbL2IZK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2015 03:25:10 -0500
X-AuditID: 12074412-f79a76d000007c8b-06-568243658e73
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id DB.06.31883.56342865; Tue, 29 Dec 2015 03:25:09 -0500 (EST)
Received: from [192.168.69.130] (p4FC97AF1.dip0.t-ipconnect.de [79.201.122.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBT8P778009964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 29 Dec 2015 03:25:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <20151229055558.GA12848@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqJvq3BRmsP4Yj0XXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7oy2BetYC85xVNx5+I2tgfEx
	WxcjJ4eEgInEkXVfmSBsMYkL99YDxbk4hAQuM0p09lxkhnAuMElMu/USrEpYwFri0eop7CC2
	iICRxI0P38AmCQlkS3x+OI0RxGYWUJNo3zSFFcRmE9CVWNTTDNbLK6Ap8epyHwuIzSKgKvF8
	5wmwOaICIRJ7d3awQNQISpyc+QTI5uDgBNo1c7EPxEh1iT/zLjFD2PIS29/OYZ7AKDALSccs
	JGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iRESukI7GNeflDvE
	KMDBqMTDmzmpMUyINbGsuDL3EKMkB5OSKK/jL6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV7X
	LUA53pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ3seOTWFCgkWp6akV
	aZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBIjS8GxipIigdo70cHoHbe4oLEXKAoROspRkUp
	cV4BJ6CEAEgiozQPbiwsIb1iFAf6UpjXAKSKB5jM4LpfAQ1mAho8c2o9yOCSRISUVAPjkSUG
	uffLw9x4xFQ7In5//32D1/7OYcmwH55J+peVtGbENlzOvHk4a8axuTNdDiwLO368IOXIWqOL
	c3Yd9b/3kSNEwv5t5obv9w6JHw79WM+88qnmZPUZexP9F3G+Tdo1vXbhzsRLodp/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283109>

On 12/29/2015 06:55 AM, Jeff King wrote:
> On Sun, Dec 20, 2015 at 02:26:37AM -0500, Jeff King wrote:
> 
>> I noticed that an interrupt "git symbolic-ref" will not clean up
>> "HEAD.lock". So I started this series as an attempt to convert
>> create_symref() to "struct lock_file" to get the usual tempfile cleanup.
> 
> Here's version 2, based on comments from Michael. The first two patches
> were picked out separately for jk/symbolic-ref-maint, so I've dropped
> them here (so 1+2 here are the original 3+4).
> 
> The other differences from v1 are:
> 
>   - use "refname" instead of "ref" to match surrounding code
> 
>   - drop adjust_shared_perm, as lockfile does it for us
> 
>   - adjust reflog writing order (done in a new patch)
> 
> The patches are:
> 
>   [1/3]: create_symref: modernize variable names
>   [2/3]: create_symref: use existing ref-lock code
>   [3/3]: create_symref: write reflog while holding lock

Thanks, Peff. The whole series is

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
