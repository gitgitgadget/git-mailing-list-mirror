Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA89DC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbiF0VEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbiF0VEU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 17:04:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0EDBC37
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:04:19 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d3-20020a170903230300b0016a4d9ded01so5872358plh.6
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=ixN53yLzFd0p35sxtkBekupafIN4ZAKur4eff/iuhrI=;
        b=i5JLP6GN7UaY9XefH5QopCoGLb/MU1PAs6+FwAdlZOvPEWhPJGcQTaOcJC5DB/VkbK
         Bj/F73c2TK+V5WZk57z6SCRkev/C0orsbA0tLV+f5HsVUkvGPuuS7hAo1uxUHFgHlSQL
         97m63vL2iaFX+yeF70yp/WgkxXa/DWNqOYxWUhcIh1uNlMYhwG3PKO0mm6dSRYjP7tdf
         oC4eiJHOe7jBTLkNx52tTjvfw+Qmz8uhqMUK3YbbbV/l7V8cMyUuexAeYr0+t0DqQGzF
         Bmg0S1QSDivMzYDmWLrEvnCFgkj47fSpBF4u3uIoOqJDsV9t/VIi2bjKsi/p5q4qx5rQ
         yQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=ixN53yLzFd0p35sxtkBekupafIN4ZAKur4eff/iuhrI=;
        b=ALNQDtWwhhENau2YvAFm18ICD1cPi8iCBZ9v03zYR5vL3vYzmjfsvrQy75+VdVPwXh
         4bev8ntpbRMutIByqDZcTHCP2ivYSWKsBOpXgU5o6KTOaVk6rcnnVDlopWcHv+LB14yb
         tpXOAWmux6g/A/OindA4hRzeKDEuB1tKUgnVVDlvos8gzr6b+VZI6zkmQB+Gs36ylRJI
         ww6KOL0RZhvQObWDIH2m9MfjTDLXHJu854iRN9h9VcVqJ6Zo/NMWj0zn48fbyv1BO+AQ
         ivPZrVth8QwcDoCzmDtyJcHMWfFXFbTurcZzNbi+Bta1edDPPBeo57lLjiBNVXeNFGDc
         WHIA==
X-Gm-Message-State: AJIora9Cthd/H4v2CYNy/CkCPoolX1la/4BhYRRNQeqfzMLbaf22q91+
        jeAw8niEt7Dz3IfmxpWekDd5H6/sGB6AMw4=
X-Google-Smtp-Source: AGRyM1thvl9QL5RSHEM7EqXhjlAf9yPq0Nthy0BgxJbuY4J58e+2lOBjlkcojTspXprdY+uNzOacZq+CCg2OARc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:3802:b0:1ed:2434:eb44 with SMTP
 id mq2-20020a17090b380200b001ed2434eb44mr22999225pjb.85.1656363859047; Mon,
 27 Jun 2022 14:04:19 -0700 (PDT)
Date:   Mon, 27 Jun 2022 21:04:06 +0000
In-Reply-To: <20220627184847.1361980-1-jonathantanmy@google.com>
Message-Id: <20220627210406.2802452-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH 2/3] merge-ort: shuffle the computation and cleanup of
 potential collisions
From:   Calvin Wan <calvinwan@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > @@ -2314,7 +2335,8 @@ static char *check_for_directory_rename(struct merge_options *opt,
> >  	}
> >  
> >  	new_path = handle_path_level_conflicts(opt, path, side_index,
> > -					       rename_info, collisions);
> > +					       rename_info,
> > +					       &collisions[side_index]);
> 
> Is this a fix of a latent bug? handle_path_level_conflicts() is not
> changed in this patch.
> 

I don't think so. IIUC this is what's happening given the callstack:

detect_and_process_renames()
  - Now defines `struct strmap collisions[3];` and computes all
    three collisions here
  - Passes collisions into collect_renames()
collect_renames()
  - Originally defined as `struct strmap collisions;` and computed
    collisions in here
  - Now takes collisions as an argument
  - Passes collisions into check_for_directory_rename()
check_for_directory_rename()
  - Collisions isn't used in this function at all except to pass into
    handle_path_level_conflicts
handle_path_level_conflicts()
  - Expecting pointer to singular collisions, not an array so side_index
    is now required
