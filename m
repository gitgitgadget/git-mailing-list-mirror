Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6896F1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 19:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeCFTau (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 14:30:50 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36436 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeCFT3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 14:29:46 -0500
Received: by mail-wr0-f176.google.com with SMTP id v111so22116522wrb.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7xDn64toh3heXf9xomSJe2/3G4zfnFPlqx9NSPFIOjg=;
        b=WD4PyvaJgmZJvzQBgR744c+ohU0hT4INU52EKIjvyPcxroksaxjigFrxmdQkBaZnKf
         nD2BBCtD9jwfOivVX0xgcH9vyM+hPuVFqK5jYC1b8fJySpeuiaGtdwx6Uvm5eOpyYwFd
         ANn2r99G7HNNNIJ1dCGeiJEIryx36+sO/QIlBu58pNPaPv7lpvOE7ZWEGp0l/hbToVFU
         /JYjUSEK7w8yFY7JTSvf746mFhpqW0MJOWEbBAPH9mwPxUG0xu0xs6wEY0eeun1qPDTQ
         SPD7byvdArM1JVWsNl6/oNtb6ep+rPqf6ilYQOQrurYQ+tvseAHnMlT9svUD/AL4Tq6g
         iK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7xDn64toh3heXf9xomSJe2/3G4zfnFPlqx9NSPFIOjg=;
        b=BZK8Lc5DnyWRCJ756xHCjV5snyEIynVt4b6Zj6qckBSF5GwSnTXINA6NuZ9wN8Go6u
         zFijFfVxbRdG1gnuwQZUFYdF/Py36/KzhpQqKUcSRd7htvAFxw296dXtdOM9ezgcuja4
         MS3+2+NPjk2eNw0/BWfN6jhlcIJKYDbDGH2JHDsMZRw4u35AVpQLFPgtV70QBzOyiwyc
         qrk7ELmdw9z6AvaEEJ/Q5VlT+ptlFSmluDR6f8wgGcL+TxAzU4KE6ltXwbzRT8S4RuZ/
         4PPgAS6XvMpW+n6EOKwY4bCT4irVI5UeyQ1Fun2Ca0vpeu0bxMNfRz/WmMLz7UdzFrJz
         2SVQ==
X-Gm-Message-State: APf1xPBJIM6Al5XSutBKZoihsJfzfHtuyv1WNSLgpgVe1Ixr9wK7mJyV
        gXUKfBKQrRkb4HJGk0mUWDU=
X-Google-Smtp-Source: AG47ELsB5hvQJA2pcOgsbdg7nzexNTVK8t/IxVrRyZpxHlOY0GylEKZc8xIlp/V5koISQM7CHN2pnw==
X-Received: by 10.223.128.201 with SMTP id 67mr16475807wrl.131.1520364585300;
        Tue, 06 Mar 2018 11:29:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 4sm8775141wmz.31.2018.03.06.11.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 11:29:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jun Wu <quark@fb.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff: improve trimming preprocessing
References: <1520337165-sup-4504@x1c>
        <CAPig+cRYsf161-Xomw7daj8XdEBxZAEQQRdOn4krRTpSAFkPOw@mail.gmail.com>
Date:   Tue, 06 Mar 2018 11:29:44 -0800
In-Reply-To: <CAPig+cRYsf161-Xomw7daj8XdEBxZAEQQRdOn4krRTpSAFkPOw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 6 Mar 2018 14:23:46 -0500")
Message-ID: <xmqq7eqp3suv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 6, 2018 at 6:53 AM, Jun Wu <quark@fb.com> wrote:
>> xdiff-interface trims common suffix if ctxlen is 0. Teach it to also
>> trim common prefix, and trim less lines if ctxlen > 0. So it can benefit
>> the default diff command, as seen by profiling: [...]

I vaguely recall that we have tried this in the distant past, found
that it produced incorrect result, and that is why we limit the
optimization for no-context case.

Does anybody have an archive reference?
