From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: difftool--helper: exit when reading a prompt answer fails
Date: Mon, 27 Oct 2014 13:54:15 +0100
Message-ID: <544E4077.8070208@drmicha.warpmail.net>
References: <544CAC30.7000607@kdbg.org> <20141027004148.GB81127@gmail.com> <20141027011051.GA87518@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 13:54:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XijoW-0002Bl-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbaJ0MyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 08:54:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33478 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751149AbaJ0MyR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 08:54:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 9F5962095D
	for <git@vger.kernel.org>; Mon, 27 Oct 2014 08:54:16 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 27 Oct 2014 08:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ZetHHOj0xUpIVXqIL1IBQg
	YhSJI=; b=cNcXXIenELXWlkVNo8KpLXDtcDfA4lt+sqxltOBjf6QflpjpPhvhDr
	vHgUOTe+f7gK8kuvlBR1XO4zkOmddbF6uoo9neR/nPEN86lNt0GXsHfXcV538dGz
	GFLRj6jZZb3DNTLmmF6q5ugqEhaSzMVG2i+KJs92n5ZflSwKjCQEA=
X-Sasl-enc: 0R+D10AuFHCwyXycIT1PyvcRqhDJQE/Kq7vmJjlGTdgS 1414414456
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DA337680076;
	Mon, 27 Oct 2014 08:54:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141027011051.GA87518@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar schrieb am 27.10.2014 um 02:10:
> On Sun, Oct 26, 2014 at 05:41:49PM -0700, David Aguilar wrote:
>> On Sun, Oct 26, 2014 at 09:09:20AM +0100, Johannes Sixt wrote:
>>> An attempt to quit difftool by hitting Ctrl-D (EOF) at its prompt does
>>> not quit it, but is treated as if 'yes' was answered to the prompt and
>>> all following prompts, which is contrary to the user's intent. Fix the
>>> error check.
>>>
>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>> ---
>>>  Found while reviewing your latest patch.
>>
>>
>> Thanks for the careful review.
>> I have one small question about the test below.
> 
> [snip]
> 
>>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>>> index dc30a51..9cf5dc9 100755
>>> --- a/t/t7800-difftool.sh
>>> +++ b/t/t7800-difftool.sh
>>> @@ -301,6 +301,14 @@ test_expect_success PERL 'say no to the second file' '
>>>  	! grep br2 output
>>>  '
>>>  
>>> +test_expect_success PERL 'ending prompt input with EOF' '
>>> +	git difftool -x cat branch </dev/null >output &&
>>> +	! grep master output &&
>>> +	! grep branch output &&
>>> +	! grep m2 output &&
>>> +	! grep br2 output
>>> +'
>>
>> Should we use "test_must_fail grep ..." instead of "! grep ..." here?
> 
> 
> Nevermind, this is good as-is.
> Using "! grep" is consistent with the rest of the tests in t7800.
> 
> What I'll do is add a follow-up patch in my upcoming reroll
> that swaps all the "! grep" lines to "test_must_fail grep"
> in one step.

Don't do that ;)

test_must_fail is meant for testing (git) commands such that a "failure
return code" is marked as "success", whereas a failure to run the
command is still capturd and marked as a failed test.

For non-git commands like grep sed etc. which we do not perform tests
*on* (but only *with*), the simple negator "!" is fine and preferable.

Michael who has sinned in the past, but repented
