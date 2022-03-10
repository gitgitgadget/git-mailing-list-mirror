Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA31C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 15:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiCJPJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343705AbiCJPHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 10:07:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E9A186229
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:57:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s10so7380198edd.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mi1tiOH/CkvrmR0nhiR/DGOACVIbFShUWnsvdi3xzjk=;
        b=dD3mo2Y+8t9U2y/hJkFvF/3WRi+/oVNJf+1Be9O47R7cveKzhDeYy7Pj0Y10z8fAuY
         FT2xPkz05Tjjk+q3vrFHP2Te4YSHXI92HTIJR9uaboasqI2GqsMOvNXNrzCHme6k6dfg
         Xt/CpeS3wtV+onHXkSQxO3qDdp31EFqoUY1+BRKNrqa1C6C63eVLRLUJf03wdoSQfvFi
         +IftscDUgB75u7RlQuUY68X3MIg7XAu2dwC3zoW/StYXepOQW3O3rWj7iQgteV57Ymvh
         iNUyhdjLToROg0jRvz0ZUlTPVo4vF7vRwHqLxytBsIY1/G+UgliBMeb+5NizTqMB5Cc0
         NEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mi1tiOH/CkvrmR0nhiR/DGOACVIbFShUWnsvdi3xzjk=;
        b=zX/LnuW7HOREjKFyAfxoHeCR3KLwkUo+Omrpn2U/HqmlNRx8AtruDZrQxQ3vuSTO91
         lfv+lE3O5ju9GtsWGm7RNdwdtE9fw9PXtf47Ve6QCHuDP3oM0cu3kSL0YqL6G5Yd0iPl
         j7SrHdRqMB1zKrmK9FEFoO12v19U/G7AizO1LCbogHcNJyliqrfhFGJ3V1LkiAS5r4aO
         KHVg8/THSHHnu9kLiHV9jDJXWtK9HnoPy9R/P+Gvx+17nXHshUO9DxoQrV5GNjjPCpkB
         5xnD3VqPsh6HKOsR4wwsdTyGeBI3C3o2BBuwZ1stXVNUM5FQZAtZPTo8s+/KN9pfcs1K
         mQ+A==
X-Gm-Message-State: AOAM532Ma3smHSRGglperiyRzsBNDxrXk2dDHXMEg43YW8sLBP47YHue
        i/C5epAaHxcKujziIKdv/f4=
X-Google-Smtp-Source: ABdhPJwmuHeqoMEHnD3Ramtco9KCPd8XL7pAkBUt6q6Er/ILMBXBYmtBHL/S9VqNTzIzSrF2+VvhHA==
X-Received: by 2002:a05:6402:3551:b0:416:7124:2116 with SMTP id f17-20020a056402355100b0041671242116mr4761736edd.211.1646924234416;
        Thu, 10 Mar 2022 06:57:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y6-20020a056402358600b004166413d27bsm2122983edc.97.2022.03.10.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:57:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSKE5-000XYU-AD;
        Thu, 10 Mar 2022 15:57:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/24] revision.[ch]: provide and start using a
 release_revisions()
Date:   Thu, 10 Mar 2022 15:56:32 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
 <xmqqmthylonj.fsf@gitster.g> <220310.864k46lk7x.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <220310.864k46lk7x.gmgdl@evledraar.gmail.com>
Message-ID: <220310.861qz9kg8m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 10 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Mar 09 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>>> index 9244827ca02..ed993383531 100644
>>> --- a/builtin/checkout.c
>>> +++ b/builtin/checkout.c
>>> @@ -629,7 +629,7 @@ static void show_local_changes(struct object *head,
>>>  	diff_setup_done(&rev.diffopt);
>>>  	add_pending_object(&rev, head, NULL);
>>>  	run_diff_index(&rev, 0);
>>> -	object_array_clear(&rev.pending);
>>> +	release_revisions(&rev);
>>>  }
>>
>> I very much like this.
>>
>>> -	object_array_clear(&rev.pending);
>>>  	clear_pathspec(&rev.prune_data);
>>> +	release_revisions(&rev);
>>
>> But this makes readers wonder why .prune_data still needs a separate
>> call to clear.  We are making it unnecessary to clear .pending
>> separately, which was what made me say I very much like this in the
>> first place.
>>
>> At least surviving clear_pathspec() now deserves an in-code comment?
>> We'll know when we see what release_revisions() actually does.
>
> I'll note it in a commit message. Generally in this series I then loop
> back and remove the clear_pathspec() (or similar) once I start clearing
> "prune_data", but in this case I seem to have missed this specific case
> later in the series...

Just for completeness, I didn't miss a case here, but thought I did
because of the truncated diff mentioning "builtin/checkout.c",
nevermind... (but will fix the other raised issue).
