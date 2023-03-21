Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89779C6FD20
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 22:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCUW7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 18:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUW7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 18:59:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BF28850
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:59:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o2so10236536plg.4
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679439588;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fP0t/LPVJ8gpnDuhKEmgt0HrW26PYziH/KOeyrwJhk=;
        b=l2R0+Dlg72vvPiDJpKmXhYi6ITnBqSFz+wGGuhWFf1ObvGxZApWOSeEaUmUoz6cPag
         dhxnD8j28ZENATn71xN5LXmsconn+fR6j/XSZMhrg3xOnnDU1Oro68ypgAAgaOSxaYsm
         mltF+iVZrP/J0XatMYaQ7FdPw7c5KiMq5O/tFfCE7hnUEbJQHs9T5zc8jTJsHg8f58UO
         S8OGDai45foez/n5C3lbcbtJFD6oTt22QFKuBRfv9QC4ckuJutjRaFwP16GM97OYQ3S3
         P1HuvMlbszxEozdfORM7PF0A9aLUjBPuq38nS94pMHrAHUqaN3k8EihZyXsCg1+bA4cv
         FZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679439588;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fP0t/LPVJ8gpnDuhKEmgt0HrW26PYziH/KOeyrwJhk=;
        b=k/B/9Ltd5kRcu+dZ6yHTxjeOtKpRFDtNhSGPt7/Dni6WwETKlt8Lx0MSyEj+hGra6q
         FGpV4NCkT7WzVVPbRV/XZc42iq/yejKnw4HoJqT6yHzi3sSTYWvlSA1tfDYmsL9Rgb31
         bf2VhTdGDX3RMbKrsS7pjqa3b+JFt8FXpjuY2cAhT0AiCe/RLsF17ded0a3jRfMrFL7j
         9dks8BS6ol0giN0Cb8E5EzF1iOyVSLYAPCrcfteAksrEz8o30Ufnis/9jXBwxP7oZq2F
         TDSd8sTrqH6NEAGAgvDHR1kS9gTi3/8GQpktvofeBSyvrdwItnjhUYz7vCyQvd2WEL6G
         cpdQ==
X-Gm-Message-State: AO0yUKU+BhlvrKDuUl1qRVgO/BSntQnhcw88Dw2lf3LLqQmSAccHVFo9
        VeoDigl1kAxnNSwk6O51ghI=
X-Google-Smtp-Source: AK7set8rVpaW9t7FSurOL4BaFguCWCGqHNlSM04V7OA+VKlMXDF2SeWhQkowk1dhURW3fxvU0ODRmg==
X-Received: by 2002:a05:6a20:bf15:b0:d9:4907:d8ac with SMTP id gc21-20020a056a20bf1500b000d94907d8acmr2876049pzb.61.1679439587958;
        Tue, 21 Mar 2023 15:59:47 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id a21-20020a62bd15000000b005895f9657ebsm8721415pff.70.2023.03.21.15.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:59:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Cristian Le <cristian.le@mpsd.mpg.de>,
        Matthias =?utf-8?Q?G=C3=B6rgens?= <matthias.goergens@gmail.com>
Subject: Re: [PATCH] archive: improve support for running in a subdirectory
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
        <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
        <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
        <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
        <xmqqcz5lbxiq.fsf@gitster.g>
        <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de>
        <xmqqo7p59049.fsf@gitster.g>
        <3da35216-ca42-9759-d4f9-20451a44c231@web.de>
        <xmqq4jqx8q6q.fsf@gitster.g>
        <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de>
        <xmqqjzzly84q.fsf@gitster.g>
        <9e215e5c-0b67-0362-fd53-8c22b8d348ff@web.de>
        <e923e844-6891-76dc-e7db-4771b2d91792@web.de>
Date:   Tue, 21 Mar 2023 15:59:47 -0700
In-Reply-To: <e923e844-6891-76dc-e7db-4771b2d91792@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 20 Mar 2023 21:02:53 +0100")
Message-ID: <xmqqlejpg17g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>  archive.c               | 71 +++++++++++++++++++++++++++++------------
>  t/t5000-tar-tree.sh     | 13 ++++++++
>  t/t5001-archive-attr.sh | 16 ++++++++++
>  3 files changed, 79 insertions(+), 21 deletions(-)

There are a handful of CI failures that can be seen at

  https://github.com/git/git/actions/runs/4482588035/jobs/7880821225#step:6:1803
  https://github.com/git/git/actions/runs/4482588035/jobs/7880821849#step:4:1811

which is with this topic in 'seen'.  Exactly the same 'seen' without
this topic seems to pass

  https://github.com/git/git/actions/runs/4484290871

Thanks.
