From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 1/2] t7508: test git status -v
Date: Wed, 04 Mar 2015 12:05:58 +0100
Message-ID: <54F6E716.5050808@drmicha.warpmail.net>
References: <54B8C82E.8000707@drmicha.warpmail.net>	<4979bf9de04197c1cd0d4a6af1348b45d4b0894c.1425390756.git.git@drmicha.warpmail.net>	<xmqqr3t5aicu.fsf@gitster.dls.corp.google.com> <xmqqioehafb2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 12:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT781-0005XA-PM
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 12:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236AbbCDLGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 06:06:02 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41148 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754072AbbCDLGA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 06:06:00 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 8D85F209BF
	for <git@vger.kernel.org>; Wed,  4 Mar 2015 06:05:58 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 04 Mar 2015 06:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3Qq6eMFhPoIeWhFxbPWqK5
	YMFko=; b=d/FCGz19DOx7R726F2OQDr68WPjjAuYEp6RTxJxPHRAQdmP2se0Xuu
	unhtn53QlTLnHosNS4po6Mc6AQpbl/EbDuviftWuNTTocxi7vwZJ2EjE3CJWcrvh
	kRLOJiXN9KluLzauls4fpE7nkNcXlFb+ix2uKB6GCRvklZqV3eAXk=
X-Sasl-enc: vFMs2nHij4ybqIpCsy2b1Ln+VgpF7c8rRR2Q7GBgK47l 1425467159
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E9F7CC0028C;
	Wed,  4 Mar 2015 06:05:58 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqioehafb2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264750>

Junio C Hamano venit, vidit, dixit 03.03.2015 23:26:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>> ---
>>>  t/t7508-status.sh | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
>>> index 8ed5788..4989e98 100755
>>> --- a/t/t7508-status.sh
>>> +++ b/t/t7508-status.sh
>>> @@ -133,6 +133,12 @@ test_expect_success 'status with status.displayCommentPrefix=false' '
>>>  	test_i18ncmp expect output
>>>  '
>>>  
>>> +test_expect_success 'status -v' '
>>> +	git diff --cached >>expect &&
>>
>> This makes the test rely on the previous one succeeding.  Do we
>> care, or is reproducing what ought to be in 'expect' at this step
>> too expensive?
> 
> Ahh, OK.  The way the existing tests prepare 'expect' is "by hand".
> 
> So I think what is wrong with this new test is not that relies on
> the current contents of 'expect', but that it modifies it (imagine
> being a merge/patch monkey who has to accept this change while a
> change from somebody else that wants to add another test that relies
> on the original 'expect' intact and then have to scratch his or her
> head when the two topics are merged, wondering why the latter test
> starts failing).
> 
> Perhaps
> 
> 	( cat expect && git diff --cached ) >expect-with-v &&
>         git status -v >actual &&
>         test_cmp expect-with-v actual
> 
> or something?

That's what I had first, but the new file shows up as untracked file in
the status output...

I don't mind setting this one up by hand also, if you prefer.

Michael
