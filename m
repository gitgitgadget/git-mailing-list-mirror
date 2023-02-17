Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6169C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 23:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBQXdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 18:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBQXdl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 18:33:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C55D3C4
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 15:33:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b20so1465813pfi.9
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 15:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVOSyIs1V14tQtKrDpOjgJLSDWwAb8TBiy8o7KFbHqk=;
        b=jhI1kmcfHr073WC30ahU78y876i2ggmHXD9Snskvb2jiYXqtRfc2pqopAfrdRTl/tv
         au8cocXxceZh+lciLBazPtBMn33Q0RsRypXLQ6WnOqDQivkYOIn5eLkYS4GjshUqITTr
         /iRjV2Wx65AI90bH3AuDhjG0FF+wBTEWCesvJVVmtHf9oAnkrXVRP7uBQWYSly7PheIz
         nHUOKY5Ly77DEt4Vja4vLpCwH8vt65vCYF66o2APrmnj4f3UFScTf/znJ86z7IebhKvW
         nwSUMQ4KGWzxf/HzArdXRZlTlzx2EdA2U0Hosv3KEHAVk6qtLzC7pnIEtHjzfhxcSwJJ
         kx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVOSyIs1V14tQtKrDpOjgJLSDWwAb8TBiy8o7KFbHqk=;
        b=PhQJk5Udw2EXt+aHxq36il2x+nlblYTT+mQrfh9bpF4M+WNsX/ZY2h0Dm1yQQekaos
         Jo1vxiKupsV8rO2jURer0ij/RZVJU3yIE4ziwBDohA4jQvB+FpyoQXhmPd2NZhxa90O4
         TRBK4T52GN8We9Bdbbh6klR9FegG1pRbzqRm64+VXrLNQjhE5qzkvheBsPVtfzw5SaV6
         HdN7bzE3erEf1wuJn5galseTTHEAKVBAQ3jAmwBxAKab+s3gPI5LbA52wspF3mROdAKJ
         eSgfHgxCn4V9iGmGR1WbLEA4hNBOPP5fr2KrHv4MMV04k4RkFzuJMKBR3I120jq+95yE
         oIRQ==
X-Gm-Message-State: AO0yUKWXeuEnJ0JGhrNjsKx443/Oupo6hGb3SOVAYH8vHu5LJNBJGeVl
        hZtT1nZUVmadqGShFJpCot+f3FZ+rZw=
X-Google-Smtp-Source: AK7set+biFRPizkd8D91bHX9Mh77Gr4TTRghEsKA1hCq3SJxybVqrXmpaGOR9EVfZ0NhTdwd2uX4Bg==
X-Received: by 2002:a62:5f45:0:b0:5a8:49c8:8533 with SMTP id t66-20020a625f45000000b005a849c88533mr2700598pfb.8.1676676818840;
        Fri, 17 Feb 2023 15:33:38 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y25-20020a62b519000000b005a8bc11d259sm3659219pfe.141.2023.02.17.15.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 15:33:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Brian Inglis <Brian.Inglis@Shaw.ca>
Subject: [PATCH] format.attach: allow empty value to disable multi-part
 messages
Date:   Fri, 17 Feb 2023 15:33:37 -0800
Message-ID: <xmqqwn4fkgtq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a lower precedence configuration file (e.g. /etc/gitconfig)
defines format.attach in any way, there was no way to disable it in
a more specific configuration file (e.g. $HOME/.gitconfig).

Change the behaviour of setting it to an empty string.  It used to
mean that the result is still a multipart message with only dashes
used as a multi-part separator, but now it resets the setting to
the default (which would be to give an inline patch, unless other
command line options are in effect).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a backward incompatible change, so we may not take it in the
   end.  We'll see.

 Documentation/config/format.txt |  3 ++-
 builtin/log.c                   |  2 ++
 t/t4014-format-patch.sh         | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 3bd78269e2..73678d88a1 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -3,7 +3,8 @@ format.attach::
 	'format-patch'.  The value can also be a double quoted string
 	which will enable attachments as the default and set the
 	value as the boundary.  See the --attach option in
-	linkgit:git-format-patch[1].
+	linkgit:git-format-patch[1].  To countermand an earlier
+	value, set it to an empty string.
 
 format.from::
 	Provides the default value for the `--from` option to format-patch.
diff --git a/builtin/log.c b/builtin/log.c
index 04412dd9c9..a70fba198f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1007,6 +1007,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "format.attach")) {
 		if (value && *value)
 			default_attach = xstrdup(value);
+		else if (value && !*value)
+			FREE_AND_NULL(default_attach);
 		else
 			default_attach = xstrdup(git_version_string);
 		return 0;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 012f155e10..f3313b8c58 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2281,6 +2281,24 @@ test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
 	test_line_count = 1 output
 '
 
+test_expect_success 'format-patch with format.attach' '
+	test_when_finished "rm -fr patches" &&
+	separator=attachment-separator &&
+	test_config format.attach "$separator" &&
+	filename=$(git format-patch -o patches -1) &&
+	grep "^Content-Type: multipart/.*$separator" "$filename"
+'
+
+test_expect_success 'format-patch with format.attach=disabled' '
+	test_when_finished "rm -fr patches" &&
+	separator=attachment-separator &&
+	test_config_global format.attach "$separator" &&
+	test_config format.attach "" &&
+	filename=$(git format-patch -o patches -1) &&
+	# The output should not even declare content type for text/plain.
+	! grep "^Content-Type: multipart/" "$filename"
+'
+
 test_expect_success '-c format.mboxrd format-patch' '
 	sp=" " &&
 	cat >msg <<-INPUT_END &&
-- 
2.39.2-501-gd9d677b2d8

