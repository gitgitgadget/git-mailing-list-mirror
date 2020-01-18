Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F633C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E382468D
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf2HnHNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgARIdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:33:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42768 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgARIde (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 03:33:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so12825718pgb.9
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9CuCKi/K1gnzNNdmC7X9dz8Nca6UM53SC/q2hKYxXE=;
        b=Tf2HnHNhinV1ZlKPFSTWvplkyLrJdu79q7/Uak5E1zAJqtQ531p56JARrrQlfyJ4Ak
         kpvvnOeNahBc7TWaV+QUwVmz3xEZEfEvWlyUte5h3NKt8YkbNvrs83xlvFLMfDq+Rfqr
         tD6QKUKJIss4A9WxVBq8z0/2Ratq//Pw7tnZZS2ljjWotrKH5EUJh0e0e6uXwLr23/At
         PSLn9jKVo1ZlMz02nXWpJwMKh+E5bbow7OBsvwqMJJg8nNUXYqPS9gtn6RL46t4ZjmhB
         ciFgjfflWro3+7WM7VBtAkPHOcv32sgeTNffgpL4dRMf+htvwFTX2PK99ZRrlVQ9scID
         vHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9CuCKi/K1gnzNNdmC7X9dz8Nca6UM53SC/q2hKYxXE=;
        b=cdfPuOLjTucb8fVo2y4ypQ+Y6DxrkfV37uHHl9G68rE8GmOZN+5Ib/0nbrQWJhGR4o
         IORex6p5Qrfq1BGpqmZeGm4dTBHGEyX5fikgvCfIApIq/XT6tuzScmHbhoU/AW4pJnPd
         0sUcZTN6xNaSevKyzUb2Gzi2LyNU5H/KjCNTYiaSpFjVbLBpVse03IwcGfTpjgUJblbT
         vT6chkBT/sk/uxn4K+I9DtWygv6B7hFOOOMQXUv2nrOZicL/HcPiZU3gFB/kFF24qqVr
         JDUL2DuTeOst1d2OiN6dK+3IjgzkMCtTZsloxpzwIHc6FFMV17Da+IisHPLxyG4AvzS1
         pCWg==
X-Gm-Message-State: APjAAAWmxy3K09+ZeUXkse94BsrwUmCk7vdr/AsoIkxturCwnnx/zgTY
        xRhChwsC342nVsUNYsbI+D4=
X-Google-Smtp-Source: APXvYqwMG9R4Uuy7XakK8ITAsCUDJbRsZq0ZOIiS01EHZG1/lY+INTcSgvM/IslIzZ4RGoWjihApeg==
X-Received: by 2002:a63:106:: with SMTP id 6mr49893806pgb.190.1579336413966;
        Sat, 18 Jan 2020 00:33:33 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id c10sm605038pgj.49.2020.01.18.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 00:33:32 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH 0/3] t6025: updating tests
Date:   Sat, 18 Jan 2020 14:03:20 +0530
Message-Id: <20200118083326.9643-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
References: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings everyone!

This is my first ever contribution in the Open-Source Community and I chose Git
for this purpose as I have been using this important tool to maintain my projects
regularly.

In this patch, I have:

  - modernized these tests so that they meet current Git CodingGuidlines[1]
  - replaced the pipe operator with the redirection operator so that one can
	detect the errors easily and precisely
  - used helper function 'test_path_is_file()' to replace 'test -f' checks in
	in the program as it improves the readability of the code and provides 
	better error messages

Also, I have some questions to better my understanding of the code:
	- In the statement, 
		> git hash-object -t blob -w --stdin
	  is it necessary to explicitly specify the type 'blob' of the hash-object?
	  I have this question because it is the default type of hash-object.
	- In the statement, 
		> l=$(printf file | git hash-object -t blob -w --stdin)
	  I have not used the redirection operator as this sub-shell will be executed 
	  separately, hence its error cannot be captured therefore the presence of '>' 
	  will not matter. Will using '>' improve the code?

Thanks,
Shourya Shukla

Shourya Shukla (3):
  t6025: modernize style
  t6025: replace pipe with redirection operator
  t6025: use helpers to replace test -f <path>

 t/t6025-merge-symlinks.sh | 97 ++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

-- 
2.20.1
