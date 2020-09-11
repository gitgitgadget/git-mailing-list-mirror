Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739AFC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B969208FE
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="eU01khcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIKQdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgIKPRi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 11:17:38 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F7DC061757
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 08:17:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q63so9414903qkf.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nwvpIUHoaQGxNy9roynZhCvDKXURSmBE0Qw0JFQmcs8=;
        b=eU01khcIiYEOlk/Je8SbbWBWvpBnsYFNBm65SZ8f6jN5G73/XLNMY+Lsjgl+X2s7x5
         +pIrSK9bzPOrQKqEPLPcI7bVbGkSY0wRxx6ER33Uo269ursWzGel/RYKsoZqhnL+5SIA
         DecUU0VNNbNapDq2AnrRh/qv+fqufwqk6OxDuFqnPVgsUFw8xzVIpKdAiJxyrkS8+Tlm
         Ql0A37NFjT59z/5Qp7+TBrJdH8NwlBXHxzY7YSY5CE0dFVakgtDGNv47hS0tFcjbwYvY
         ltVO/p3wV+ZWqZaW3PBtyhRdBh5jSjPhQXrzEVW0uQZrJ+V7eOcDwKvwHV3DEAdBerMi
         bdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nwvpIUHoaQGxNy9roynZhCvDKXURSmBE0Qw0JFQmcs8=;
        b=HNycaLALxiD57xG6TN2UH4jtbRKaP2UfkWauMQOXXyk+ns292ihWDlMkhk2VgT63qC
         bLc6lKnqIcTKn+E/WjsicY7RTqAByrtwiiAiw9V4JSThli+IK6xyCfgdPR18b+eA9Rwe
         WbcnyCI+e4WUHjKJv0UovZ0kZKj8CAZOkjBxbokdV4Br7TsZMvhpneCIm9MUn4k46MKl
         dPCjquPCl2VADD3BmI0zW5f+qC6/gwR07ojEfIFquGmTbGEVfNhyq/4DXz8b3Ct2tJjb
         et/YFCHxci+us4nW9fbg805GJsX1UpkEng8cCFXYra8PnuDXx1D8HfslVrMkHYfleeja
         xAcg==
X-Gm-Message-State: AOAM532kSxa1nd4R85USiQ0Gp6mWyMljGjTjiNNeMXBlrX4TF9Kptl9U
        9WPhGzxcUTYtfV7VAUJkPeW4kH+v6CaWug==
X-Google-Smtp-Source: ABdhPJz+radljQXF8uQSCPpj2AxaBNlwLt3jumGdMqu3jTsYxbjNjtvCAgsqEZowA90NY+mn4fbcIg==
X-Received: by 2002:a37:654b:: with SMTP id z72mr1853202qkb.365.1599837449038;
        Fri, 11 Sep 2020 08:17:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id v16sm2951993qkg.37.2020.09.11.08.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 08:17:28 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, martin.agren@gmail.com
Subject: Posible bug with GIT_DEFAULT_HASH during clone
Date:   Fri, 11 Sep 2020 12:17:17 -0300
Message-Id: <20200911151717.43475-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

Documentation/git.txt mentions that GIT_DEFAULT_HASH is ignored during
clone, but I think it may not be *totally* ignored, sometimes leaving
the config file on the cloned repo in an inconsistent state.

To reproduce this (tested with current `master` and `seen`):

git init test
echo F>test/F
git -C test add F
git -C test commit -m F
export GIT_DEFAULT_HASH=sha256
git clone test test-clone
git -C test-clone status

Which outputs:
fatal: repo version is 0, but v1-only extensions found:
        objectformat

From what I could see under gdb, the steps leading to this are:

- First, this call chain gets the GIT_DEFAULT_HASH value:
  cmd_clone() > init_db() > validate_hash_algorithm().

- Then, init_db() calls create_default_files(), which calls
  initialize_repository_version() with GIT_HASH_SHA256, setting these
  configs:
  * extensions.objectFormat=sha256
  * core.repositoryFormatVersion=1

- Finally, cmd_clone() later uses the return of
  transport_get_hash_algo() to call initialize_repository_version()
  again, but with GIT_HASH_SHA1, setting:
  * core.repositoryFormatVersion=0

So we end up with the repository format version as 0 but the
objectFormat extension is present.

Thanks,
Matheus

