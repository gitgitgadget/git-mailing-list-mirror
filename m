Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C9C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 15:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhKVPYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 10:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhKVPYe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 10:24:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B895C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 07:21:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so78521204edd.9
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Rp/FMkFWU02KQgUzUL6P2bmB22Q4bE2MfghfNdcxkgA=;
        b=EDsiEZr6TdwH0oBMlOfacorS9LEsu17FzI+jZUnn4l2UZwtRZRQGZnfDxAvJlap+Tm
         MN/pMPfBux0RfBnLfHKGPtNpPQC4fnclLZiPz7h30rvbSzHLlQadPf/bD3jVfdIcSqyF
         x4vTIEofo1BRHf+dUq0jrDatPZIfEnoUUbp7BGDlMYdFLsbcMDERVo8P9UrkEJbnIvLS
         RuMwX6QArd01NbPHPFQBICvLgpNisdckmQ4+YqFEqSspjz9WY9Wn1RzB+zFjqFQow8JG
         XDpdCutNouvMZfsXXbne96FV6WepMJ/+81eLb6gCOKFYKnImyq7iC8nMiP9SjfHi9/eG
         x+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Rp/FMkFWU02KQgUzUL6P2bmB22Q4bE2MfghfNdcxkgA=;
        b=vbBrc7gjr6FhwhNolP+CrxJTWxgBA6SdfTs9xSPGfdgGkaugHDSXsif/W/CB3EquFE
         XbwHdsy/lSUUljxRmyZG3iQAyIv9bk8oqyvF8413x1yqFS68ejFcUK5T2C7qIqvR7Mc+
         cq0N/QlL79hlm5ruKITjjdsCjg/jM44qzw/uSE2BFxiqVMyzsSzC+HqrNMZKbdQF11ce
         Mqi6cdhgwSB7VdqfObnWdf4qGi6lQcg9My9H/JczbJCYe2qoWIZ4+uqshHhpBU+VRy30
         DAwJUuwAKgdG6cxXDSBIwTY3COJZHSX56y6tZs8TnGh3hbVg8Wu+0cG6yTJ/cRSS+s3/
         UYfQ==
X-Gm-Message-State: AOAM531PKAEm0U/IViAGNPbFHf5q78VM2YKaoy26e6eQVhEJhH2K7F3W
        uNnl4lwGrbKswyO92WIonw9/kK2woI0=
X-Google-Smtp-Source: ABdhPJz6ywHq31ojV/mLcbMVaw64PEWrAlgYYs0TFH6nIC/Cu9Tx4PnaXG5DxfstInFQlyjGgtNcmQ==
X-Received: by 2002:a17:906:1256:: with SMTP id u22mr43488820eja.317.1637594483125;
        Mon, 22 Nov 2021 07:21:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hd18sm3853761ejc.84.2021.11.22.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:21:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpB8D-0015AI-K5;
        Mon, 22 Nov 2021 16:21:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 4/4] t1400: use test-helper ref-store to inspect reflog
 contents
Date:   Mon, 22 Nov 2021 16:20:18 +0100
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <4ba97a4e70aa437f9f710746fa7a8abad0732996.1637590855.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <4ba97a4e70aa437f9f710746fa7a8abad0732996.1637590855.git.gitgitgadget@gmail.com>
Message-ID: <211122.86lf1gz05q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Han-Wen Nienhuys via GitGitGadget wrote:

>  Z=$ZERO_OID
> +TAB='	'
>  
>  m=refs/heads/main
>  n_dir=refs/heads/gu
> @@ -318,11 +319,12 @@ test_expect_success 'symref empty directory removal' '
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
>  $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
> -$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
> +$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB

So preceding commits added a trailing tab, or was that always the case
with the alternate test utility?
