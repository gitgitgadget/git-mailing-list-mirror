Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E54BC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 12:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbjAJMY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 07:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbjAJMYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 07:24:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E23A0
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 04:22:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m3so8656191wmq.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 04:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DPiRlb1k3jUNETwTywYRrc8tgZSRvLO9rcYT3CLxS3A=;
        b=qSnNbmDJm13N54RwxDQY1gLa902yubk7ONB7IdGhJZG16C0iE9/pVcUim+Ps841/L0
         U9WMKEgFi+nY6q85L8s7poFzX2ofPMMQABC0OicysdHHwRYOT+gqdNStkSiYVoP01GgG
         Jyr79wBhtNjQITakuYI4el+cgP975WOJQTMJuvBk51/WrqRZKxNYP5Dn97IuU15J+xdC
         1pvDbeCH8Gzt0B5sRZvd4NfI+FyyeGEVNCYWVylT71ydczrKoKzVfIPImVEcqtllV8P1
         CM1JUpbkuVZXhz+LPN8lGuFRSr7r/KVUq+3TtkeUjdcyUjhQBlsGMeGcZKG13EnnmutR
         HDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPiRlb1k3jUNETwTywYRrc8tgZSRvLO9rcYT3CLxS3A=;
        b=jWcLQn9J9BoE1TVIYwhY4zDUHCT0omzqxtihCFVUDquuDMKpa5i2PIPOTgD6Zoa272
         bBWUPKSsXQk41/4XfRJgGAwymIe7Wd/302Ppq0N/7H3RvAkgcSWV3cxOe/70o0Bfg7e4
         e+J9Qnywc0yazcIarv60WWGluYoaWtDTyKBQQ6w33EWU4G0EZwWRGlvQWbqPN/IU6lQF
         3fsiOlrKfIz8VWrus7poRkpXCRDS2+jiWO0mzFCOlKaY+sdVv5BOzUOHZ+hsRuNqvr+q
         qb/fdNwyk+XukYt3zJa9hfYdLaw45+fH9H6gBWInnHD17ta/wZn54NRDtIHSByW4JF90
         Qpvg==
X-Gm-Message-State: AFqh2kr9q+sYHrULGwQixS1/uMkIZ0QHbhMHo7XTL6ocuU1yS5/1+R54
        +lWIdacfL2dyprR0k4r0XgOAqKGiml2Wgg==
X-Google-Smtp-Source: AMrXdXttWw/ajjk250XSZp8SUzLM8Sn/Ri3Pem5NgMbpLXrFoV2V/cGOTuXA9BEhORAJf/eTuQ3AGA==
X-Received: by 2002:a05:600c:2217:b0:3d2:267d:64da with SMTP id z23-20020a05600c221700b003d2267d64damr47645027wml.10.1673353343664;
        Tue, 10 Jan 2023 04:22:23 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t14-20020adfeb8e000000b002baa780f0fasm10944233wrn.111.2023.01.10.04.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 04:22:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFDe2-000OAy-0L;
        Tue, 10 Jan 2023 13:22:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/5] sparse-index API: fix TODO, BUG() out on NULL
 ensure_full_index()
Date:   Tue, 10 Jan 2023 13:22:09 +0100
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <patch-3.5-d96388acef6-20230110T060340Z-avarab@gmail.com>
 <f2e69f51-ae92-4383-d86d-4d5d29c684a6@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <f2e69f51-ae92-4383-d86d-4d5d29c684a6@iee.email>
Message-ID: <230110.86sfgiziip.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 10 2023, Philip Oakley wrote:

> On 10/01/2023 06:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Make the ensure_full_index() function stricter, and have it only
>> accept a non-NULL "struct index_state". This function (and this
>> behavior) was added in [1].
>>
>> The only reason it needed to be this lax was due to interaction with
>> repo_index_has_changes(). See the addition of that code in .
>
> Missing reference. Should this be [2]?

Yes, thanks. Will fix that in a re-roll (pending further comments, will
wait a while).
