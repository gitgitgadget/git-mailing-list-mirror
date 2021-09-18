Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10240C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 17:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDC360F26
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 17:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhIRR5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhIRR5r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 13:57:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084DC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 10:56:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g41so14065911lfv.1
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WVPNocfT2ekubujVG/UQlJkN8bTvqOXqgaZUct3SRj0=;
        b=AjQIJOYOHWXD8Zowuya7Tvt3AAmc+UrAbAPfZJMgrI1pmTIdTAGW3YslX2PxGD54au
         IiqA1SPs6BTgHDinEhOYv3lPxPbRuXM46Zge/dnz/1Syuem9VdbilTK5tPqgoayHL9Bg
         c+/xdk+uWz3PHkmxTM7j/pIcNEC0e4um6to9oipwOwE+/6+jh2sde55+OdSUJe1XYfqx
         zIyKFvrLaD3Kv4ETauGICNkzhfeKptn2Ca1YIR5PZsKNzkL7+b4ZZBLBycTev7dOphhM
         pkncOat0LbQxfBCNsU5CqYYkBp10bnL/NtbDD4ZaFx2+qr3M7lN2TNTj1PEsPLDtULBJ
         XHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WVPNocfT2ekubujVG/UQlJkN8bTvqOXqgaZUct3SRj0=;
        b=XifPXoN0gzLJpGM3PuIaqIM47H22P46S/J4DVx0bVvanOOFFc3tvop7kddFma2nUoO
         Mm7tPGzTKe82Pjpaeu9kMDVr5s3O2jyYmsCWPzYfsA/BOe1KV6ZEHShdMICGuHjtKpvm
         zc3xI2YL0/KVTAC/f2z9q0AtM31PoKX1mIXdoRzjMubE4ho3DB/SkF/blhgx2eKy5MBW
         7VnZdAXBnZ3X2Z2xUxpzZxmOAkiktb1WfJLDiTj7CZ9Ew4CgVGgke0dAHUO+a9CGkCG4
         hp4u+EwsmO0o7GEs+ROq17iZSglfVusnhb/Ux44ip6ezLdiCms4Kekevmb0GgH7i5kfM
         2KdQ==
X-Gm-Message-State: AOAM5308dwb684oCV9/w706IUFxJXlWVwASKAKdFXRcfHaIIkJytkYMe
        gv3lJKBXSXW5gLovDFRODq2ApBcr0hY=
X-Google-Smtp-Source: ABdhPJz662HMBoUYDUlK7R89Uu+dpOA6oGFwkSLquD5L/YRB9hqEH5Rwoymuq6aPUTE0b3sDcr9FXg==
X-Received: by 2002:a2e:9598:: with SMTP id w24mr14381028ljh.77.1631987781006;
        Sat, 18 Sep 2021 10:56:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k3sm824746lfo.9.2021.09.18.10.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 10:56:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>, Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
        <xmqqy27wrzmj.fsf@gitster.g> <874kaki1nb.fsf@osv.gnss.ru>
        <xmqqzgscqgmv.fsf@gitster.g> <87bl4rk7bh.fsf@osv.gnss.ru>
        <61ffe5ee-dcc9-4308-7ced-430c3891e898@iee.email>
        <87ee9n5cob.fsf@osv.gnss.ru>
Date:   Sat, 18 Sep 2021 20:56:19 +0300
In-Reply-To: <87ee9n5cob.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        17 Sep 2021 20:34:12 +0300")
Message-ID: <87mto99398.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Philip Oakley <philipoakley@iee.email> writes:
>
>> On 17/09/2021 08:08, Sergey Organov wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Sergey Organov <sorganov@gmail.com> writes:
>>>>
>>>>> I'm not sure I follow. What "show -p" has to do with "diff-index --cc"?
>>>>>
>>>>> My only point here is that usage of *--cc* in *diff-index* is entirely
>>>>> undocumneted, and that needs to be somehow resolved.
>>>> It was a response to your "historical status quo that is a problem."
>>>> I do not think there is any problem with "diff-index --cc" (except
>>>> for it wants a better documentation---but that we already agree) but
>>> Ah, now I see, but it's exactly lack of documentation (and tests) that I
>>> was referring to as the "problem of the historical status quo" on the
>>> Git side, so I was somewhat confused by your original response.
>>>
>>> Also, it's still unclear, even if not very essential, what exactly that
>>> "status quo" is when seen from the point of view of gitk. Does gitk
>>> actually utilize *particular output* of "diff-index --cc" for better, or
>>> gitk would be just as happy if it were synonym for "diff-index -p", or
>>> even if it'd be just as happy if --cc were silently consumed by
>>> diff-index?
>>
>> Did Johannes Sixt's earlier answer
>> https://lore.kernel.org/git/cbd0d173-ef17-576b-ab7a-465d42c82265@kdbg.org/
>> help clarify the choices?
>
> Sorry, no. I did read that carefully when it has been posted. Further
> explanations by Johannes also only tell that gitk expects --cc to be
> accepted by diff-index as it likes to treat multiple commands
> universally, but don't specify what output git expects from --cc when it
> passes it exactly to diff-index. Maybe it just shows the output and have
> no other expectations, dunno.

And, even more importantly, if gitk uses "git diff-index --cc" for its
specific output, is there another, documented way to achieve the same
goal?

Thanks,
-- Sergey Organov
