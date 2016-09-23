Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF11207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 19:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757906AbcIWT0w (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 15:26:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62881 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753358AbcIWT0v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 15:26:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97A283FA59;
        Fri, 23 Sep 2016 15:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ka6SjrrwQxSkLg5Hqo61g+oKGx4=; b=jE0CuL
        n/ypulfosI9ffbDkH9OYyFxu0XX5IJH+15i/jaRkzFOVbN+5n8lW+OUS98qLhIRf
        0ogZtim64WT0SmJ+KqqLO78Rc6we3jFWjfm8Ci19k7Y5e/77Jpk52evJqbCVhOrB
        XwGFRH1lYmXMvbZSrI823ATP0SGy9n9Gs+OdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PuqmpxzvrNdO85ha+w1cmLL+/jnDNZw7
        18Du+Ugbem+RJpSydQ/2FFpHxnxSEqfhNBl3S3Khv+WAiuEK5OVRp6Ptg3um1ft4
        Mr/MBS46OQtTvj9AZ9YrvOgv+yY9Fs18ngMDE8sDhtVLbMvLsORfIYMTvVdfosSR
        NLOZbwCtjlQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D86A3FA58;
        Fri, 23 Sep 2016 15:26:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05A5E3FA57;
        Fri, 23 Sep 2016 15:26:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] run-command: async_exit no longer needs to be public
References: <78f2bdd0-f6ad-db5c-f9f2-f90528bc4f77@ramsayjones.plus.com>
        <58164A5E-AC93-48A9-9139-B69CFB854CA8@gmail.com>
        <xmqqmviy1qux.fsf@gitster.mtv.corp.google.com>
        <6DE6D03D-F496-4FAB-866A-BC6802312B43@gmail.com>
Date:   Fri, 23 Sep 2016 12:26:48 -0700
In-Reply-To: <6DE6D03D-F496-4FAB-866A-BC6802312B43@gmail.com> (Lars
        Schneider's message of "Fri, 23 Sep 2016 20:56:34 +0200")
Message-ID: <xmqq60pm1kp3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACE04A46-81C3-11E6-83DB-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> I do not offhand know if the topic is otherwise ready as-is, or
>> needs further work.  When you need to reroll, you'd also need to
>> fetch from the result of the above from me first and then start your
>> work from it, though, if we go that route.
>
> Sounds good to me!

OK, here is what I queued, then.

-- >8 --
From: Lars Schneider <larsxschneider@gmail.com>
Date: Tue, 20 Sep 2016 21:02:39 +0200
Subject: [PATCH] run-command: move check_pipe() from write_or_die to
 run_command

Move check_pipe() to run_command and make it public. This is necessary
to call the function from pkt-line in a subsequent patch.

While at it, make async_exit() static to run_command.c as it is no
longer used from outside.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c  | 17 +++++++++++++++--
 run-command.h  |  2 +-
 write_or_die.c | 13 -------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5a4dbb6..3269362 100644
--- a/run-command.c
+++ b/run-command.c
@@ -634,7 +634,7 @@ int in_async(void)
 	return !pthread_equal(main_thread, pthread_self());
 }
 
-void NORETURN async_exit(int code)
+static void NORETURN async_exit(int code)
 {
 	pthread_exit((void *)(intptr_t)code);
 }
@@ -684,13 +684,26 @@ int in_async(void)
 	return process_is_async;
 }
 
-void NORETURN async_exit(int code)
+static void NORETURN async_exit(int code)
 {
 	exit(code);
 }
 
 #endif
 
+void check_pipe(int err)
+{
+	if (err == EPIPE) {
+		if (in_async())
+			async_exit(141);
+
+		signal(SIGPIPE, SIG_DFL);
+		raise(SIGPIPE);
+		/* Should never happen, but just in case... */
+		exit(141);
+	}
+}
+
 int start_async(struct async *async)
 {
 	int need_in, need_out;
diff --git a/run-command.h b/run-command.h
index 5066649..cf29a31 100644
--- a/run-command.h
+++ b/run-command.h
@@ -139,7 +139,7 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 int in_async(void);
-void NORETURN async_exit(int code);
+void check_pipe(int err);
 
 /**
  * This callback should initialize the child process and preload the
diff --git a/write_or_die.c b/write_or_die.c
index 0734432..eab8c8d 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,19 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
 
-static void check_pipe(int err)
-{
-	if (err == EPIPE) {
-		if (in_async())
-			async_exit(141);
-
-		signal(SIGPIPE, SIG_DFL);
-		raise(SIGPIPE);
-		/* Should never happen, but just in case... */
-		exit(141);
-	}
-}
-
 /*
  * Some cases use stdio, but want to flush after the write
  * to get error handling (and to get better interactive
-- 
2.10.0-530-g67247c9

