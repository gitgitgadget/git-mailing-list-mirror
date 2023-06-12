Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B437BC7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 22:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjFLW5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFLW5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 18:57:45 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098089B
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 15:57:44 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75eb918116aso35818185a.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686610663; x=1689202663;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GXERrG0hvD1gpsxbHEmQq4fwY+nkFzrkpCuxdimD5Q=;
        b=kPiri613ccWacoPrYgNbtTpgz+siNPekHuWc+/P6p1w43KkrLEZdF8gVsBnio/rLtm
         XD1qZJ3qzHCyz3lso3HktA0oJZ141RgiPp9REQTmg/cPcOXXsLJBA7TozdYb9tzyCd3h
         k4GAGzlJrQc7+rJF5PocyvkZBIHS9q6MZxA0Qj4IzSdqXzj7Lra1dRHi5R4N29J0dehG
         PXpNcuOYIy6ogRhjMO7PJDm6/e0GK4dYYMelvJfi5I+KbLBIBWqkyRqGh/O7P+6vVdkl
         tsi96q/CZQ2yMy/E4BhR/98o2doog+6vYrh8T03eor0vTmT/Jx5+QcYLAemKcSPErkdE
         z9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686610663; x=1689202663;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GXERrG0hvD1gpsxbHEmQq4fwY+nkFzrkpCuxdimD5Q=;
        b=BOrVK5/gLreOAT2We5NE+u9JqAJ5LmEasCEdxXnEehba0OpEMxo+xAceu0NcEH1WHm
         ouNNGWzH+TcnDEjalwvgWxkGBB8G+7dLehLn7yABYAGQN1ZKtiKB1yqqlsVL0hoc2HF9
         dl5FHD4x2XKisD8f9O0FD2TTGiyNyNPSMV/Sx3SchoFveRtLijNHwxNLXROX0Fx8JfMo
         VzpCzPaW9S22h4LB3g75ZFyC2INi0yvxKqB77HX2lTQG5BQsSrItIPvQPZheKJMi7uI3
         4wWVwAw9KHEzUN04Eaj1NnW0R/nYFZM7MXWrqUlDRLCb/MI+fWkbhwbVdzrLh+lgPwur
         C1fA==
X-Gm-Message-State: AC+VfDyNe5/VdbmS+fx+IUpdVZk0sz2K3A/e+SEYTJzdJRit6Y81oxud
        tQlnmZu2y0kW0QSr0XY69mo=
X-Google-Smtp-Source: ACHHUZ7vyngXy02oelz0jOBVQTsnWrLdIxx6Z0hGf7yk56znVb6vSUVvrdHu0kcJW+SeoZOhJV0pxw==
X-Received: by 2002:a05:620a:4251:b0:75b:23a0:e7ea with SMTP id w17-20020a05620a425100b0075b23a0e7eamr11358253qko.75.1686610663104;
        Mon, 12 Jun 2023 15:57:43 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id n13-20020a05620a152d00b0075ebbd60771sm3184727qkk.84.2023.06.12.15.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:57:42 -0700 (PDT)
Subject: Re: [PATCH v2 19/25] completion: complete --patch-with-raw
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
 <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
 <807b8201d145a21c629797067cee21d1d1b9a0d4.1686574374.git.gitgitgadget@gmail.com>
 <xmqq4jnc8iie.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5cba334c-4d75-0dac-20c6-9e3def1f224a@gmail.com>
Date:   Mon, 12 Jun 2023 18:57:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4jnc8iie.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2023-06-12 à 17:42, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Everything else in the series looked OK, but I am not sure if we
> want to advertise this historical wart that has no practical
> advantage over using "-p --raw".  The only reason why we kept it is
> because we do not have to even think about how likely it will break
> ancient scripts if we removed it.
> 
> Thanks.

Yes, I tend to agree. I can drop this one in the next version.

