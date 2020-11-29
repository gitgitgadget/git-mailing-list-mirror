Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D3C3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4653720771
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 10:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eASOEY7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgK2K1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 05:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgK2K1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 05:27:06 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255AFC0613CF
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 02:26:26 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id q3so11161609edr.12
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 02:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jr02zUSydTXXhh0BskK/pYRnRU80xmGRi8rMcJffwTw=;
        b=eASOEY7tPz0mkr1dlxxEP+lZcgubsVbTZTolGvAd4mNN70rHys2eRKxTQAW9eaSXDS
         QkKVHMQU4t6zr4K/geO9gnuwTD/YjwKqhZHPLQZUj7SskwPLoJRkKmtsYa2kvBT2wkyg
         ezuDD81PNz2E1XnFbKFrIzuFB5nYMdjPSZmbMS5XF1jYQaIhqEMvXsOg8ePmlkrdfSVi
         v3yzTyS864dd8QcicRk8L0YKkC30ggGrQJvwpcGm35ogXxkYyLsm6yV4kwZDOhvax9eb
         QlfsR59zaO145Jbqk4ASrLicfDfoU8/eVQFhL3K6cLUvx+Ndv37EXy/DgI9NbEtMxc+/
         Hwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jr02zUSydTXXhh0BskK/pYRnRU80xmGRi8rMcJffwTw=;
        b=APyrJY4Vj8R7mUuLVvzkti+9QSkeHN7HnEd/0RbbwRhGXH/Tt6zmXhZ9mH2RuInzFy
         x/4ys/TquRwilkrwDHu0wwCkAITdgTOerIh4WXLDzZKksjlDzz4GZDESu7G45gP9d6qY
         9GjtkKnAls6mI5xm9lm0Gp7qUErE7SadSyrMr/g+YpSZXrLAFIqpVxAn3Bm/HJ3D53WY
         jbRAAv6AVbVADipC8oP+zeZQDR+Qb19qm9aWHLVoi8mFguEG1tL1IeMfTpKAef2WNdKf
         zv43K/X0mP3VsnL1MvmifRy+dqYEyAjNqBvWp9pAS5ttMEVbYead2+nyASAD08rYrKd2
         t4pQ==
X-Gm-Message-State: AOAM533pVjhtYN+aj0mFsmq56J+1NOxNZ+NiINPV2+nzHSOGN74NWeqO
        mcw9LeQOpSCdNprHhX9349Cm6TiaVO59Pg==
X-Google-Smtp-Source: ABdhPJw7tqowzs54ut7/eB89pxubdVUQZfG6go0lvtBOXKV/vECCrx7bgAUvkhxBuJPvDr2UJXs9mw==
X-Received: by 2002:aa7:cc14:: with SMTP id q20mr16775287edt.140.1606645584674;
        Sun, 29 Nov 2020 02:26:24 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id d22sm6569051eja.72.2020.11.29.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 02:26:24 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/20] merge-ort: add an err() function similar to one from merge-recursive
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com> <91516799e46ebbc91fb6b1811164fe7c9a15a3ad.1606635803.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <91516799e46ebbc91fb6b1811164fe7c9a15a3ad.1606635803.git.gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 11:26:23 +0100
Message-ID: <87ft4sjw6o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 29 2020, Elijah Newren via GitGitGadget wrote:

> +		err(opt, _("collecting merge info failed for trees %s, %s, %s"),
> +		    oid_to_hex(&merge_base->object.oid),
> +		    oid_to_hex(&side1->object.oid),
> +		    oid_to_hex(&side2->object.oid));

(Sorry about the two E-Mails, didn't spot this at first). This error
message without context for translators is going to give them no idea
what %s/%s/%s are. Maybe this before it:

 /*
  * TRANSLATORS: The %s arguments are: 1) tree SHA-1 of a merge base 2-3) the
  * trees for the two trees we're merging.
  */
