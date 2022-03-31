Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694C3C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiCaJui (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiCaJug (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:50:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72048322
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:48:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so46914594ejd.5
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gt3rQCGjoM7Ue+yTp5zWgob2V7OhqI5ihH91NGIJqLs=;
        b=Wnw1PgKxw/SmWqRzWmC/2ZAgAPjFz270F8L3wp+NMGgd546dIgR3lL9oDeNMFRR9LP
         aCK1WtLjgPCk4ualSmduNzJOrYixCfWQnunhZCescymOg+BCZdCZtI+tOWlmK+dp50iy
         OxpBywYHeUB/23MV5VZvSSTuf1Uqj2VTAfj+5dKPXnNhU29CmVzbzx7TrY0MjJ/PhwQ9
         ujk/d6E5bANsxFyuyfTHPN5dlcwjWCSTnDdwZnsrprPdCK5LSqHjUEWNyOW0T/DHaJuc
         E4H2OI0dEgGYbA5s7cOXlbO+1LOf/0Kl3heUmO49wJxR++FM4f5odUqfM1ZfnAKcFdg4
         HOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gt3rQCGjoM7Ue+yTp5zWgob2V7OhqI5ihH91NGIJqLs=;
        b=mggRHiPmL13//kSJtzlvKNXn+0rdtUeq0BXOMoLU/N1Tcdgt9pRzSM/6BGrkXW51CE
         lq45wXrMd2FWzgOLnlUyP09yMb48hKIxKomXEH8kUmOh7tLAN9OEWqLkT4z2JF4Kbj5J
         4/pMOYY9TolX51sSKwaiOtpmXO+YA6ZoVGCY2+yi3FDNlIkVO17T2EgC65YT3a4sVQGx
         xQHwWF6Pr7gwfFq5GaOSQB/7s4hFTzduWL/+ypBIk/na6kUaDjXm3+MJYO9Vurp4+ADN
         L8BuT4N+qwfdqldVrrEkhoRpR+cMlOLiniuy6NWY4xkCryj1/9jqjoIzAO6cxp7Y4FLG
         VXWg==
X-Gm-Message-State: AOAM531OOsHs78P3RI5tnplEGqf/wxwkLHd8Y25luNtxD0tKLsAqzWXR
        iRdQVH4hRdZ7EWGqUf0p1Mh3OOyAzPfx+Q==
X-Google-Smtp-Source: ABdhPJzm/EKj5iM8HqP/WI0lg0uXp8QaIXqtZgV7TiM3mUzm6rrt5q3dqYJnc+jexSM/xgJ0c/J1uQ==
X-Received: by 2002:a17:906:60d4:b0:6db:f0a8:f39e with SMTP id f20-20020a17090660d400b006dbf0a8f39emr4285096ejk.54.1648720127841;
        Thu, 31 Mar 2022 02:48:47 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hu8-20020a170907a08800b006dfd2056ab2sm9347317ejc.97.2022.03.31.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:48:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZrQ6-000Kff-Ib;
        Thu, 31 Mar 2022 11:48:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: tk/ambiguous-fetch-refspec (was: What's cooking in git.git (Mar
 2022, #07; Wed, 30))
Date:   Thu, 31 Mar 2022 11:47:35 +0200
References: <xmqqee2i50h9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqee2i50h9.fsf@gitster.g>
Message-ID: <220331.864k3esb9d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Junio C Hamano wrote:

> * tk/ambiguous-fetch-refspec (2022-03-28) 1 commit
>  - tracking branches: add advice to ambiguous refspec error
>
>  Give hint when branch tracking cannot be established because fetch
>  refspecs from multiple remote repositories overlap.
>
>  Will merge to 'next'?
>  source: <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>

If it helps: Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>

I've been the primary reviewer of this topic, and it looks good to me in
its current shape.
