Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1652AC433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 18:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB1364DBA
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 18:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBNS0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 13:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBNS0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 13:26:20 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54466C061574
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 10:25:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id y26so7676684eju.13
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 10:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lJEsyBoGQGWoPaOsE5Q76UieSV5S3Fd73G9ClBBUhbA=;
        b=Piv6LpbYbz8IocUotbc+wcp6ssfqxaFBQTCWeyuJS44GsbvhVQnVy2/360vhPTrsN3
         BoJpvxuwIiXNXEG9n5fyoH2IYoX7yoBe7ry8ZemLzBeMGNro48tlyzmMlO8JiERehCtj
         RwxCo9vHOpXv+BFPWntSlurBvP2kiKLzBaovFJ8KazsjYB69Fp5svpaoVG4+cQYRHSr4
         jFUESuvwXDvKqf9qfVasYf2enKgClVN7mshUC+CY+ESh399ju/VxOa8qsoF+yeb3qtoa
         JMOxYcBoTmcQPykAzs7pT7mvn8p4MeOsfPSyHIeyDKqNWfHaR4gAUaxQ1mJX+zdbPTCU
         IZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lJEsyBoGQGWoPaOsE5Q76UieSV5S3Fd73G9ClBBUhbA=;
        b=Hyv9yJ9D30XMIEcra+J4IJD7iPNZ3r6ZtHwBvT58t5mzSz+GPHbRvTvpMhqTn9Up3K
         5a92W6QFeA2dzhdJaO69qF8kwhZ9W5TnW9kQVHkjUaHHkcs/MaD3VXX67qsAFhrHJi1d
         IXWqG03HDjtujshqrdMYlhyPrntSQRtgpBD94hmw+f8vrjDWk1uHbddwSozGnpKQCd5B
         8pWnzYWsH3STKtUyJyzj4ujmDl9w62zIi3s+spkqMs3CCRsK7VUC2KZPMqYY4mG/+QcV
         Rl6XwvbVQUh5a/I3Ykh/DD7tSOgJ/8d6KqXlruwJy01n5SrBtF92cLXdz+RsyuZbYBit
         2CiQ==
X-Gm-Message-State: AOAM531GRE4dOHwvlQs6LMgnDvEjAXNJiPw3WbGk+6QVhq+mx2u3+2y2
        b4dlYEM40DBKmnuNpR/vVYO+JFZT+qdsYQ==
X-Google-Smtp-Source: ABdhPJxjWIn+T7eXXbbNCkkFcjRcRXv9qWT91AZe8xKSgIpkFjn2vpOZ8RpcbTLfIeu/CndsSiupSQ==
X-Received: by 2002:a17:906:7ca:: with SMTP id m10mr12071639ejc.257.1613327138922;
        Sun, 14 Feb 2021 10:25:38 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id i18sm8921629eds.19.2021.02.14.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 10:25:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
        Protesilaos Stavrou <info@protesilaos.com>
Subject: Re: [PATCH] userdiff: add support for Emacs Lisp
References: <20210213192447.6114-1-git@adamspiers.org>
 <87wnvbbf2y.fsf@evledraar.gmail.com>
 <aab77ef2-c619-ed87-6c3b-9a1b5ec36f41@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <aab77ef2-c619-ed87-6c3b-9a1b5ec36f41@kdbg.org>
Date:   Sun, 14 Feb 2021 19:25:37 +0100
Message-ID: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 14 2021, Johannes Sixt wrote:

> Am 14.02.21 um 02:41 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Just a cursory "git log -p -- lisp" in emacs.git with your patch shows
>> e.g. lisp/thingatpt.el where forms in a "defun" aren't indented (before
>> it selects the "defun", after with yours it's a "put" in the middle of
>> the function).
>
> Note that negative matches can be specified. We use the feature in the
> cpp case to exclude public:/protected:/private: and label: that happen=20
> to be not indented. Perhaps that can be useful here?
>
> Oh, and BTW, what the patterns treat as "function" must not match what
> the language treats as function. The purpose of the hunk header is to=20
> spot a place in the source file easily. So, it does not hurt if
> eval-and-compile forms are captured (as was mentioned in the linked=20
> thread) if desired.

Right, so having lots of test-case is helpful, e.g. for elisp maybe you
have a top-level defun, maybe not, maybe the top-level is a "(progn" so
you'd like a second-level more meaningful context, or maybe not...

Obviously these userdiff patterns aren't a general parser and will
always be hit-and-miss, it's just useful to at least eyeball them
against in-the-wild test data to check their sanity & add some tests.

My cursory glance at the emacs.git version v.s. what's being submitted
here is that this one does a worse job in *very common* cases.

>> Yours also changes it from e.g.:
>>      @@ -61,7 +61,7 @@ forward-thing
>> to:
>>      @@ -61,7 +61,7 @@ (defun forward-thing (thing &optional n)
>> Is this really desired in elisp?
>
> It's common practice to extract the entire line (sans indentation if
> applicable), not just the function name. Why would somebody want the=20
> latter? It doesn't carry as much information as could be possible.

Because I'm familiar with the codebase I'm editing and I just need to
know that the diff I'm viewing is on the "main" function, not that it's
"main()", "int main(int argv, char **argv)", "int main(const int argv,
const char *argv[])", or to either have a " {" or not at the end
depending on the project's coding style.

I know our own userdiff builtin patterns don't do this, but it would be
very useful to retrofit this capability / maybe make it a configurable
feature, i.e. have them capture the meaningful part of the line, and you
could either print it all, or just that part.

>> I also note how our tests in
>> t4018-diff-funcname.sh are really bad in not testing for this at
>> all. I.e. we just test that we match the right line, not how we extract
>> a match from it.
>
> Oh, well. These are "semi-automated" tests cases. If you have an idea
> how to achieve the goal without burdening test writers with lots of=20
> subtleties, be my guest. ;)

I'll do that soon.

>> 1. https://lists.gnu.org/archive/html/emacs-devel/2021-02/msg00739.html
>>=20
>
> -- Hannes

