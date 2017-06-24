Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9D420831
	for <e@80x24.org>; Sat, 24 Jun 2017 01:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbdFXBja (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 21:39:30 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35671 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbdFXBja (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 21:39:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so8040000pgc.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3+mQ2ghxS0TuFSyiB/72M1UiC3asmMZ6ymFWvb4uICc=;
        b=kmn42CMbTVlEf3eY7KgV6y20SjsIoDHIj1DYA7q75JwgJA7hJpRMGXcsULd7iFLGok
         KJ3mxjMeADqPAOeIwLRK3vNg1+Pg1aGhn5lNZhVIaBJmmCV39EP07t0/WnnFpbndupmI
         D7NnLLMa77xijZnRILYNaEqI/0iwIdOUGw5NzYEqhtpip2iNPCgWwbxKzOKERuhXiWct
         BVhA/eBQ2E+lw1smKPVTwYT16K9b8izxygYAcZOILkMDqOX9nJ2jTutsTQurlI8z7Iak
         iNYwNrh+PIjHC1R2CPme+DL31FG6KaWOVnvmr5cVWiBYDcCGP94kkRLJfwGO9uhtoiXf
         +05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3+mQ2ghxS0TuFSyiB/72M1UiC3asmMZ6ymFWvb4uICc=;
        b=d/KIOaskrZDPeuDdLM1D/bDcEVnihjx9I52l8EPROGF/idpQBFztX/w/pVyfR+1y+u
         O33EIfeeoXZKuvovnazDvM1OjZg6HINXfu0/DltZJaA1MJvlk1i2WDzW/4eHefHgOG8Z
         d3IdoPa+7uDmGIq91rKciwB6bqLiXFeTHOriJT8XzMida/yszo3ZKZR56kIv/80p1Xc6
         GAt1mrBA+zP0vNS6X+1wLwkp6k5+Nnfn9S6YClCh6X4Ct9e4uqmDvQGsNmGT7h9lumcd
         JTmrhYsDiuo5mbw7RLnWqP3MZ4BJJvqIkfrEUTVjtcsmy0+LTiRWErpjZaeYpY//AYap
         uLrw==
X-Gm-Message-State: AKS2vOyo0vb+ktykJF7Re5chcy31PwepGQmA+xQo6K1ArNgwzi+1hpcC
        SQY9RijMT485Rg==
X-Received: by 10.99.111.201 with SMTP id k192mr10715989pgc.192.1498268368820;
        Fri, 23 Jun 2017 18:39:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id d1sm11590924pfj.51.2017.06.23.18.39.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 18:39:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC/PATCH 2/3] wildmatch: add interface for precompiling wildmatch() patterns
References: <20170622213810.14785-1-avarab@gmail.com>
        <20170622213810.14785-3-avarab@gmail.com>
Date:   Fri, 23 Jun 2017 18:39:25 -0700
In-Reply-To: <20170622213810.14785-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 22 Jun 2017 21:38:09 +0000")
Message-ID: <xmqqshiq9naq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +struct wildmatch_compiled *wildmatch_compile(const char *pattern, unsigned int flags)
> +{
> +	struct wildmatch_compiled *code = xmalloc(sizeof(struct wildmatch_compiled));
> +	code->pattern = xstrdup(pattern);
> +	code->flags = flags;
> +
> +	return code;
> +}
> +
> +int wildmatch_match(struct wildmatch_compiled *code, const char *text)
> +{
> +	return wildmatch(code->pattern, text, code->flags);
> +}

Is the far-in-the-future vision to make this the other way around?
That is, this being scaffolding, wildmatch_match() which is supposed
to be precompiled match actually uses wildmatch() as its underlying
engine, but when a viable compilation machinery is plugged in, the
wildmatch_match() that takes a precompiled pattern will call into
the machinery to execute the compiled pattern, and wildmatch() will
be reimplemented as "compile, call wildmatch_match() once and
discard" sequence?

Otherwise I'd be worried about wildmatch() vs wildmatch_match()
introducing subtle behaviour differences that leads to hard to debug
problems.

