Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808DB1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 03:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfA2DuW (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 22:50:22 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:36667 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfA2DuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 22:50:19 -0500
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190129035017.BFXQ12708.fed1rmfepo102.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Mon, 28 Jan 2019 22:50:17 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id A7D24B80EC8;
        Mon, 28 Jan 2019 20:50:16 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090209.5C4FCD79.0040,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=Tv9Sewfh c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=vBvTkK9lZnjO_d9gKhIA:9
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v4 0/5] Re-roll of 'human' date format patch set
Date:   Mon, 28 Jan 2019 20:50:11 -0700
Message-Id: <20190129035016.25981-1-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20190121053112.4736-1-ischis2@cox.net>
References: <20190121053112.4736-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed the binary and test to rename TEST_DATE_NOW environment
variable.  Changed the 'human' test to test_i18ncmp.

Updates for the relative date format will be done in a follow-on patch.

Range-diff relative to v3:

1:  ee75d9002d = 1:  ee75d9002d Add 'human' date format
2:  722c3319cd = 2:  722c3319cd Replace the proposed 'auto' mode with 'auto:'
3:  67cb73edb4 = 3:  67cb73edb4 Add 'human' date format documentation
4:  1562e7c713 ! 4:  a3f6f820b2 Add `human` format to test-tool
    @@ -2,15 +2,19 @@
     
         Add `human` format to test-tool
     
    -    Add the human format support to the test tool so that TEST_DATE_NOW
    -    can be used to specify the current time.
    +    Add the human format support to the test tool so that
    +    GIT_TEST_DATE_NOW can be used to specify the current time.
     
         The get_time() helper function was created and and checks the
    -    TEST_DATE_NOW environment variable.  If TEST_DATE_NOW is set, then
    -    that date is used instead of the date returned by by gettimeofday().
    +    GIT_TEST_DATE_NOW environment variable.  If GIT_TEST_DATE_NOW is set,
    +    then that date is used instead of the date returned by by
    +    gettimeofday().
     
         All calls to gettimeofday() were replaced by calls to get_time().
     
    +    Renamed occurances of TEST_DATE_NOW to GIT_TEST_DATE_NOW since the
    +    variable is now used in the get binary and not just in the test-tool.
    +
      diff --git a/cache.h b/cache.h
      --- a/cache.h
      +++ b/cache.h
    @@ -35,7 +39,7 @@
     +{
     +	const char *x;
     +
    -+	x = getenv("TEST_DATE_NOW");
    ++	x = getenv("GIT_TEST_DATE_NOW");
     +	if (x) {
     +		now->tv_sec = atoi(x);
     +		now->tv_usec = 0;
    @@ -110,6 +114,15 @@
      static void show_dates(const char **argv, const char *format)
      {
      	struct date_mode mode;
    +@@
    + 	struct timeval now;
    + 	const char *x;
    + 
    +-	x = getenv("TEST_DATE_NOW");
    ++	x = getenv("GIT_TEST_DATE_NOW");
    + 	if (x) {
    + 		now.tv_sec = atoi(x);
    + 		now.tv_usec = 0;
     @@
      		usage(usage_msg);
      	if (!strcmp(*argv, "relative"))
    @@ -119,3 +132,20 @@
      	else if (skip_prefix(*argv, "show:", &x))
      		show_dates(argv+1, x);
      	else if (!strcmp(*argv, "parse"))
    +
    + diff --git a/t/t0006-date.sh b/t/t0006-date.sh
    + --- a/t/t0006-date.sh
    + +++ b/t/t0006-date.sh
    +@@
    + . ./test-lib.sh
    + 
    + # arbitrary reference time: 2009-08-30 19:20:00
    +-TEST_DATE_NOW=1251660000; export TEST_DATE_NOW
    ++GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
    + 
    + check_relative() {
    +-	t=$(($TEST_DATE_NOW - $1))
    ++	t=$(($GIT_TEST_DATE_NOW - $1))
    + 	echo "$t -> $2" >expect
    + 	test_expect_${3:-success} "relative date ($2)" "
    + 	test-tool date relative $t >actual &&
5:  5e6b5705fd ! 5:  87d3a81e8a Add `human` date format tests.
    @@ -19,11 +19,11 @@
      check_approxidate '2009-12-01' '2009-12-01 19:20:00'
      
     +check_date_format_human() {
    -+	t=$(($TEST_DATE_NOW - $1))
    ++	t=$(($GIT_TEST_DATE_NOW - $1))
     +	echo "$t -> $2" >expect
     +	test_expect_success "human date $t" '
    -+	test-tool date human $t >actual &&
    -+	test_cmp expect actual
    ++		test-tool date human $t >actual &&
    ++		test_i18ncmp expect actual
     +'
     +}
     +


Linus Torvalds (1):
  Add 'human' date format

Stephen P. Smith (4):
  Replace the proposed 'auto' mode with 'auto:'
  Add 'human' date format documentation
  Add `human` format to test-tool
  Add `human` date format tests.

 Documentation/git-log.txt          |   4 +
 Documentation/rev-list-options.txt |   7 ++
 builtin/blame.c                    |   4 +
 cache.h                            |   3 +
 date.c                             | 148 ++++++++++++++++++++++++-----
 t/helper/test-date.c               |  13 ++-
 t/t0006-date.sh                    |  22 ++++-
 7 files changed, 176 insertions(+), 25 deletions(-)

-- 
2.20.1.2.gb21ebb671b

