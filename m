Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B018FC74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjC2TCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC2TCc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 15:02:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399152D55
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 12:02:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id kq3so15837920plb.13
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680116550;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9UfdgZ7fyB+9ATsrhxNvn7xER/+dhTWpk2IT6sJaio=;
        b=cpuxJtcckGbyTF5U26xp6f/73MirbtiI85hTW6Ew3oXtM6Mo9JJVHLnvGJ81SIgtpM
         zelFVWV758Vz7Qz1dOXo6Zuj83Cg57rCnQ2looe4Y6S2Z+hcNhx7dfutV6toIpPvzUBn
         9RNRWEKVaM8GVZerhnNP95BtZLY2ra+rUUW/OC8VVXi3YTQSTk4b0HlZH/q5mcZjzltU
         PLwBAIzZanOrZCSCbbOFDihplP2NTsw6I0FPlN5vL4SdERmHyiHTUJt6z/S6q2N6JF/P
         8TvkaInSGuDw1xdflsy7QhKWGJU4qVzvx7n+wBeP8WWioDkOEE/xNe5A48CO6tneOpD9
         68wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116550;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9UfdgZ7fyB+9ATsrhxNvn7xER/+dhTWpk2IT6sJaio=;
        b=LjF2fFv9xMuXCPKhKs+HzY8nSYR0TYK+xjN14iTE8goByna5z7/4VjvlcHQTrIBOaT
         2d3qONaaNmKgsU0D8BTNnO1sHnRkukMDsM7nOKOUs0b/Y9rjbNVq1aHNaeNSX+vpgZLR
         ciSxs52ufPjlqs2CnV0KZ1cH5yQHWGSsGVy/KPmbjojFPa4WsOG+VbVjXQ7G6LgaP9mM
         yFWNHniJHbZVRNiLlmWP/efhU6lMtJA88ww54Rtu899j4FPtEUh6qz15Gm0t7cKQUxWd
         OZsWJqQ0T5yOZElzv4SFDVAIR6p+UkKCSbtxMhQcceULz1OKM57HWcEqfjx3BEgo+/nB
         RRkQ==
X-Gm-Message-State: AAQBX9eEPjAt6xXKrxPAnJZ0sD6h2PKIlJoVNwu6I31Ck0etL0g3rUWt
        OvIYcL31RwXbrVZtGhTAlb4=
X-Google-Smtp-Source: AKy350YeUVWiL3Nn8h2Ozub6vULNNdS05j76YzFBns7b6p+pAaGuJB9tJWi0xqbxLpLdTIcpeJh+WA==
X-Received: by 2002:a17:902:db04:b0:1a1:97b5:c660 with SMTP id m4-20020a170902db0400b001a197b5c660mr3341953plx.20.1680116550617;
        Wed, 29 Mar 2023 12:02:30 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902b70a00b0019a5aa7eab0sm23389888pls.54.2023.03.29.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:02:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/17] cocci: remove "the_repository" wrapper macros
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
        <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
Date:   Wed, 29 Mar 2023 12:02:29 -0700
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Mar
 2023 15:58:41
        +0200")
Message-ID: <xmqq355n9y9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  1:  c167bde3c0c !  1:  e1e27490d60 cocci: remove dead rule from "the_repository.pending.cocci"
>     @@ Commit message
>          cocci: remove dead rule from "the_repository.pending.cocci"
>      
>          The "parse_commit_gently" macro went away in [1], so we don't need to
>     -    carry his for its migration.
>     +    carry this for its migration.
>      
>          1. ea3f7e598c8 (revision: use repository from rev_info when parsing
>             commits, 2020-06-23)
>  2:  1b1fc5d41f5 =  2:  5ac9d5b8905 cocci: fix incorrect & verbose "the_repository" rules
>  3:  34c6b8afd6c !  3:  a3fcd19d744 cocci: sort "the_repository" rules by header
>     @@ Commit message
>          rules. This will make subsequent commits easier to follow, as we'll be
>          applying these rules on a header-by-header basis.
>      
>     +    Once we've fully applied "the_repository.pending.cocci" we'll keep
>     +    this rules around for a while in "the_repository.cocci", to help any
>     +    outstanding topics and out-of-tree code to resolve textual or semantic
>     +    conflicts with these changes, but eventually we'll remove the
>     +    "the_repository.cocci" as a follow-up.
>     +
>     +    So even if some of these functions are subsequently moved and/or split
>     +    into other or new headers there's no risk of this becoming stale, if
>     +    and when that happens the we should be removing these rules anyway.
>     +
>          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      
>       ## contrib/coccinelle/the_repository.pending.cocci ##

After removing the rebase noise from later steps, the above two are
the real changes compared to the previous round.

Are people happy with the result?  I think the previous round was
both read carefully on the central piece of the series, with some
spot checks to mechanical parts, and with the above clarification
the series is ready to be merged down to 'next'.

If I am grossly off base in the above assessment, please holler
soonish.  Thanks.
