Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2DFC6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjCZRIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjCZRIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 13:08:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D13AA1
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 10:08:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso9326569pjf.0
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679850487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGd/nqvmAnf68f2v15ZtiTSAHEv1iE3SRxe/jKH7qvg=;
        b=NX6gSec6ss9fitkluz/KKYV840bLQ/25vVRcTgDWbgzZD3RDDoTZWSt9Envix59g8m
         hzggKoy9+aXtp0YeEwKLcqTzpCesxYVC5F9pTOSwD9+YpJCq671DIPQR/V0vmJLCGnsn
         GIIE5+8X6ylpNW/SCkNsFyfqWBMt1VjLXwWGksLDwBdWoOdryidwnya4kchVd9dnH/2a
         RwX/leOqiclrYEXx2KUADVkfQxNek0FPgKYG3hsZqC7nWW1FPXFYB1VVVD+6OJaFAqKk
         rN3ywfdTwBU3zAndIe7s8aJVMB1WdpEqeKE+eHehNtuorGiSyjfdc6zf/Wx91VfegZyS
         YFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679850487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGd/nqvmAnf68f2v15ZtiTSAHEv1iE3SRxe/jKH7qvg=;
        b=5zYZBResAK09uArKp7SQlKDs4fZfv+SY+Fk4oMTtp9AYhaPY0dzECU095YGYoP1aSZ
         ghw1TRGrfiOpvWF7fxxVa6DNHTxKK99si3JaGQapNAR0iuneyWCsXI2bIl+MO8OBH5tm
         UYUx1/WjUkP0p326CCO6uIjuVPD72T4sfgsscyKP35GRcTjH/M458lrTDidgeAFJWnSR
         GJ1D4ML82teLxRxb4V1kE6S9iIvMYGwtD1F3DwCxWw/BSgcH3QyBisyyQGKrC5GL8kdd
         8B0B8xx8uLHFpkWnacRflGXbwIUYVKUU6gZsrSYy64lPEOhYNx7MuFcBd7l3gFx/7tTz
         Oyjg==
X-Gm-Message-State: AAQBX9fSHWWykWpJsbRrjGb1JpqPuG5wRvBS3GW6121IPVci5ArbodLk
        LBn4gBkuWO9QePPUC7RK/kmq+wn7b5RSjg==
X-Google-Smtp-Source: AKy350b5jvBoqdxa9v2vNI8LETz3aWGc5njN5ob/E9JS5+wBr8WzHNv23LKbbWXjnMIvdand+T/MrA==
X-Received: by 2002:a17:90b:4c8b:b0:23f:2c65:fab7 with SMTP id my11-20020a17090b4c8b00b0023f2c65fab7mr9788432pjb.42.1679850487454;
        Sun, 26 Mar 2023 10:08:07 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.150.51])
        by smtp.gmail.com with ESMTPSA id c5-20020a17090aa60500b0023af8a3cf6esm2884532pjq.48.2023.03.26.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 10:08:07 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     five231003@gmail.com
Subject: [GSoC][Project Idea] Refactor lazy-fetching in a partial clone
Date:   Sun, 26 Mar 2023 22:38:01 +0530
Message-Id: <20230326170801.7955-1-five231003@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The term "object" below always means a blob or a tree since git doesn't
yet allow filters on commits or tags.

Whenever an object is missing in a partial clone and we check for it
or read it, we trigger a lazy-fetch depending on whether fetch_if_missing
is set to 1 or 0. Currently, this global is set to 1 everywhere and some
commands which do not want to lazy-fetch have it set to 0 internally (for
example index-pack, fetch-pack, rev-list).

The goal of this project is to look into all the commands where fetch_if_missing
is set to 1 (in which case, whenever an object is missing, a connection
is made, the object that is missing is fetched and we disconnect. This
is bad because we are fetching for each object individually and this
leads to huge performance loss) and make changes so that fetching of
objects is done in a batch. In this way, when all of commands know how
to nicely fetch objects, we can change fetch_if_missing to default to 0.

I think this can be implemented by looking for all the places in the code
where has_object_file*(), read_object_file() or really any other function
which uses oid_object_info_extended(), is used and where fetch_if_missing is
set to 1 and make the necessary and appropriate changes to either fetch
efficiently or to not fetch at all and also write the tests necessary
according to the family [1] they belong to.

The above idea is the result of the discussion on the patch

  https://lore.kernel.org/git/20230225052439.27096-1-five231003@gmail.com/

Please let me know if it is doable as a project.

Thanks

[1] https://lore.kernel.org/git/20230311025906.4170554-1-jonathantanmy@google.com/
