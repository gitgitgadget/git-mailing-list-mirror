Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEDEC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCIRai (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCIRag (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:30:36 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC4F8E47
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:30:35 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id b10-20020a4aba0a000000b005200c0d4a2aso392200oop.11
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678383034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TccVeKqCo9/cwsDaj9BYp09/EIA7ZloNTGCFVQgZ2hs=;
        b=Qv/+glggPG5sVTXRKLanmX/9cs7Arca+HqYZ/sJEwV5UAZjOHlTlDx5ZbBqpfMgNz/
         RRFC5LmZ99xcv6wetMRyc5SOW2ZUV9eoNzp5Th1jwGdGC0T8x8fi1ly94Cgh5zUg59p9
         oWCsCk+T+vQHyM6DjBLXjw9/MuBKlaK7XWjqnJQ7s5ps5CiUbZURSXvAFgeHGcrtBe+n
         VpZIKeJ9P8EwJESLm+q4Pd8C+vrxJ+qa5h4uJXFbZsHfqN3j9/qPy6Ci6wvYG/O4wX5d
         5cFm2e0QMfLFDRlcjWHqbrv8PjQUetJItFDTPMuaKcUHEmNARR3MSOVL+n8TPsSywfzc
         NTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678383034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TccVeKqCo9/cwsDaj9BYp09/EIA7ZloNTGCFVQgZ2hs=;
        b=qJ/la3Uxpb35OU5u7dmxDJ+9dEmVYB6ZgUcVFb1XaKc6/zIX6Za+1LlxllBzIZLFdI
         he5ebOvfqrRYolMu8/IiNKwYdnKKxevbTIBmRaX66yV68PSq3aHYMDSK3b37q1+0pPm7
         AwK70mAK6Rp7owRz+EbZTQsvUWOVopXbJADEwkuz3DYWOYMeQpUj7DpQnrBbLAdFqkB5
         ncj7IQFh9Q/3KEBAxpH3h2Hi3aXQ/caufXuhZKR8koQvQch2VXsdjA47m7d47Awx81bD
         cZvNU4VQHJglBVXtg2/ry/owXhM5JjLVltTtHqtSLC8NORh3Tawf+hbxzYRAmE552JOp
         kmlg==
X-Gm-Message-State: AO0yUKWnBDZ5kxYX+lL7wUK1fplTJMkSoWhIHO5OCDYe8NRJmjK6+aNM
        ev3R7GtFlG35SuvT0CDWv2ShCapM0wQ=
X-Google-Smtp-Source: AK7set80bfofMjjBW+L6d4dPs6e+iSilJipgrgHvXNFALIA/s4eAOvPnYVbY5kXk0wK4p9GgJPPp8Q==
X-Received: by 2002:a4a:b0ce:0:b0:525:4cde:53ca with SMTP id l14-20020a4ab0ce000000b005254cde53camr9584696oon.7.1678383033799;
        Thu, 09 Mar 2023 09:30:33 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q81-20020acad954000000b0037fa61eb1dasm7591778oig.47.2023.03.09.09.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:30:33 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] test: cleanups of aggregate-results.sh
Date:   Thu,  9 Mar 2023 11:30:30 -0600
Message-Id: <20230309173032.959968-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Basically $title.

Since v1 I'm now passing the directory, instead of the file pattern as
Ævar suggested.

Also, while at it, let's silence the print of the command.

Felipe Contreras (2):
  test: simplify counts aggregation
  test: don't print aggregate-results command

 contrib/subtree/t/Makefile | 4 +---
 t/Makefile                 | 4 +---
 t/aggregate-results.sh     | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.39.2

