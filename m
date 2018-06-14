Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BDF1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755166AbeFNMbm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 08:31:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54143 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbeFNMbk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 08:31:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so10211945wmc.3
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6feXB2D240SY1YOWN7uBStlY4xsSI1WziQ1BAn+3PA=;
        b=o8LpxfKvBkxXXPcKYCid7hvz4m6Wou6bLmzqHVq6VL5cy76OdK4wAoRab6nudGxnBb
         ZWYsdxQtL5OLx9OkPJU5QI3zQo55hEn7sPPi9I7RUq1LnkAXRaz3Sf495M2UphDtDSfo
         L2VgT8Ho03bzfWOGpjg4wnyYPHMrXeUkc2F9X/RRJOUf89dtftR+e81u4dbLfpr0LCED
         mWRLjNPAyGh+ip9wCySoJXBc+p43+SRe0Zy1FQEVqswP9Td5MNH3ckS/w7B23Pn5SFXn
         cG/oFQZbYvqvcdS0IzBAATH1ysQvPEOtxZ8UAMlhhNRJuIweulefDM5VaxajkxDNc0iB
         7S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6feXB2D240SY1YOWN7uBStlY4xsSI1WziQ1BAn+3PA=;
        b=h576QmndqWKUb9aVLqNEgER7bBe+VCbPcsSC+WEzWFUqhWRDnOt3WwCOCDsPgjvX3z
         HpdUbHAWovN6vAM6rH+A9PSMnfk4fxjR2OuN7QyOzTslQ32mWa9G2prp+JI0v9HygfLh
         CzTLmsMrZ0pmbyjE6DwdMOrb63gPXTlEDjuiEYMUg9nuEKNnCsk1nXbQt50ss8kKwBJ1
         fAyBpaNavf15VSiDl242I6DaWgyWkZyE+6bMgD8eaiqIf0mmEl4yW4FQHrsGP2nSf15y
         vgvngh6QpXycRvoo4Gf5KHo0yzqdWq2n3rSo9jcW8sz7VFYlJzLZGp+ow70PipH2mnbW
         +ZPw==
X-Gm-Message-State: APt69E2B6w+3lREi2hr/73ip34LIEI72jZk5hdyLQuRzh/n9ErAkyOLD
        JxLq7ZfDwGRQ1Eg+vN/rgj70DHg3
X-Google-Smtp-Source: ADUXVKJ4XPy0fV4OK7+pbUFIclt6pK7e832j0oPvMWDWUqweusTNieFeizBZsgCH0YIR4NAfFc3mfQ==
X-Received: by 2002:a1c:7d56:: with SMTP id y83-v6mr1914525wmc.65.1528979498576;
        Thu, 14 Jun 2018 05:31:38 -0700 (PDT)
Received: from localhost.localdomain (x4db06284.dyn.telefonica.de. [77.176.98.132])
        by smtp.gmail.com with ESMTPSA id w67-v6sm6281497wmw.0.2018.06.14.05.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 05:31:38 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 4/4] t/lib-httpd: sort log based on timestamp to avoid occasional failure
Date:   Thu, 14 Jun 2018 14:31:07 +0200
Message-Id: <20180614123107.11608-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180614123107.11608-1-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last test of 't5561-http-backend.sh', 'server request log matches
test results' may fail occasionally, because the order of entries in
Apache's access log doesn't match the order of requests sent in the
previous tests, although all the right requests are there.  I saw it
fail on Travis CI five times in the span of about half a year, when
the order of two subsequent requests was flipped, and could trigger
the failure with a modified Git.  However, I was unable to trigger it
with stock Git on my machine.  Three tests in
't5541-http-push-smart.sh' and 't5551-http-fetch-smart.sh' check
requests in the log the same way, so they might be prone to a similar
occasional failure as well.

When a test sends a HTTP request, it can continue execution after
'git-http-backend' fulfilled that request, but Apache writes the
corresponding access log entry only after 'git-http-backend' exited.
Some time inevitably passes between fulfilling the request and writing
the log entry, and, under unfavourable circumstances, enough time
might pass for the subsequent request to be sent and fulfilled, and
then Apache writes access log entries racily.

This effect can be exacerbated by adding a bit of variable delay after
the request is fulfilled but before 'git-http-backend' exits, e.g.
like this:

  diff --git a/http-backend.c b/http-backend.c
  index f3dc218b2..bbf4c125b 100644
  --- a/http-backend.c
  +++ b/http-backend.c
  @@ -709,5 +709,7 @@ int cmd_main(int argc, const char **argv)
   					   max_request_buffer);

   	cmd->imp(&hdr, cmd_arg);
  +	if (getpid() % 2)
  +		sleep(1);
   	return 0;
   }

This delay considerably increases the chances of log entries being
written out of order, and in turn makes t5561's last test fail almost
every time.  Alas, it doesn't seem to be enough to trigger a similar
failure in t5541 and t5551.

Now, by default the timestamp of a log entry marks the beginning of
the request processing, not when the log entry gets written.  Since
our requests are sent sequentially, sorting the log entries based on
their timestamps would ensure that their order corresponds to the
order of our requests.

Therefore, change Apache's log format to use microseconds since epoch
as timestamps, the finest resolution Apache has to offer.  This will:

  - give enough resolution to make reasonably sure that no two
    requests have the same timestamp; the default timestamp format has
    only one second resolution, which is not nearly enough.

  - make the timestamps sortable; the default timestamp format looks
    like "[31/Jan/2018:16:33:52 +0000]", which would trip sorting if
    the test script happens to run over month boundaries.

Modify the strip_access_log() helper function, used by all potentially
affected tests, to sort the access log entries based on their
timestamp before stripping the uninteresting bits from the entries.

Unfortunately, this "microseconds since epoch" is an extended time
format specifier which was only introduced in Apache 2.2.30 [1], and
standard strftime() doesn't have any format specifiers with
microsecond or finer precision, so we can't use the above solution
with Apache versions older than 2.2.30.  However, since Apache 2.2 is
no longer maintained anyway, it's not that big a deal to leave test
runs with those old versions prone to this occasional failure.  So use
microsecond timestamps and sort access log entries only if the test is
run with an Apache version supporting it; otherwise stick to the
default timestamp format and leave the order of access log entries
unchanged.

[1] http://httpd.apache.org/docs/2.2/mod/mod_log_config.html

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    The log of the latest of this test failures:
    
      https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/391499735#L3130
    
    I don't really like the fix in this patch.  I think an unfortunate
    clock skew during the test run could mess up the sorting added in this
    patch and cause test failure.  Or if DST or even a leap second happen
    while the test is running.  Do we care?  Anyway, this occasional test
    failure apparently happens more often than DST and leap seconds
    combined.
    Furthermore, in the future we might have computers fast enough to
    fulfill more than one test requests in a single microsecond; but I
    guess by that time we'll have higher resolution time formats as well.
    
    An alternative I considered was that we could decide that the order of
    requests in the access log is not important as long as all the right
    requests are there.  This would inherently eliminate the raciness
    issue, but if something were to go wrong, then it would become rather
    hard to find out e.g. which request from which test has gone missing,
    especially considering that several requests are sent in more than one
    test.  We could address this by truncating the access log at the
    beginning and checking its contents at the end of each test sending
    requests.  Unfortunately, this would raise additional difficulties,
    because all requests in t5561 come from tests included from
    't556x-common', i.e. from tests shared with
    't5560-http-backend-noserver.sh', which as its name suggests doesn't
    run Apache and doesn't have an access log at all.
    
    Another alternative is to simply accept that these tests are racy, and
    that the resulting test failures are rare enough that it isn't worth
    the complexity of the workaround, but adding a comment to the affected
    tests warning about the raciness is sufficient.  (But I wrote this
    when I first saw and tracked down this failure; since then I observed
    it four more times... :)
    
    --
    
    Apache doesn't maintain 2.2 anymore; the final maintenance release
    2.2.34 was released in July 2017, almost a year ago.  OTOH, our
    't/lib-httpd/apache.conf' contains a couple of IfVersion directives
    dealing with versions <2.4, and one even with <2.1.  How much do we
    actually care about these unmaintained Apache versions, and how much
    of this is just bitrotting?

 t/lib-httpd.sh          | 13 ++++++++++++-
 t/lib-httpd/apache.conf |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5915625631..1a7fe67141 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -289,10 +289,21 @@ expect_askpass() {
 }
 
 strip_access_log() {
+	case "$HTTPD_VERSION" in
+	2.[01].*|2.2.[0-9]|2.2.[12][0-9])
+		# Apache versions < 2.2.30 didn't have any log timestamp
+		# format with microseconds precision, so don't attempt to
+		# sort the access log when testing with such old versions.
+		cat "$HTTPD_ROOT_PATH"/access.log
+		;;
+	*)
+		sort -n -k 4,4 "$HTTPD_ROOT_PATH"/access.log
+		;;
+	esac | \
 	sed -e "
 		s/^.* \"//
 		s/\"//
 		s/ [1-9][0-9]*\$//
 		s/^GET /GET  /
-	" "$HTTPD_ROOT_PATH"/access.log
+	"
 }
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 724d9ae462..8d6da6bdb2 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -1,7 +1,12 @@
 ServerName dummy
 PidFile httpd.pid
 DocumentRoot www
+<IfVersion >= 2.2.30>
+LogFormat "%h %l %u %{usec}t \"%r\" %>s %b" common
+</IfVersion>
+<IfVersion < 2.2.30>
 LogFormat "%h %l %u %t \"%r\" %>s %b" common
+</IfVersion>
 CustomLog access.log common
 ErrorLog error.log
 <IfModule !mod_log_config.c>
-- 
2.18.0.rc0.207.ga6211da864

