From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 5/5] get_sha1: drop object/refname ambiguity flag
Date: Wed, 08 Jan 2014 17:34:43 +0100
Message-ID: <52CD7E23.8020503@alum.mit.edu>
References: <20140107235631.GA10503@sigill.intra.peff.net> <20140108000009.GE10657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 08 17:34:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0w5k-0005qJ-By
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 17:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795AbaAHQet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 11:34:49 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44407 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756324AbaAHQer (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 11:34:47 -0500
X-AuditID: 12074413-b7fc76d000002aba-f1-52cd7e272b0d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 67.0C.10938.72E7DC25; Wed,  8 Jan 2014 11:34:47 -0500 (EST)
Received: from [192.168.69.148] (p4FDD47EC.dip0.t-ipconnect.de [79.221.71.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s08GYhi4027454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Jan 2014 11:34:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140108000009.GE10657@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqKtedzbI4Nx6FosDL5+yWHRd6Way
	aOi9wmzRPeUto8WPlh5mB1aPnbPusns8693D6HHxkrLHswM32Tw+b5ILYI3itklKLCkLzkzP
	07dL4M54daemYAdnRdPSbcwNjP3sXYycHBICJhJf7rxjhLDFJC7cW88GYgsJXGaUmPMnqIuR
	C8g+xyRxqbeTFSTBK6AtcfjPdBYQm0VAVWLjr7dgNpuArsSinmYmEFtUIFhi9eUHLBD1ghIn
	Zz4Bs0UEZCW+H97ICDKUWWADo8SpP/fANgsLeEjse3qACWJzpsS0l01AV3BwcApYS/T+rwYx
	JQTEJXoag0BMZgF1ifXzhECKmQXkJba/ncM8gVFwFpJlsxCqZiGpWsDIvIpRLjGnNFc3NzEz
	pzg1Wbc4OTEvL7VI11wvN7NELzWldBMjJOSFdzDuOil3iFGAg1GJh5eh7GyQEGtiWXFl7iFG
	SQ4mJVFevSqgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe68VAOd6UxMqq1KJ8mJQ0B4uSOK/a
	EnU/IYH0xJLU7NTUgtQimKwMB4eSBK9HLVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFi
	aUlGPChy44uBsQuS4gHa+6QGZG9xQWIuUBSi9RSjLse8Lx++MQqx5OXnpUqJ86qC7BAAKcoo
	zYNbAUtwrxjFgT4W5tUHqeIBJke4Sa+AljABLQmNOwWypCQRISXVwJg8/YgWm+nCeEELdsOI
	n4yC0mfu66bv7pbdxCf1ZtvZYI7tjf2zX9vvvHtq5obQdU0su+zfCrpxLi/3OGNa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240219>

On 01/08/2014 01:00 AM, Jeff King wrote:
> Now that our object/refname ambiguity test is much faster
> (thanks to the previous commit), there is no reason for code
> like "cat-file --batch-check" to turn it off. Here are
> before and after timings with this patch (on git.git):
> 
>   $ git rev-list --objects --all | cut -d' ' -f1 >objects
> 
>   [with flag]
>   $ best-of-five -i objects ./git cat-file --batch-check
>   real    0m0.392s
>   user    0m0.368s
>   sys     0m0.024s
> 
>   [without flag, without speedup; i.e., pre-25fba78]
>   $ best-of-five -i objects ./git cat-file --batch-check
>   real    0m1.652s
>   user    0m0.904s
>   sys     0m0.748s
> 
>   [without flag, with speedup]
>   $ best-of-five -i objects ./git cat-file --batch-check
>   real    0m0.388s
>   user    0m0.356s
>   sys     0m0.028s
> 
> So the new implementation does just as well as we did with
> the flag turning the whole thing off (better actually, but
> that is within the noise).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> [...]

Very nice.  Correctness without a performance hit.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
