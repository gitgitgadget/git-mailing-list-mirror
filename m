Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECDC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 09:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjARJAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 04:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjARI7O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 03:59:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21E4614E
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 00:17:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r30so8649259wrr.10
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 00:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hNl2x06dc4yZteCZjT1tRTvyYDYh579liZtH1QQth9M=;
        b=g0l8fwnb776sKLmN0dcVa1Z6qYi+2ApF+dBy5jCamMthbV4+Nu+SBXbHUxhZQMxlId
         Rdmq2sGHYqdb4PO2jQXR1ItENBKlKqtN5OcpXFgQ1sE8y02yIlGo45QKAzbybLVKRPOT
         oYTFrG/zhb/P744eTSgbLUfONz8jRcikRkRcP3Zp3cns7TIKD2aw/G9xsJC5kCOtuuGi
         +9ESaI5ngB6BW2qsqTDff3pgyYWGuC8IMJak4Q8sfYW09mwZZMLZmuO0IedmdFQSLqWz
         Z3LdG8RSTiEqTRbMNqg8ie9qNH/foEZb6haXQo124RZdeHqbHMgSs4E6YLi6NgfM8VSw
         gTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNl2x06dc4yZteCZjT1tRTvyYDYh579liZtH1QQth9M=;
        b=R7Bd74UH2sYIXANzeE1QrvcdVnVSKDTBazAt6kKzHdJaVKtElgOHs9DbMM18UBMnde
         0JXd2H6IqIJwPW5iTzHu1X8ZH2VBZ+oUeZQMK+sFP/hjq07NKi4aZgR7aGaKyhWc6Tfp
         WHh1DHyIj4UCryOvkkJ8pb1y3GlzKwHPcf10mvEO0VXDLbex2pqCtUZoFdUhPs85oxdh
         P/52+nkJze+NYSl/fkMUwKd4JvGMNE5lPj88gAXF8VuWiSzg5eFpGEMVyF5PXc9S2gi0
         gKDibt9ASEHLAwKIaRdXE3QTwqjD/+YrT6xkv5M5Kkfhwk0V8LErnjyYsn7iN1gAUtsx
         UXvA==
X-Gm-Message-State: AFqh2kpA6nt+onh00JcD3F2G+HZ9WDoqqx8vyx3APr8YNBiGQSsOf0mL
        8BQfN67fdyxVOFf5BVXfACYyZGREGpI=
X-Google-Smtp-Source: AMrXdXtWJ4k2Knd6DUqeuR8Vqxcjjrx4l5Bj6qE1fFWJSOvESy9WFC1fWE7NE40chOG/j7tyy+LM4g==
X-Received: by 2002:a05:6000:1e0f:b0:2bd:fe42:2b34 with SMTP id bj15-20020a0560001e0f00b002bdfe422b34mr5476988wrb.71.1674029875510;
        Wed, 18 Jan 2023 00:17:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b00236545edc91sm31172083wrv.76.2023.01.18.00.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:17:55 -0800 (PST)
Message-Id: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
From:   "Adam Szkoda via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 08:17:54 +0000
Subject: [PATCH] ssh signing: better error message when key not in agent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Adam Szkoda <adaszko@gmail.com>, Adam Szkoda <adaszko@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Szkoda <adaszko@gmail.com>

When signing a commit with a SSH key, with the private key missing from
ssh-agent, a confusing error message is produced:

    error: Load key
    "/var/folders/t5/cscwwl_n3n1_8_5j_00x_3t40000gn/T//.git_signing_key_tmpkArSj7":
    invalid format? fatal: failed to write commit object

The temporary file .git_signing_key_tmpkArSj7 created by git contains a
valid *public* key.  The error message comes from `ssh-keygen -Y sign' and
is caused by a fallback mechanism in ssh-keygen whereby it tries to
interpret .git_signing_key_tmpkArSj7 as a *private* key if it can't find in
the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All that
needs to be done is to pass an additional backward-compatible option -U to
'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets the file
as public key and expects to find the private key in the agent.

As a result, when the private key is missing from the agent, a more accurate
error message gets produced:

    error: Couldn't find key in agent

[1] https://bugzilla.mindrot.org/show_bug.cgi?id=3429

Signed-off-by: Adam Szkoda <adaszko@gmail.com>
---
    ssh signing: better error message when key not in agent
    
    When signing a commit with a SSH key, with the private key missing from
    ssh-agent, a confusing error message is produced:
    
    error: Load key "/var/folders/t5/cscwwl_n3n1_8_5j_00x_3t40000gn/T//.git_signing_key_tmpkArSj7": invalid format?
    fatal: failed to write commit object
    
    
    The temporary file .git_signing_key_tmpkArSj7 created by git contains a
    valid public key. The error message comes from `ssh-keygen -Y sign' and
    is caused by a fallback mechanism in ssh-keygen whereby it tries to
    interpret .git_signing_key_tmpkArSj7 as a private key if it can't find
    in the agent [1]. A fix is scheduled to be released in OpenSSH 9.1. All
    that needs to be done is to pass an additional backward-compatible
    option -U to 'ssh-keygen -Y sign' call. With '-U', ssh-keygen always
    interprets the file as public key and expects to find the private key in
    the agent.
    
    As a result, when the private key is missing from the agent, a more
    accurate error message gets produced:
    
    error: Couldn't find key in agent
    
    
    [1] https://bugzilla.mindrot.org/show_bug.cgi?id=3429

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1270%2Fradicle-dev%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1270/radicle-dev/maint-v1
Pull-Request: https://github.com/git/git/pull/1270

 gpg-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index 280f1fa1a58..4a5913ae942 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1022,6 +1022,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	strvec_pushl(&signer.args, use_format->program,
 		     "-Y", "sign",
 		     "-n", "git",
+		     "-U",
 		     "-f", ssh_signing_key_file,
 		     buffer_file->filename.buf,
 		     NULL);

base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
-- 
gitgitgadget
