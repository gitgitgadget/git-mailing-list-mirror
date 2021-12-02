Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E38C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbhLBRrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:47:06 -0500
Received: from avasout-peh-003.plus.net ([212.159.14.19]:50269 "EHLO
        avasout-peh-003.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbhLBRrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:47:05 -0500
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id sq7Pmt3wBxiCtsq7Qm2gYL; Thu, 02 Dec 2021 17:43:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1638467021; bh=NRf/JCaDbdHLBDu1c9pA05wPYqcpVi5WVtR5W/7NTIY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=r+CumGB2sOU2NwMT3Mn4k0P+Lo30KASR/AIW2z0MGL0v4jBY7lIoDM/fWuL/kBBdz
         4F+LQaBnGbP4C7RK3akq8jpyPZXT1HrjQKsz6/1PuWPYbQZAb3vbu8PXmXd6aue0iQ
         2erbgVRY8HBexrkXg0oT500VoMQI33KB/oI8RLJzoqIQJpseCzZCas5lvZb1RikfWH
         +w4r301JSlo4nWpyoJhomQ/v+xTJ/uKtCDSJYED68E+azyhxsDDsKj4wy0OevKTRyt
         P3Rrsx6xC7wpcZFkND7UHF2IBvJaODfewkhkQj6FMD8A08zbo9/0bDILBmvo3FiMBd
         zWvP2n3zjAbtg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=KuQuZUaN c=1 sm=1 tr=0 ts=61a905cd
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=0uv-BlV7Jiwxw5BG004A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?U2xhdmljYSDEkHVracSH?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
 <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
 <a936a701-c13f-346e-69ee-85441ca20641@gmail.com>
 <nycvar.QRO.7.76.6.2112021557530.63@tvgsbejvaqbjf.bet>
 <xmqq5ys7vt8t.fsf@gitster.g>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <713b6ced-cbdf-9d5d-a722-30e525a3f931@ramsayjones.plus.com>
Date:   Thu, 2 Dec 2021 17:43:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq5ys7vt8t.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCyQ1XbcIRhXc6elfGPJRdO+rE+wLb/ZlhjiJ7zR6Ppu/dvH4HMsDlQHC5eF7p9v9+5J98lz8o66imbgHS7G3bDQZQoFnvWAUJSGVEVHBAdcbBKrQ8wh
 wpI6ogj6zN72kKPiD3FWsMF06kw7eS6rjsy20tyOPU82jUqII6/CbKEyibAVQadgbUPU9uuFljbczhuNqJ3nTnLdy4q1IISXrUQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/12/2021 16:58, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>>> +	if (use_builtin_add_i < 0 &&
>>>> +	    git_config_get_bool("add.interactive.usebuiltin",
>>>> +				&use_builtin_add_i))
>>>> +		use_builtin_add_i = 1;
>>>>   -	if (use_builtin_add_i == 1) {
>>>> +	if (use_builtin_add_i != 0) {
>>>
>>> This could be simplified to "if (use_builtin_add_i)" but don't re-roll just
>>> for that
>>
>> I was actually considering this, given that Git's coding practice suggests
>> precisely the form you suggested.
>>
>> However, in this instance I found that form misleading: it would read to
>> me as if `use_builtin_add_i` was a Boolean. But it is a tristate, it can
>> also be `-1` ("undecided"). And I wanted to express "if this is not set to
>> `false` specifically", therefore I ended up with my proposal.
> 
> I do not think that line of logic is sensible.  The variable starts
> its life as a tristate (i.e. not just bool but can be unknown), and
> the four new lines above the conditional the patch adds is exactly
> about getting rid of the unknown-ness and turning it into a known
> boolean.  After that happens, the variable can safely be used as a
> boolean.  In fact, I view the four lines before it is exactly to
> allow us to do so.
> 
> Writing "if not zero" implies that the variable can have a non-zero
> value that is still "unknown" at this point in the code that has to
> be defaulted to "true", which would mean that the "if unset, read
> the config, and if that fails, default to true" logic above is not
> doing its job.  That is a false impression that misleads readers of
> the code.
> 
> So, I would say this conditional just should treat the variable as a
> simple boolean.
> 

Just an FYI - I had t3701-add-interactive.sh show:

  # 2 known breakage(s) vanished; please update test(s)

on Linux tonight (tests #45 and #47).

I assumed, with little (well, any) thought, that these vanishing
breakages are due to this 'js/use-builtin-add-i' branch.

Just ignore me (and apologies in advance), if this is not the case! ;-)

ATB,
Ramsay Jones


