Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60882C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 13:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiDMNNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiDMNNq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 09:13:46 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F423DDC9
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 06:11:25 -0700 (PDT)
Received: from [192.168.3.156] (unknown [92.173.128.58])
        (Authenticated sender: jn.avila@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 4E0755FFAA;
        Wed, 13 Apr 2022 15:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1649855482;
        bh=vyi7WLPqRPFEUJOAtas6mTun2cUHI0Nqez0VDh13T1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=obUYoFEO65kUybQfkhf9qHespzPjTfCNe37KKbesvUfItD+mmZScs8fWfc69a1n0Y
         VtEwv2YyCQTCNahAIwJuPZN3S0YbxT9TBsWPulsjxGTb7V2JhzIQIqkxi3RMb38N7Q
         EE/aj2lcKlg8G0gic+IYxGa4cXAt+Z0MtFAs2ZxOKGm9jtIdnmAwJZt94rcGmJGnW5
         YB127KkdQ2TCZMi0sQ/c/RlodtojVDefeuRCAhfJyKfP8IUBceJiyTimLTva2BtoOI
         69QAQcXfzENrOF1phpOwCOAYBzdzf0dUnJR1rTHWfjXR/sVUGKWiHt/eKlEydJIuep
         3zH3yWKUs+3Ig==
Message-ID: <10867692-7c2b-1f89-d575-3d9b6e696a24@free.fr>
Date:   Wed, 13 Apr 2022 15:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Make a colon translatable
Content-Language: fr
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Julien Palard <julien@palard.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?S=c3=a9bastien_Helleu?= <flashcode@flashtux.org>
References: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr>
 <xmqq5ynfh101.fsf@gitster.g> <220412.86tuayhga7.gmgdl@evledraar.gmail.com>
 <xmqq35iicle2.fsf@gitster.g>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
In-Reply-To: <xmqq35iicle2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 12/04/2022 à 18:32, Junio C Hamano a écrit :
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>>>> --- a/wt-status.c
>>>> +++ b/wt-status.c
>>>> @@ -248,7 +248,7 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
>>>>   					     const char *how)
>>>>   {
>>>>   	const char *c = color(WT_STATUS_HEADER, s);
>>>> -	status_printf_ln(s, c, "%s:", what);
>>>> +	status_printf_ln(s, c, "%s", what);
>>>
>>> I.e. this one is better handled by
>>>
>>> 	status_printf_ln(s, c, _("%s:"), what);
>>>
>>> as _(...) in C-locale is original-language centric, where we want
>>> the label to be <phrase> immediately followed by a colon.  And that
>>> allows French translation to have nbsp before the colon.
>>
>> In this case I think the change as suggested is better, translators get
>> zero context from "%s:", whereas "Untracked files:" being status output
>> is immediately obvious.
> 
> It is unclear if you read the original (and discussion so far).
> 
> I understand that Julien wants to turn "%s:" to have nonbreaking
> whitespace before the colon.  It does not matter what label we are
> using (it can be "Ignored files").  I took it that the patch is
> addressing "git status" output but the general thrust is in Julien's
> translation, all "label-string followed by colon" should become "the
> string followed by nonbreaking whitespace followed by colon".
> 
> Moving the colon to the label string is backwards, isn't it?  If the
> presentation form accepted in the C-locale, i.e. "%s:", needs to be
> localized in Julien's translation to "%s :", shouldn't the "%s:"
> that defines the presentation be what is marked for translation?
> 
>> His commit message also doesn't mention it, but for existing "headings"
>> we already do this, e.g.:
>>
>>      status_printf_ln(s, c, _("Changes to be committed:"));
>>      status_printf_ln(s, c, _("Changes not staged for commit:"));
> 
> That's another arugment to translate _("%s:") once for the language,
> I would think.

Just to chime in, I would tend to approve Julien's proposal, but with a 
reworded commit message, which should convey that the segment to 
translate is not a full sentence.


The main argument is that for translators to correctly work, the strings 
to translate must hold complete sentences, comprising the end colon. I 
guess that in the present case, we are quite lucky that these strings 
appear so often that translators know how to handle them.

Why use a /* TRANSLATORS:*/ stance when simply providing the full 
sentence would not require any additional hint and uniformize it to the 
general way of presenting strings to translators. This is an indication 
that the string is not a complete semantic entity, although we can 
provide it (e.g. just like for the other ones, lines 284-305).

Also making a string as generic as "%s:" translatable can lead to 
translation errors because this has the structure of sentence lego where 
we can be sure that the %s is another translated string.


