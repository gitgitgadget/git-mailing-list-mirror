Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C78FC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 19:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBBTLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjBBTLV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 14:11:21 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB234020
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 11:11:19 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 5so2885825plo.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 11:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+OVdiAMNWSLZthDJDm7NzAVAeLP5lvZjZ8YY8VQVqw=;
        b=n9HRlXsxiRnx0JsqgousEEzHz1EEJtCF+eC988cinJMQK3gxez2+5Gao58fXlfxK7n
         H3bwdR7CgPVmMyIjjA4prb1zCpJgfYDuagRV0qb4XyGcDbVsIJ7Cu6QP4KM6Bf634ZWH
         2OYWh4aubN9SHJlYHI69f/94e9WtymU6DbCrVR0PwqAeyilicrtnkQvqJq5PpTj7OZ1G
         +VcdMcvoOqq6aOBpV6n5sC7OZY/orqtO8QD7vbGFVg4dJ2Pzi/SntHhhGCoOPJG9UHl9
         450Lxck6HUE99/Tywe70kqsEZqRlQvGqVaYZCZ/lsvFVyx8o8SC50MscVbIvlBCuuhkc
         Fibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+OVdiAMNWSLZthDJDm7NzAVAeLP5lvZjZ8YY8VQVqw=;
        b=mx+kCQApJG3i2iLuJyrrUg6izNBoIjIkN74fNsKbGKG3Inz6bV/D+twsw10BGjKxKs
         WLLS4Qa//wdPvmRMwfnKL9n5KiUc5tcfgeWeu0IKnQGny/cMI8Vo9+KzTizIVsNR3ocm
         qPkVAUVACHQsinxX0bmdN+9HFAGM9XYUKIR5Nl/CVhwODCaZLf50QbfLodJ+GPiI7XLB
         KPdiuWkS9zIer945qo4mAjRP7umIBpDKh1ehAma5UBpdk/au0WdC7N0TtUyq53zdDSGt
         totAKn9SkwVGSPztw1K2n+6JS3zxQ91gkLHINjVmzxZgJoRSadXWjIveQy0iqPvDfyzt
         biwQ==
X-Gm-Message-State: AO0yUKXfrwQjMDILSS7ME3cTf40hvRyWT+0AHZ2Tb/PjDSdeNiBJzBkw
        ehhVIVxtvpcTuRIrCyWZz6Us1m6DE28=
X-Google-Smtp-Source: AK7set+NBuSV3iOz5R6vyb4FKrYs2AZMalAt8pS+R1MfJ95ej26b3AvKCKcyMQqYF0cKFgJ8BnwuEA==
X-Received: by 2002:a05:6a20:9b8c:b0:bf:58d1:ce98 with SMTP id mr12-20020a056a209b8c00b000bf58d1ce98mr2463590pzb.23.1675365079107;
        Thu, 02 Feb 2023 11:11:19 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id h88-20020a17090a29e100b0022c1fa729e6sm3621927pjd.7.2023.02.02.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:11:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/6] imap-send: note "auth_method", not "host" on
 auth method failure
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-1.6-3187a643035-20230202T093706Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 11:11:17 -0800
In-Reply-To: <patch-v2-1.6-3187a643035-20230202T093706Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:44:12
        +0100")
Message-ID: <xmqq7cwzvq5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix error reporting added in ae9c606ed22 (imap-send: support CRAM-MD5
> authentication, 2010-02-15), the use of "srvc->host" here was
> seemingly copy/pasted from other uses added in the same commit.

Obviously correct ;-).
