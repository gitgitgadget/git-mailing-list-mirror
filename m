Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95828C33C9E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 06:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CEB20658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 06:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKxoXdD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgBCGr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 01:47:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43041 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBCGr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 01:47:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so5447746plq.10
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 22:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzgjDVnfmVteAUl+q92RhM3Qcz0mxdpfL+UEg+M69/s=;
        b=lKxoXdD/Z3eRTvuN0nBfJ7E9MT9HUPQ5qnUFhFi9sw45SZdhezmolIutfICbkAgE/5
         E3ZukGEbNWQFMlSNudxKfhwoYyiQrxQJNJ3Jv5MzZScUgWU8HM9hE/hZmsjdBP3OChY8
         urrDxL6VNf4jcV97sZvTTmpjoYTaniGYHEgGphx9ngBL7zyrKgOveZZKcitWPVePJaps
         KSLyMPfROocJYiruDuonr0R/eN7w6Hmm6LSCak+bo4PdaYpLRmoBGgk46ebf9rJNGBmr
         EeQ1Q2IJkyPDthCNvKYcYuSPTIXGlxZGXVtgOqImhAiQy3UfZR6jxW2MbTgo1pROMka0
         81YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzgjDVnfmVteAUl+q92RhM3Qcz0mxdpfL+UEg+M69/s=;
        b=Wlc7ZxdUaKZKoMPwvgIuFciM5wl6LC47Kzvuc9MhFBfE2+YT4tJtLlZ/uC+zexAbSO
         bueEWE1cwB3/MVlEnCjcQGVjKieBrSbej+L6wpWSqJdEg6HGA+bb0KXRgOSdFQX3pb18
         yD9V/JFOKrtms2cUCECWFCbhdE8rphz4qZ/KkvMi0EqC3WPKuUhpYQpf+id/KKGwE2wF
         jFnL6TFOp8You7wNgSsUZi9ur2GO5/oozfG1tQheARfeOwNtZSaQJ7usz/02UF4aYXJp
         xp/YgP+qQL0nFTU52gdL/taVHvAhkrcSwtfmlyuV0DozB2OJCY6zAjM0fBWC0GV5Uhq4
         R3qQ==
X-Gm-Message-State: APjAAAUwWLnI70oxr7TV3Ft955JsnZKpeQ2no3p2Crw6nLiSUBgytci0
        4DNh1uS5C7LB9uDzGWhgGNtA0ikgYStnBw==
X-Google-Smtp-Source: APXvYqxYSVadBr7sPbq73lw8NJ7i27HOZV3rAR668civvrr4bl1p2NZUcCBHXcDgmGh7Frp9hpbZqA==
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr28490815pjq.14.1580712445411;
        Sun, 02 Feb 2020 22:47:25 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id w28sm10341913pgl.20.2020.02.02.22.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 22:47:24 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        christian.couder@gmail.com, peff@peff.net
Cc:     newren@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: sending attachments via git send-email
Date:   Mon,  3 Feb 2020 12:17:12 +0530
Message-Id: <20200203064712.14621-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I was doing some tests on 'git send-email'[1] and noticed a couple of things:

	1. We are not able to send attachments via 'git send-email' unlike
	   various other mail clients such as GMail, Yahoo, etc. Is there
	   any particular reason for this (maybe performance issues or code
	   compatibility issues etc.)?
	
	2. Even so, I tried sending an image to myself and noticed that the
	   command basically does not check if we are sending a text file or
	   not(though I think it should unless there is any key reason behind it).
	   On executing the command(when trying to send an image), it asks for the
	   encoding (that was odd as it did not ask for any of emails I have sent
           using the command). I entered the command:
	   'git send-email --to=shouryashukla.oo@gmail.com --subject=test_mail me.JPG'
	   which prompts:
	   'The following files are 8bit, but do not declare a Content-Transfer-Encoding.'
    	   'me.JPG'
	   'Which 8bit encoding should I declare [UTF-8]?'
	   So i enter the encoding as '8BIT', which at the end prompts:
	   'No subject line in me.JPG? at /usr/lib/git-core/git-send-email line 687.'
	   
	   Why is this happening even though I entered the subject in the command itself?

	3. I looked up at the script of the command and noticed that there are two files,
	   namely: 'git-send-email.perl' and 'git-send-email', both are identical except for
	   an extra 'use lib (split(/:/, $ENV{GITPERLLIB} || '/home/<<username>>/share/perl5'));'
	   on line 3 of 'git-send-email'(my inference is that we are trying to import the perl
	   library by splitting the addresses at '/' or something similar). What is the purpose
	   of the latter file?(I am new to Perl, if I am missing out on anything please forgive
	   my ignorance).

On an additional note, I noticed that there is a test file called 't9001-send-email.sh' which needs
various style modernisations and maybe other changes too(I glanced at the file so I might have missed
out on other improvements which could be made). ;-)

I would love to hear from the community what exactly is going on and if any improvements are possible in the command. :-)

Regards,
Shourya Shukla

[1]: https://git-scm.com/docs/git-send-email
