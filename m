Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43826C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 21:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjASVvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 16:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjASVtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 16:49:07 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79598A732A
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:33:07 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i1so2549975pfk.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zb5CEKmVkKP6MSenxQV6oBCAPhV9fjMpf8ThJWgQTwc=;
        b=FhzS6iij3quKyW8ZConsoGCebKDiebRJzbiME0EJO6NC1sNIdM/rjtlM0RDHZNZoAu
         NPivQXN8EcT+Fn8tacOBphnlqqmNbtbqMY0tD9FIneU8wU5OTab+VVp+C+AaKlx9zoxn
         6hn12qxCcA2pfPrAb/IHiUrWzFV5CJ1lUPC9Hj5AC8VyOI8vcbFrGz8GxT1zkT6DB3R0
         BoKUESQoOWkwCDfBhT3zyUHyqXD/0DfYcUSXeVIynYCdMFjAKkPj5eMK3S7Lppz7FVl2
         E2Gwa67qPPbHGJDLDWlnctAfCGa06CgRwOQm6FPBnFYJL+/UGrKj5DCJ5jyBPjoBXjSp
         6qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zb5CEKmVkKP6MSenxQV6oBCAPhV9fjMpf8ThJWgQTwc=;
        b=ed348yva/KO1uZCrIdGWv2Cpd9ym95Xwkf+ezKBe6MI5dB2jeFkJGT97i8kMhu6PbV
         cwaGmdenIXZoKG6n8DV/FfrUYd80BL7t1R3rlEq8RXb4EdEO4m8cdoJ5smLSXmwKqSxd
         /y3oIusDUo0mM7rlUDukMf2EyUYFITUHhi1B4ZvLmpZZWKGvfs4LrnsBRqHvlBh/SqjB
         oFxZZ6UFwRyt7UVIcWWztuN9KQVekXGLdtaXQo93MENlsch1kr6T2VpuzdKQDObqq5wV
         sv6ULL1eaiP3Q3642T2Jbf6qnTB4wGXHTOe1r3agX41UWvZRbj/SejO58al2BA564XUZ
         XiTg==
X-Gm-Message-State: AFqh2kqxEXPYmYmK9hF12NF0SZHuhY3iAuZxgsotCnqizCi/6rkwAmDX
        7xCTcy6cYL3N7Vy5+OX5EgPV9a1jyr4=
X-Google-Smtp-Source: AMrXdXsDfkVtAaXa8Dhz8TZ1SVcVhboBCLFKYrd1BklMKp2gCHP8UzfbaxtTvH/S/kW2b31sKaoxnA==
X-Received: by 2002:a05:6a00:1887:b0:589:d831:ad2a with SMTP id x7-20020a056a00188700b00589d831ad2amr18438019pfh.6.1674163986931;
        Thu, 19 Jan 2023 13:33:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y16-20020aa793d0000000b0058df43c29fasm2682099pff.120.2023.01.19.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:33:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] branch: rename orphan branches in any worktree
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
        <a47ff192-db67-dc4c-ded3-cd1e7c197726@gmail.com>
Date:   Thu, 19 Jan 2023 13:33:06 -0800
In-Reply-To: <a47ff192-db67-dc4c-ded3-cd1e7c197726@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Mon, 16 Jan 2023 01:04:26 +0100")
Message-ID: <xmqqedrq1a7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> +	if (!copy && !(ishead > 1) &&

Logically it might be necessary to be able to extend "is that branch
what we have checked out, yes or no?" bool into something else that
can be something other than 0 or 1, but as soon as you did so,
"is_head" is no longer a Boolean "is it a HEAD, yes or no?".

Now what does that value really _mean_?  Please rename the variable
and helper function appropriately to make it clear what is going on.
