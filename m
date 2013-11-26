From: =?UTF-8?B?IkFuZHLDqXMgRy4gQXJhZ29uZXNlcyI=?= <knocte@gmail.com>
Subject: [PATCHv4] transport: Catch non positive --depth option value
Date: Tue, 26 Nov 2013 12:41:09 +0100
Message-ID: <529488D5.80605@gmail.com>
References: <5283A380.9030308@gmail.com> <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com> <528A9877.4060802@gmail.com> <xmqq61ro9utf.fsf@gitster.dls.corp.google.com> <528E2660.6020107@gmail.com> <xmqq1u294ih3.fsf@gitster.dls.corp.google.com> <CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com> <5293DE93.3020008@gmail.com> <CACsJy8BV74W63Sak-j_9RMjp_5Bo8HMd3Xc93GTtSn4yWStfEA@mail.gmail.com> <52947B42.4080105@gmail.com> <CACsJy8Dfibu96VchD=p_05deLm-46mfXZzcYQg+0BqaN2=To=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 12:41:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlH1C-0008DB-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 12:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab3KZLlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 06:41:13 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:47299 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3KZLlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 06:41:12 -0500
Received: by mail-ea0-f179.google.com with SMTP id r15so3413815ead.38
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 03:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=f0xH0G2DotfvTGOJhIedP1zaksXweiZDmCJmosYgPy4=;
        b=dbAYfRJl9XjZBHwVWOTZoYG26gU2ImN3PtGNp60U4g/gaPPbQ1fix6FJxq9gcDf0eA
         jf3ed6Akc3rILA3dAAnBbUzi5IEwUg86zaQbty6gUsO9IibuBpSSDHrIXXiBY1lG80m3
         XQ9DN1mp3v5SCq0e9vzYl7laFurAF93SX2F8ebWH5cTX4F14iAVlYI8jj77OyQwJ1/P1
         D4wYkpAI+DmsTN/O6nyE+3T+QhmxZbVIQ1MUqVGSsCGt52R2J75wzP9QsJKWZjxSwRhn
         mdVI35nvTYMVOXhJLGMOeRwVlhQs8Ljw9dCfwzn6j0pK4zWjyWO3ysJwRiQdU0EOFIX9
         JYOA==
X-Received: by 10.14.211.69 with SMTP id v45mr2086395eeo.75.1385466071907;
        Tue, 26 Nov 2013 03:41:11 -0800 (PST)
Received: from [192.168.0.151] (82.Red-83-39-68.dynamicIP.rima-tde.net. [83.39.68.82])
        by mx.google.com with ESMTPSA id 8sm8146283eem.15.2013.11.26.03.41.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Nov 2013 03:41:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACsJy8Dfibu96VchD=p_05deLm-46mfXZzcYQg+0BqaN2=To=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238379>

>From 4f3b24379090b7b69046903fba494f3191577b20 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andr=C3=A9s=20G=2E=20Aragoneses?= <knocte@gmail.com>
Date: Tue, 26 Nov 2013 12:38:19 +0100
Subject: [PATCH] transport: Catch non positive --depth option value

Instead of simply ignoring the value passed to --depth
option when it is zero or negative, now it is caught
and reported.

This will let people know that they were using the
option incorrectly (as depth<0 should be simply invalid,
and under the hood depth==0 didn't have any effect).

(The change in fetch.c is needed to avoid the tests
failing because of this new restriction.)

Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
---
 builtin/fetch.c | 2 +-
 transport.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7a101..88c04d7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -770,7 +770,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	}
 
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
-	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
+	transport_set_option(transport, TRANS_OPT_DEPTH, NULL);
 	fetch_refs(transport, ref_map);
 
 	if (gsecondary) {
diff --git a/transport.c b/transport.c
index 7202b77..5b42ccb 100644
--- a/transport.c
+++ b/transport.c
@@ -483,6 +483,8 @@ static int set_git_option(struct git_transport_options *opts,
 			opts->depth = strtol(value, &end, 0);
 			if (*end)
 				die("transport: invalid depth option '%s'", value);
+			if (opts->depth < 1)
+				die("transport: invalid depth option '%s' (must be positive)", value);
 		}
 		return 0;
 	}
-- 
1.8.1.2
