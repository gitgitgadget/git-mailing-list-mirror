Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED042C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 07:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbjD0Hvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjD0Hvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 03:51:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF81735
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 00:51:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a677dffb37so67631495ad.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682581905; x=1685173905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB4UUGacV0x4HqNa8y8rrq+oDaVSTU0d9pCYnehzSII=;
        b=GwxbDQ84QNjgSQ140xZBNIce+uboo4Ndelh6iWc8gsVCob7/YU4OJC2+tEllp8c7rs
         UgZ0NykXa8xpYMt2Ojc7Aih5H3/JS7MoDmCyIJfgcWHQUctiucQ85oVUBYJvA3xhuFy4
         L4ystHRox4Wc3OvbaCSJ3yQPRKZ3hK5To46cop6+11UbKIxPK2wvaFTwmypucP7kP8Jo
         zL7IS9ZFpdVL5u5OALxnfTR3PEs4zolLb6Y5yIi6YnCoUlu/bsmETTKZpir4HMFz6/Il
         auW2s2txVQdHyZM8J4IDkXMa3rkKraiXl2UGVmzafMwEazIKwKTjDMuJUlSRjtLmu/hH
         VFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682581905; x=1685173905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB4UUGacV0x4HqNa8y8rrq+oDaVSTU0d9pCYnehzSII=;
        b=QGXuhS2smgVHcL8FIBSBsR2WRO8KqhQ/qGdFo8Ugv/4aIOFMJhFM9egJKNMcTv8Nuh
         z0rABRcDpVE0BRuRMr+RUZNKEpQ5nVZffEWglfgvDOv84vXKoAPGcQmtrGTF/WiOWx3F
         M5Hgzqop8T28WGAexWVQT5F+Yr5g5mPMq3MGXVvMmxK6+COgWli45fRX3eUGE0h+2xGG
         Tbi2EwSTLr2tZEmxfBTAeegTqNnhcKRvO1YgPrDo9bAds9IGFCnTDO9ql2NnuDh0Ge8V
         U4QKuC4l8en4B9wieosTglMQ1ofDQy0dLnooHSgvTnxSlFClapOiVeAcXt5UujjkXcBT
         pipw==
X-Gm-Message-State: AC+VfDwBPgDpSbWaCtrLTAWlahYApHtiRtJUcQkLQ+E8FSd5o6nYKkt6
        Eb0wSfTXKfwJxfj1jFWMVNA=
X-Google-Smtp-Source: ACHHUZ6SlmisFq2fS7l+7VYMCG4PFFUN6x3WG8wsdXANFtRw0lepO2hUoResxqC7jo3M5yisAOCaWQ==
X-Received: by 2002:a17:903:228b:b0:1a6:6d9f:2fc9 with SMTP id b11-20020a170903228b00b001a66d9f2fc9mr742330plh.30.1682581905213;
        Thu, 27 Apr 2023 00:51:45 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170903131100b001a1fe42a141sm11067781plb.115.2023.04.27.00.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Apr 2023 00:51:44 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 5/6] notes.c: append separator instead of insert by pos
Date:   Thu, 27 Apr 2023 15:51:38 +0800
Message-ID: <20230427075138.62092-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.358.g2947072e
In-Reply-To: <xmqqa5yv26ry.fsf@gitster.g>
References: <xmqqa5yv26ry.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> From: Teng Long <dyroneteng@gmail.com>
>>
>> This commit rename "insert_separator" to "append_separator" and also
>
>"This commit rename" -> "Rename".
>
>...
>
>> The second is that when we execute the "git notes append" subcommand
>> , we need to combine the "prev_note" and "current_note" to get the
>
>Funny placement of comma?
>
>> +static void append_separator(struct strbuf *message)
>>  {
>>  	if (!separator)
>> -		strbuf_insertstr(message, pos, "\n");
>> +		strbuf_insertstr(message, message->len, "\n");
>>  	else if (separator[strlen(separator) - 1] == '\n')
>> -		strbuf_insertstr(message, pos, separator);
>> +		strbuf_insertstr(message, message->len, separator);
>>  	else
>> -		strbuf_insertf(message, pos, "%s%s", separator, "\n");
>> +		strbuf_insertf(message, message->len, "%s%s", separator, "\n");
>>  }
>
>Is it still needed to use strbuf_insert*() variants when the only
>thing being done is to append at the end?  Use of strbuf_add*()
>would let you drop message->len from the arguments.

Will fix.

Thanks.
