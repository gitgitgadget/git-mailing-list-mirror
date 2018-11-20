Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 727C91F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 12:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeKTXIu (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:08:50 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43110 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTXIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:08:50 -0500
Received: by mail-oi1-f176.google.com with SMTP id u18so1335324oie.10
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 04:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IfHO5nJ4P5XdXKHdrQfeH/DgmH6xtFmme/8dR3SlGxw=;
        b=AhVWWmSrfPsGkWtS+3D/KNClNVH30F5nf3ehovnJKWMprFhWnqC49jhhlG6N3HQUKs
         JanagQMLrVYkYWb4RpKxFve+z22KEKwgalB+znQnRo2Zy/FxmaRx29jSJPtm+HvkOCqG
         cZzcEpJ0AAK1cUf3zIhZsyNrXJpvijBvoY4N4wNqb3Q41C4/WKo9YumnncAvfnEfEPEY
         xIWI3Blg7O8mBaTe+GiNpu6A8ATpX8BLY1Vu7HZHYqMiOGoZ2cXhys0lpzcWIGxREDAU
         1SBoHhnxQOI+KHcMWM7zz7COg/z5xYOsnBTFhXdj83AXV1DhZGHU6vZHgRFkjYUIboBC
         cWOA==
X-Gm-Message-State: AGRZ1gKDEZ0jbbA+hgOeTlQkRCxISIrl0tTFF52oFV8/TmvOvmrmQYM+
        E8r25gxdNwyHjucuJYP5lyzXYtjDTHLm68tsufWIe+SU
X-Google-Smtp-Source: AJdET5fsJUIKj6Mz5eOV0mHXghDvNoe7O+gcyrMh9ArUz6lpuu4MaCk1/ik+QK8eUiXvKSo7WCCPYX+A+zmWIdV8JkI=
X-Received: by 2002:aca:aa81:: with SMTP id t123mr1063906oie.218.1542717592821;
 Tue, 20 Nov 2018 04:39:52 -0800 (PST)
MIME-Version: 1.0
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 20 Nov 2018 13:39:40 +0100
Message-ID: <CA+7wUsz5WyRcxMTUWTg13K866vWWp+bVGSZJFU1hRSL1Ehr8Aw@mail.gmail.com>
Subject: How to prepare patch for git am which remove a file ?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a simple setup:

  cd /tmp
  mkdir g
  cd g
  git init .
  wget http://central.maven.org/maven2/org/apache/xmlgraphics/fop/2.1/fop-2.1.pom
  git add fop-2.1.pom
  git commit -m "My First Commit"
  git rm fop-2.1.pom
  git commit -m "Second Commit"
  git format-patch HEAD~
  git reset --hard HEAD~
  git am 0001-Second-Commit.patch
Applying: Second Commit
error: patch failed: fop-2.1.pom:1
error: fop-2.1.pom: patch does not apply
Patch failed at 0001 Second Commit
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

What is the black magic to get `git am` to understand this patch ?
Please note that:

$ patch --dry-run -p1 < 0001-Second-Commit.patch
checking file fop-2.1.pom

Thanks!
