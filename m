Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546291F859
	for <e@80x24.org>; Thu,  8 Sep 2016 01:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbcIHBqD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 21:46:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36157 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbcIHBp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 21:45:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id x24so1725903pfa.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJuovFsuQ+yVRxdv6F6fwhC7jwLRhJSe7lQF/3qkC14=;
        b=g74UcmBeHcS7PCPDkaW7pJpkkVnYT/JQ2yIhg1Z/gikT0Uh3O8ogzBiWrHceQxEW81
         Ufc3gAeEMvWGcvWRDpqPlz4XxL33hzhzpH/PUnKbuqmNUklgyWB+srtwHhRxjH+YhWts
         Otill0lcDY5Ewm4JYcYml0fdEyZYgUGc/TDOSyn00+YVKBHk0Jw3Oe2llVJybVVMfWhv
         oKSV1PsLGnvKA0fm0/BjMw69oxcS3f4pdiz+iCm6HqBVkgfJjw703Hq1dUdhoV+MlyRp
         qgSd/MmakX6HIce3JnPKhrzb/v3oXY/dosgoI1xa0WyQ9dXLGmUuVOq0qMAEkZ410uqA
         Zjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJuovFsuQ+yVRxdv6F6fwhC7jwLRhJSe7lQF/3qkC14=;
        b=AgPaRQm4dyupPlPNXEJZdPQRlB1a/CbUpURecIR2QDxWxs8PrIC6hHAyBuDt1wiiBX
         PkcJo35flMAjK0jaagGcL6veBfTlaU/1HKn89yutQtusyR+tDbuuMktNQlfT3rt2o1NC
         Z5UFwkIZ5hNqA8BztFOxk3c/ddI3aUJfmTM6TIv65Psx1jkeHkseOhxgRe6L9Y+qU7kV
         YUwHRTGag4d/up3xuWg8i1EPdNSah+OT6xz4RPV/kBhYGWwhUjxDuaB711SKpen93hfQ
         uft5WBqmF+q3oNvCMMZLI1ICL0RgO+nntwejLBONQWB5c2HUuaHy6Pv77pxPXqTcpzOR
         pbOA==
X-Gm-Message-State: AE9vXwN6PVRfmopUtzpqRoLx9+YfaJLhej7FzRj09ykkz2ddqO/mlaCfBU8S28SdUmGj3A==
X-Received: by 10.98.70.8 with SMTP id t8mr88308449pfa.36.1473299158141;
        Wed, 07 Sep 2016 18:45:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:60fa:bcd3:3f9b:dd2])
        by smtp.gmail.com with ESMTPSA id 12sm18786481pfu.28.2016.09.07.18.45.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 18:45:57 -0700 (PDT)
Date:   Wed, 7 Sep 2016 18:45:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, sbeller@google.com,
        peff@peff.net, gitster@pobox.com, Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] connect: tighten check for unexpected early hang up (Re:
 [PATCH v3 2/2] connect: advertized capability is not a ref)
Message-ID: <20160908014555.GD25016@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473291819.git.jonathantanmy@google.com>
 <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
 <20160908013431.GC25016@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160908013431.GC25016@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Heiko)
Jonathan Nieder wrote:

> 'die_initial_contact' uses got_at_least_one_head to determine whether
> it was on the first line but code paths added later that use
> 'continue' don't populate it properly (see b06dcd7d, 40c155ff, and
> 1a7141ff).  We could do
>
> 	int first_line = 1;
>
> 	for (;; first_line = 0) {
> 		...
> 	}
>
> and use !first_line instead of got_at_least_one_head (removing
> got_at_least_one_head in the process since it has no other purpose).

I got the history wrong.  It looks like this was always confused
by the 'continue' cases.  Unless I'm missing something subtle ---
thoughts?

Thanks,
Jonathan

-- >8 --
Subject: connect: tighten check for unexpected early hang up

A server hanging up immediately to mark access being denied does not
send any .have refs, shallow lines, or anything else before hanging
up.  If the server has sent anything, then the hangup is unexpected.

That is, if the server hangs up after a shallow line but before sending
any refs, then git should tell me so:

	fatal: The remote end hung up upon initial contact

instead of suggesting an access control problem:

	fatal: Could not read from remote repository.
	Please make sure you have the correct access rights
	and the repository exists.

Noticed while examining this code.  This case isn't likely to come up
in practice but tightening the check makes the code easier to read and
manipulate.

Change-Id: I3cec2c160eb6c6f3efdce7dab38a4c78592f6c7f
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 connect.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 722dc3f..2c2ebef 100644
--- a/connect.c
+++ b/connect.c
@@ -43,9 +43,9 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, flags);
 }
 
-static void die_initial_contact(int got_at_least_one_head)
+static void die_initial_contact(int unexpected)
 {
-	if (got_at_least_one_head)
+	if (unexpected)
 		die("The remote end hung up upon initial contact");
 	else
 		die("Could not read from remote repository.\n\n"
@@ -115,10 +115,10 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct sha1_array *shallow_points)
 {
 	struct ref **orig_list = list;
-	int got_at_least_one_head = 0;
+	int first_line = 1;
 
 	*list = NULL;
-	for (;;) {
+	for (;; first_line = 0) {
 		struct ref *ref;
 		struct object_id old_oid;
 		char *name;
@@ -131,7 +131,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				  PACKET_READ_GENTLE_ON_EOF |
 				  PACKET_READ_CHOMP_NEWLINE);
 		if (len < 0)
-			die_initial_contact(got_at_least_one_head);
+			die_initial_contact(first_line);
 
 		if (!len)
 			break;
@@ -171,7 +171,6 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		oidcpy(&ref->old_oid, &old_oid);
 		*list = ref;
 		list = &ref->next;
-		got_at_least_one_head = 1;
 	}
 
 	annotate_refs_with_symref_info(*orig_list);
-- 
