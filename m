Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF1C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjELTV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbjELTV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:21:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA1B8A58
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:21:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643990c5373so10522702b3a.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683919285; x=1686511285;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bWT18DOWj95RxSIHQb77lOlYKLV1IqXwQs8nLDOPww=;
        b=e2lzJ/jh/zcZNY7ZvN47+NNpxbF5qgpARCCsAR7ziayMWcqgA+AAHVM9kD9K416PLS
         WHEHKMae+iYeH8XeTrwv/9vgM1Bzzy/RLQt82r0huPHmCGQW7FBoDbq3vlnQtNqw6Sld
         aYyfBTer69YPUs9cW93xVxGECPrmp4Qa1b7uN89gY2XZM21VFMHg1Rrw8FvrO3o9ykaB
         3rZlFqtEBUawOjDPM3El0J3nmHPpuo6X4c5xbmkeFmj5F3WQsld5zo8xRsyyyuylpv3Z
         md2ltKDmfLLhn+u0MWeDPbxj9dh26Ja5MTtrS/Nd/NOrkCZiUI43Cpr0VjyymkT7LoH2
         QUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683919285; x=1686511285;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7bWT18DOWj95RxSIHQb77lOlYKLV1IqXwQs8nLDOPww=;
        b=lXDHl/x/D4ftrnX5f1bOXiPhCbfZ5TW0oO9J5MExKeczuSoHWTHmLJ+I1NCAZOCs+u
         K4PvLLje/MtDquBl9TQFFU+o2sJGoHJu/coqEVcuOOVDCmHJpMPhLQvyAOVeTvCPo3Cq
         zp9/blVrod78pBl48oA5DAo0QPzcXrdw//nQVeO+DvclIdCd5pQG1g8ayk2RewSQLQRa
         ly3+d+6m5Ny4tyU4359vuL0pyvhQSOxMdZqWjOzFs4JSuIDz+xj8phPFmHaY2qjSOIM8
         hwzWgkEN52x344edJdiaeUYOVGxzZazEIyFNaBfK7KEDSR9Z637Us6QkARqExM78QB3c
         ngYg==
X-Gm-Message-State: AC+VfDyQEqNokDYZQjrXWd0151/S7D8OOFHKmLudXWprO335ssm5xBGu
        dHSr4SAfIeSSAFnDOYh8VLMDRLO8MWA=
X-Google-Smtp-Source: ACHHUZ47fO3dqLo0hX8jdah+dF1h1UkkFD0Cwh4crXR1hQvrBJPyeEIRqtHVewRvV3ecf0r4cY04Aw==
X-Received: by 2002:a05:6a20:2590:b0:f6:51ff:9c27 with SMTP id k16-20020a056a20259000b000f651ff9c27mr35915978pzd.42.1683919285451;
        Fri, 12 May 2023 12:21:25 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0062a7462d398sm7628657pfm.170.2023.05.12.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:21:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
Date:   Fri, 12 May 2023 12:21:24 -0700
In-Reply-To: <87h6shif6q.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        12 May 2023 21:21:17 +0300")
Message-ID: <xmqqv8gxpd8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> --patch. Thus, making --no-patch a synonym for -s was a mistake in the
> first place that leaked through review process at that time, and
>
>    git show --format="%ad" --no-patch
>
> will still work the same way even if we fix --no-patch to disable
> --patch only.

Not so fast.  I have a show.outputFormat configuration variable to
teach builtin/log.c::show_setup_revisions_tweak() to tweak the
hardcoded default from DIFF_FORMAT_PATCH to others (primarily
because I often find myself doing "git show -p --stat").  Changing
"--no-patch" to toggle only "--patch" away will close the door for
future improvement like that, and "will still work" is an illusion.

The user needs to be told that "--no-patch" no longer means "-s" and
somebody needs to apologize to them that we are deliberately
breaking their reliance they held for 10 years, based on what we
documented and prepare a smooth transition for them.  Until the time
when nobody uses "--no-patch" as a synonym for "-s" any longer, such
a future improvement would be blocked.  And that is another reason
why I want to be much more careful about "should --no-patch be
changed to mean something other than -s" than "should -s be fixed
not to be sticky for some but not all options".  The latter is not a
documented "feature" and it clearly was a bug that "-s --raw" did not
honor "--raw".  The former was a documented "feature", even though
it may have been a suboptimal one.
