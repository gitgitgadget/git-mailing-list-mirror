Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE6C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353621AbiBCSzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353615AbiBCSzC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:55:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD8C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:55:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h23so3010511pgk.11
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4Qi3Sm7j5+GZ5cKqFkd5Bd0uAaSBudaQWxqm6b/zUb4=;
        b=c4IBz6eBDQshshcYPv/JMDdK3wsgL31/3cSSLc1lpqI+faeWZVNjGUrAWWdDYLc2xq
         Zzb5qMMkwSHERRSuNBhsx3Ygj8BZFIh+yQA9oX18jm74UltsL475kw217j/hhyX1khXa
         vnA8qRmDZ/IzGp8kFm9rXpORyDDUaRQJHHhSWU2YxW5olh42j7BjUquYBvQAbWOxHRLO
         aYKYo+bQcs/F2ktE/drNPoBXNGz/3ahZSmyieh5VYvP/iqIc2f5hiP3qihKK+MguKtT2
         Oj2RV9D+mV0CnKb3bWI2ISyncT7gnFbIDlOmmgaCgaHr/d8MN5Y/V4oqAbdMYwsajYUY
         LCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4Qi3Sm7j5+GZ5cKqFkd5Bd0uAaSBudaQWxqm6b/zUb4=;
        b=DfNQ9XWFSuviPNAiZ1PXS+zzPb5f3Z9ACx4tm+FkPmkvvbcPjzKECBZB0ddfD2CP+7
         ieEbLQSS3B+4PnTZlWaJaD5M8OOf6VYNVP5s6/Bf1H80wQtKo6VbempTiz7RgplQe/d4
         tSvCKQWaA/kS5TqudI5Pxo+z/iacC7ge7smS0MaSliEcHo8U42K41/jrCAjby5zhRBZt
         g6reemuxY6dtgfhxRZ/nRTTL5InmqLSojV2qG96XOncEkJWiC14nYu8Paqc+qVqnM9Ai
         aqNjzG4NlzZJmag0H6B95aONdOIuufZhp7m8vrxl6SGuH/Izzkcm1JfNJKb4VCsMUrA8
         2ALA==
X-Gm-Message-State: AOAM530/nj95lLY7NswT5JEo1TPaRww2w+pFiM8rKv/da0ZJUeOCWw/q
        F2tjLQrBhzmC8cRCcNp+K24=
X-Google-Smtp-Source: ABdhPJynxFofAc6D7E+M3Y4ScnfjUiOKraIWPUBlNrMJhvXdAMLC8pIrv4rHPsT7QVjn1ODd0TM1ow==
X-Received: by 2002:a63:5c1f:: with SMTP id q31mr29598925pgb.176.1643914502057;
        Thu, 03 Feb 2022 10:55:02 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id a13sm24365564pgv.27.2022.02.03.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:55:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
References: <20220203123724.47529-1-fs@gigacodes.de>
Date:   Thu, 03 Feb 2022 10:55:01 -0800
In-Reply-To: <20220203123724.47529-1-fs@gigacodes.de> (Fabian Stelzer's
        message of "Thu, 3 Feb 2022 13:37:24 +0100")
Message-ID: <xmqq7dabvkze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> gpgsm v2.3 changed some details about its output:
>  - instead of displaying `fingerprint:` for keys it will print `sha1
>    fpr:` and `sha2 fpr:`
>  - some wording of errors has changed
>  - signing will omit an extra debug output line before the [GNUPG]: tag
>
> This change adjusts the gpgsm test prerequisite to work with v2.3 as
> well by accepting `sha1 fpr:` as well as `fingerprint:` and allows both
> variants of errors for unknown certs.

OK, so the change is meant to add support for the new behaviour
without deprecating/removing the support for the older one.  Good.

> Checking for successful signature creation will omit the leading NL in
> its search string.

I think this is to adjust for "will omit an extra debug output"; as
long as we still ensure that the "[GNUPG:] SIG_CREATED" comes at the
beginning of a line with some other means, I think that is a good
change.

> I am not a user of gpgsm but noticed that the GPGSM test prereq was disabled 
> on my runs so i investigated. The `fix` seems rather trivial and I tried to 
> test this as thorough as possible. I ran the test suite on machines 
> available to me (fedora35, centos8) and did a full CI run on github without 
> any issues.
> But if you actually use gpgsm with git please give this a go and let me know 
> if I missed anything.

Yup, thanks for a call for help.  I am not gpgsm user either and
testing by actual users is very much appreciated.

> @@ -939,7 +939,7 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
>  			   signature, 1024, &gpg_status, 0);
>  	sigchain_pop(SIGPIPE);
>  
> -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
> +	ret |= !strstr(gpg_status.buf, "[GNUPG:] SIG_CREATED ");

This I am not sure about.  I understand that the intention is to
allow this at the beginning of gpg_status.buf, but not to allow the
substring appear in the middle of an otherwise unrelated line.  I am
afraid that the new check is a bit too lose for that.

Totally untested but just to illustrate the idea...

 gpg-interface.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git c/gpg-interface.c w/gpg-interface.c
index b52eb0e2e0..4238e60dfa 100644
--- c/gpg-interface.c
+++ w/gpg-interface.c
@@ -920,6 +920,7 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
 	size_t bottom;
+	const char *cp;
 	struct strbuf gpg_status = STRBUF_INIT;
 
 	strvec_pushl(&gpg.args,
@@ -939,7 +940,13 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   signature, 1024, &gpg_status, 0);
 	sigchain_pop(SIGPIPE);
 
-	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
+	for (cp = gpg_status.buf;
+	     cp && (cp = strstr(cp, "[GNUPG:] SIG_CREATED "));
+	     cp++) {
+		if (cp == gpg_status.buf || cp[-1] == '\n')
+			break; /* found */
+	}
+	ret |= !cp;
 	strbuf_release(&gpg_status);
 	if (ret)
 		return error(_("gpg failed to sign the data"));
