Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD79C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 18:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjAXSDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjAXSDI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 13:03:08 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F94A5E7
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 10:03:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o13so15848626pjg.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 10:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AykxYq3DYzKwgRiHKoSp75/MzSuD7UsZBMYA6wDH1c=;
        b=RXlonRRyrQ//sVz6fNpaSaud4Qc39/8wESVvBWXCa8a/fq2CyL3VTNxijG6YVJbnk/
         0NqPou19X1nT40p4eqvTOV48/71HoTciVJNODjiKrp450NEEIdoQsVu5Ec2xhjmFxOz/
         Y+iEpuUMhGUlioSfYU12lIIy56Ix8p8pkZLuFp+MlWIXG1J7ZZcVPekSeYg4tlEf9ffC
         efJIjCZQPFWWEymAe4IKdcHsosC/2F/VUHNWTWKuf9ppQqKmATe6IvM/Wqc21weh2CsK
         mIeldcMK17AoQdcBLNzJzJ2VCAxThUmAjiCNrCDq/iX8DUudF0/p5DVSmUS74jY2VDo2
         sd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3AykxYq3DYzKwgRiHKoSp75/MzSuD7UsZBMYA6wDH1c=;
        b=xCnReJgo25Cg0jjclotjpJz/YfnN4pbco9RDUkpEzvGmsdxLtaSejs+001szQaD0Nk
         g6oD8MKxeEsdtgartYBT0YVgwJf4/aEbMq54SpgCkto7eAJ3nnxvqDWomIaBP6v5l06n
         pzvf1qZ8DbPETFz69+bl58lK/qljQ0BVGbkzr0Xl+aEkU3rYoEbD1ycG/Q7cAu9b/bKW
         XZ6BfrrsiM2OLB99FdxsqaXzjX4vlgMV7dutrYBZb2/nIdj2URobyZnsxA+rWdjVoVhT
         xbH0Ozmauei3NvILOtih61qjI8f1ZKsNdxE/30pY+AIhYFBUGe7dhTmdUexTrvhJwFzO
         Qlnw==
X-Gm-Message-State: AFqh2kpp3ZxHNWYPievG+XtCEeDsFdgdywlHwe4/Zl8sWnG0fKhx8FkP
        4vDPumoQZyPkwKC/b9uwcfQ=
X-Google-Smtp-Source: AMrXdXtx5bWBE/jNbxmB9tbOVPm2gvD6YJi8w0OAW6kdrIkpEVa4T5Q18Udt2IEsYbVA1MmzpqUSXQ==
X-Received: by 2002:a17:90b:17c7:b0:22b:b894:a627 with SMTP id me7-20020a17090b17c700b0022bb894a627mr15969920pjb.28.1674583382975;
        Tue, 24 Jan 2023 10:03:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a6d0400b0022bbad75af4sm1879230pjj.2.2023.01.24.10.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 10:03:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
        <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>
Date:   Tue, 24 Jan 2023 10:03:02 -0800
In-Reply-To: <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com> (Victoria Dye's
        message of "Tue, 24 Jan 2023 09:30:02 -0800")
Message-ID: <xmqqwn5bg695.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Matthew John Cheetham via GitGitGadget wrote:
>> Updates in v6
>> =============
>> ...
> I've re-read the patches in this version; all of my comments from v5 have
> been addressed, and the additional updates w.r.t. other reviewer feedback
> all look good as well. At this point, I think the series is ready for
> 'next'.
>
> Thanks!

Thanks, both.  Let's merge it down.
