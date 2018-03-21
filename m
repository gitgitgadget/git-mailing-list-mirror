Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395B51F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 11:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCULNj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 07:13:39 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:43691 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeCULNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 07:13:38 -0400
Received: by mail-oi0-f45.google.com with SMTP id y27-v6so3944725oix.10
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/AeiVLFynDa0ZqHbb3sKXMk+jdgNQJ1Rpvb0foKfN5Y=;
        b=Uyo7QFDE8ZQrIQukkwDLVsZ4hCiD8lgfGS3NEz4WKb5n+vSei47PAibzUlJ+5CAn6n
         bYWA76iW28Dizu9FcEyUkGyxUlR8eQVQ89WW2VcI2u2xIP2ohyCCfPbWnN8vzHjSq/uT
         ZFgDNGj0Q6WhEFZ+PqBPMg6TjHcmb12PSuWJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/AeiVLFynDa0ZqHbb3sKXMk+jdgNQJ1Rpvb0foKfN5Y=;
        b=tOK+sMBfZp6GZAz1ApvrMoksQrSO345vlX5lNnaigawznqBZd3+tiMSxkITQ7tnaus
         rtRzei51bqy3AxEBnwjAeuuBa9KNqiM4EhJX00oGSHXb7+BZZZvAI4mWEgu8s8I+7GrB
         rdf5oV8JtwXZ3wE2OTEXO7zcDYQi/iyaAPs1f7J/KlwPwebzaWsOrrK4C+v2gMehE9qw
         bqejmR95DdqpMGG0f9EGcEbtf+jQ/BKzxRdBUSNQEK/yv+Ebsw1rqR6mpm2cB7dentfp
         mvtzS8Tsg0Vd9GMx8yi90GaFso2Fxpzq1VMY8wltXfR5XnYu7i8m7CAWZrhPI4EZXJZ5
         y4sg==
X-Gm-Message-State: AElRT7EfHZPX1V366tPUG9ybmGPJT8+Reckw6INSqjaaYYQZrn/Gf/5w
        stk2CWi3l8wUg4pT8Z4oXdfPlbNWX1KIEDtalG1tHQ==
X-Google-Smtp-Source: AG47ELtOCwtm/TTupPEPA5wKjXjfCK8X4FrdZGXchJgdY7/WxMPmI5GJoB28mR4doHOUbNmT1nOw2MnmQSNBqk8lsO8=
X-Received: by 10.202.90.138 with SMTP id o132mr10674019oib.11.1521630817611;
 Wed, 21 Mar 2018 04:13:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 04:13:37
 -0700 (PDT)
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Wed, 21 Mar 2018 07:13:37 -0400
Message-ID: <CAHnyXxSqtB=bSbA83V6HC6-aPCxw60h1iKQaa6ChwsmcUUCd0w@mail.gmail.com>
Subject: [PATCH] doc: clarify non-recursion for ignore paths like `foo/`
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> At any rate, would it at least be a good idea to make the "trailing
>> slash halts recursion, won't consider nested .gitignore files"
>> explicit in the `.gitignore` doc? Unless I'm missing it, I don't think
>> that behavior is called out (or at least not called out concisely/in
>> one place). It looks like this is all there is:
>
> Yeah, it's definitely come up multiple times over the years. I don't
> know what all is in gitignore(5), but if it's not mentioned it probably
> should be.
>
>>     "If the pattern ends with a slash, it is removed for the purpose
>> of the following description, but it would only find a match with a
>> directory. In other words, foo/ will match a directory foo and paths
>> underneath it, but will not match a regular file or a symbolic link
>> foo (this is consistent with the way how pathspec works in general in
>> Git)."
>>
>> Also, I'm not sure what the "following description" is in "it is
>> removed for the purpose of the following description". Is that trying
>> to imply "excluded from the rest of the doc"?
>
> I think it means "for the rest of the description of how the patterns
> work". I.e., "foo/" matches as "foo" when the rest of the matching rules
> are applied. I agree it's a bit awkward. Patches welcome. :)

I hope this is correct. I tried to follow the instructions. Please let
me know if I need to fix something with how I'm sending this!

-- >8 --
Subject: [PATCH] doc: clarify non-recursion for ignore paths like `foo/`

The behavior of .gitignore patterns ending with trailing slashes is
unclear. The user may expect subsequent matching patterns to matter, while
they do not. For example:

  foo/       # Ignores `foo` directories and everything inside of them
  !foo/*.txt # Does nothing

Explain this behavior (and its implications) more explicitly.

Signed-off-by: Dakota Hawkins <daktoahawkins@gmail.com>
---
 Documentation/gitignore.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index ff5d7f9ed..e9c34c1d5 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -89,12 +89,17 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".

- - If the pattern ends with a slash, it is removed for the
-   purpose of the following description, but it would only find
-   a match with a directory.  In other words, `foo/` will match a
-   directory `foo` and paths underneath it, but will not match a
-   regular file or a symbolic link `foo` (this is consistent
-   with the way how pathspec works in general in Git).
+ - If the pattern ends with a slash it will match directories but prevent
+   further recursion into subdirectories. In other words, `foo/` will match a
+   directory `foo`, excluding files and paths underneath it, but will not match
+   a regular file or a symbolic link `foo` (this is consistent with the way
+   that pathspec works in general in Git). Consequently, `foo/` will prevent
+   consideration of subsequent matches, including exclusions (for example,
+   `!foo/*.noignore`). In order to match `foo/` directories while allowing for
+   possible later exclusions, consider using a trailing wildcard (`foo/*`).
+   Note that matching directories with a trailing wildcard incurs some
+   additional performance cost, since it requires recursion into
+   subdirectories.

  - If the pattern does not contain a slash '/', Git treats it as
    a shell glob pattern and checks for a match against the
-- 
2.16.2.windows.1
