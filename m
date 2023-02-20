Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775E7C636D6
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 18:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBTSNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 13:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBTSNh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 13:13:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA97D536
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 10:13:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nt5-20020a17090b248500b00237161e33f4so338626pjb.4
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i41s20otOIP+rpP4d/Te6By5pKwWcjx3dNyj2CERRG4=;
        b=Gnu7bKlWbI1zFLzLNjhgRt8tbeHGVcN5FHPtC5bzbZDO5S6yIyt+G1zSJjKp0dO4Gs
         TPz+DhB3Hj5E7bWKznKdUvxRBcHfltfXPgA4GbHqrtvoj2NJcMXD56W/Nb40P0FXS7K3
         Ur1oqnqfhqkqcBE+VpmQIA757lug1ZDOhGR46scEPvuLlvGeXsxGiWHwjGm/mXxLRl9f
         FqykH1AUKoenPFs/q1yrkds6VZKUh6ApWJQbfPZ52UvyfB0DE/+5qniqTOs/ijPvU4Dg
         sl+Ruivd+3CeNAG5XT7C3buyZAY8l795iHkbvwuLhnIdDqeow4juud5Q8uyhO2GbU/lB
         yJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i41s20otOIP+rpP4d/Te6By5pKwWcjx3dNyj2CERRG4=;
        b=3cJ2JMSpFmE35pFnUYUyDc2sVOdgQOEYODh0rLKEF066wCxVa85LdddnuYhW0BsRZl
         zpqC4FJw0OH51q1iYT2Pr9F4cLym2fcHr7ogyt0c89e+Eg+hWNKzuJkOpmQFNPVCoKrK
         +TESY9xZEHh/RiguGPw3hAd68GJFs75VET6Y7fLkjwmY7c+gdCPv6FJaHlemd3E44MOH
         SOiFjN35DasqJnEPvHE+cCr6F0fkDJys/EkhN4QlFpdgiYHKArXk8cEIbTk6x1op0CA8
         PDE4fbvK9MCIBWRJhiiCgjTSSGlaqFapY2xZEP3divWh74D4SWECFZt4OlgQTrC3DTgG
         DtqQ==
X-Gm-Message-State: AO0yUKXs6Hjx0HwWBnh72KzzXGP2sfe2JnQzGNd1Z4FADHLzKezQw/O4
        KZp4KqfySHR6wux5ETVE0LdKkMqIuXXKrkkC
X-Google-Smtp-Source: AK7set+9mcKfLhZu1g+OjYbZ/mNiFUE6nfeM/O5LxmKnH0+fEm7wYm5R1Hlk/v9wf+h6lpu6PYLsQQ==
X-Received: by 2002:a05:6a20:9383:b0:c7:5cd8:f851 with SMTP id x3-20020a056a20938300b000c75cd8f851mr1470450pzh.51.1676916816092;
        Mon, 20 Feb 2023 10:13:36 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.24])
        by smtp.gmail.com with ESMTPSA id p20-20020aa78614000000b005b0853a1a3esm2073722pfn.159.2023.02.20.10.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 10:13:35 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     jonathantanmy@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
Date:   Mon, 20 Feb 2023 23:43:24 +0530
Message-Id: <20230220181324.25116-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200507194354.33347-1-jonathantanmy@google.com>
References: <20200507194354.33347-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here, we are partial-cloning from a shallow remote and some
objects are not sent due to our clone filters. Let's say that
the shallow remote has a 5-commit history and we are cloning it
into another repository with a blob:none filter. The expected
behavior is cloning the 5 commits, with no blobs, except
for the HEAD.

When executing the above process, it leads to errors:

	fatal: the remote end hung up unexpectedly
	fatal: protocol error: bad pack header
	warning: Clone succeeded, but checkout failed
	You can inspect what was checked out with 'git status'
	and retry with 'git restore --source=HEAD :/'

I looked into it a bit and it seems that packet_read() is not
successful. I'm not really sure how packet reading fits into
the big picture but it looks like the buffer is not read
completely.

It is a similar case with "bad pack header" too. The function
read_pack_header() fails because the pack header was not fully read.

Also, is the shallow object not sent when cloning due to the partial
clone filter and hence a subsequent fetching is done to ask for this
object? If so, then will such a fetch counted as an args->update_shallow?
