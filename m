Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A09EED61E
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 17:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbjIORyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbjIORyd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 13:54:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8011B10C9
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:54:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e79ec07b4so2781575276.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694800467; x=1695405267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uFvaL3yoRpCkQVgqFRqw3qSCi+wm+8Yf033zNheEUSg=;
        b=yeKMEGT29cKJ0WXqR1GDyX/etdA1P8zyqLno6u9LucNdMUSWij7FiETl2qkefexdg0
         XB9e2F/7/0sHdh8gSbMx3YGFebFj7nFtM4br0YXq1cFyM+NVHm+2EgNAz9qkeufe4wQa
         02a3vfN2PSTB1hg4016dbrVzO8VGRjG7MwkcimlhAITBagmZ1cqVCp3wO9vF0VTsEROZ
         9pfWUo/2FRy+a/pWzdrdcGDn8VLy6Dvz4nkS4Mbf3MllM6iO2cjMlXf3yuAPtro6FDOl
         vA1gJxOdiWDIXtQoOQfJ5Ctvy//R8JntBg6OZtqm8Y8bRFsIBTkflwolIyc3r8mCE3LV
         YrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694800467; x=1695405267;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFvaL3yoRpCkQVgqFRqw3qSCi+wm+8Yf033zNheEUSg=;
        b=VIU9SH0+2Xhjq3s2bFB+E2ms6W39Tv735UiFXG/h0CP6NuG5W1sdK27MFBduyLTliW
         Af0XqOqh1bLzoyabdurWN2rlw0qexzGjbpmPfwyn5rZarM1bRPa/Cn0cDL5pdn56DIDO
         hWlK7YoJ8PutlISytkbOgPwJ1OB+vXm0NS4cUfluDUtm7Vo8hJVmt6HOmaAMOKVbQ17R
         cshpr/oDDc99vW1jIuQw55tRlpGYvxAlDuoyeJvwBoDwgkjyodZ6FTeKevxFa6L4Lo4b
         CnzQsbdO54IQhxZVbCuQbqXBZk/sEtAgBMRmqHTGirOlab3z1HRnnTYBL7DixnvLiwWc
         sixA==
X-Gm-Message-State: AOJu0YzhegZrsPtHcKXNZjF8MMu248B1S42buxhlSW+ra6HIpS1dCzTO
        Y+5LWm2iqcjO8AwTmqB8wlSV+H2QmZoPw4tph8u5
X-Google-Smtp-Source: AGHT+IEYjeQp97uOxHYwJiAgHTBgeu6yJM9NgV/BpfwnE+H4SbANDuNYYxj7OCJsOispxcRL3/XJso2iV/t4r6ls00pC
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:841e:7bbe:cbee:5eda])
 (user=jonathantanmy job=sendgmr) by 2002:a25:aa30:0:b0:d73:bcb7:7282 with
 SMTP id s45-20020a25aa30000000b00d73bcb77282mr56249ybi.8.1694800467704; Fri,
 15 Sep 2023 10:54:27 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:54:25 -0700
In-Reply-To: <20230908174443.1027716-2-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915175425.1585455-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/6] wrapper: remove dependency to Git-specific
 internal file
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> In order for wrapper.c to be built independently as part of a smaller
> library, it cannot have dependencies to other Git specific
> internals. remove_or_warn() creates an unnecessary dependency to
> object.h in wrapper.c. Therefore move the function to entry.[ch] which
> performs changes on the worktree based on the Git-specific file modes in
> the index.

Looking at remove_or_warn(), it's only used from entry.c and apply.c
(which already includes entry.h for another reason) so moving it to
entry.c looks fine.
