Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0DCECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 18:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiIMSkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIMSjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 14:39:47 -0400
Received: from blade-b3-vm-relay.servers.aueb.gr (blade-b3-vm-relay.servers.aueb.gr [195.251.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 397021103
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 11:09:25 -0700 (PDT)
Received: from blade-a1-vm-smtp.servers.aueb.gr (blade-a1-vm-smtp.servers.aueb.gr [195.251.255.217])
        by blade-b3-vm-relay.servers.aueb.gr (Postfix) with ESMTP id 0A2511E89;
        Tue, 13 Sep 2022 21:09:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aueb.gr; s=201901;
        t=1663092563; bh=5VJoJeV5mKR3CPUEjg7XdRH624l6+gnfSfHnW/A2HA8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z1FjaawpGsfIWun5/AwyRBxvGU+vPFqRYtjB1EETvykpZjhJK81bC4xFjk3P9UN1E
         ZLvkpYvn9Ci28SAq8Qn5kv0WzZIDgTyb7DPGjmFaR5+eH0VAF1ZfJZEFl0a9r83vBz
         B/91u2Spr32MLiQFPDocorBIpgzCiGjrW4Y4Gl57NiJMcGXhF4sYG66DiU7sWmnAy3
         E8YZ40qIfmej1LgOQRElvKYMN0Bi9DjtRxkQ7NcBroTZSBtc9nxizgBpEiiqk2XsE9
         RCHlfmKEhN8mYz1x4oXLATJO5dlU3Mio7gfgPRXJ9Wks+cOa4cWMBQ+NI8CpcYchAy
         pWS77sDgug76Q==
Received: from [192.168.136.3] (ppp-94-66-129-2.home.otenet.gr [94.66.129.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dds)
        by blade-a1-vm-smtp.servers.aueb.gr (Postfix) with ESMTPSA id 9D7AA698;
        Tue, 13 Sep 2022 21:09:22 +0300 (EEST)
Message-ID: <a8ba447f-d087-1c5e-0ce0-a9040ad080d1@aueb.gr>
Date:   Tue, 13 Sep 2022 21:09:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] grep: fix multibyte regex handling under macOS
Content-Language: el
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        avarab@gmail.com
References: <20220826085815.2771102-1-dds@aueb.gr>
 <xmqqzgf389k9.fsf@gitster.g>
From:   Diomidis Spinellis <dds@aueb.gr>
Organization: Athens University of Economics and Business
Phone:  +30 210 8203621
In-Reply-To: <xmqqzgf389k9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13-Sep-22 20:32, Junio C Hamano wrote:
>> +#include <locale.h>
>>   #ifdef NEEDS_SYS_PARAM_H
>>   #include <sys/param.h>
>>   #endif
> 
> I'll let others more familiar with the locale support to comment on
> these changes.  We are unconditionally including <locale.h> now;
> platforms that lack <locale.h> could set NO_GETTEXT to work it
> around before this change, but that will no longer work.
> 
> I do not know if thta is a practical downside to anybody, but it
> could be a problem.
> 
> Perhaps cook this in 'next' and see if anybody screams?

I was programming in C before locale.h was introduced, so its 
availability was something that worried me as well.  I looked up whether 
we could/should use a GNU autoconf macro to test for the locale.h 
availability.  According to autoconf's documentation "All hosted 
environments that are still of interest for portable code provide all of 
the headers specified in ISO C90 (as amended in 1995): assert.h, [...] 
locale.h [...], and wctype.h. Most programs can safely include these 
headers unconditionally." [1]

[1] https://www.gnu.org/software/autoconf/manual/autoconf-2.70/autoconf.html
