Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DEBC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C1320714
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCNvBf2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgC2NS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 09:18:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44047 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgC2NS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 09:18:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so14921566lji.11
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuJZog9X/C8NOzR0O4NfB8HHFnGZQDpijvA8cbNIHyI=;
        b=lCNvBf2eHF6mL5t/N0l0Qa4Sj2YXkgVAjIdeOAxx74Iu9/cSsizIej6fjRfxNDzogP
         wpntXyzZ7ui8OMcWORbqrf5Vx7P+v+cUGAfBoudVKMlVTMiuppZDq1LUg7yGC4HHMXmM
         JpmEVqeXVW2YtgYF0bG5OBn+/5pS3k9dIQOyrKGno/Mi1z6ISLQ/o9tKZq8foVoIStjZ
         oRyUkSXDXKt1H3GPlfwFsuOUx+Jy6qiXgaRBC9vSBtzwNR6ys5BFGPEoD7DzeSeIh55x
         m10akPDWSAAs6vFG11UnwFScUgwNdy4bo8Sg1oZB8CbtHacuaMmkuHJ/LZRT71MGutMC
         8K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuJZog9X/C8NOzR0O4NfB8HHFnGZQDpijvA8cbNIHyI=;
        b=tY9VBy2GLMmXDU4BC/gEjBFb2+BoNnatPWOEa2ujNBQtSZAJidkEmHEQI6IjZdT25Q
         BJyxHV5HF+LuPIRCioxqsETjnVcNBO8fcgesFlkiHv1vCRjvdJ9aW8KrMSUmCEhaa/2O
         VHy9ZhgfcJw69GkxOX20GWb3JKq83gyY06qng+XeqRIHFdoxAss4Yb3UHMowZo4/YYh/
         vGkvaQlZ/foqUAEauQlMaeTK6JL5W4lLrwczNI2QOOtjTla5hPAQkwVe1jIkwcs6ejSm
         Ze97IxNzNGBSScB2HPSSmbbQkA2VAcViw4Uv9zYbrnVej/S5OhAFhoapJzl4HNOQbWSI
         dpiA==
X-Gm-Message-State: AGi0PuY17oTB2Eyl4iC4RDnQXxLiujGRNxtYqsaZUzHSf5pDXeTeT55c
        yCPOw0BjqOt1W6tVE2IvycI/qcN+
X-Google-Smtp-Source: APiQypIOvAmTdFTOH1b+kfydoXysmiR/P3y49X4IQJ/Opv/Ry07qfO0Tlxs6CUzCESSzTJaOPXrdhw==
X-Received: by 2002:a2e:8e83:: with SMTP id z3mr4591360ljk.239.1585487903867;
        Sun, 29 Mar 2020 06:18:23 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d16sm1247742lfm.91.2020.03.29.06.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 06:18:23 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
Date:   Sun, 29 Mar 2020 15:18:04 +0200
Message-Id: <cover.1585486103.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the documentation Makefile and a few helper conf and xsl files, we
carry various workarounds to make the docs build at all or to look
better with older docbook-xsl versions. Let's see if we can't just drop
that support. All of this seems to have been useful at one point, but I
doubt that anyone needs this nowadays. This was also suggested in [1].

The final commit in this series bumps the minimum required version of
docbook-xsl to 1.74.0, which is from June 2008. The whole series should
be a no-op unless you're on an older release than that. That said, I've
only tested this with the version that comes with my OS, 1.79.1.

After this series, user-manual.conf still refers to older docbook-xsl
versions. The proper fix there might be to actually be a bit more
aggressive and drop that hunk, making the rendered docs prettier.
There's some history there, including mentions of texinfo, which is
outside my comfort zone. I've got work in progress there, but I'd rather
submit that separately from these "expected no-op" patches.

Martin

[1] https://lore.kernel.org/git/20191030212422.GE29013@sigill.intra.peff.net/

Martin Ågren (6):
  Doc: drop support for docbook-xsl before 1.71.1
  Doc: drop support for docbook-xsl before 1.72.0
  Doc: drop support for docbook-xsl before 1.73.0
  manpage-bold-literal.xsl: stop using git.docbook.backslash
  manpage-normal.xsl: fold in manpage-base.xsl
  INSTALL: drop support for docbook-xsl before 1.74

 Documentation/Makefile                 | 23 -----------------
 Documentation/asciidoc.conf            | 19 --------------
 Documentation/manpage-1.72.xsl         | 14 -----------
 Documentation/manpage-base.xsl         | 35 --------------------------
 Documentation/manpage-bold-literal.xsl |  6 ++---
 Documentation/manpage-normal.xsl       | 25 +++++++++++++-----
 Documentation/manpage-suppress-sp.xsl  | 21 ----------------
 Makefile                               |  6 -----
 INSTALL                                |  4 +--
 9 files changed, 22 insertions(+), 131 deletions(-)
 delete mode 100644 Documentation/manpage-1.72.xsl
 delete mode 100644 Documentation/manpage-base.xsl
 delete mode 100644 Documentation/manpage-suppress-sp.xsl

-- 
2.26.0

