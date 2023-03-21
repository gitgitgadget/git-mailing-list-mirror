Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22C2C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCUSWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUSWk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:22:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADFF4DBE1
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:22:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id kq3so4546654plb.13
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679422958;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8LM0TG+nY/lOse7Se2wNMX8uNeFT05QSdJxKNXSu3E=;
        b=qFbIUqKrV3/vBMPBZv+t4riLykXnR+36w6yME8ReB9pp66/UdNbmDxpq7tKJPFrE/y
         q8GW/ENpzmP7k4KWEJ2bPbCcEODKl8erkOzLN38r0fzWTjOwj7lk/49sTWLqY3voXOE0
         f3TooZz2Fv0kMFt22gDb4L09yh2DpRzjSuQx8ZpvSn42ggJ48AfQdC89I+cIg6HSfwCO
         L29t+LlWnBEpirVnTgB9aiaAyQSbSeuo7VPkwU1x8YnnR8yXItGkbszreA8aHtEf80hD
         ixkZxS9B6t+9jCA6XTqCtWlIWqnqYUl/88VlWxJrzbQjJ13FG1KaN0zLYwmc02HkSZdl
         ilTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422958;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j8LM0TG+nY/lOse7Se2wNMX8uNeFT05QSdJxKNXSu3E=;
        b=5J2l2Q8zM3ka/A84l1/edxPlfR6OPfi/sy1NR64D39cgRVwup6MCZKHlhTRdZrKwZT
         ru9fYAOMuOVgGcdBE8VZchlQTP+obl9h0csXRhZetrOybXg1m7bJ+38dRg0fWsrj8whS
         hpTIJH9SmPolOSgrN8meoAB+fsfzmX2Lq6UKa/Kc+Xs5j9KBnmdPcAYuVmOAhDosm+2x
         TAI02jIGcbTw6fmAvI4kLjMsoTUvNEOCyeestsceF22OVC0ulbIhrwC1KYbtLxMovHx5
         sH/3vBirTyT39GVudLt2CguU4Phm9KNc8wIH7h9otvbcdPCMErWXIWKAXt7NyKC9XTtD
         wGGw==
X-Gm-Message-State: AO0yUKX4bzpPdBzJPrYuTjwxI4Qg8VreiwBYBJrScQVTJUq0lMVyW3pk
        yCs34dKNEeLHekan1UE2YkA=
X-Google-Smtp-Source: AK7set/3xxptDg5GUldAJ4CUJzPiuUlgM+1kJa4KSl5B4NveKQzdoFDZlvvi9HvdnDtcr736fmK3CA==
X-Received: by 2002:a17:902:e5d2:b0:1a1:956e:542f with SMTP id u18-20020a170902e5d200b001a1956e542fmr105616plf.19.1679422958667;
        Tue, 21 Mar 2023 11:22:38 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019fea4bb887sm9122235plb.157.2023.03.21.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:22:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
        <20230320230507.3932018-1-gitster@pobox.com>
        <20230321174444.nuvym6ti3p3rd6hv@carbon>
Date:   Tue, 21 Mar 2023 11:22:37 -0700
In-Reply-To: <20230321174444.nuvym6ti3p3rd6hv@carbon> (Konstantin Khomoutov's
        message of "Tue, 21 Mar 2023 20:44:44 +0300")
Message-ID: <xmqq8rfqhslu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> writes:

> On Mon, Mar 20, 2023 at 04:05:07PM -0700, Junio C Hamano wrote:
>
> [...]
>> higher-res methods like gettimeofday.  Although strictly
>> speaking users should tolerate this behavuior because a
>
> A small typo: it should probably read "behavior" or "behaviour".
>
> [...]

Thanks.
