From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Thu, 19 Feb 2015 11:33:01 +0100
Message-ID: <54E5BBDD.7040100@drmicha.warpmail.net>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com> <20150218170007.784be6aa@pc09.procura.nl> <54E4CFDC.40401@drmicha.warpmail.net> <20150218182547.GA6346@peff.net> <xmqqpp972h1n.fsf@gitster.dls.corp.google.com> <20150218185734.GB7257@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:33:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOOPw-0000s4-8d
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 11:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbbBSKdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 05:33:05 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52466 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753314AbbBSKdD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 05:33:03 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id F051020993
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 05:33:02 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 19 Feb 2015 05:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=WK1wK/mIz/D1pCjaS/zSGr
	PROuI=; b=eA6GHRHnr9ZlSC8tZlaLZoJyBddH6WsxEv7J4NS+7qhKS4SDiCo/tJ
	iTbcebIguM8OteA8okvqT+Yz2wsCZvrQlQwrwPSb4fBZrU0BGgkFwrQ54jIeqtY4
	oStXHsbHnF5dj3vjFKbgluKAsjQ+f2GmvL7+Lh3OwJPDW1acLjE4I=
X-Sasl-enc: Hx/M3hoMZwK40T0v/V7TVXPBmZuXq0PmdbvqsbYTrNcB 1424341982
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3D4C26801D3;
	Thu, 19 Feb 2015 05:33:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150218185734.GB7257@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264088>

Jeff King venit, vidit, dixit 18.02.2015 19:57:
> On Wed, Feb 18, 2015 at 10:47:16AM -0800, Junio C Hamano wrote:
> 
>>> It seems like we could use
>>>
>>>   (cd src && tar cf - .) | (cd dst && tar xf -)
>>>
>>> here as a more portable alternative. I don't think we can rely on rsync
>>> being everywhere.
>>
>> Thanks; I wasn't even aware that we used rsync in our tests.  We
>> certainly do not want to rely on it.
> 
> I don't think we do.
> 
> Grepping for rsync in t/, it is mentioned in three places:
> 
>   1. In t1509, we use it, but that test script does not run unless you
>      set a bunch of environment variables to enable it.
> 
>   2. In a sample patch for t4100. Obviously this one doesn't execute. :)
> 
>   3. In t5500, to test "rsync:" protocol supported. This is behind a
>      check that we can run rsync at all (though it does not properly use
>      prereqs or use the normal "skip" procedure).
> 
>> Why not "cp -r src dst", though?
> 
> I was assuming that the "-P" in the original had some purpose. My "cp
> -r" does not seem to dereference symlinks, but maybe there is something
> I am missing.
> 
> -Peff

There's a symlink in sub that needs to be preserved.

I'm cooking up a mini-series covering tar/cp -P so far and hopefully the
JP encodings later. Do I understand correctly that for Merijin's use
case on HP-UX, we want

- as few extra tools (GNU...) as possible for the run time git
- may get a few more tools installed to run the test

I still don't have a clear picture of the iconv situation: Does your
iconv library require OLD_ICONV to compile? Is there a reason you want
to disable it?

Failing so many tests with NO_ICONV is certainly not ideal, but I'm not
sure we should care to protect so many tests with a prerequisite.

Michael
