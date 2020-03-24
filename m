Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40718C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137A520724
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="VBLPFZIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCXXig (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:38:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44449 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgCXXif (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 19:38:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id x16so588163qts.11
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRkHU8Y9SjZ1FJk+kIziK/E9JZ0hAcLeN/mhEIj7M7Y=;
        b=VBLPFZImjNxunzXDE1QTBAv7wDI/q3txn+DJcGDSHwyusiP3K+IAwn7AL+Q+7M5BUF
         tqka/8v1IzOqml9IfiYaUFCfhHUS1mVQcdFEHvpCVQfkmA742M9EfEs9hQyDTakx36Wi
         EkG2439vquji+eBKFyaoV2vKHC5TJsa8F+pCsb7qE709pivl4MdJj+I2zmabVGG/girz
         Q8cgTY8GZ4k1Ol+7IV8yPw3CKolnZUq/drEi30YDEo1DVny2mKqPRmHAY4EARn6ECZ+u
         yptQ8A7IWvYt7qKbEX55o3lEX6xK5K/W2t0D6V+6vetdumQwfvawpRYwcpUu36XDgptQ
         K2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRkHU8Y9SjZ1FJk+kIziK/E9JZ0hAcLeN/mhEIj7M7Y=;
        b=OwvFEaBmcpyJtoB/I69ZZnN9douYCBnk3rfl8OEsW95xaF8U+0pcelEa4z3mL/5zf4
         Yrkh2tveMGNah0OV8oAGkPWzyeylrvlaAQ3BS0s7erZyAYVZVckW1eAhfq6vxI43LoxY
         K2ogzSt9UeKAYCiU+5FwaM6zvk5Xd/nXFTY78nagPqKpHlbIYsVsnSsrMR59jrGx0dMC
         S2JfuN1/5w8s1cFT4lmki9Rsadx1QTpO7NGxJqg27eMlSyHap1AsZZ0yySbUKW2VO/26
         ocQcrosQuBZVPtPfTbBXHVtnApjz2kUc6PUtisF6C0qAvlqKjY+hlERuWwetoYCPZfOj
         NUxA==
X-Gm-Message-State: ANhLgQ17aZ0Ro4cbOUsc8EmsHNm+fqWWXI76yOOXW1GczRZyA4N53+bi
        /y3HIanDzgz4VoQ9/ZjUgh7C8Q==
X-Google-Smtp-Source: ADFU+vsdjqbM06V3t5UXryD4k4ld4VbhDVrkKEAbBZi8zxK64P9TXWHpMy01RYSrqqVK68vJ6oisCQ==
X-Received: by 2002:ac8:75ce:: with SMTP id z14mr423363qtq.12.1585093114913;
        Tue, 24 Mar 2020 16:38:34 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id h46sm6451673qtc.84.2020.03.24.16.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 16:38:34 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH 1/3] doc: grep: unify info on configuration variables
Date:   Tue, 24 Mar 2020 20:38:25 -0300
Message-Id: <20200324233825.11032-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqq4kud1m1t.fsf@gitster.c.googlers.com>
References: <xmqq4kud1m1t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
> >> index 44abe45a7c..76689771aa 100644
> >> --- a/Documentation/config/grep.txt
> >> +++ b/Documentation/config/grep.txt
> >> @@ -16,8 +16,11 @@ grep.extendedRegexp::
> >> ...
> >> +       Number of grep worker threads to use. See `--threads` in
> >> +       linkgit:git-grep[1] for more information.
> >> ...
> >> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> >> index ddb6acc025..97e25d7b1b 100644
> >> --- a/Documentation/git-grep.txt
> >> +++ b/Documentation/git-grep.txt
> >> @@ -41,34 +41,7 @@ characters.  An empty string as search expression matches all lines.
> >> ...
> >> +include::config/grep.txt[]
> >> ...
> >>  --threads <num>::
> >> -       Number of grep worker threads to use.
> >> -       See `grep.threads` in 'CONFIGURATION' for more information.
> >> +       Number of grep worker threads to use. If not provided (or set to
> >> +       0), Git will use as many worker threads as the number of logical
> >> +       cores available. The default value can also be set with the
> >> +       `grep.threads` configuration (see linkgit:git-config[1]).
> >
> > I'm possibly showing my ignorance here, but doesn't the
> > "include::config/grep.txt[]" you added above mean that the user
> > doesn't have to see an external manpage but can see the definition
> > earlier within this same manpage?

You are right. I added the "(see linkgit:git-config[1])" here more as a
reference to the config system itself (for a user that is possibly not familiar
with git-config). But if this is not necessary, we can remove the reference.

> I think so.  Also, the new reference "See `--threads` in git-grep"
> added to grep.threads to config/grep.txt would become somewhat
> redundant in the context of "git grep --help" (only "See --threads"
> is relevant when it appears in this same manual page).

Thanks for pointing that out. I think we can solve this issue with the
following:

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index c1d49484c8..ac06db4206 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -16,8 +16,11 @@ grep.extendedRegexp::
 	other than 'default'.

 grep.threads::
-	Number of grep worker threads to use. See `--threads` in
-	linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. See `--threads`
+ifndef::git-grep[]
+	in linkgit:git-grep[1]
+endif::git-grep[]
+	for more information.

 grep.fullName::
 	If set to true, enable `--full-name` option by default.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 5c5c66c056..192aab4cba 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -41,6 +41,7 @@ characters.  An empty string as search expression matches all lines.
 CONFIGURATION
 -------------

+:git-grep: 1
 include::config/grep.txt[]

 OPTIONS

I will add these changes in v2.

