Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1D3C00528
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 13:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFSNWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 09:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFSNWc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 09:22:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD8BAA
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 06:22:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9786fc23505so418230466b.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687180949; x=1689772949;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19g+1YMukA86of0ucuZKzjlusyMIyYy/+NM+w3B5S6Q=;
        b=Z+uF6n9F5M4VO5g/R7SNeHP/jeJjKQbfUGZbG+d4bBS0VXSNixdWivhIUrCQYAWXWD
         TI65Ea4NyurPTn4V8uv/S575kUn1AstUo1/gomJRH/9cpWZ8vLMPknR8QP3uSPxKLtub
         Ri0c9EO1waFUBiZCL+vMbH1lgUKNkVz4seGqVviqYYoofT7MRLkRMg0Cq+zkk8o1Mt4e
         0h/eP96bj9dxBDj8TQNa0zP+THmzv0NCwcyosXhwZCYAJUwAH9uQ0vzMO/2KUIr6NWbx
         mEe+2G/JL/bGO9b9KKS5Yq1uVr9PWpCUtJl7PLZZC3N0AcvZBa38obrICTe0tCVF4FCe
         xGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180949; x=1689772949;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=19g+1YMukA86of0ucuZKzjlusyMIyYy/+NM+w3B5S6Q=;
        b=H2T1gBslwug0MVItnPCKfMNrMeTio+ejh/k2t8TviRTeGz7r8Ng08YDvPa6UJwD8re
         9ihdQDT7YlXLReQQbYlPbZb5+hUnxKblK35pKKXg9Q8Uewvam/Wp4zbfgRCkZ45OBpi/
         fQ5ja4VqbqoBzG7vgyGn1c6akDeTpBMZSNYSy3A06LUT5jMWvht5EdJfvLTXlmpPOTHa
         XVVvfM/HGiBj4zqV1B3a7i2m74jkfxq4UaxqX7uv+ePpd2v7lq6dwzXiTK0hCePTdMPB
         08jg630zy15PHsioQ9vVH9mW+ME3mlFNGmUkw5xKJj2n/ZfmfZBB4UwakOpHfftXxu+l
         64rA==
X-Gm-Message-State: AC+VfDyiA1MPNuNRmZWuMWmuUbUgMQQXJGV7VHfQK45sUdFAaiwaveoH
        FM0DVaB1tIF2PCcaamhN+11NfoSjMVg=
X-Google-Smtp-Source: ACHHUZ7zMTsLWfyTvG4/NutaDaKWuwhxnc7u7twS5RggOSHrqBb2OxqHsa2LuHLNaORkHrFJgRt7XQ==
X-Received: by 2002:a17:907:62a7:b0:986:f586:b97 with SMTP id nd39-20020a17090762a700b00986f5860b97mr5839324ejc.59.1687180949401;
        Mon, 19 Jun 2023 06:22:29 -0700 (PDT)
Received: from ?IPV6:2003:ce:af33:6e00:75c2:3a56:cc26:554b? (p200300ceaf336e0075c23a56cc26554b.dip0.t-ipconnect.de. [2003:ce:af33:6e00:75c2:3a56:cc26:554b])
        by smtp.gmail.com with ESMTPSA id gv19-20020a170906f11300b00988a0765e29sm1635062ejb.104.2023.06.19.06.22.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:22:28 -0700 (PDT)
Message-ID: <c6950001-ced5-448d-8f0e-22f597c68b9b@gmail.com>
Date:   Mon, 19 Jun 2023 15:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: de-DE
From:   paul <pl.gruener@gmail.com>
Subject: commit messages are silently re-encoded to UTF-8 despite docs
 implying otherwise
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When supplying a commit message that is not UTF-8, Git assumes it is encoded in latin1/ISO-8859-1, and silently does a latin1 -> UTF-8 re-encoding. That assumption is sensible, but the problem is the docs imply such a conversion does not happen.

Documentation/i18n.txt explicitly says (emphasis mine):
> Although we encourage that the commit log messages are encoded
> in UTF-8, both the core and Git Porcelain are designed **not to
> force UTF-8** on projects.  If all participants of a particular
> project find it more convenient to use legacy encodings, Git
> does not forbid it.  However, there are a few things to keep in
> mind.
> . 'git commit' and 'git commit-tree' issues
>   a warning if the commit log message given to it does not look
>   like a valid UTF-8 string, unless you explicitly say your
>   project uses a legacy encoding.  The way to say this is to
>   have `i18n.commitEncoding` in `.git/config` file, like this:
> […]
> Note that **we deliberately chose not to re-code the commit log
> message when a commit is made to force UTF-8** at the commit
> object level, because re-coding to UTF-8 is not necessarily a
> reversible operation.

Said warning reads:
> # Warning: commit message did not conform to UTF-8.
> # You may want to amend it after fixing the message, or set the config
> # variable i18n.commitEncoding to the encoding your project uses.

I interpret this as: that config variable is only used to silence the warning (and as courtesy to the future reader), not to control some behind-the-scenes conversion, especially because the note above says a re-coding doesn't happen.

But we can easily verify that a non-UTF-8 commit message produces the same commit:
---
#!/usr/bin/env bash

export {GIT_AUTHOR_NAME,GIT_AUTHOR_EMAIL,GIT_COMMITTER_EMAIL,GIT_COMMITTER_NAME}=me
export {GIT_AUTHOR_DATE,GIT_COMMITTER_DATE}=2005-04-07T22:13:13
# symbol 'Ä' is 0xc384 in utf-8 but 0xc4 in iso-8859-1

git commit-tree -m $(printf '\xc3\x84\n') $(git hash-object -t tree /dev/null)
# 4df6ed26ffd0b02c8b5c1d85ba184b02fbcaa2db

git commit-tree -m $(printf '\xc4\n') $(git hash-object -t tree /dev/null)
# Warning: commit message did not conform to UTF-8.
# You may want to amend it after fixing the message, or set the config
# variable i18n.commitEncoding to the encoding your project uses.
# 4df6ed26ffd0b02c8b5c1d85ba184b02fbcaa2db
---

It's debatable whether Git should even attempt to do an encoding conversion – I think it's fine if properly communicated, so at the very least the warning message should be changed to something like

> # Warning: commit message did not conform to UTF-8 and was automatically
> # converted. You possibly need to fix and amend it.
> # To use a different encoding than UTF-8, set the config variable
> # i18n.commitEncoding to the encoding your project uses.

and the documentation adapted similarly.

regards,
paul


PS: the code responsible for the conversion is in
commit.c +1654
> /* And check the encoding */
> if (encoding_is_utf8 && !verify_utf8(&buffer))
>     fprintf(stderr, _(commit_utf8_warn));

and
> /*
>  * This verifies that the buffer is in proper utf8 format.
>  *
>  * If it isn't, it assumes any non-utf8 characters are Latin1,
>  * and does the conversion.
>  */
> static int verify_utf8(struct strbuf *buf)
