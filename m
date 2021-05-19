Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D6C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 21:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E676124C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 21:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhESVc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESVcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 17:32:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CB5C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 14:31:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f22so9430826pgb.9
        for <git@vger.kernel.org>; Wed, 19 May 2021 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PVWij9B0LC/6HHlmS6QSeLBlHub7sxJqiWtgg+KP5Kk=;
        b=OEC9PpPFM64LtX9oDLGvycO2OryOlE17jgOMI2FWknb7cXws0cyAAFx7FwnzXnrc2y
         Jos4zk/V/FAia6J2gKnQx/2gQct6xg/6KWkdNhi+6DhKbEjAMhclawvmO5Y8xUyO/GT0
         FFpjwvu1fqJ4k+cf/WeUQr4U4LECE5Mym0SjsnFO06Pgpsm30PRP+ivGU4vI0Wv8ln+y
         9Y468ugo0gEnTg9sbOuiqUekd2Eb6RFFkXZnD3n1/uUGIynuzQTsSU9REQgdc7uOnRvA
         Z5Vh391LQb+0sgR2EC6zOQ4XXGVOVCzvL+lZ+Q08sybU+VR5/pnWFBxrVYPYfsdlLGyu
         sqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PVWij9B0LC/6HHlmS6QSeLBlHub7sxJqiWtgg+KP5Kk=;
        b=ADbfBxeAMdkjWmMa+UO7Gv1RDwaqtfnQg6lWrE1XDsxrIR8UKIAeQUrd9Xvx78BahG
         pPCraoeGCbug/mmLex7qulIE6fiiXMdt/YebYCdEoOF6IpasIk7i5NHi0YziSmDL7aEj
         hMPvWz1YUHfYgXxgqj8jRnG1ggaSBX9UO8tWDZsPGTGb2UrJ1u3LqemzqH6UOeLV27M8
         whBn0wB/iaTLaB55pyNkC/LwPBz+T1T3KCJX0qC6CeUeFvWo484Pe3xjGuUx2bWvgVb4
         tgoEoCHaTvnj3Vn6WHw1eMxltkmHF0zi6Mr20EqezyFz3spdg/EjfJ5NmEW8m2loGOg2
         qH4w==
X-Gm-Message-State: AOAM533Ea5Geolpaj0mjxAVZrbwfi4Yc1ifmzKH5YB4GSWkvYj8MUU18
        UlcOUVt7fCigwmFtgJSEO+I=
X-Google-Smtp-Source: ABdhPJy57wDhoKFgZlUTJnE8uuQ5XUS61L/qAmOSwqR60qpnWuXtTsaothtq3pP+uSEBPs62ApWKxg==
X-Received: by 2002:a65:6256:: with SMTP id q22mr1132255pgv.391.1621459863360;
        Wed, 19 May 2021 14:31:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id 125sm265814pfg.52.2021.05.19.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:31:02 -0700 (PDT)
Date:   Wed, 19 May 2021 14:31:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Subject: Re: Standardized escaping to store a .git in git?
Message-ID: <YKWDlF59jWoyE+xJ@google.com>
References: <YKV8hEAxIzolnROX@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKV8hEAxIzolnROX@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh,

Josh Triplett wrote:

> On rare occasions, a project may need to store and version a .git
> directory in a git repository. For instance, a project that interacts
> with git repositories may need test cases. Or, a project using git to
> store backups may also want to back up git repositories. `.git` is the
> only filename that git can't transparently store and version.

My take on this might be a bit surprising, but it's probably worth
spelling out anyway: Git is first and foremost a source code
management tool, and ".git" directories are not a good interchange
format, so while I have sympathy for this use case, I do _not_ think
that Git should make changes that hurt other use cases in order to
support it.

Instead, I recommend doing one of the following, in order from most to
least preferred:

 1. Make the test case run git commands to create a Git repository.
    This makes it obvious what the test is trying to do, without
    having to deal with unrelated details also recorded in ".git".
    This is what Git's test suite does, for example.

 2. Check in a fast-import file and use "git fast-import" to make a
    Git repository out of it.

 3. Check in a "git bundle" file and use "git clone" to make a Git
    repository out of it.

 4. Check in an archive file (e.g., tar) containing a .git directory.
    (I consider this preferable over checking in a .git directory
    directly because it prevents a user from accidentally "cd"-ing
    into it and running git commands within the checked-in repository
    that they intended to run in the top-level repository.  That seems
    especially worth preventing because the checked-in repository can
    contain git aliases and other settings such as core.pager that
    cause automatic code execution, as you mentioned.)

Thanks and hope that helps,
Jonathan
