Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C0DC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 02:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7369B20720
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 02:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBnRrstZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHaChv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 22:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHaCht (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 22:37:49 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290EEC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 19:37:49 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j10so2141827qvk.11
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 19:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VISOfab2gNxJEm5TiLbKrtE3irHn54seci1FgyWeNpU=;
        b=RBnRrstZFOxxGerBwIwazVpKoZ07CHY0bd82k1PgswbZ4zUte+gPKJ8L+A4dvpuFRy
         YnfzOCOEbCwQBO9wN+domNYWB9U6ccCYjmJaFim28uT18GQukUW2i18sVfib98HsN8hg
         gIjcpl1k7RRe9NoWw2mrZumkKpjE91DgCEPtdkE7o/Lbbpw8B1yhcER6DqOFZp+h14hX
         yaAySpAX5+f73aymXIfNHhxnj26dt9hUNRA2/vDaNZaHEXO4ou+4PCobAwL7u0i77v1G
         5oFEzOvcsfJicStNmo/vUJN827HAMwZEUVtrdLt9nOG6JtFT2G7KlH//dAXIICTVtj8X
         akzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VISOfab2gNxJEm5TiLbKrtE3irHn54seci1FgyWeNpU=;
        b=H1+xlgDUmDhpA9DzbNa7OZEwt7N6VgjH1jNps/zKWbou8eU9YtE/m7b9Zjkj0R4kPg
         Y/g957aZMEbxLVBp6Ar7fHFD5qje672p78hMTUxw9X4n1b4d5/yC9DGF3+5Ajd24yWN+
         98SRJH5G6wZ+Z+4fA0YiPcyCy/3DbUrL6edtVo13IKke+EuOjNiYyW+KmNSZ6yWeItRg
         TnDcNS/w9CdJQcXZYKE5IZA0MK+SjTycJFdHRnaXQqYigHfhMnMmrNmRCcinIqykL03X
         QVmKFgj+aLM39VbDahCXMpY9l7ZNsBvA0xCy9y7K5M62B/+NH0SRwomhdXvZyIeqdE42
         Qg2Q==
X-Gm-Message-State: AOAM531RRL0DE4GjDWOkSDXYdtEQ8IuEu1DvGf9IplRFxQMdEnBYPmKS
        KLqnm/a8WIcHaXBX2yq/kw0=
X-Google-Smtp-Source: ABdhPJx576zRfxmNfWpSg6+K1btO+Kc/I9J363KD8rj0k/6+Ix/6iR/nCZzxDMLFzGe5lOzM3azRBQ==
X-Received: by 2002:a0c:b203:: with SMTP id x3mr8094386qvd.97.1598841467783;
        Sun, 30 Aug 2020 19:37:47 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w128sm514681qkb.6.2020.08.30.19.37.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 19:37:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Makefile: add support for generating JSON compilation database
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200830221004.GB241078@camp.crustytoothpaste.net>
Date:   Sun, 30 Aug 2020 22:37:45 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <194CC2CB-8C74-446E-940D-DC4582AF3EB3@gmail.com>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com> <20200830221004.GB241078@camp.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,=20

> Le 30 ao=C3=BBt 2020 =C3=A0 18:10, brian m. carlson =
<sandals@crustytoothpaste.net> a =C3=A9crit :
>=20
> On 2020-08-30 at 19:28:27, Philippe Blain via GitGitGadget wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> Tools based on LibClang [1] can make use of a 'JSON Compilation
>> Database' [2] that keeps track of the exact options used to compile a =
set
>> of source files.
>=20
> For additional context why this is valuable, clangd, which is a C
> language server protocol implementation, can use these files to
> determine the flags needed to compile a file so it can provide proper
> editor integration.  As a result, editors supporting the language =
server
> protocol (such as VS Code, or Vim with a suitable plugin) can provide
> better searching, integration, and refactoring tools.
>=20
> So I'm very much in favor of a change like this.

Thanks!

>=20
>> +ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
>> +all:: compile_commands.json
>> +compile_commands.json:
>> +	@$(RM) $@
>> +	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' =
$(compdb_dir)*.o.json > $@+
>> +	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
>> +endif
>=20
> How are those commas at the end of the line added?  Are they natively
> part of the files?  If so, this seems reasonable.

Yes: the '*.o.json' files generated by the compiler contain one JSON =
object per file,=20
with a trailing comma.
This 'sed' invocation turns these files into a proper JSON array by:
- adding a '[' at the beginning and a ']' at the end of the list of =
objects
- removing the comma after the last entry (before the closing ']')

