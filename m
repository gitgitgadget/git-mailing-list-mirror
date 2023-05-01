Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52784C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjEAWvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEAWvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:51:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3364EB1
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:51:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aad6f2be8eso25129615ad.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682981504; x=1685573504;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz6Co4TKsidc0PU/um1dYSvQe9H2LqRZAJymgYy7hCc=;
        b=GYj7ucfK7LCL3YA+nIrbvQEXTLDVZhhBI4Jn7sA6l0+z8iSdVlSElokM59l2bWAcU4
         1if2DcHLIr7zVvMWtifdcltFoPKnrRwQHv3cwEatdNo0L0q6ow7wnclFfCWvoNJTaUIF
         5z+KuW3Id/KBCNlCQ0/pGOTtsQ6HBOYT6mCsxfJ8g3ZP/y2Gmld6x2mKvxLhFJGN2tX+
         tKUSdksC63JH0vGLLJEzZinea9qsaFiOAVsbU3HQOqRcSC1ti7gsIUaIGkudLe0j3Xed
         aJqKXH4s1soUw7HoJL7pJczoSsREeNzuaor/kewu6ifRHttYUhbU/ylVMxgCPIMvELcV
         C8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981504; x=1685573504;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sz6Co4TKsidc0PU/um1dYSvQe9H2LqRZAJymgYy7hCc=;
        b=Fi53zrj4LaW734b4pS/pTJrphg5UsIVQ7KXx+9afj420udHTYNdTesAm/N0tn3BVsC
         PFTo+jR3WIiwq3GA3nevHlsNmsIou7DJ8L21QB7l09/8QlPsKp3m6YV6GjI5/ewaxVCf
         ZXed00ZMIV1eMM0C/Rq1lpzaQ060exFsTS4RJPvbEd1tEpW9S90AJ6XvP74c+jt2hkU1
         J/H3AKtLnbLnTF8Tyf9cD6Bp0DyFW6grbSqI7xC5AEDqSAMAYr1kJ/oIXOp6ro3pN5J1
         QsJzxElGRtU2S79XpFk7KK0ETAHEEC290FQ3+r0JX+UwnwCKDi26E3OuDWBy/jAKARGF
         13IA==
X-Gm-Message-State: AC+VfDzkxaVf9JfbPvfa/3at0ZayYmx59Ps4Tx3OpRVork1NgjIWb6/A
        Tck//5MQG1Sx6J5WqOqS/oc=
X-Google-Smtp-Source: ACHHUZ64d8rUvpqREslCwilSvmlMsiCFO5nCpmN8fPazv7rcj0LPtsmwg1g0O0SoVNA5cF5RYlHoEg==
X-Received: by 2002:a17:903:245:b0:1a9:37f4:6345 with SMTP id j5-20020a170903024500b001a937f46345mr17991215plh.12.1682981504467;
        Mon, 01 May 2023 15:51:44 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a682a195basm18461509plb.28.2023.05.01.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:51:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH v2 1/1] upload-pack: advertise capabilities when cloning
 empty repos
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230501170018.1410567-1-sandals@crustytoothpaste.net>
        <20230501170018.1410567-2-sandals@crustytoothpaste.net>
        <20230501224038.GA1174291@coredump.intra.peff.net>
Date:   Mon, 01 May 2023 15:51:43 -0700
In-Reply-To: <20230501224038.GA1174291@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 1 May 2023 18:40:38 -0400")
Message-ID: <xmqqzg6n1x8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> @@ -1382,8 +1386,10 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
>  			data.no_done = 1;
>  		head_ref_namespaced(send_ref, &data);
>  		for_each_namespaced_ref(send_ref, &data);
> -		if (!data.sent_capabilities)
> -			send_ref("capabilities^{}", null_oid(), 0, &data);
> +		if (!data.sent_capabilities) {
> +			const char *ref = "capabilities^{}";
> +			write_v0_ref(&data, ref, ref, null_oid());
> +		}

Ah, this separation of duties wrt the namespace stripping makes the
result easier to read.

The version brian posted looked good enough to me, but if we are to
have another iteration, incorporating this change would be nice.

Thanks.

