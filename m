Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88021C7EE22
	for <git@archiver.kernel.org>; Sat,  6 May 2023 21:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjEFVj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFVjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 17:39:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569817DDB
        for <git@vger.kernel.org>; Sat,  6 May 2023 14:39:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab01bf474aso23309605ad.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683409163; x=1686001163;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYWsP/SJp1KRLEEHHRwh2QywHISR8ZMOUcBe16XG9P4=;
        b=Va9YiVGXxyUyqpNPRrKlZsBBQjuuWK3m+FZgpFYo0f2C7LuGTlsoggLmBswS0L80lh
         FpIw9q4X/9/35LvnEmaVTNyYTALonurHBYmqXse8CwlmcQ8BKfReNPWOodfMODw3jyEC
         hTpjjSC0HXkBh8Mtq3agrMLnNoxSHIOZ4Ycybfv4xuvlLdhLkrtdCmIulcCyKEnpc5ep
         BFFCEWjS7vyGwiGF9dQxoMWXpEcQYQk3Ybamr+KWXAPic8kU3vFz0J8hog5oKTrIubWS
         1mKrMFUXb2gaO9SyQpIvDS698zB1gvGIuFo/jl6PfWFlHkGHpKJBnkfv3ZiCr9bcP2Fa
         bvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683409163; x=1686001163;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYWsP/SJp1KRLEEHHRwh2QywHISR8ZMOUcBe16XG9P4=;
        b=ZsmDZ/1IMaw/SumytQeTcExndjLdaaiWHuUld5/Ah/+/XidDYdffgdrM5eDsOAfJc/
         tFzH6phoP+3SAeDU2WCaz0HDIwsd+mR3dwIZ2Vf3t7bRaMe8c84root0tsOUWPVfUTT4
         3RzZmBrx6u7txTsNEb4KazkOS+0I+FXr9+iqvS/qyZ+UvjW0POHVFT2t7K9dz+bSVknb
         8bX0Lb4SWprUPYyJXX1X0g5aWy6yoJ0zasoHqgZlTE/IIUDdIK0EGZOqUyMHVFoDksNV
         gfvmyBRxiKqBvD9iTpOaWHn6XRvWLO/Am5lTUNtiBBdnVPxuG9a/AItK3e3QhhjreR7k
         SiJA==
X-Gm-Message-State: AC+VfDwX06ntk/EMUphLJyxT1uazKpDdYPycJoCFEKY2dcWuIucpSAab
        oKMzxV2I4XulxkJOSB2bZmk=
X-Google-Smtp-Source: ACHHUZ7wkIXh6BiTZnnIQkctLCSRIa4Ic/OCmbj5NfrT6+Tdf6RjAiywwWuDJeO6TnavNYzm82gVbA==
X-Received: by 2002:a17:903:248:b0:1aa:e631:9f7f with SMTP id j8-20020a170903024800b001aae6319f7fmr6064114plh.41.1683409163255;
        Sat, 06 May 2023 14:39:23 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902dac600b00198d7b52eefsm4093859plx.257.2023.05.06.14.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 14:39:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com, adlternative@gmail.com
Subject: Re: [PATCH 1/1] push: introduce '--branches' option
References: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
        <20230506113408.61529-1-tenglong.tl@alibaba-inc.com>
        <20230506113408.61529-2-tenglong.tl@alibaba-inc.com>
Date:   Sat, 06 May 2023 14:39:22 -0700
In-Reply-To: <20230506113408.61529-2-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Sat, 6 May 2023 19:34:08 +0800")
Message-ID: <xmqqedntrvg5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> -'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
> +'git push' [--all | --branches | --mirror | --tags] [--follow-tags] ...

Will queue.

By the way, you may want to check and correct your patch sending
procedure.  Somebody in your toolchain is adding "--cc=" to the
first recipient address or something silly like that.

> Cc: --cc=avarab@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,  tenglong.tl@alibaba-inc.com,  adlternative@gmail.com
