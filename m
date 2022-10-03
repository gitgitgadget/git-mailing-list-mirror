Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB7C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJCQea (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJCQe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 12:34:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD632018D
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 09:34:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f140so5394390pfa.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhjTTQ8TzOulejjZwCf7g5XSQRubL6GA5DYbUiA4Y4Q=;
        b=TLkEENt2JEE7PMfY16ZbQ1DiVUvjk+m/TeT7gD0CAhQ7MW92iNaYBzJjdSUq68LhRr
         Zdnn6CU8C+kRV+oJrt5E41e5yxfY9CPzEX78Q8D0Ox4VV7ZCKtXkskkARB9idl/wGEzq
         tZeNHg1/k6AHLuJP7lx7bS531qm/Pg4lCSBmYa+Pumb9xjXFLbAtGbULLRtS1yFG73hV
         v8AxOjZYH7EzTC78aY7e6M2bw/5syr7cgLd+TqNXXCVGHFUNlpXRWnD4mnYjpBAkhImK
         bpouTq3OOo8dTf3TW5QyrccfP+X3wsoBHBloNz8u3AmAw/al1WLcFzYgpM0UpLI3908M
         /4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HhjTTQ8TzOulejjZwCf7g5XSQRubL6GA5DYbUiA4Y4Q=;
        b=e9S231ZObUadcpH8+SBcriAkiYep/OS9n8J9RrtMPAtcYmM5qXU7qwV9n6AUGf1m2Q
         v/JyXhP6Q0q8yzVSlS4lNe4oXi1lfnlLlq+vaBrnS8KAjFF9L0OTcjN6tFFjuuRxAH3X
         vbiNAC4Htm2SmpsSSCemukJQqHb13Z0vbKtzMIdzZwSFURxZwumEW4RjvCP+sxM17+iZ
         Lcan/Q6CZq4nLOEiVodwYCdKMe22Vc9F6irVRFH8A/HWsQarPIJhgZSw+/PyCOeG7WkM
         IRLZzEnHd4wiWduc9pr016/lqQpw9e5/DRJIcsE7/uoBbo2qOBd8KPVMj/pXParstJyV
         +r3g==
X-Gm-Message-State: ACrzQf2Q+A/AE7X6zb2SVZhctuz22hQM2HMJM3fah/rFY9WSdyiaknfr
        b8486h418ZMbKGKIv59ufSo=
X-Google-Smtp-Source: AMsMyM5s7DdC281bzMwYmZjbVPyyqqlaSnsT4ICj2D22a3S2pgNk0gSr6IAYjcGY+vidG4g5XRDhaQ==
X-Received: by 2002:a05:6a00:298a:b0:55f:e8ca:f257 with SMTP id cj10-20020a056a00298a00b0055fe8caf257mr11298930pfb.75.1664814867304;
        Mon, 03 Oct 2022 09:34:27 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id cu23-20020a17090afa9700b0020a750c6979sm4355626pjb.34.2022.10.03.09.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:34:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Michael V. Scovetta" <michael.scovetta@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: detect author name errors in
 read_author_script()
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
        <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
Date:   Mon, 03 Oct 2022 09:34:26 -0700
In-Reply-To: <YzqhEcTDwMwa8dQX@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 3 Oct 2022 04:45:05 -0400")
Message-ID: <xmqq8rlwx3vx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Oct 02, 2022 at 11:39:16PM -0700, Michael V. Scovetta wrote:
>
>> In commit 2a7d63a2, sequencer.c:912 looks like:
>> 912  if (name_i == -2)
>> 913      error(_("missing 'GIT_AUTHOR_NAME'"));
>> 914  if (email_i == -2)
>> 915      error(_("missing 'GIT_AUTHOR_EMAIL'"));
>> 916  if (date_i == -2)
>> 917      error(_("missing 'GIT_AUTHOR_DATE'"));
>> 918  if (date_i < 0 || email_i < 0 || date_i < 0 || err)    <-- date_i
>> is referenced here twice
>> 919      goto finish;
>> 
>> I'm fairly sure that line 918 should be:
>> 918  if (name_i < 0 || email_i < 0 || date_i < 0 || err)
>
> Agreed, but +cc Phillip as the original author.
>
>> I haven't validated this, but I suspect that if
>> `rebase-merge/author-script` contained two GIT_AUTHOR_NAME fields,
>> then name_i would be set to -1 (by the error function), but control
>> wouldn't flow to finish, but instead to line 920 ( *name =
>> kv.items[name_i].util; ) where it would attempt to access memory
>> slightly outside of items' memory space.
>
> Correct. It also happens if GIT_AUTHOR_NAME is missing.
>
>> I haven't been able to actually trigger the bug, but strongly suspect
>> I'm just not familiar enough with how rebasing works under the covers.
>
> It's a little tricky, because we avoid writing and reading the
> author-script file unless necessary. An easy way to need it is to break
> with a conflict (which writes it), and then resume with "git rebase
> --continue" (which reads it back while committing).
>
> Here's a patch to fix it. Thanks for your report!

And thanks for your fix ;-)
