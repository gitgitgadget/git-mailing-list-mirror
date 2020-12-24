Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCF5C433E6
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 16:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B46C224B0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 16:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgLXQAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 11:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgLXQAY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 11:00:24 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9FCC061573
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 07:59:43 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a109so2140095otc.1
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 07:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LN7hU1tlPvEuc2Iq5wsfXt4rPYoxImbyemBAcdrFdTk=;
        b=kSDDC55VOE6wfE1XfnDbzNashO/MuYQIkQr99nnhpx4lWdN3w+8jcAhrQFKGPcUE76
         2k6iPbP18P8XUYq2TAg30Q6Qz8njpimULY7IDfxba7nlaNd5DxLD0Fm4TkoJZ2SKFGLg
         5UuX9Uv87BASIRG2DwR3HVEk03Jskp2vzTkO8bepaC57SYeDCeIoYIMRWQ2Grk8Rq9/f
         31lI3J+ElnW/6QjS98EKFzo8IdFSmXGvCxdoT+f4Es3XqxP5HpEhMbk+Xg73BgDfxKpn
         /JG3dYjmxdkNBB9a9EBeIegCMv+c8r11YcHKseDmUddutbY0IqpMBEkXkI6C3EI+HwjB
         DBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LN7hU1tlPvEuc2Iq5wsfXt4rPYoxImbyemBAcdrFdTk=;
        b=NOO1hiQ5FbVasbieeMosZZiyhoobkWbEHuhi6xza0y50ja79BVewF+klisk2PVczFV
         wUPBZPn3bOfqlAsVrUM0DD+iXumrmw58Aj092kvL4LJUT1X2ifrQx9YDxen/Ap1whOde
         Z3vk24dzShx5rA/fK2f7JsmawCv90pLaitk1IohWbQRvG046m24IzX15iWCoeBwmI0M1
         0TaXjj6sfIeJCNuvegNSmD877Epc2XZtWEmBFWfjpY13xq/PC9xnGTx3yiM8NYSEQ1mX
         lf7Z9OHUuVFQOVSbh2w5xvTc/34JjE1hA+79hDrjJtpnd53u+cfu+G+/J6oGYEWrNgDm
         2UMA==
X-Gm-Message-State: AOAM533WcoqGH0ghJe7DbHsQfjuKslq8E82LgMKZc1Wq8qOOuYxWrq+V
        PUk5T3Uh/EkG1uN75Gj1ePYX3U46cigcvQ==
X-Google-Smtp-Source: ABdhPJzZ8FSYsKQLJG72378tSEv5ttq0AoOvz6CFMxpiK4iJQYNHVncId42arHwByTGF196Gouk8ow==
X-Received: by 2002:a9d:1d64:: with SMTP id m91mr22816527otm.290.1608825583066;
        Thu, 24 Dec 2020 07:59:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b25sm7748815ooe.18.2020.12.24.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 07:59:42 -0800 (PST)
Date:   Thu, 24 Dec 2020 09:59:41 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fe4baed206cc_19c9208e8@natae.notmuch>
In-Reply-To: <xmqqim8r4tjh.fsf@gitster.c.googlers.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201223045358.100754-2-felipe.contreras@gmail.com>
 <xmqqblekabof.fsf@gitster.c.googlers.com>
 <5fe352e3968f6_198be2083@natae.notmuch>
 <xmqqblek8e94.fsf@gitster.c.googlers.com>
 <5fe3dd62e12f8_7855a2081f@natae.notmuch>
 <xmqqv9cs3uxo.fsf@gitster.c.googlers.com>
 <5fe3f083f27cd_7855a20885@natae.notmuch>
 <xmqqim8r4tjh.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> Yup, I already mentioned UI mistake so you do not have to repeat
> >
> > You said it was a UI mistake, not me. I am a different mind than yours.
> 
> Yes, but the point is that I do not need to nor particularly want to
> hear your opinion on the behaviour of "git merge-file".

Then disregard the comment.

> I know (and others reading the thread on the list also know) that the
> exit code of the command is misdesigned already.

Unless you can read minds, you don't know that.

And even if you do, I don't know what you know. I can't read your mind.

Plus, they can disregard the comment as well.

> > I communicated that fact after you, so I did not repeat anything,
> > because I hadn't said that before. *You* did, not *me*.
> 
> Again, please realize that on list discussion is a team effort to
> come up together a better design of a shared solution.

Which is why agreement in a team with different minds and different
viewpoints is important.

Just to show a few instances of Jeff King telling you he agrees with
you:

 1. "I agree it's not all that useful in that example" [1]. 16 Dec 2020
 2. "I agree with the current definition" [2]. 18 Dec 2020 (same thread)
 3. "I agree the two should behave the same" [3]. 18 Dec 2020 (same
    mail)

The fact that you value Jeff King's agreement and don't care what some
other members in the community think, is a personal vale judgement, and
doesn't necessarily mean the viewpoints of such community members are
objectively worthless.

Cheers.

[1] https://lore.kernel.org/git/X9pUc2HXUr3+WHbR@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/X9xJ6BHM9VY0%2FyLs@coredump.intra.peff.net/
[3] https://lore.kernel.org/git/X9xJ6BHM9VY0%2FyLs@coredump.intra.peff.net/

-- 
Felipe Contreras
