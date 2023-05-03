Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5656C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 04:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjECEso (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 00:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECEs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 00:48:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169B40C6
        for <git@vger.kernel.org>; Tue,  2 May 2023 21:48:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso3570347b3a.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 21:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683089283; x=1685681283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jw9MyR1w7Yj894aWTvdXeslHHjDn/0TumNJ3RLY9M0=;
        b=UlvW80tijhnh/3RDdydKJK3jF1gSnUDepZq64ZVYhCyTP1ZRqRXpCGsKsn3OsNWHt6
         mb6Oj7usQFPxYsrHKGgJBPHKa52vdHcMkhfJZM0Ig1/jiK4SuF+tdqa+QdopeKnxMsPU
         NVtDOuJVSD09xVYFYimQjXlksoApWDGnMMFyPWzULZzz/bWbRM1YdCNDjQtq3n2U+Ded
         ZaDAdMcakGQfG7JgpUjrxa24aFVfKUBEr9xoMeMbiyyTTUR3Xk6/wr+Tplvt+6yi28uO
         cEtU3RPTZCnZPyyBJySsF6FiPMSCdlhz06oUFfOe4FB8Q5gU1CiCu8j0E0GyJ5uMbmrr
         IPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683089283; x=1685681283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jw9MyR1w7Yj894aWTvdXeslHHjDn/0TumNJ3RLY9M0=;
        b=kySBTSRGglJvZoNY57eN+ST5pN5AXDKSSzDSXWi/1lpC6WHzPKBnSezh+JiclsukUq
         PpHWD3TeoRuVu9us/TJYQzdn8nGvyr1HlhrEjCy9Xd5os/3CzKmq/zR9g/Qs3U1DfOnA
         s7HKCq5gNLpBRHZhw+Ikzbtak1wqwJMGuKcL3Z5i4dB+nZPSRmUeWBqBD1LCB1ApK4xx
         dkCXLLFfoSi7P/Y8cvxHw3WoGdU/qUTk8BC70tMFcS8zO8FNyvhNcURnRIl/M2i3dEk2
         E1daKREfiqGpg5o2ojIuZBxg+3sroZxVlNh5Y3alNt44ZLzmDZskITw4v87DD9wDeunp
         eZww==
X-Gm-Message-State: AC+VfDwLKqfbPFNKS63h6X6RMvex6mEuMoN0Hp/9J/YS5gHe1AypF+Z0
        oR2e2I0G/bE6xLlXNHoljNUo/NIXRoo=
X-Google-Smtp-Source: ACHHUZ5bazcrtnP5/gJL6g4QKxtzW2NRSiAtENXWHNwnIhC0DSn1W+bWhTrOyRKByPnuauy52Msm1g==
X-Received: by 2002:a05:6a00:b92:b0:625:fe95:f120 with SMTP id g18-20020a056a000b9200b00625fe95f120mr26293737pfj.8.1683089282567;
        Tue, 02 May 2023 21:48:02 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id o64-20020a62cd43000000b0063d642dcd12sm23320349pfg.16.2023.05.02.21.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 21:48:01 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de,
        gitster@pobox.com, sandals@crustytoothpaste.net
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 0/1] docs: rewrite the documentation of the text and eol attributes
Date:   Tue,  2 May 2023 22:46:55 -0600
Message-Id: <20230503044656.221175-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501023533.35370-1-alexhenrie24@gmail.com>
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v3:
- Rewrite sentence about how `eol` can imply `text`
- Use the phrase "all other platforms" instead of the word "Unix"

Alex Henrie (1):
  docs: rewrite the documentation of the text and eol attributes

 Documentation/gitattributes.txt | 59 +++++++++++++++++----------------
 1 file changed, 31 insertions(+), 28 deletions(-)

Range-diff against v3:
1:  3d5985bc28 ! 1:  eccf627db1 docs: rewrite the documentation of the text and eol attributes
    @@ Commit message
         does not do anything to the line endings either.
     
         On top of that, in several places the documentation for the eol
    -    attribute sounds like it can turn on normalization on checkin, but eol
    -    only controls conversion on checkout. It also sounds like setting eol
    +    attribute sounds like either it does not affect normalization on checkin
    +    or it forces normalization on checkin. It also sounds like setting eol
         (or setting a config variable) is required to turn on conversion on
         checkout, but the text attribute can turn on conversion on checkout by
         itself if eol is unspecified.
    @@ Documentation/gitattributes.txt: unspecified.
     -`text=auto` is set. Adding the path to the index again will normalize
     -the line endings in the index.
     +This attribute marks a path to use a specific line-ending style in the
    -+working tree when it is checked out.  This attribute has effect only if
    -+the `text` attribute is set or unspecified, or if it is set to `auto`,
    -+the file is detected as text, and it is stored with LF endings in the
    -+index.
    ++working tree when it is checked out.  It has effect only if `text` or
    ++`text=auto` is set (see above), but specifying `eol` automatically sets
    ++`text` if `text` was left unspecified.
      
      Set to string value "crlf"::
      
    @@ Documentation/gitattributes.txt: unspecified.
     +	If the `eol` attribute is unspecified for a file, its line endings
     +	in the working directory are determined by the `core.autocrlf` or
     +	`core.eol` configuration variable (see the definitions of those
    -+	options in linkgit:git-config[1]).  The default if `text` is set but
    -+	neither of those variables is is `eol=lf` on Unix and `eol=crlf` on
    -+	Windows.
    ++	options in linkgit:git-config[1]).  If `text` is set but neither of
    ++	those variables is, the default is `eol=crlf` on Windows and
    ++	`eol=lf` on all other platforms.
      
      Backwards compatibility with `crlf` attribute
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.40.1

