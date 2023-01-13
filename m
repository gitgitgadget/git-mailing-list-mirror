Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA43C677F1
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 18:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAMSeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjAMSd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 13:33:28 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9955FFC
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 10:29:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id dw9so21804041pjb.5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 10:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QX9NVi/XrH1GF/YQy4LHV1SaWUerlQKSLbxD9wUtA4A=;
        b=BWRcqFGUDPXG5Yop7CYrWZZrkS/yRIo6G2ufTu3shidscHwf6lsk/75vJeJx8RRA6p
         gDiYU3ItAK/2VYma38cFTMYgw4Zw1nD+ztSO5XtAvqHDp28IEx5v1A4sLl85axJqw7Bf
         bW5icFeu3gLKJjC3ojvU5YGz6WxM+4O5SnlHpFUYYZ9C8leghVM3uhc+T0XYwYQCr6gz
         3NntamJ5QvDyg25tvdgjGX3SZUoMNwzPNX2pUUsGgP6UHF81c3ubDItZH4sWEO/HhrIY
         cNW1itUn3x0GICsRjezfX5yZxkGS5R9QL1VkRl5Pl/HVDYL5vLJu+LzLAbxVGY78JtN1
         oT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QX9NVi/XrH1GF/YQy4LHV1SaWUerlQKSLbxD9wUtA4A=;
        b=nfp9BmgURgDyXo2xW6YpJlUvuJMEVeimzXX5FbMOFrZteKeQ2BSNbSnoOv0rJEHuMs
         S/ZldM9caxzLU3YFIPzqW1vNYrzjLUXq9M2c2X56nUSYv/Dj+xAPpzRgW4QsUzEK9C/Z
         iLuJ2SX690nTHnEwHqKH990sP7r95WoLm3gNryOFINKyLwfGi7FLXPyPMbb99EvJ/+N8
         hLUPl5nk0Z2PdVKnG5/DbakT1VD9dEaVrleyRY3meZ5tpu43jAemK4S64GtbPymamhzz
         j5oOYbL9ybzpd339W4MlES1rWPoZSrECyg9jny0h6O/oI11Q6PSfXTJQqF2Q4z1fNxyM
         EPVw==
X-Gm-Message-State: AFqh2koVLbIRiH/1vW319qwkdbrJ2Y5BBTfWs70aFXurWIxuzz6UMyP+
        uNifmW+oKudcyDR6jqxbYjxvVW+anzQ=
X-Google-Smtp-Source: AMrXdXskFhwDhydZMBQhN7W8KkWO3Lxt2D+zZErUp+xcw1KUtdzsix64iXUZ6MFh7tNLAknR5ho0MQ==
X-Received: by 2002:a17:902:9a98:b0:193:167c:d4b1 with SMTP id w24-20020a1709029a9800b00193167cd4b1mr25438387plp.11.1673634568090;
        Fri, 13 Jan 2023 10:29:28 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b00193020e8a90sm14344411pln.294.2023.01.13.10.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:29:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/6] cache API: always have a "istate->repo"
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
        <26708e4a-93bf-5dec-2b3e-da8f4ce37571@github.com>
Date:   Fri, 13 Jan 2023 10:29:27 -0800
In-Reply-To: <26708e4a-93bf-5dec-2b3e-da8f4ce37571@github.com> (Derrick
        Stolee's message of "Thu, 12 Jan 2023 10:23:54 -0500")
Message-ID: <xmqq7cxq47aw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I wasn't expecting the initializer idea to work as well as it has.
> Now, Patch 5 does all the heavy lifting and Patch 6 is an easy read.
>
> Outside of one question about the istate->initialized member (which
> might not need any change) I'm happy with this version.

Thanks, both.  And especially for finding 913e0e99 (unpack_trees():
protect the handcrafted in-core index from read_cache(),
2008-08-23).

Will queue.
