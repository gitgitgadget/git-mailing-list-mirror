From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] strbuf_split_buf(): use ALLOC_GROW()
Date: Tue, 06 Nov 2012 08:54:07 +0100
Message-ID: <5098C21F.6030803@alum.mit.edu>
References: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu> <1352011614-29334-2-git-send-email-mhagger@alum.mit.edu> <20121104114101.GA336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:54:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVdzM-0002Hq-1U
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 08:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab2KFHyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 02:54:11 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:59330 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753505Ab2KFHyL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2012 02:54:11 -0500
X-AuditID: 12074412-b7f216d0000008e3-29-5098c222e679
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C8.F1.02275.222C8905; Tue,  6 Nov 2012 02:54:10 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA67s7eJ008067
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Nov 2012 02:54:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <20121104114101.GA336@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqKt0aEaAwY9eHouuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bm3N7xjLXjFVzFh/yrmBsa3
	3F2MnBwSAiYShzv7WCFsMYkL99azdTFycQgJXGaUWLnqDCOEc4xJ4s+cCWwgVbwC2hJXb11j
	ArFZBFQlDrVcAutmE9CVWNTTDBYXFQiTWLPnEBNEvaDEyZlPWEBsEQFZie+HNzKC2MwC1hIr
	Xh8GqxEWsJU4c3wD1LJVjBIL9/wCS3AKWEqc7e0GauYAalCXWD9PCKJXXmL72znMExgFZiFZ
	MQuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQkJXaAfj+pNy
	hxgFOBiVeHgFxGYECLEmlhVX5h5ilORgUhLl/bAHKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	d8c2oBxvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgSvwUGgRsGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQpMYXA2MVJMUDtLf1AMje4oLEXKAoROspRmOO
	o2/mPmTk+Ng47yGjEEtefl6qlDivCsgmAZDSjNI8uEWwpPWKURzob2FeD5AqHmDCg5v3CmgV
	E9Cq7ZemgKwqSURISTUwclx2WvznSv2J6AP3Xry4yDphqXzcof8BNtEnM0+//sQ/41r6cbHt
	Lr6OBx5vdjP4aGvTz3ODe9KsppjTM2R/Fv1+ybFQICTvAVt79KnLD4Wr4ypb9u+K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209102>

On 11/04/2012 12:41 PM, Jeff King wrote:
> On Sun, Nov 04, 2012 at 07:46:51AM +0100, Michael Haggerty wrote:
> 
>> Use ALLOC_GROW() rather than inline code to manage memory in
>> strbuf_split_buf().  Rename "pos" to "nr" because it better describes
>> the use of the variable and it better conforms to the "ALLOC_GROW"
>> idiom.
> 
> I suspect this was not used originally because ALLOC_GROW relies on
> alloc_nr, which does fast growth early on. At (x+16)*3/2, we end up with
> 24 slots for the first allocation. We are typically splitting 1 or 2
> values.
> 
> It probably doesn't make a big difference in practice, though, as we're
> talking about wasting less than 200 bytes on a 64-bit platform, and we
> do not tend to keep large numbers of split lists around.

I did a little bit of archeology, and found out that

* ALLOC_GROW() did indeed exist when this code was developed, so it
  *could have* been used.

* OTOH, I didn't find any indication on the mailing list that the
  choice not to use ALLOC_GROW() was a conscious decision.

So history doesn't give us much guidance.

If the size of the initial allocation is a concern, then I would suggest
adding a macro like ALLOC_SET_SIZE(ary,nr,alloc) that could be called to
initialize the size to some number less than 24.  Such a macro might be
useful elsewhere, too.  It wouldn't, of course, slow the growth rate
*after* the first allocation.

FWIW, the "max" parameter of strbuf_split*() is only used in one place,
though strbuf_split*() is used in some other places where not too many
substrings would be expected.

I am working on some patch series that will eliminate even more uses of
strbuf_split*(), so I won't work more on optimizing its resource usage
unless somebody gives me a stronger nudge.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
