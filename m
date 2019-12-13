Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FABC50728
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666BD2477A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQslYbeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLMN6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:58:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32804 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfLMN6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:58:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so6075507wmd.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SVII1kQsuRzK80C1ukpW8UUzp5/t43pSCzXiJaBtnPA=;
        b=FQslYbeRZYAmjhPMLnwlhLqMomDtb3cZcw3iGQdT7TAK3WHpUZYw4KknRvpXhnuYYx
         GLCjD3i6mIlEDyznTE8RApJLu2gT7fe3K77XYfRA1wjHrkYGa5tuKv2tJOAeRkHuQbm5
         ZziLvVI6W4HM6F1eMN/D8DeEds/+1KuO0lArfOtQwPjqu+rL4wqj1Uk9GOZkdP2b6PPz
         NujrE/NWAYmm0XlXfEL/LnCrDAPex3fMDoYU7RG/0q6fSXf8NfmdNO8i1EErxRAENb4X
         DoTkWEBx+GEE2vCJwPwpJW4SSjxoF0ZtuN4ySmJTkBczQBKcqQW+txFi+n7VDLVni2A0
         SsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SVII1kQsuRzK80C1ukpW8UUzp5/t43pSCzXiJaBtnPA=;
        b=dwKtwIq+hMLbfmyk12lOUQ020asYHb6DMf7q9pgHsD0oTOW8W2nLStvPMW8hCkFFSi
         teG8SqmBy+9jCGIvOtNDWnufv9pPGCE14jQyDQJ/vC3LPv12gLTHZ20kGih71n7kciGJ
         3FeOGi/n6EtDBbdrImr+Bh9bH7Jh48gL8EPTAJmE2EbIx4f5ihMqAx7xcRx3puerZhmv
         1zhY6AbniqAO25N4W+Qh0OOgSOyFNeMIT0C8FBMZUvLRkaXzdBUajlXgLf8QBX3ds9rh
         7zJfYBL5C4rnfJfq12IONjePl2tPG5z5ujf6UnG/2HU+jA5Wsyn1we9RyxgfHqNT3SqE
         FQvg==
X-Gm-Message-State: APjAAAWyzqf7V2kXhxlXaiFh8QPM1ItROU1BJ7Hs0+nSzLgUc53R9Vza
        qB3BrCG060RlIGTzALr4NQSwKQnY
X-Google-Smtp-Source: APXvYqzVrr5OArVc1f4uZc8t5moL3H8R2nf/9zxnjZnNti/CN7Pcy55eUVPd+SDH2oks/x4jw38y2w==
X-Received: by 2002:a1c:46:: with SMTP id 67mr13515378wma.51.1576245482868;
        Fri, 13 Dec 2019 05:58:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm10238558wro.47.2019.12.13.05.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:58:02 -0800 (PST)
Message-Id: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
References: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 13:57:57 +0000
Subject: [PATCH v4 0/4] git-p4: Usability enhancements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some user interaction with git-p4 is not as user-friendly as the rest of the
Git ecosystem. 

Here are three areas that can be improved on:

1) When a patch fails and the user is prompted, there is no sanitization of
the user input so for a "yes/no" question, if the user enters "YES" instead
of a lowercase "y", they will be re-prompted to enter their answer. 

Commit 1 addresses this by sanitizing the user text by trimming and
lowercasing their input before testing. Now "YES" will succeed!

2) If the command line arguments are incorrect for git-p4, the program
reports that there was a syntax error, but doesn't show what the correct
syntax is.

Commit 2 displays the context help for the failed command.

3) If Git generates an error while attempting to clean up the RCS Keyword
expansions, it currently leaves P4 in an invalid state. Files that were
checked out by P4 are not revereted.

Commit 3 adds and exception handler that catches this condition and issues a
P4 Revert for the files that were previously edited.

4) Git can handle scraping the RCS Keyword expansions out of source files
when it is preparing to submit them to P4. However, if the config value
"git-p4.attemptRCSCleanup" isn't set, it will just report that it fails.

Commit 4 adds a helpful suggestion, that the user might want to set
git-p4.attemptRCSCleanup.

Revisions
=========

v3 - Implemented the various suggestions from Luke and Denton.

I did not add additional exception handling for the EOFError in the prompt
method. I do believe that it is a good idea, but that would change the logic
handling of the existing code to handle this new "no answer" condition and I
didn't want to introduce that at this time.

v4 - Whitespace clean up and commit clarifications.

Submit 3 suggested some clarifications to the commit test and revealed some
whitespace errors.

Ben Keene (4):
  git-p4: yes/no prompts should sanitize user text
  git-p4: show detailed help when parsing options fail
  git-p4: wrap patchRCSKeywords test to revert changes on failure
  git-p4: failure because of RCS keywords should show help

 git-p4.py | 93 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 34 deletions(-)


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-675%2Fseraphire%2Fseraphire%2Fp4-usability-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-675/seraphire/seraphire/p4-usability-v4
Pull-Request: https://github.com/git/git/pull/675

Range-diff vs v3:

 1:  fff93acf44 ! 1:  6c23cd5684 git-p4: yes/no prompts should sanitize user text
     @@ -10,10 +10,10 @@
          will fail.
      
          Create a new function, prompt(prompt_text) where
     -      * promt_text is the text prompt for the user
     -      * choices are extracted from the prompt text [.]
     -          a single letter surrounded by square brackets
     -          is selected as a valid choice.
     +      * prompt_text is the text prompt for the user
     +      * returns a single character where valid return values are
     +          found by inspecting prompt_text for single characters
     +          surrounded by square brackets
      
          This new function must  prompt the user for input and sanitize it by
          converting the response to a lower case string, trimming leading and
     @@ -26,6 +26,7 @@
          choices, remove the loop from the calling code that handles response
          verification.
      
     +    Thanks-to: Denton Liu <Denton Liu>
          Signed-off-by: Ben Keene <seraphire@gmail.com>
      
       diff --git a/git-p4.py b/git-p4.py
     @@ -119,8 +120,3 @@
                               break
       
               chdir(self.oldWorkingDirectory)
     -@@
     - 
     - if __name__ == '__main__':
     -     main()
     -+
 2:  5c5c981632 = 2:  bfdd3dc517 git-p4: show detailed help when parsing options fail
 3:  c466e79148 = 3:  20f6398693 git-p4: wrap patchRCSKeywords test to revert changes on failure
 4:  00307c3951 = 4:  c78e2e4db1 git-p4: failure because of RCS keywords should show help

-- 
gitgitgadget
