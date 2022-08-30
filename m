Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CFDC0502A
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiH3Jc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiH3Jca (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:30 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF3DF0B8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:14 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11edd61a9edso9321937fac.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oTRE06/q9ntf0vVxS5BAWAQYIHk6BB6j42GcRK3OcPY=;
        b=N57JwuX5eU1vQUgnQWp7wWOdUZmjAGN94IVJy1h0KeCedMhanusI0u7VAGtMtB34gy
         9RQWCeqDQIFORIkazssvE0XraLmkwBf09bCl7yakHmvkRrCFSTVOkRWHUyh4Fh4qoB/P
         pbW/Frhr9TKfRmWiWzg0lbsPlaOHC+FgeuJy5futXW5COWjKFc26AuOz1fKPdlrcgbIU
         OhMQlf6JsOvOKIYPTMph21fV9Z5P1SqOtUSQdfhSXJxBM0dlbxtNOgpBkU0zNr2dXX17
         PMaFUN9kw19fh79PnOw/vDpo1EDiPOhFyvp8Dri0bKi4twAMarqUmIek0LFld5kX1P/i
         yX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oTRE06/q9ntf0vVxS5BAWAQYIHk6BB6j42GcRK3OcPY=;
        b=7WaMbYuByEfzwg9FSFA/MYfwx4Ww+C8s1+RMY6PQltAnRfBwvbLG3iEMchFWEkxGcO
         oJ7AmMw/xWgjabKzp6bX4Eh3Xx7hd457mOh3AWznqhYZ1+3PfLq05FrjgjBiHJqw4rqd
         rOpHkfMEjjUYmmxhHEWOvAP9axb/KuO+57CGYLtNjTR/xXKqprvCRcBwkbbZNuIQ7unX
         8rvy0ueDyPQoYdx4xX+aJA+JazVLvyiVAiTIZHk2cRkzp+qoAd3UBv19Fs8X0SGC3tAE
         mokaIeCVy1cep+nr3H/8RExqCpe0k5hBCjyY/QJxZkH/nwD6ys/iE5wJihAuLvjiSl/n
         jtVA==
X-Gm-Message-State: ACgBeo2gYqgRY9h/CcHCYTijyMVDnkVq3Fmsfbbkwr2rjpzamhfLXAgh
        hPRfJSLNUH3lGuH3otOShoIsc5SlOz0=
X-Google-Smtp-Source: AA6agR7INhKmNQCNo+vZXx2BdDRV46ansWh5udPOdYG7Gqd5ibTzTVg30dE5MVw+aKBqvy/QmJ+bRA==
X-Received: by 2002:aca:d0a:0:b0:343:4049:689b with SMTP id 10-20020aca0d0a000000b003434049689bmr8830838oin.56.1661851933318;
        Tue, 30 Aug 2022 02:32:13 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u187-20020acaabc4000000b00342df642fd3sm5844662oie.48.2022.08.30.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 20/51] completion: zsh: expand --git-dir file argument
Date:   Tue, 30 Aug 2022 04:31:07 -0500
Message-Id: <20220830093138.1581538-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 10ad15face..0e72b9add7 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -245,7 +245,7 @@ __git_zsh_main ()
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'
 		else
-			__git_dir=${opt_args[--git-dir]}
+			__git_dir=${~opt_args[--git-dir]}
 		fi
 
 		(( $+opt_args[--help] )) && command='help'
-- 
2.37.2.351.g9bf691b78c.dirty

