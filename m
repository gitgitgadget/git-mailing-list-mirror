Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD40203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 13:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbcG0Nop (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 09:44:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:49804 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754393AbcG0Noo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 09:44:44 -0400
Received: (qmail 22028 invoked by uid 102); 27 Jul 2016 13:44:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 09:44:44 -0400
Received: (qmail 16728 invoked by uid 107); 27 Jul 2016 13:45:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 09:45:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 09:44:41 -0400
Date:	Wed, 27 Jul 2016 09:44:41 -0400
From:	Jeff King <peff@peff.net>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/6] date: document and test "raw-local" mode
Message-ID: <20160727134441.GB14928@sigill.intra.peff.net>
References: <20160722195105.GA19542@sigill.intra.peff.net>
 <20160722195144.GE19648@sigill.intra.peff.net>
 <579343C9.1040902@gmail.com>
 <20160726184746.GA678@sigill.intra.peff.net>
 <5798AA7C.6050107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5798AA7C.6050107@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 02:35:08PM +0200, Jakub Narębski wrote:

> > All correct. There is no --relative-local because "--relative" is a
> > historical artifact. We could support --foo for every --date=foo, but I
> > don't think there is a reason to do so (and reasons not to, like
> > avoiding cluttering the option space).
> 
> So shouldn't the last sentence 
> 
>   "The `-local` option has no effect for `--relative`." 
> 
> be rather
> 
>  "The `-local` option has no effect for `--date=relative`."

Ah, I see. I didn't realize that's what you are getting at. Yes, it
would be more accurate. That's not a new problem introduced by my patch;
I just happened to be touching that sentence for other reasons. But the
patch does try to clean up the text in general, so it seems like a good
time to make this fix, too.

Since it looks like this is not even in 'next' yet, here is a
replacement for the 5th patch (second from the top) of the
jk/reflog-date topic.

-- >8 --
Subject: [PATCH] date: document and test "raw-local" mode

The "raw" format shows a Unix epoch timestamp, but with a
timezone tacked on. The timestamp is not _in_ that zone, but
it is extra information about the time (by default, the zone
the author was in).

The documentation claims that "raw-local" does not work. It
does, but the end result is rather subtle. Let's describe it
in better detail, and test to make sure it works (namely,
the epoch time doesn't change, but the zone does).

While we are rewording the documentation in this area, let's
not use the phrase "does not work" for the remaining option,
"--date=relative". It's vague; do we accept it or not? We do
accept it, but it has no effect (which is a reasonable
outcome). We should also refer to the option not as
"--relative" (which is the historical synonym, and does not
take "-local" at all), but as "--date=relative".

Helped-by: Jakub Narębski <jnareb@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt | 9 ++++++---
 t/t0006-date.sh                    | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5d1de06..04c7c64 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -725,8 +725,8 @@ include::pretty-options.txt[]
 	`iso-local`), the user's local time zone is used instead.
 +
 `--date=relative` shows dates relative to the current time,
-e.g. ``2 hours ago''. The `-local` option cannot be used with
-`--raw` or `--relative`.
+e.g. ``2 hours ago''. The `-local` option has no effect for
+`--date=relative`.
 +
 `--date=local` is an alias for `--date=default-local`.
 +
@@ -746,7 +746,10 @@ format, often found in email messages.
 +
 `--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
 +
-`--date=raw` shows the date in the internal raw Git format `%s %z` format.
+`--date=raw` shows the date in the internal raw Git format `%s %z`
+format. Note that the `-local` option does not affect the
+seconds-since-epoch value (which is always measured in UTC), but does
+switch the accompanying timezone value.
 +
 `--date=format:...` feeds the format `...` to your system `strftime`.
 Use `--date=format:%c` to show the date in your system locale's
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 4c8cf58..482fec0 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -47,6 +47,7 @@ check_show short "$TIME" '2016-06-15'
 check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
 check_show raw "$TIME" '1466000000 +0200'
 check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
+check_show raw-local "$TIME" '1466000000 +0000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-- 
2.9.2.607.g98dce7b

