Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC9C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 09:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiBQJS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:18:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiBQJS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 04:18:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B1241DAE
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:18:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lw4so5579684ejb.12
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WvHkUmHCc49hhnLp0RPhDD/AmC2AKFSaJut7nf+N/CI=;
        b=YM/OIX/GpJWuhdtD1iOi4E4P7kUGLOw7OGHbMHlmBvCdF9r36Om1F1bGKMn6URFvnW
         vlRGoWVdT8dziUnzqEQjawPTFxSpscpFVL5rggu6KXLF43W4LL24Gr7w56XFZM+XIkfw
         4lzwxzX+gjJsRL6FhKptNItU9ixdeCXnrHI9jptBN/FOViyKMsnDvSZf5mboRxFEy1sw
         iUcheQLOYyTCdyMZiMhDk4f58LNCMzgUlMJaRK5x8kFBznnpXXppbhbagAdFB7pKhxyu
         UpMjh5Bp+Rdxt9li1ajs6YzubwGAdjseSj2BN28LfUFQp5m3mh5huOQvVwS5qByainif
         llSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WvHkUmHCc49hhnLp0RPhDD/AmC2AKFSaJut7nf+N/CI=;
        b=m7hGY/1/2MWwOU9YpuI6XQaDREEEUvuJzXHTmBQgsvDwzCnSbwuePupoyicw/XisH2
         Tm7+LiU3Z8VNsWTn7ooROhOqbzsDAYxeOMl2j3hvsSLPjzZ3opNbXG5tC30vHBfsR8Zb
         wn1GoDMA0CC9WMrelYE9q75dTErk25m3iDJtsVAQo1yQmOrCZY23H8Of89+467p2jjmn
         HB25Ru3+fQFZARLuzEUNlIISckfv2G8yOdQL6E35pcflpsze4IJnNWyq45DiIhrsKHq5
         43+Yuh/HIJHebzBQReUX7Gv/vD2PLXS/oC/8oZDcylO9/sLPMfnDfOfKZZuTUlvt4yEM
         jdow==
X-Gm-Message-State: AOAM5311HncO1ZY4i2Q9NTBWdofaOJMievSW54zFRuBAn9hop7WNQtFe
        L9QklEqF7QFt4VJSQIF7SCPtWEWRNWwBSw==
X-Google-Smtp-Source: ABdhPJxSv+1VY326ZTEcC26Er46Io9tVZnuPUf+Kan3nggccGn+KLXXb+44eDhr4as7UQTgxZ5wIww==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr1539220ejn.278.1645089518577;
        Thu, 17 Feb 2022 01:18:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k7sm947102eje.162.2022.02.17.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 01:18:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKcvs-003fPo-Qx;
        Thu, 17 Feb 2022 10:18:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
Date:   Thu, 17 Feb 2022 10:17:08 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <220212.868rugxhq0.gmgdl@evledraar.gmail.com>
 <kl6l4k4y59p4.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6l4k4y59p4.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220217.86r181j1g3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 17 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Feb 10 2022, Glen Choo wrote:
>>
>>> Atharva Raykar (6):
>>>   submodule--helper: get remote names from any repository
>>>   submodule--helper: refactor get_submodule_displaypath()
>>>   submodule--helper: allow setting superprefix for init_submodule()
>>>   submodule--helper: run update using child process struct
>>>   builtin/submodule--helper.c: reformat designated initializers
>>>   submodule: move core cmd_update() logic to C
>>>
>>> Glen Choo (11):
>>>   submodule--helper: remove update-module-mode
>>>   submodule--helper: reorganize code for sh to C conversion
>>>   submodule--helper run-update-procedure: remove --suboid
>>>   submodule--helper run-update-procedure: learn --remote
>>>   submodule--helper: remove ensure-core-worktree
>>>   submodule--helper update-clone: learn --init
>>>   submodule--helper: move functions around
>>>   submodule--helper: reduce logic in run_update_procedure()
>>>   fixup! submodule--helper run-update-procedure: remove --suboid
>>>   fixup! submodule--helper run-update-procedure: learn --remote
>>>   fixup! submodule: move core cmd_update() logic to C
>>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>>>   builtin/submodule--helper.c: rename option variables to "opt"
>>>   submodule--helper: don't use bitfield indirection for parse_options()
>>>   submodule tests: test for init and update failure output
>>
>> I think sending a version of this with the fixups squashed in as a v8
>> would be good, and perhaps addressing some of my comments.
>>
>> I don't know if my suggested split-up of "prep fixes" into another
>> series would be a good thing to pursue overall, perhaps Junio will chime
>> in on how he'd be most comfortable in merging this down. I'd think
>> splitting such trivial fixes into their own series be easier to review,
>> but perhaps not.
>
> Combing through the patches again, I couldn't really convince myself
> that the patch 4..9 prep fixes make sense as obvious standalone fixes,
> except maybe:
>
> - patch 4 submodule--helper: run update using child process struct
> - patch 8 submodule tests: test for init and update failure output
> - patch 9:  087bf43aba submodule--helper: remove update-module-mode
>
> But, since the 'final' patch (ignoring the fixup!-s) is consuming a huge
> chunk of the work anyway, here's an alternative patch organization with
> the fixup!-s squashed:
>
> =3D Move 'easy' and 'obviously correct' code from sh->C
> - patches 8-9   Cleanup and introduce tests
> - patches 1-4   Refactor existing functions, which enables..
> - patches 10-14 Move 'obviously correct' pieces of logic from sh-> C
>
> =3D Finalize move from sh->C
> i.e. combine "run-update-procedure" and "update-clone" into "update"
> - patches 5,7     Cleanup and prep
> - patches 6,15-16 Shrinking the diff
> - patch 17        Implement "git submodule--helper update"=20
>
> I'll send this if there are no objections :)

Yes that sounds good, or rather, I haven't re-looked at that in detail,
but I think if you think it makes sense we should go for it.

Or rather, we should really be aiming to produce a patch series that
makes sense in its current iteration, as opposed to optimizing for a
diff against some ad-hoc re-roll I produced a few versions ago :)

Thanks again for working on this & picking this up. It's great to see
progress in this area!
