Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E8E1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 04:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfILELG (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 00:11:06 -0400
Received: from omta016.useast.a.cloudfilter.net ([34.195.253.207]:52901 "EHLO
        omta016.useast.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbfILELG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Sep 2019 00:11:06 -0400
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.210])
        by cmsmtp with ESMTP
        id 7zY8iKbGzLe2C8GRliMz4k; Thu, 12 Sep 2019 04:11:05 +0000
Received: from thunderbird.smith.home ([68.231.71.156])
        by cmsmtp with ESMTPSA
        id 8GRiioeTWQvl08GRkiSmsO; Thu, 12 Sep 2019 04:11:05 +0000
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.3 cv=dvOl9Go4 c=1 sm=1 tr=0
 a=3BwGCz7hYCwPRAPwzRnSaA==:117 a=3BwGCz7hYCwPRAPwzRnSaA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=J70Eh1EUuV4A:10 a=5rxgeBVgAAAA:8
 a=vZxbLtyPAAAA:8 a=TUJdDHLZC0J5mYqbSrQA:9 a=PwKx63F5tFurRwaNxrlG:22
 a=YIznc7gRMHvxYRuyG5Sm:22
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 453C5B80236;
        Wed, 11 Sep 2019 21:11:02 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Date test code clean-up
Date:   Wed, 11 Sep 2019 21:11:00 -0700
Message-Id: <20190912041102.16266-1-ischis2@cox.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909014711.3894-1-ischis2@cox.net>
References: <20190909014711.3894-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfI5gi76S2drm/XgV/Ui4udRXDtUPJ1CUvQoQZFokMApwFmtOSakjS3PkkwSlJ2Pd1I1+T+vEbre7ziwCIz1bWPg6IdSZqVaGZFmwLAqOo9MyNZZhzIsl
 VnrqutzxKaM/H7NIgw2cxSRpURLLNmkptltQco+HXkwqw7SnxdXkFcvKYYrf7LIq5bQzuCMztjuGRxrN2V/2fI46t4HEaAvbB9xCH7SnkGE+XtqhmxAuqUns
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of a previous patch submission[1], a cleanup patch was
suggested to remove a now unnecessary passing of a date environment
variable to the production code.

While the two patches in the set could easily be submitted as a single
patch, I split the removal of the getenv() call into a second
patch. I did that to make the comment about the initialization of `x`
more localized to the change.

[1] https://public-inbox.org/git/xmqq5zuge2y7.fsf@gitster-ct.c.googlers.com

Range Diff:
1:  f4170ad553 ! 1:  e2b8322d58 Quit passing 'now' to date code
    @@ Metadata
      ## Commit message ##
         Quit passing 'now' to date code
     
    -    As part of a previous patch set, the get_time() function was added to
    -    date.c eliminating the need to pass a `now` parameter from the test
    -    code.
    +    Commit b841d4ff43 (Add `human` format to test-tool, 2019-01-28) added
    +    a get_time() function which allows $GIT_TEST_DATE_NOW in the
    +    environment to override the current time. So we no longer need to
    +    interpret that variable in cmd__date().
     
    -    This patch removes the unneeded `now` parameter.
    +    Therefore, we can stop passing the "now" parameter down through the
    +    date functions, since nobody uses them. Note that we do need to make
    +    sure all of the previous callers that took a "now" parameter are
    +    correctly using get_time().
     
      ## cache.h ##
     @@ cache.h: struct date_mode {
2:  3c7c4f1f55 ! 2:  18ec5b3b3d test_date.c: Remove reference to GIT_TEST_DATE_NOW
    @@ Commit message
         test_date.c: Remove reference to GIT_TEST_DATE_NOW
     
         Remove the reference to the GIT_TEST_DATE_NOW which is done in date.c.
    -    The intialization of variable x with the value from GIT_TEST_DATE_NOW
    -    is unneeded since x is initalized by skip_prefix().
    +    We can't get rid of the "x" variable, since it serves as a generic
    +    scratch variable for parsing later in the function.
     
      ## t/helper/test-date.c ##
     @@ t/helper/test-date.c: static void getnanos(const char **argv)


Stephen P. Smith (2):
  Quit passing 'now' to date code
  test_date.c: Remove reference to GIT_TEST_DATE_NOW

 cache.h              |  5 ++---
 date.c               | 27 +++++++++++++--------------
 t/helper/test-date.c | 27 +++++++++------------------
 3 files changed, 24 insertions(+), 35 deletions(-)

-- 
2.23.0

