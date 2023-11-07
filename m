Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC34358B3
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ghr7xAQa"
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9DC120
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:22:58 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41feb963f60so22308961cf.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699381377; x=1699986177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOtY+mWAf67a4+JINx10ktWSKIT7UYqgd3eoaYX1ORI=;
        b=ghr7xAQaZBfHYNLJez9oBj6Nx6pNKtd7TN5SZKbPdnCCPoKexFdDP1nW8jAk6e6x8q
         xzq4eSpd7sHVSqDnWUweBcvEp/uEu8mIJELn7OtewCnUVfiuWt2Ss7GQNr0O0tFX1UZM
         DFIJF4WmRwKFzw1ibN7OoUDe5YjFF2DZyMgGsalvwP3f0OtX3jBzP0iR886QNFgMtFhw
         l5ZjNcHKz1QG/jwZ/bXwd1/jmLucz3V38n+IWkwnYpBXDDYW7yFX0cSfIUsxzIlGbWlW
         FEyAyJKtfwcm1o29AgQa4E8ZIT7Y4OEy9XRlooAq518eB49T7BJElcow8yeEKqzf8e9K
         s5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381377; x=1699986177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOtY+mWAf67a4+JINx10ktWSKIT7UYqgd3eoaYX1ORI=;
        b=MEJQlX+Fgv6IFe3YW9ESYUCtNb8+NQFjtiYl7O+7NVPqhCTGadABn//FQcm7O1QMmE
         /wHp6ma8H2JO26rR89PkA8QZffmisebUl7tnjyy1LYF2FiCxS3x1gMBoHXYSXqlk7KMz
         HztrQCJByon7MjwksRDM5RXqpNDooSPuQ6qtaUTPSV6Sr86NFNE9oCkRNw99rzVyTXFI
         UrjZxzP/JEG/gmmncOZBU3SGeYPsIhdjnTa77xbzPwClXy1EjV7tcGXEVSxDjVfhFox9
         uCUpRfnclkGTc1nxT+umAuvCtd2cpuTSzu9mNA9s9MZdz51s6HuMGuh3ia8tTUCRku3Q
         vaig==
X-Gm-Message-State: AOJu0Yz6EQdPaspho9jlGK+7vOlQIZa4ShbrCLVrndhy69nAOGKb8xWm
	r7ZitDkMbZUvp3WQ7Lh4srqy/4aZs8LUbU8iXAsSPQ==
X-Google-Smtp-Source: AGHT+IH//mQEZJY+A7Z2TJpZ5pXpPDGAUVTJJBr6XXDxJ7EJ15lba846LKt3JzIvDH7QL8FqrMolZg==
X-Received: by 2002:a05:622a:24b:b0:41c:c045:2c86 with SMTP id c11-20020a05622a024b00b0041cc0452c86mr5271947qtx.31.1699381377135;
        Tue, 07 Nov 2023 10:22:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i24-20020ac871d8000000b0041eef6cacf4sm139380qtp.81.2023.11.07.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:22:56 -0800 (PST)
Date: Tue, 7 Nov 2023 13:22:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH 1/3] merge-ort.c: finalize ODB transactions after each
 step
Message-ID: <c615a61d32644b64ef8f47feb47ec909286c56b3.1699381371.git.me@ttaylorr.com>
References: <ZUpepnSCSxL8i96b@nand.local>
 <cover.1699381371.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699381371.git.me@ttaylorr.com>

In a previous commit, the ORT merge backend learned how to use the
bulk-checkin mechanism to emit a single pack containing any new objects
created during the merge. This functionality was implemented by setting
up a new ODB transaction, and finalizing it at the end of the merge via
`process_entries()`.

In a future commit, we will extend this functionality to the new `git
replay` command, which needs to see objects from previous steps in order
to replay each commit.

As a step towards implementing this, teach the ORT backend to flush the
ODB transaction at the end of each step in `process_entries()`, and then
finalize the result with `end_odb_transaction()` when calling
`merge_finalize()`.

For normal `merge-tree --write-pack` invocations, this produces no
functional change: the pack is written out at the end of
`process_entries()`, and then the `end_odb_transaction()` call is a
noop.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 merge-ort.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 523577d71e..7b352451cc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4354,7 +4354,7 @@ static int process_entries(struct merge_options *opt,
 		ret = -1;
 
 	if (opt->write_pack)
-		end_odb_transaction();
+		flush_odb_transaction();
 
 cleanup:
 	string_list_clear(&plist, 0);
@@ -4726,6 +4726,9 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
+	if (opt->write_pack)
+		end_odb_transaction();
+
 	if (opt->renormalize)
 		git_attr_set_direction(GIT_ATTR_CHECKIN);
 	assert(opt->priv == NULL);
-- 
2.42.0.446.g0b9ef90488

