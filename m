Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904E2C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDRUys (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjDRUyq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:54:46 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161339772
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:54:25 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54f6a796bd0so359888697b3.12
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681851264; x=1684443264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+5CsISckF8WI6iis7xs8+aKkVUTyNGadvKsU2/iDO0=;
        b=MW3UpJJ0151IvtJuUGJjjwB3CLE5fqvI18u0A7cy+N3AhOHLeN66NZw1tReH+HNCzj
         DKSSFEKAxrak99kfHabRVzgFQm4Xuj3gZ/UDDkqLTfiITDBGaFf0s84YOCZoTBQInLJI
         gCV5knF18+KmBRZ77/vPXXbfC5WIDFrm2NOK4zJdftRIx0tH4JE/VvP522qauFR7yE8H
         BE/LXBhLKjXCf6kPyGR8VjEtIuoxvntX2qvcaualp+BO1c48fch3gVXBuYG/jAF0D1QT
         L6cdB+YT/ev8KREenstR1c6IMkl5Tmxxs50hiAAMY+XEjml1U4KPXztim0VoaAEjjcrA
         cUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851264; x=1684443264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+5CsISckF8WI6iis7xs8+aKkVUTyNGadvKsU2/iDO0=;
        b=PBzBUbcJnTxDN7m+dozeYYdmk6AXxXzi6GyMCjPoO2Qylsr0CmrFD+pec7kOX/gFIU
         hIMjAMfuWgNh9jqwtdT2OyP5hKXmPxi0ZrYuO/Vw44DOjsWzEij9VH9YzvNXmyi4q9Td
         bPb9hkBXWt8jLWBD1fofkGuaCD16t8REsK5bbbPD+PddGmsWte6+25asbIzTKs65lBP2
         My+cM821S4Juf8zFFFVqlg4QMKACyr/kbA9iRAAilQFvQjN9sbIVM4qCd3sTzv+KiygC
         H5JwsELAxu2xJfdbrDcl0A+3x8869OUTTMmxN0LpC14UweSB6tBHQ2wX+Lx1wzB0hWqw
         xUdg==
X-Gm-Message-State: AAQBX9cBC4JlKftvJgQdLT/48YZMDoMaMC32M7IadJ29jLDtKob1x6rW
        Dghpliy23qJhJ3ht6V6iBarWng==
X-Google-Smtp-Source: AKy350ZOMRzRzYmMKOhJxjIGIAmgHYzHIkB2pSRRcaj+vFWBIVmhyBqp/bTZbDmOGd0dwYz/QofTWg==
X-Received: by 2002:a0d:d4d1:0:b0:54c:1ddf:6c4b with SMTP id w200-20020a0dd4d1000000b0054c1ddf6c4bmr1159756ywd.11.1681851264234;
        Tue, 18 Apr 2023 13:54:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t22-20020a817816000000b00545a0818494sm4107996ywc.36.2023.04.18.13.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:54:23 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:54:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`
Message-ID: <ZD8Df1iZaUGzodrg@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
 <xmqqleipc73v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqleipc73v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 12:39:48PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Introduce a variant of the `string_list_split_in_place()` function that
> > takes a string of accepted delimiters.
> >
> > By contrast to its cousin `string_list_split_in_place()` which splits
> > the given string at every instance of the single character `delim`, the
> > `_multi` variant splits the given string any any character appearing in
> > the string `delim`.
> >
> > Like `strtok()`, the `_multi` variant skips past sequential delimiting
> > characters. For example:
> >
> >     string_list_split_in_place(&xs, xstrdup("foo::bar::baz"), ":", -1);
> >
> > would place in `xs` the elements "foo", "bar", and "baz".
>
> strtok() also skips leading and trailing delimiters, i.e. the above
> will give you identical result for ":foo:bar:baz:".

I'm not sure the results are identical. Adding this test case for
testing the behavior of string_list_split_in_place() passes before and
after this series:

--- 8< ---
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 9c5094616a..dfe970a566 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -72,6 +72,15 @@ test_split ":" ":" "-1" <<EOF
 [1]: ""
 EOF

+test_split ":foo:bar:baz:" ":" "-1" <<-\EOF
+5
+[0]: ""
+[1]: "foo"
+[2]: "bar"
+[3]: "baz"
+[4]: ""
+EOF
+
 test_split_in_place_multi "foo:;:bar:;:baz" ":;" "-1" <<-\EOF
 3
 [0]: "foo"
--- >8 ---

> It would be useful to test that here in addition to the existing ones.

Sure. FWIW, the behavior for string_list_split_in_place_multi() is
slightly different, since it will eat up all of the leading delimiter
tokens and treat the first token as "foo".

Here's a diff that could be squashed into this patch which captures both
cases:

--- 8< ---
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 9c5094616a..efc84dc124 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -72,6 +72,15 @@ test_split ":" ":" "-1" <<EOF
 [1]: ""
 EOF

+test_split ":foo:bar:baz:" ":" "-1" <<-\EOF
+5
+[0]: ""
+[1]: "foo"
+[2]: "bar"
+[3]: "baz"
+[4]: ""
+EOF
+
 test_split_in_place_multi "foo:;:bar:;:baz" ":;" "-1" <<-\EOF
 3
 [0]: "foo"
@@ -104,6 +113,14 @@ test_split_in_place_multi "foo:;:bar:;:" ":;" "-1" <<-\EOF
 [2]: ""
 EOF

+test_split_in_place_multi ":;:foo:;:bar:;:baz:;:" ":;" "-1" <<-\EOF
+4
+[0]: "foo"
+[1]: "bar"
+[2]: "baz"
+[3]: ""
+EOF
+
 test_expect_success "test filter_string_list" '
 	test "x-" = "x$(test-tool string-list filter - y)" &&
 	test "x-" = "x$(test-tool string-list filter no y)" &&
--- >8 ---


Thanks,
Taylor
