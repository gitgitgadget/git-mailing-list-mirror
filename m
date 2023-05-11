Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A2C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbjEKSFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbjEKSE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:04:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455117D85
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:04:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f13ef4ad91so10413895e87.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683828257; x=1686420257;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9XrkLl4/+NZqqyuM1FrDmO4o+HEvW/Z+oDNbMeCBcY=;
        b=c22BSHawNzLCj2y6u7ydmKXBHFueBO5BGJBOJ/4GjZf73M62P7+GxqpIT/B0TsgS4u
         PnVdeO+mAWYwm900LJk+/ZKl0pNnxrIHzbdUCnqdMO610Xek7M0FYz8OOqHjhdxLhL2s
         Z89T+uNwoVLQWTu2bUG2YqM+CWACr1teqsiC3zozxaC5KfAatJbbi4w2PsllgpCT59bY
         EcE3W/iVez+nUKA4SOXq5sQnkrAI0hX3Cv8n0D+xKuiTfSHIGTQpJP1MjrRL2qZ0MlQ7
         Kqy1WVPRsR7YUBiN7pWukLeBgaQFflDwvxjrgAgRC6KB6IwquUBF9KIITHGh+kcp1546
         AMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683828257; x=1686420257;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9XrkLl4/+NZqqyuM1FrDmO4o+HEvW/Z+oDNbMeCBcY=;
        b=cTYZehpOpRrnnKOjtPcNKX5fqDSAeX2/kSLfX9YoBnz4+m1VMPz/AYu3XUfj39DVq+
         m+tIereKTNSE89f44/Dt43rZK9XKYtBhKS0BsFtTM/aJhvcbs3CV62izGM17z8Vqz5zv
         MccarAJIBLKgt/NPyGyDR/LoUABiJFVQkAjl7JNXZariRz3xdSHrlh/Jg2IlVvNu3HwT
         1v0eUwbEgYDSZkR/jFokCujaHZ/35KtsgmweSJmsM7MJ9JL3e25ZOXEEDlQyPvto/sCB
         reBGt4ZMK09TiDlbO8IFUfESKhKgypZm9/RPVsniAhIrPIBQ0CREgAJkD19E+NL/iMqD
         1KEQ==
X-Gm-Message-State: AC+VfDxyzj+h5PRhKYZrOkQEJSU1eUwbrAs2+TcB9r1tBg/UR9Z7UXbn
        Xr9tVOr1CP36xUcsNE5bs48=
X-Google-Smtp-Source: ACHHUZ5q7eI2s3TmGMUgMRoeOzuMiScKauyxSMg8DtbM08KNELK+x+CBC7X9FL9CmgcFEoPRkwCNTg==
X-Received: by 2002:ac2:4a7a:0:b0:4ee:d8f3:1390 with SMTP id q26-20020ac24a7a000000b004eed8f31390mr2736290lfp.53.1683828256893;
        Thu, 11 May 2023 11:04:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w21-20020ac24435000000b004f1f16777f1sm1190815lfl.303.2023.05.11.11.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:04:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru> <xmqqwn1ewyzx.fsf@gitster.g>
Date:   Thu, 11 May 2023 21:04:15 +0300
In-Reply-To: <xmqqwn1ewyzx.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        11 May 2023 10:37:22 -0700")
Message-ID: <87lehu219c.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I entirely agree with your conclusion: obviously, -s (--silent) and
>> --no-patch are to be different for UI to be even remotely intuitive, and
>> I'd vote for immediate fix of --no-patch semantics even though it's a
>> backward-incompatible change.
>
> I forgot to write about this part.
>
> tl;dr.  While I do not think the current "--no-patch" that turns off
> things other than "--patch" is intuitive, an "immediate" change is
> not possible.  Let's do one fix at a time.
>
> The behaviour came in the v1.8.4 days with a series that was merged
> by e2ecd252 (Merge branch 'mm/diff-no-patch-synonym-to-s',
> 2013-07-22), which
>
>  * made "--no-patch" a synonym for "-s";
>
>  * fixed "-s --patch", in which the effect of "-s" got stuck and did
>    not allow the patch output to be re-enabled again with "--patch";
>
>  * updated documentation to explain "--no-patch" as a synonym for
>    "-s".
>
> While it is very clear that the intent of the author was to make it
> a synonym for "-s" and not a "feature-wise enable/disable" option,
> that is what we've run with for the past 10 years.  You identified
> bugs related the "-s got stuck" problem and we recently fixed that.

I wonder, why this intention of the author has not been opposed at that
time is beyond my understanding, sorry! What exactly did it bring to
make --no-patch a synonym for -s? Not only it's illogical, it's even not
useful as being more lengthy.

Probably nobody actually cared at that time, me thinks.

>
> "Should --no-patch be changed" can be treated as a separate issue,
> and whenever we can treat two things separately, I want to do so, to
> keep the potential blast radius smaller.

Sure it's a separate change. When I said "immediate" I meant that there
is no need for some transition measures like config variables, not that
it is to be included in the "fix -s".

> That way, if an earlier change turns out OK but the other change
> causes severe regression, we can only revert or rework the latter. An
> exception is if committing to one change (e.g. "fix '-s'") makes the
> other change (e.g. "redefine --no-patch") impossible, but we all know
> it is not the case here. I gave an outline of how to go about it in
> the log message of that "fix '-s'" patch.
>
> I do not think it will break established use cases too badly to fix
> the behaviour of "-s" so that it does not get stuck.  We saw an
> existing breakage in one test, but asking the owners of scripts that
> make the same mistake of assuming "-s" gets stuck for some but not
> other options to fix that assumption based on an earlier faulty
> implementation is much easier.
>
> But "git diff --stat --patch --no-patch", which suddenly starts
> showing diffstat after you make "--no-patch" no longer a synonym for
> "-s", has a much larger potential to break the existing workflows.
> And I do not think asking the users who followed the documented
> "--no-patch is a synonym for -s" to change their script because we
> decided to make "--no-patch" no longer a synonym is much harder.

Why somebody would use --no-patch instead of -s when she means -s? Is't
it obvious that

   git diff --stat --patch -s

is not only shorter but dramatically more clear than

   git diff --stat --patch --no-patch

???

Taking this into account, I'd predict no breakage at all.

> So, no, I do not think we can immediately "fix".  I do not think
> anybody knows if it can be done "immediately" or needs a careful
> planning to transition, and I offhand do not know if it is even
> possible to transition without fallout.

This has been expected, and this is one of the things that stops me from
trying to "fix" anything in the Git UI recently. I think that perfectly
legit carefulness from the maintainer to be conservative in accepting of
such changes goes a bit too far, sorry!

Thanks,
-- Sergey Organov
