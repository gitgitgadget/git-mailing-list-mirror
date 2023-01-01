Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64652C4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 12:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjAAMrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 07:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjAAMq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 07:46:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00443C1A
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 04:46:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fy4so27319050pjb.0
        for <git@vger.kernel.org>; Sun, 01 Jan 2023 04:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iutR5IZmkwRzaWo+JQYdlBX3TQfauvytD/9cOtUAZGg=;
        b=XgSpkocgUdOaS25L4yKZAHSfwJ2wtNJVfR9TzpUQBkr23BPZ+Yu5snQ7wyFIOfe5cQ
         AUT4avt3rGD/jNr5xZA19k4ldwhb+xfHiFdy7h5foHz96xUKhHg2WrPrZp1SGwXc0b79
         AWtyldlVcLNlbS5MSNY2vHsU+Q5Qf/mGDpzoR7ndl+QiFaMoXzYUWjlZtm4ynjcU+nuI
         0r2UGiIfJyd23+ygO09nM+sMUT3UWdXuB5inc58tMzvbXe8RiwqhSqveXUv/RIndDxj6
         I3GeHZBMDIJ4+85+Exr3jKT8QjDU3ptOJ5pcum1iIUhCAEqa8kWp4y/IoB2XfLGH/Yvx
         Gnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iutR5IZmkwRzaWo+JQYdlBX3TQfauvytD/9cOtUAZGg=;
        b=RSKbumbiTP5FSOxyUBa51yxTpu1ZIpAEs49zFTogeB7lLi+N6P3Jd45J2EvuY5f8qR
         uC43C1DH9TZqNs5mpK267aI8XWeJi07X7DV3pz2ctp//gHLPmJykpaJe6p5JvwuszzTI
         GWei761ov/+BonF9COb1yPa4Sys15ZmVrdZhNnUdahAoY//0106H5PYcxogj0OnhqTpO
         NFkxdHpAO+5UNyVYx1MT3RINcK2c4tfLtIRtXr7oqJuNtz98Be25oeh/ZTBqRDPVdV1k
         vytJpO/mCraFZa7FujzBULGH5M/io4KdsqpsNS5C2Bj7cJtAowMLhmCHlH0AEBqxRl/w
         yegA==
X-Gm-Message-State: AFqh2ko3/e5QMRtok+5uYg75XTeI5uvMqfxvdAcudMPRFomGohSCdJx4
        cJN0OaPhdQxKpB1Cwk44rJQ=
X-Google-Smtp-Source: AMrXdXum9v2AaE/0taE9cjkkLSifo7z38zIxlIIWWPwtVZ8xVoZz3ks3MnYxJBwkISZ1w8Qojc38cQ==
X-Received: by 2002:a17:902:f80c:b0:189:ea4c:e414 with SMTP id ix12-20020a170902f80c00b00189ea4ce414mr42534706plb.61.1672577213386;
        Sun, 01 Jan 2023 04:46:53 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902d18c00b00186bc66d2cbsm18335017plb.73.2023.01.01.04.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 04:46:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] do full type check in COPY_ARRAY and MOVE_ARRAY
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
        <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de>
        <xmqq8rinhs7t.fsf@gitster.g> <xmqqsfguhplc.fsf@gitster.g>
        <220515b3-3924-c8d2-ff20-7017caa7dead@web.de>
        <bf4e6798-c687-270d-1344-37bacb403e13@web.de>
        <xmqqzgb2fo8g.fsf@gitster.g>
        <269d85de-1448-0198-8251-9af898fedc67@web.de>
Date:   Sun, 01 Jan 2023 21:46:52 +0900
In-Reply-To: <269d85de-1448-0198-8251-9af898fedc67@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 1 Jan 2023 13:32:11 +0100")
Message-ID: <xmqqv8lqfmmb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Ah, right, __builtin_types_compatible_p returns 0 in this case and an
> assignment is silently allowed.

Thanks.  There is another thing I forgot to mention.  I think the
side that can use __builtin_types_compatible_p() can lose the
assignment check (what I wrote had the GCC extension in addition to
the assignment check instead), i.e. the assignment check from your
original patch can be considered as a fallback position for
compilers without the GCC extension.
