Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55685C3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A68321741
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="QUZIBKpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgCDLr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:47:29 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54526 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgCDLr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:47:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id np16so234375pjb.4
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=WDOJTQK5ck+8r4Zf3ZsVQV/latrxaL9EkVDF982sj4E=;
        b=QUZIBKpq3nhgHY5PYB0LaCGR6VtaEb64C0Tj0m8ekISplWW4yNLqab3tLyQSujBxkX
         7Igz/VeRrq4qeeArf8ewqGlQX306v54/kralHZDd4UMOTuO2BTKQdNY+ZeEXtAu/GNWe
         uAaP4RxnOrzDXsXOjHzBge2fuxR+NBJNlFTpHImHfoS3xLvTgJYBwlbsslnaYstq0R/u
         QW/A1vnGYK/73FbSawWUxmVvbDPJzp1rAWflgNMyyEWDxOk8FSMhitGr7S00z6widHy9
         eLisF9VfLGt9oiQe6XggOkGk8lfsxN42PUGDXl4cmosn3qJuP41xh2QOWfrTiZelT3cH
         zwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WDOJTQK5ck+8r4Zf3ZsVQV/latrxaL9EkVDF982sj4E=;
        b=fGSWjfj4c7OFokic5zyWfVCVeKOrnqF4XiP7jNZAeaRJXDT4PMKyePfb7jgg2+KW48
         mgdebOIPWuozxBFZdjrG/PDwKuIC78Avf2W2GxYPaecd7DVTDCYezpCfME3p/tQhsZPc
         faE6eBzw46bpvZTVdt9Zor0H/If4e2upn6EKq6OswbqkBupAZGDHeI1JO52Qsteukc46
         nFVxCRda/8lbvP8hrYP51ANMu3Pwj6E+MOx5upJBB15kNr3qQOXnupyZEMn9fUdVcM/9
         brpvzurFpH7uNAK2kvfdQaIQzDXO2sXZQLZaB3eOxuB7UYWc/kfGZuHL5aq+N3U8kCxP
         c/zg==
X-Gm-Message-State: ANhLgQ09hicGf8O1Dw4QC2HFLiqjj0ELuH1sXUgtSg7bgkiWbh9PAlBq
        1AHwNwK6KeRoWQ3z/B5ahQVIG59U7uQ=
X-Google-Smtp-Source: ADFU+vtDUwOd2tC7oMvmi2Y3/iQrR5cqFa4525K1WxGcF0gE6QNPv5gBocDpPe3MnRyUp83zhdVNOw==
X-Received: by 2002:a17:902:8bc8:: with SMTP id r8mr2681576plo.48.1583322447842;
        Wed, 04 Mar 2020 03:47:27 -0800 (PST)
Received: from localhost ([203.144.74.196])
        by smtp.gmail.com with ESMTPSA id d22sm2658843pja.14.2020.03.04.03.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:47:27 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Signed commit regression?
In-Reply-To: <xmqqlfomefj2.fsf@gitster-ct.c.googlers.com>
References: <CAHk-=wgg8ctNmHbKjy-yYnz07L3m8=1et_q2FJHKM9mZKXzGAA@mail.gmail.com> <CAHk-=whg3uip_N1EjLEzaZNMvS8v+5u2GGueE9Wm2xnY87D+-A@mail.gmail.com> <xmqqpndyeim1.fsf@gitster-ct.c.googlers.com> <xmqqlfomefj2.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 04 Mar 2020 11:33:55 +0000
Message-ID: <87zhcwxskc.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28 2020, Junio C Hamano wrote:
> I'd expect that there may be another round of attempt to update the
> GPG interface.  Let's make sure we won't lose info given to the
> end-users while doing so.

The regression was introduced by this botched chunk in 72b006f4bf:

@@ -521,18 +522,19 @@ static int show_one_mergetag(struct commit *commit,
 	gpg_message_offset = verify_message.len;

 	payload_size = parse_signature(extra->value, extra->len);
 	status = -1;
 	if (extra->len > payload_size) {
 		/* could have a good signature */
-		if (!verify_signed_buffer(extra->value, payload_size,
-					  extra->value + payload_size,
-					  extra->len - payload_size,
-					  &verify_message, NULL))
+		if (!check_signature(extra->value, payload_size,
+				     extra->value + payload_size,
+				     extra->len - payload_size, &sigc)) {
+			strbuf_addstr(&verify_message, sigc.gpg_output);
+			signature_check_clear(&sigc);
 			status = 0; /* good */
-		else if (verify_message.len <= gpg_message_offset)
+		} else if (verify_message.len <= gpg_message_offset)
 			strbuf_addstr(&verify_message, "No signature\n");
 		/* otherwise we couldn't verify, which is shown as bad */
 	}

There are two ridiculous bugs in my original patch:

1. The output from GPG is only added to `verify_message' if a signature
   verifies successfully.

2. On verification failure, the "No signature" message is always added
   to `verify_message'.  This is because, again, no output from GPG is
   added to `verify_message' on failure, so its length will always equal
   `gpg_message_offset' (see the initial assignment) when
   `check_signature()' returns non-zero, sigh...

Not sure of the proper way of fixing a reverted commit, but I'll send v1
based on pu that includes regression tests.

I'm sorry for my fuckup and the headache it caused!

-- 
hji
