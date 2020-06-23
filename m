Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C6BC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED758206EB
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7VzqR1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbgFWRXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWRXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:23:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B6C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:23:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n23so24312805ljh.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OhBtxrh68jBZcX+oVbFuCYwrWLhJafSM6gkCNj00q9w=;
        b=h7VzqR1aQSrg3yyJd0n9uoQ7GMP2Qb8hBF1/KGI5SoZfUgaZeWsAO79RCEjEfEeQTy
         XhHPuxGsdYKi844AtltjDNUHsPRSUprAlWkniqi5MBpJcuqBBFYW8HtH6+fuANT9SC7Z
         IOJfe5l+kR6jdxKJs+42EjKKUZsSg9kvBI8xKJlxZ/cl/0l3jgT1ezgBzsJ6Y5OJlT2e
         94BmbGomQCtiySKCj0IYPqNHw+Kxe7VPtr97M96N6fwN8QzkvAlT1MHQAUryIt7p+50I
         +RgzCRygg5N4krLcYHKGKdodGGQ/RZv7fpmd5TX67Ymuj+EjBb3+P2+9cjsZIGvid53X
         y7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OhBtxrh68jBZcX+oVbFuCYwrWLhJafSM6gkCNj00q9w=;
        b=aCix/lKPUVJSwvZ2pCc5xIgPkKz0NNzaxBipQNkvMB/YhhKpvlqN2vW+YktPNjztkL
         qPdUzmvoN+a4R0+k0s6uevFV/S2Ct5N6gbn+cnSdTW2Cgrd16xDJX0Fu2CrrUM0+47CH
         SwWmg1O8iFF6MvZoUmZo/3qg6R01JdKeUqJYueqs3nly3wyTNy9GsVg5C4JjDRgQefM6
         Sd5WSe2qXyXeu8MdDE3H9I883gLjcGb1ejLtcmhOcJ2k1Zl3wNDUHYP6saqRPFGdsolV
         58bmdxz3fCcVS22nt6l439PLrQeN7GTaUbYKQHWJ7pSA0z49r80EV1JvR9MzLBZ4uZ4i
         zl6A==
X-Gm-Message-State: AOAM531wnxHcXGsz2OGW79Njg3Sf3GZLrVWHWnS5ABQHffnbFPxqLWzO
        ZHwRO8vIm0Hbm9xNiiUyoyk=
X-Google-Smtp-Source: ABdhPJxKEO7XSN6bB0wmiZsaiO1e5kSAi2PGQvgocQOWu2C/dWwVMA7+PuCAZWb9gohS5Qh8bghpDQ==
X-Received: by 2002:a2e:9802:: with SMTP id a2mr1867929ljj.269.1592932984711;
        Tue, 23 Jun 2020 10:23:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q20sm3404465lji.124.2020.06.23.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:23:03 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
        <20200622194122.GN6531@camp.crustytoothpaste.net>
        <871rm6x86y.fsf@osv.gnss.ru>
        <51924543-3e26-8340-2105-1d08adcea196@iee.email>
Date:   Tue, 23 Jun 2020 20:23:02 +0300
In-Reply-To: <51924543-3e26-8340-2105-1d08adcea196@iee.email> (Philip Oakley's
        message of "Tue, 23 Jun 2020 17:16:17 +0100")
Message-ID: <87d05psnm1.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:


[...]

>> The next step would then be to support
>>
>>   git merge --force -- <files>
>>
>> that would force to re-merge <files> with given strategy no matter what
>> their current status in the index is.
> Isn't this already the same as the restore/checkout?

I don't think it is. I meant it to be real (partial) merge, but
performed from the state where merge is already in progress, so affected
files may have specific state in the index and in the work tree, both of
which are to be discarded before the re-merge.

-- Sergey
