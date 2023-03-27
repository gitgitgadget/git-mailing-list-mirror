Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12AEC6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 16:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjC0QJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 12:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjC0QJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 12:09:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA7C269D
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:09:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k2so8885160pll.8
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679933384;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzDhN0QRcRuw1ytzinHVbUVSlMH0dSQPfuKVzFSLKsQ=;
        b=V5Tadf5RcxX6BQ8TH7sWlja4MeU6lo60J30sHdlf+4BWxt2xOY0maNCwMY20ppcfZn
         /UG/apgz+j2Q4dMMprldNpkM0vVlZtO4rD6wqpDVyhQdGqBwrLX2Mg1RUwAoLwV/chzw
         BIiJwx4HJVnRVfk8TOEAmZi/T0dOo5GYeikxCFkgE4A8iAal4zCUEoZK7+rE5N8WlkxA
         +y6dgFVlpEy6ipxDaZFjMN/cIryeP0ufURMtrVQr0PZbsnWjkruv6xZ2ZEyc2/0cwWFe
         wLcCYEiA6HvwKE/7fakJSTVYpXarnRLwXw04+fga02Nt/HL4BiZ7LhZr/vgkiXNAV61S
         Y3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933384;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzDhN0QRcRuw1ytzinHVbUVSlMH0dSQPfuKVzFSLKsQ=;
        b=c3To8REQpATxNbDK3ubJD0ThSa17swTEDfQZJbGGJ0+M94QFG61dQkE7555N1aKmw/
         lgf8GATy5ckqTneJlFRN9CqXjE1VJCLUEAD7O2xEsT4YXonD2UL3e8aDLmeIRkdIQ66D
         R5C2o4k4jjmdY8jadKJKbFLfbGNLn6C6DJLrOVLwbcKw1GhkHQH8S9icdVMJoCQkY8e5
         MjOhyLhaN6JD7CEMtIgv3uEWlaXwBks1+8NI7oqQyHI/15BmxHbpVwIX7wg1niKRQxjo
         yS2VLlBa4aYRFZns9JOShrC17b6e2LMbzs6XtoWe60zy/FF3ekXLMTfBtUK5bkLccxeJ
         IfAw==
X-Gm-Message-State: AO0yUKU57TrtL2Dtguy1tFSE/mSguJvDDbrkY6wfTzxKZmjp9/5vTeY5
        nDi1YyP3B4F9wKvO3yKgCdA=
X-Google-Smtp-Source: AK7set8xrVtbeYsgPNXlre3GFKavcpS66OhHhdZeOCQrhV9xoCP95u71wRS+WuR44BjwHcwV5MQYIw==
X-Received: by 2002:a05:6a20:3b19:b0:d6:91f5:2b10 with SMTP id c25-20020a056a203b1900b000d691f52b10mr10875104pzh.58.1679933383952;
        Mon, 27 Mar 2023 09:09:43 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x4-20020aa784c4000000b0062a7462d398sm7620260pfn.170.2023.03.27.09.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:09:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Cristian Le <cristian.le@mpsd.mpg.de>,
        Matthias =?utf-8?Q?G=C3=B6rgens?= <matthias.goergens@gmail.com>
Subject: Re: [PATCH v2] archive: improve support for running in subdirectory
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
        <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
        <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
        <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
        <xmqqcz5lbxiq.fsf@gitster.g>
        <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de>
        <xmqqo7p59049.fsf@gitster.g>
        <3da35216-ca42-9759-d4f9-20451a44c231@web.de>
        <xmqq4jqx8q6q.fsf@gitster.g>
        <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de>
        <xmqqjzzly84q.fsf@gitster.g>
        <9e215e5c-0b67-0362-fd53-8c22b8d348ff@web.de>
        <e923e844-6891-76dc-e7db-4771b2d91792@web.de>
        <7c33b01b-7b2a-25fa-9a66-1e65cd12bc84@web.de>
Date:   Mon, 27 Mar 2023 09:09:43 -0700
In-Reply-To: <7c33b01b-7b2a-25fa-9a66-1e65cd12bc84@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 24 Mar 2023 23:27:11 +0100")
Message-ID: <xmqqpm8uch14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>   +		/* rel can refer to path, so don't edit it in place */
>   +		strbuf_reset(&new_path);
>   +		strbuf_add(&new_path, args->base, args->baselen);
>   +		strbuf_addstr(&new_path, rel);
>   +		strbuf_swap(&path, &new_path);

Thanks.  That indeed was nasty and tricky.

