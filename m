Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2756CC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 23:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37DF60FE3
	for <git@archiver.kernel.org>; Wed, 19 May 2021 23:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhESXfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 19:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhESXft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 19:35:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99FC061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 16:34:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k15so10540440pgb.10
        for <git@vger.kernel.org>; Wed, 19 May 2021 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=V2h+T684TN5n6PXdkxPo3V8LoifzBkBd6hIXCMKHuBc=;
        b=Lgg3xuuOIWRe5LBs5jg7twtzcIoE2XPN7XxVECEp6DmMAM0czn6PbZgHa4u+UsQj26
         HM0sJpguw6jawLWI5jCmD8lEV1tfyXmbsXZT44u4WqqHXmKrowgEK160YlvEhPGxKInP
         58BFYhKYTvJBeyQvNC6o6stDv13xEQSJPjKKyNOjmn3fpODtMnDYToZfeOW/g+1aYfxa
         mPvIq3ev2G/ABi82wHSgSR4Cwves3s0ZFDkJEyFXLlHRhgJhippHu3kRNNXjOuw3iRbc
         L226oNUeGR1BpmLBYfl4R5NETI+jDeXjwEzU9XcR+1zxYKu4JmX36mwlw86HOHGYgHju
         1IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=V2h+T684TN5n6PXdkxPo3V8LoifzBkBd6hIXCMKHuBc=;
        b=kKiOa7AEoIWpOmV4UELbXvo8pguSLo3VraUF/zx+J8RnxB4k7rKPNM3wGl3agkFXE3
         ghH/elZMtmrPrafsvycdOBTgprKNGt4T2hdDKLP5ybn0fskc701rvU561SB0wOxKkUfv
         JdP+flMy9u9Xy7DRii4s0sOvB1+iBIU27cXrKgLTTXaFsqQpOP7WsA+6AwPmr8/v62d8
         RF3DNy4xA6p8X3Gz7u4f70pgkkiU9uuQrRIRdbI1L8B3M2Z0Z+uk9KFul55Bj8iWNonv
         aKLegAyzB7ZexAfLwYiT6CuWFSKz3vM5wMSIMk5w4kIv98VBTYQZ5QGDcI5sjeeTeBSv
         lbUQ==
X-Gm-Message-State: AOAM531iHiGrhRc7L2OhL8MNhKEvTFVj7vf4M3vsYLFDb1lS4tuzW8nS
        +yqHgZQkX+pmxZF3OQlAPEqLkh6dbe8=
X-Google-Smtp-Source: ABdhPJy7l2ZTTPHZPMQCMhzifUciM0WzzUXRff0121E+gSOYgOFQWHMJqpP2VmPN4ganc52ur74DTg==
X-Received: by 2002:a63:5c1:: with SMTP id 184mr1625596pgf.75.1621467267718;
        Wed, 19 May 2021 16:34:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id i197sm351578pgc.13.2021.05.19.16.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:34:26 -0700 (PDT)
Date:   Wed, 19 May 2021 16:34:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: RFC: error codes on exit
Message-ID: <YKWggLGDhTOY+lcy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

(Danger, jrn is wading into error handling again...)

At $DAYJOB we are setting up some alerting for some bot fleets and
developer workstations, using trace2 as the data source.  Having
trace2 has been great --- combined with gradual weekly rollouts of
"next", it helps us to understand quickly when a change is creating a
regression for users, which hopefully improves the quality of Git for
everyone.

One kind of signal we haven't been able to make good use of is error
rates.  The problem is that a die() call can be an indication of

 a. the user asked to do something that isn't sensible, and we kindly
    rebuked the user

 b. we contacted a server, and the server was not happy with our
    request

 c. the local Git repository is corrupt

 d. we ran out of resources (e.g., disk space)

 e. we encountered an internal error in handling the user's
    legitimate request

and these different cases do not all motivate the same response.
(E.g., if (c) affects just a single bot but produces a high error rate
from that bot, we shouldn't be alarmed; if (d) is happening on a bot,
then we should look into giving it more disk; if (e) is increasing
significantly during a rollout then we should roll back quickly.)

In order to do this, I would like to annotate "exit" events with a
classification of the error.  I'm not too opinionated about what that
classification looks like (bikeshedding welcome!) --- e.g., something
like the enumeration at
https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto
is likely to work fine.

(I'm particularly fond of how that maps to HTTP statuses.  See also
https://github.com/abseil/abseil-cpp/blob/HEAD/absl/status/status.h
for an example of using that kind of enumeration within a single
process.)

The API could look something like

	--- a/cache.h
	+++ b/cache.h
	@@ -590,6 +590,15 @@ int is_git_directory(const char *path);
	  */
	 int is_nonbare_repository_dir(struct strbuf *path);

	+enum git_error_code {
	+	/*
	+	 * Not an error (= HTTP 200)
	+	 */
	+	OK = 0,
	+};
	+NORETURN void fatal(enum git_error_code code, const char *err, ...)
	+	__attribute__((format (printf, 2, 3)));
	+
	 #define READ_GITFILE_ERR_STAT_FAILED 1
	 #define READ_GITFILE_ERR_NOT_A_FILE 2
	 #define READ_GITFILE_ERR_OPEN_FAILED 3

(with new error codes added when they first get used) and a typical
caller could look like

	Subject: xsize_t: tag "cannot handle files this big" as a failed precondition

	Unlike retriable errors, failed preconditions indicate that some
	aspect of the state needs to be changed in order to recover.  Mark
	this error as such to make signals from monitoring in controlled
	environments (e.g., bot fleets or corporate installations of Git)
	easier to understand.

	Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
[...]
	+       /*
	+        * The system is not in a state required for the operation to succeed.
	+        * For example, a file on disk is larger than we can handle.
	+        * (= HTTP 400)
	+        */
	+       FAILED_PRECONDITION = 9,
[...]
	 static inline size_t xsize_t(off_t len)
	 {
		if (len < 0 || len > SIZE_MAX)
	-               die("Cannot handle files this big");
	+               fatal(FAILED_PRECONDITION, "Cannot handle files this big");

Further down the line I can imagine making use of git_error_code
elsewhere for e.g. some limited retries of the corresponding
transaction when we fail to lock a file.

Thoughts?  Good idea?  Bad idea?

Thanks,
Jonathan
