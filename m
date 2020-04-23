Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD0C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 18:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9596520776
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 18:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKE1jkgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgDWSJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgDWSJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 14:09:09 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09395C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 11:09:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l2so5305241pgg.8
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P1YfqfcntJbopY9VnBDTGl6WRUOrGLRsSzmyexSpIJ4=;
        b=SKE1jkgOmDwYRFsdAb5nQPfNYH6JtrO7NwZ+qI6I0cIwkShhg6ZuM/1rcWaeOH2BNy
         r/U3VqkMJRRxbVNBm+UY/EWa+4+X1a8yQi9ysW8i0OgE6CWhMirnTWrzsE1IPppq/rkV
         sB5tmC8HziLs3+idKQhzSZfvqSGS/m++4mUAbpEVRLHWv4C2XJSPqgShxsd7iuEJ9w2z
         5lUob7Y0o3l3XoEvpZCF4+Wnbkiiuuxkq6X3G6xGGg4Io3CVCNWY2Ps7F9m9yNbRc3Iq
         QsKreHFGolDgVFq6IwKTs7nmlixIhLeWwtAkCtenrH2L8axUne7006qa8cKwZDcPgdFL
         U/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P1YfqfcntJbopY9VnBDTGl6WRUOrGLRsSzmyexSpIJ4=;
        b=rIPtveHzurKuamOP81IRZrpEZ8YbeeRHvig9g1LaMUwevinIU2ecDCFNTl5n65bsRj
         tDff2nO6GtqMy7ZJcDjbsfDxDBqiM+um/dZvKy791Pf+nMZFclcGhnOo/Sd0vzoLAto9
         ZbJAyGlPNyBHe0SNVV27UlZrJtznS7OqG17QsamYBQu7vrDqiL3vcPwG7UJcrSsV81/p
         uzRWn7t4xf9eUjsHHxr2ywwJ5zOxj0EX42xF43p8LS6BzPfYSuk/ryEcbo15bJfqu/5h
         pHlE+LIQubI4EnRENh6V0WHOXbM6K2lMRMlv+LjEpdmslaSk+C3SqaB4oYHwHcRrtzv5
         /AHQ==
X-Gm-Message-State: AGi0Pua3VuFm2E4Na+Me2st2miVYH93qVrcbmjj3aT85yYdsvJhPUKqt
        VIXK38DP27PC0s5GscPdVrnmiA/nEu78epZljxm5
X-Google-Smtp-Source: APiQypJapwn3nMcQv4cFq1Cy7r5OGeu7/EW+a7MhAkP1khhCZ0ACzCa7Bx0aIksAStOD51By9ug/VbkuGNJzcG7tKFN1
X-Received: by 2002:a17:90b:128d:: with SMTP id fw13mr2051109pjb.23.1587665348325;
 Thu, 23 Apr 2020 11:09:08 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:09:05 -0700
In-Reply-To: <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
Message-Id: <20200423180905.195407-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Replace each instance of 'commit_lock_file' and 'rollback_lock_file'
> with 'commit_shallow_file' and 'rollback_shallow_file' when the lock
> being held is over the '.git/shallow' file.

I think Jonathan Nieder already covered 1/2 so I'll just close the loop
on this patch. There was one potential issue in that a previous version
of this patch also called reset_repository_shallow() in
setup_alternate_shallow(), but this version does not. But after looking
into it, this looks fine - setup_alternate_shallow() deals with a
passed-in alternate_shallow_file variable, which is different from the
r->parsed_objects->alternate_shallow_file that is_repository_shallow()
uses to set the global variables. (I might have confused the two during
earlier reviews.) Also, setup_alternate_shallow() is called either
before any shallow processing (empirically demonstrating that no
resetting is needed in this case, because it has been working), or right
before a commit or rollback of the lock file (so the global variables
are being reset anyway, so we do not need to call
reset_repository_shallow()).

So,
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
