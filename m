Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D32DC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B4F20748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udLo6p9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgAPUgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:36:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39744 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgAPUgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:36:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so10793659pfs.6
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9CuCKi/K1gnzNNdmC7X9dz8Nca6UM53SC/q2hKYxXE=;
        b=udLo6p9vI5K4fo7qfwjNKQ6dnojS537/iypyQb/m5EY50k2ZbVEW0oVA/1nw3BmhJw
         XEnhp5B9FW1XOIzQvmcR0YNToPBa+pLWU4JSs/Jgqu2MA1CFpc2bhIe3ql8SsG51xU3P
         dAGsAME7G+ceBUCWta/ST2Id8g6xDTjFl4PS/1lIZyigryIaQ4QHKQ7IYY40GMsH3oQY
         k6Wb57bUu0GUrtWGNnVGUP23LFaxObkJVkbyXUhz4WO14bcbdHPj2Lfp0lI8TGR/Z7ro
         ZpTVXN9mssW/ZlvWyao5vacyzMO02iC62FHN7Ruyz2H6XcJx/zM60jc8k6ojoYSAXfHe
         TfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9CuCKi/K1gnzNNdmC7X9dz8Nca6UM53SC/q2hKYxXE=;
        b=evuCdcGb513VZddgoXCn/aSkZTnj+VA7THE4Hz69OHk9yAtCZfNgOA3LcH/hPRqspr
         M1OzdyxQLdy/PW7VLi83uXyDb52NvCySFdGQ0tz/v4OFslQgt0yCqfXInWJerjhUxQZ6
         97Ie50FXiDuacYvgAl5jYcCEMePqQ0q6JvkyIUkV4vd024ifhmkWrEqi+mCNQfjwhN1D
         NgXy/EMztSA12EYkrdrk0M+ywbyAtTjOt5B+vKn8//XF8tgleAi+LfOxo9aRXyo2PQbc
         SktQ6idFfhk+q612bUJ/MCf3Vd646Kf6YkKIXUvSfUkGmlBzXz7tzpUambt28NIUInLH
         E1ww==
X-Gm-Message-State: APjAAAUY7LiKzWWqxkiipfPtrSMJz7lSb6KEDxux3v6dRrc1y6aBaTYI
        o8TIDuphYPJs/erbZ67YKL56vQpVWb65Sw==
X-Google-Smtp-Source: APXvYqxuyK4fv1ik37TxcMChx4/ww2YWQZjKIwGQ8zl4A3+FQ0FOvcuhi3EKQqL8YWiX+LxUS5zVEw==
X-Received: by 2002:a63:1b0a:: with SMTP id b10mr41020048pgb.56.1579206994691;
        Thu, 16 Jan 2020 12:36:34 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id d4sm3481167pjg.19.2020.01.16.12.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:36:33 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 0/3] t6025: updating tests
Date:   Fri, 17 Jan 2020 02:06:19 +0530
Message-Id: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
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
