Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE0E1F454
	for <e@80x24.org>; Wed, 24 Oct 2018 02:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeJXLYt (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:24:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXLYs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:24:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id q6-v6so3800662wrw.11
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 19:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2gUwXgQB790VN7aWNe2PbAIbZ+J+ybQgE8AyEgfaTqA=;
        b=ADH+slwmhm6piLTN71jv4lVcFSemRPo0Y+au0p5UqbS0YqdImUSI/Qw7CinwhkFp8Y
         B1FGCURarmK17UT7fho3d4d/FrpU68cocAoYg6wtxjPwl1LOZ7oPN41i6+XCPL1mgJ5j
         ap5Xv6vulLuTd2gvAfWsQUJDCAraXS0BHU1xudLrpD/tK4oHYqsN9n3fkOteMYE4qGVK
         zB8Fmx+R0X0P3HNbFD7IDIKaSNOH47+YQdxrhqh2/y3GKxohUG3md9AscyPtKkyU5/1c
         KvimEFwWlzl7rsXM5Cp8FXMbrb7ost9XqTwuRe0jy7nDJrcVXWoGPBjLMQPHhre3fnu4
         taVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2gUwXgQB790VN7aWNe2PbAIbZ+J+ybQgE8AyEgfaTqA=;
        b=Ffm23AirHcHGrslduigVDAXpEh8GK1ZiCMFhx4pXM3uRv1/ctehWfIKhc4vhJ4Mwq1
         jTtCLmbIz0snLmXcqtlYib63YmaTHnOZ3OiLGog3iu1yL3QuD3dwLiyyHsKo5VcO5iOa
         hRdPBjeQiGx6fr9XG8e8OfQ62aFsd9Kd5F9vMQFPTdlnBDhLSqhVvo9yrtqIyyHUXjdL
         tHL4m4cz15IArK8259y9mzGsV8QFVAnv87op/4yGB+FH18xxXSVvtuu2f9P3H46Z7nH+
         dgQ7DduVc+N0opjNOFjZTAEQdTjxa1M1Yqd03jEMiOJNCEgsHFI6LRZgWsLnPu8+V/Yw
         1OAg==
X-Gm-Message-State: AGRZ1gJRcFtjZRdrUXQa/wOWNnmS0ZhzeFP/PbcuKL9UJCkBIgOa79G5
        wSKUJicIOFNKdXXvLpt9Czo=
X-Google-Smtp-Source: AJdET5elR9qS8VgRLVu+aTOzyutQrqZTrGzsOqgihE9QVfA5xCpSB93uTyq8vT3eCjfoV2EfuU8aRQ==
X-Received: by 2002:adf:f301:: with SMTP id i1-v6mr709994wro.161.1540349925140;
        Tue, 23 Oct 2018 19:58:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p8-v6sm3324936wre.50.2018.10.23.19.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 19:58:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH/RFC] thread-utils: better wrapper to avoid #ifdef NO_PTHREADS
References: <20181018170934.GA21138@sigill.intra.peff.net>
        <20181018180522.17642-1-pclouds@gmail.com>
        <20181023202842.GA17371@sigill.intra.peff.net>
Date:   Wed, 24 Oct 2018 11:58:43 +0900
In-Reply-To: <20181023202842.GA17371@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 23 Oct 2018 16:28:43 -0400")
Message-ID: <xmqq1s8gqcd8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also think we may want to make a fundamental shift in our view of
> thread support. In the early days, it was "well, this is a thing that
> modern systems can take advantage of for certain commands". But these
> days I suspect it is more like "there are a handful of legacy systems
> that do not even support threads".
>
> I don't think we should break the build on those legacy systems, but
> it's probably OK to stop thinking of it as "non-threaded platforms are
> the default and must pay zero cost" and more as "threaded platforms are
> the default, and non-threaded ones are OK to pay a small cost as long as
> they still work".

Good suggestion.

