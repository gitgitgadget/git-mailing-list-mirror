Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA2C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 15:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjERPRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjERPRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 11:17:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAD0C9
        for <git@vger.kernel.org>; Thu, 18 May 2023 08:17:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so16209705ad.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684423066; x=1687015066;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/TohTk5f4fy4aOqvTv2kE2jHD5uODuYWZMHdGwAI4A=;
        b=PN5KASz1eRroLzZ84yFBb8AUp9/mMKFHGUIi2ljmDETecWGvEojtuPGYxgQSA6NyZ7
         tKWVPHN76TpvRPQES6NQ4Yf3Ij93hTdo7Fl1oUUs/rbLA/45gH3Wy+rkLkQBkC8ndGXQ
         JX1OzrE9NL3XbITnImNKLsx6VUByiinyrFxbmoTOJQHEewQxE2eh14hZbGoRqz+R/MgK
         CVX6Pl/jUAiKaB5FDWv6lc/w8IKdS3VZtNgvwMeZOiXYzX0rjG29rhHWqrlYpxGkJa8H
         6AN85xtyIKcBKOIwIBxtmOgUdNdBDZnV2Sr93vI3mus2y2qIZY4PrQI1rHRusPuNSpvt
         CGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684423066; x=1687015066;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/TohTk5f4fy4aOqvTv2kE2jHD5uODuYWZMHdGwAI4A=;
        b=DH9ATeSbsrOttY4bKFyC3Bku3bI34gOLEUCM4FHOvam0Ippmrmww9ig/0Un1IEC7OG
         NO1PdFe1boDk/+rNaO2GQxVZQ31nD2dlwMHbT4kmDyU3FGENJslv5Jj+tRS16GycLBNE
         XQyW9RJI4a6f1cxlpFvqG6wc9ujpc17FlXmQPnBlK2BU7TgUhspZr0WrWjtmLRpcZmql
         UIqvxTRGzBmdYjDy0IdqA0f2j7HD17KnEikNO9tRWw4KxlV0529zxZ/85/wcEPuOFpNF
         EkicQb8iHTuDxFn2LuHZxh5T64K8vxPi4w9l326Ide4RCmivyvIDvqXPB/8Biqsibudo
         KQ9A==
X-Gm-Message-State: AC+VfDybHGz5KPpX5cU6MeZyvYLpY5oPxKXPfOMiWp/3b8uloA0ofnOo
        nHaE08771T9sqDAOSZ9dZ1g=
X-Google-Smtp-Source: ACHHUZ62DNYqdFGff1zaW2gsuOcVUsCXPlw14VgLbaHZea0P1YpWLRRTbtQV/cX3fkKtw3f6Q7Lnrw==
X-Received: by 2002:a17:902:e80c:b0:1a9:581e:d809 with SMTP id u12-20020a170902e80c00b001a9581ed809mr3670024plg.7.1684423065763;
        Thu, 18 May 2023 08:17:45 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b001ac2be26340sm1551635pld.222.2023.05.18.08.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:17:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 0/6] notes.c: introduce "--separator" option
References: <cover.1682671758.git.dyroneteng@gmail.com>
        <cover.1684411136.git.dyroneteng@gmail.com>
Date:   Thu, 18 May 2023 08:17:44 -0700
In-Reply-To: <cover.1684411136.git.dyroneteng@gmail.com> (Teng Long's message
        of "Thu, 18 May 2023 20:02:05 +0800")
Message-ID: <xmqqfs7tvfc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> Diff since v9:
>
> 1. [4/6] support `--no-separator` which means not to add any paragraph-breaks.
> 2. [4/6] Fix the problems by the Junio's suggestion [1]
>
> [1] https://public-inbox.org/git/xmqqsfcjbuud.fsf@gitster.g/

Thanks for an update, but it was a bit unexpected to see a full
reroll instead of a new patch to add --no-separator support on top
of what has already been queued in 'next' for the past 10+ days.





