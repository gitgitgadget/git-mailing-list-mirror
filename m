Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F3BC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 22:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiD1WtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353002AbiD1WtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 18:49:08 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A766C86
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 15:45:52 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23SMjnWl030751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Apr 2022 18:45:49 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Carlo Arenas'" <carenas@gmail.com>, <git@vger.kernel.org>
References: <20220428033544.68188-1-carenas@gmail.com>        <20220428105852.94449-1-carenas@gmail.com>        <20220428105852.94449-4-carenas@gmail.com>        <xmqq7d79du6c.fsf@gitster.g>        <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com>        <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com>        <000801d85b40$ac11ec80$0435c580$@nexbridge.com>        <CAPUEspgcd1CYTfL=ug3WtnOrJscWbyQXeF-2SQ_24KcCTkuRkA@mail.gmail.com>        <000f01d85b4a$af8c3aa0$0ea4afe0$@nexbridge.com> <xmqqczh0etmt.fsf@gitster.g>
In-Reply-To: <xmqqczh0etmt.fsf@gitster.g>
Subject: RE: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
Date:   Thu, 28 Apr 2022 18:45:44 -0400
Organization: Nexbridge Inc.
Message-ID: <001901d85b51$b5333420$1f999c60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEhoH1klsquz/XrUeoh6UIeie+nGgNSFEhJAdygO20BcR/rTQHiUZcMAngeyfgBGrLMqwDSjnBuATELG1ABSq98t634SAZg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 28, 2022 6:22 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>is_root() {
>>>  id -u >u
>>>  id -u root >r
>>>  cmp u r
>>>}
>>
>> This is about as portable as I can find and works even in ksh. It could
be
>optimized.
>>
>> is_root() {
>>   id -u >u
>>   id -u root >r
>>   cmp -s u r
>>   if [ $? -ne 0 ]; then
>>     echo 0
>>   else
>>     echo 1
>>   fi
>> }
>>
>> if [ `is_root` -ne 0 ]; then
>>         echo root
>> else
>>         echo Not root
>> fi
>
>The above looks very roundabout way.  With the first three in is_root that
ends
>with "cmp", we already know from its exit status if "id -u" output for
ourselves
>matches that for root, i.e. if we are root then cmp would have exited with
0.
>
>So with the first one I quoted from your quote, the caller can say
>
>	if is_root
>	then
>		echo root
>	else
>		echo not root
>	fi
>
>without turning the exit status into string "0" or "1" and comparing that
string with
>"[ `cmd` -ne 0 ]".  And the first one is just as portable.  I agree that
running cmp
>with "-s" is probably a good idea.
>
>What I used to often use in my previous life (in previous century) is
technically
>incorrect, but is a lot more succinct and works well in practice on any
sanely
>installed systems.  Just see if the root directory is writable.  No sane
system makes
>it writable by anybody but root.
>
>I.e.
>
>	if test -w /
>	then
>		... we are running as root ...
>	else
>		... we are not running as root ...
>	fi

I agree. I think my ksh is rather broken. But we use bash for git testing
and can never go back to ksh, so no worries on that score. Thanks.

