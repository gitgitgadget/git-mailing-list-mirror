Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90974C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FBE22251
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqFlH1tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408114AbgJTO3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408105AbgJTO3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 10:29:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08094C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 07:29:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c194so2014518wme.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=g3KkuU6tmZqdwo0mP4+STEnNEuN/+2DMdfc0oXsw5Bo=;
        b=QqFlH1txtc9DVA41yyArjheL1pU7BbjEiR6Dg5BF6um5Sa+8y7jQKRJYec+hqplYew
         8U/LFnJNjbLEBWjUzfUuzLM+qxE+JeSRFQXCVC7E6M9ZkxqOXz01cLfoFvsy9LTu2H0k
         5WcfjjPUEO5ZU1vUIsLAoVStUn/6ajSkJ46XEKECG3QIDIzJZvrwCIIeoP8tlWhhfjiK
         /s4V2w8VgFL5qejmFv8G3FdoWOFJfGxniwsJTPXw2u76P4NlZ4ndL5HNh91a/LF1QhuR
         CzgsGKFfGjpYsSgLo9DsRgL3yvuNEdOf1ZWRXop+GVzthpmA/1FsKdxc50D06XXugBqV
         h9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g3KkuU6tmZqdwo0mP4+STEnNEuN/+2DMdfc0oXsw5Bo=;
        b=dl9GEA5UIsmmRzMdwypzG9SqTwC1qLHfvwmQfomBn5nrdMRHhmNKD9GlKklQTxLBln
         yk1F/i3n23e1Tz4rfr6OPmA0pE6/zOI1CgLuYTpgIt4hD+P+5V4YYCClUCuKTlf40S/s
         bXH6J3bZpvGn1Q6dGLYWBNiyMXYbsBPcdKOUGZDraidG1Aqyury+RhziCu0qkY9aPTYX
         3/CBzyK8p0AdXPH0o5F8VIoQcy2tDElqDuzEHjz/Da6R8LWicQPnfD1DhEAQW1obJg79
         ey3NX7T6upu2xMxzSX2d36CPpDcb2KbnavahpBsfQMXa/JbXit+zIGYOCCExl42k3WJq
         AZIA==
X-Gm-Message-State: AOAM532a1CKO/8VEG26AsPfc73hHgpQWwISG7UmLLtfz9O/txKhwUCC0
        QeJ5/poT67YpR/LjJiAySAjsQGT7vsa5Ww==
X-Google-Smtp-Source: ABdhPJzH5p3SM7VjSxA/PwypIFymIXX3LjMKbyT56jsV3lvrkdecM+orDUROCVUn4YPSUPRojcobjA==
X-Received: by 2002:a1c:bc05:: with SMTP id m5mr3504326wmf.68.1603204185156;
        Tue, 20 Oct 2020 07:29:45 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:d1:f360:e45a:76e2:d443:321a? ([2a01:e0a:d1:f360:e45a:76e2:d443:321a])
        by smtp.googlemail.com with ESMTPSA id y2sm3277324wrh.0.2020.10.20.07.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 07:29:44 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_French_translation=3a_incorrect_translation_for_err?=
 =?UTF-8?B?b3IgbWVzc2FnZSBpbiDigJxnaXQgcHVzaCA8cmVtb3RlPuKAnQ==?=
To:     Sami Boukortt <sami@boukortt.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAAb+AL_xObsexRXL_fZdhj2FNQsOLzEz3_mZqd1Yz7F0=-havA@mail.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <85708905-cac0-963a-c244-f77d95ab421b@gmail.com>
Date:   Tue, 20 Oct 2020 16:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAb+AL_xObsexRXL_fZdhj2FNQsOLzEz3_mZqd1Yz7F0=-havA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sami,

I'm in charge of the French translation of git, and you are right.

Remote repo in French was usually translated as "dépôt distant"
(or simply "distant" by analogy with English). So the sentence should
really be:

Vous êtes en train de pousser vers le dépôt distant 'foo', qui n'est
pas l'amont de votre branche courante 'the-branch'....

You can either open a pull request to my repo or send me a patch.

Best regards,

Jean-Noël

Le 19/10/2020 à 17:59, Sami Boukortt a écrit :
> Hi,
>
> I just noticed a misleading translation. When running `git push foo`,
> one can get an error message that looks like this:
>
>> fatal: You are pushing to remote 'foo', which is not the upstream of
>> your current branch 'the-branch', without telling me what to push
>> to update which remote branch.
> In French, that message is:
>
>> fatal: Vous êtes en train de pousser vers la branche distante 'foo', qui n'est
>> pas une branche amont de votre branche courante 'the-branch', sans me dire
>> quoi pousser pour mettre à jour quelle branche amont.
> which incorrectly refers to foo as a remote *branch*, as opposed to
> just a remote.
>
> In the error message for `git remote rename a b`, remotes are called «
> serveur remote » (« fatal: Pas de serveur remote : 'a' »), so this
> could be what to change the message to. « qui n'est pas une branche
> amont » would also have to be changed.
>
> Thanks.
>
> Best,
> Sami


