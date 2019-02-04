Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497031F453
	for <e@80x24.org>; Mon,  4 Feb 2019 20:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfBDUuA (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 15:50:00 -0500
Received: from avasout04.plus.net ([212.159.14.19]:39708 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBDUuA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 15:50:00 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id qlBlgrwoxAOoyqlBmgNkBt; Mon, 04 Feb 2019 20:49:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=b0VUcTZ58wrE6yisSGwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/1] Makefile: improve SPARSE_FLAGS customisation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <3ccf0255-8a15-effc-ce6b-eabb61625f90@ramsayjones.plus.com>
 <xmqqmunfxjve.fsf@gitster-ct.c.googlers.com>
 <4a8f6b3f-3844-b4e8-2ed2-4078b592dd4b@ramsayjones.plus.com>
 <xmqqwomfv2w5.fsf@gitster-ct.c.googlers.com>
 <365a9539-4ce1-121a-ec8c-2e52a5828091@ramsayjones.plus.com>
 <xmqqy36vtimu.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a60cd464-33e8-eefb-33df-83c1dca09031@ramsayjones.plus.com>
Date:   Mon, 4 Feb 2019 20:49:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqy36vtimu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCEgndwPPaFJVCvyTO4hEXExl4Joao2LXGXJnDrn6HZGeDUGExAkxztndNSKpp/YUXgO58d++NmKSHWk6rsDIGZ2s+q9jAc9b6AQSX+UYkwo8gchIQOn
 XNNfYADQ0EV6g346bQcya9gSJAKqJ6yM4JdX8H4HGXXDoUOnxXIuMeHEmkaQ2SoFkm28KswY/Agd4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/02/2019 20:15, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 04/02/2019 18:12, Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>>
>>>>> Thanks for a detailed and clear explanation here and in the cover
>>>>> letter.  I agree with the motivation and most of the things I see in
>>>>> this patch, but one thing that stands out at me is if we still want
>>>>> to += append to SP_EXTRA_FLAGS in target specific way.  Before this
>>>>> patch, because SPARSE_FLAGS was a dual use variable, it needed +=
>>>>> appending to it in these two places, but that rationale is gone with
>>>>> this patch.
>>>>
>>>> As Luc surmised, in his reply, my intention was that SP_EXTRA_FLAGS
>>>> should be used for any 'internal' settings (not just the target
>>>> specific settings), whereas SPARSE_FLAGS would now be used _only_ for
>>>> user customisation.
>>>
>>> OK, if that is the case, then not using "+= append" on SP_EXTRA_FLAGS
>>
>> Err, no, that clearly wouldn't be an improvement! As I said above,
>> this is not just for target specific settings.
> 
> Ah, do you mean that there may be globally applicable internal
> setting?  I would have expected that such an option would be done
> directly on the command line, e.g.
> 
> $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
> 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
> 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) \
> 		-Wsparse-settings-for-everybody $<

global, possibly, but more likely platform variations - as I tried
(but obviously failed) to indicate with the cygwin and MinGW examples
in my previous email.

ATB,
Ramsay Jones

