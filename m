Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509ACFA3744
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJaUzo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 31 Oct 2022 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJaUzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:55:17 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EECBD10E
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:55:15 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 29VKtEh1066316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 31 Oct 2022 16:55:14 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Derrick Stolee'" <derrickstolee@github.com>,
        "'Abhradeep Chakraborty'" <chakrabortyabhradeep79@gmail.com>,
        "'Abhradeep Chakraborty via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Kaartic Sivaram'" <kaartic.sivaraam@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>        <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>        <xmqqczbdl6wl.fsf@gitster.g>        <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>        <CAPOJW5z_ZRChNo8PGBmJu=vvjTL2cYL8oTdVwoDRh-UHt2Dy4w@mail.gmail.com>        <58841dcd-e732-416f-5ab0-fd5a5d8de4c7@github.com>        <xmqqcza8dlkn.fsf@gitster.g> <221031.86cza77tvl.gmgdl@evledraar.gmail.com>
In-Reply-To: <221031.86cza77tvl.gmgdl@evledraar.gmail.com>
Subject: RE: C99 -> C11 or C17? (was: [PATCH 3/5] roaring: teach Git to write roaring bitmaps)
Date:   Mon, 31 Oct 2022 16:55:09 -0400
Organization: Nexbridge Inc.
Message-ID: <004601d8ed6b$13a2f580$3ae8e080$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGQ8RoOvy8Rz4D9g6ZSfEwS8ArPOwIl86dQAbEsETEBpWli9AGrQ8QUAk4Z/dABEAU38QCnNPaZrl+IJ/A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 31, 2022 1:51 PM, Ævar Arnfjörð Bjarmason wrote:
>On Mon, Oct 31 2022, Junio C Hamano wrote:
>
>> Derrick Stolee <derrickstolee@github.com> writes:
>>
>>> I HAVE OPINIONS! :D
>>>
>>> Mostly, there are two things I'd like for you to keep in mind:
>>
>> Nicely summarised.
>>
>> Stepping back a bit, we do not care about how the sources to some
>> pieces of software we depend on, say OpenSSL, match our style guide.
>> It is because we do not even have to see them while working on Git,
>> but also because we do not have to maintain it.
>>
>> So a third-option could be to fill pieces missing from the upstream
>> (e.g. big endian support) and contribute them back, and after that
>> treat them as just one of the external dependencies, just like we
>> happen to have a copy of sha1dc code for convenience but have an
>> option to use the upstream code as a submodule.
>>
>> Assuming that such a "they are just one of our external dependencies,
>> just like OpenSSL or cURL libraries" happens, I would not worry too
>> much about C11, as long as use of roaring bitmaps can be made an
>> optional feature that can be disabled at compile time.
>> Bitmaps are used only for local optimization and never transferred
>> across repositories, so you having only ewah would not prevent you
>> from talking with other people with both ewah and roaring.
>
>As an aside: We might think about just requiring C11 or C17 sooner than later.

As a request, there is no C11 or C17 on NonStop Itanium, which does not go off support until at least mid-2025. Requiring C11 or C17 will cut git updates off for that platform variant. NonStop x86 does not yet have C17, although it might in future (and I can report when it does - nonetheless, C11 will be required for some supported revisions of the operating system until 2030). Please do not do this.

C99 is the maximum guaranteed version available on all supported NonStop OS versions as of today. Git has thousands of NonStop users who would potentially be impacted and stuck without being able to obtain fixes for CVEs. In my opinion, and for many other Open-Source projects on which I maintain the platform, C11 and C17 do not contain a significant set of constructs that justify moving past C99, but it is obviously the git team's choice. This decision would leave us in the cold and would have to patch C99 code in to make git work.

Sincerely,
Randall

