From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/6] t4030: demonstrate behavior of show with textconv
Date: Sat, 20 Apr 2013 15:35:24 +0200
Message-ID: <5172999C.1050407@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net> <a3162a9df3055532a818db264f43abc994325049.1366389739.git.git@drmicha.warpmail.net> <20130420040400.GA24970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 16:55:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZCX-0001sz-1v
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 16:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab3DTOzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 10:55:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60807 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754967Ab3DTOze (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Apr 2013 10:55:34 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 18D9B2072C;
	Sat, 20 Apr 2013 10:44:24 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Sat, 20 Apr 2013 10:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=0lO05rzwqKoccDiX+9U2W9
	Bh21Q=; b=qNDNiPN6SSbb5pdrNovYfkR8tbBsvm65Yfz4zrN+J7XVh7FEB5M38S
	Ir9kRsBn7cfNGH3hyCiLgqYkT/iRS7WWCskxmxlViCCwU0C0UG7zbLThIeOTKV/1
	GCQ1LAQCHFuAXC1UKu9632lHbsz/ONMMKVsTPD4lHwYG1LbcPjUWA=
X-Sasl-enc: gwemFR+BmnFiMHnaWLNojgHr/0+wjI53ospozF4UeoHN 1366469063
Received: from localhost.localdomain (unknown [88.70.147.219])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6596BC80004;
	Sat, 20 Apr 2013 10:44:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <20130420040400.GA24970@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221855>

Jeff King venit, vidit, dixit 20.04.2013 06:04:
> On Fri, Apr 19, 2013 at 06:44:44PM +0200, Michael J Gruber wrote:
> 
>> "git show <commit>" obeys the textconc setting while "git show <blob>"
>> does not. Demonstrate this in the test.
> 
> s/textconc/textconv

Thanks, plus s/obey/honor/

>> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
>> index 53ec330..f314ced 100755
>> --- a/t/t4030-diff-textconv.sh
>> +++ b/t/t4030-diff-textconv.sh
>> @@ -58,6 +58,12 @@ test_expect_success 'diff produces text' '
>>  	test_cmp expect.text actual
>>  '
>>  
>> +test_expect_success 'show commit produces text' '
>> +	git show HEAD >diff &&
>> +	find_diff <diff >actual &&
>> +	test_cmp expect.text actual
>> +'
> 
> Makes sense.
> 
>> +test_expect_success 'show blob produces binary' '
>> +	git show HEAD:file >actual &&
>> +	printf "\\0\\n\\1\\n" >expect &&
>> +	test_cmp expect actual
>> +'
> 
> I think this is probably the right thing. I can see instances where one
> would want the converted contents, but we have "cat-file --textconv" for
> that.
> 

By that you mean that this behavior is to stay as is?

My reasoning is twofold:

- consistency between "git show commit" and "git show blob"

- "git show" is a user facing command, and as such should produce output
consumable by humans; whereas "git cat-file" is plumbing and should
produce raw data unless told otherwise (-p, --textconv).

Michael
