Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F7421F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJQCqs (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:46:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46621 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJQCqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:46:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id d8-v6so27015131qtk.13
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zfzt9tFlPfXt35NBJBG3s8ML8twyxpmt7YWYFVIgHZs=;
        b=jiG7zs7MyyDFpCoTHDvZhA5ty5iogTAh94vofKilBqkZSB1pjZsPuw1qf2WA5tC1xI
         /KjbWmtaZI7Fk597VMoVs1T6GQcpCUzWER4S3IIqC2U16UpxB46HkysGaHnDIgooOxF2
         bSqKyFEOuxnSsN5WrJaC59+ME5u7E6cTnr+2tHjfYyYdY1SHHrko660WO+hQ0wB8yOqA
         ydgyH6y70xerSxdFY6khseKB6MJLw39uvyUTaeYmW+oTfFPCcum4psQyEKzPSY7JPsbu
         U8RM75sWExRv/D2GPl+oerRLk80KyhW2yjLoT6Eb8w3XsU1g5A+HIdCRwfpup4xicBHm
         OOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zfzt9tFlPfXt35NBJBG3s8ML8twyxpmt7YWYFVIgHZs=;
        b=O/Q9RP3ns3cmv8R9bN/weyEbvsLWMUbDpAEElK3Spf2RVoMuyMfXkWzgTecXc9XbX7
         3GOwAsmIeOVkxvecLl032f8r8C1vQXKES7E9wev9X3y9ej4p8dZdrUYR67yv89frHJrj
         rKepfC0nef6SDuVQ8zC0Ef0dOO1lYtThzPxVA14KjfIQRLJgetx1j8qBe2InxsMkQevo
         uItFNeqcRh/yQyRfW2C3wU4UrUc0yZpDsRsLyduQgVV7b0TcmVlnD7JrytMA8EW8Qa2Y
         BJuC90nt/kyYQfPg9vE7lt2vgI3pd++I42O0Y7NDEfbxlazybNFhSuRyuaG4GgHKmkNr
         lcVw==
X-Gm-Message-State: ABuFfogE9DGI+Wvx9JTUzYksCCC6kzLDB3SgdB7bX1TAvnS48nmTsSIT
        orR3XQcc90iIcGwSzYFYEX9jP1Bek+NFSYPScxNg6f8w
X-Google-Smtp-Source: ACcGV63LRU26mnnQhq6oW3bWgyKd3eqBZjNmFkeF2KYgmtDMVZBYLkvY6Tv8mXuFW1OG+0sqPwQn54YLfQMXkhtyfxs=
X-Received: by 2002:a0c:e150:: with SMTP id c16mr23279475qvl.161.1539716099519;
 Tue, 16 Oct 2018 11:54:59 -0700 (PDT)
MIME-Version: 1.0
From:   Rajesh Madamanchi <rmadamanchi@gmail.com>
Date:   Tue, 16 Oct 2018 13:54:48 -0500
Message-ID: <CANahLXm7O6scvLdaL6bm14d5oGM5Zp+S-rpQDo554ssagRFNoQ@mail.gmail.com>
Subject: receive.denyCurrentBranch=updateInstead updates working tree even
 when receive.denyNonFastForwards rejects push
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I am looking to report the below behavior when seems incorrect to
me when receive.denyCurrentBranch is set to updateInstead and
receive.denyNonFastForwards is set to true. Below are the steps to
reproduce the scenario. Please excuse my ignorance if I'm missing
something fundamental.

Step 1 - Setup remote repository (remote host):
git config --global receive.denyCurrentBranch updateInstead
git config --global receive.denyNonFastForwards true
mkdir /tmp/hello
cd /tmp/hello
git init
echo hello > hello.txt
git add . && git commit -m "hello.txt"

Step 2 - Create 2 Clones (local host):
git clone ssh://REMOTEIP/tmp/hello /tmp/hello1
git clone ssh://REMOTEIP/tmp/hello /tmp/hello2

Step 3 - Push a commit from Clone 1
cd /tmp/hello1
echo hello1 > hello1.txt
git add . && git commit -m "hello1.txt"
git push
--> at this point server working tree contains hello1.txt which is expected

Step 4: Try to force push a commit from Clone 2
cd /tmp/hello2
echo hello2 > hello2.txt
git add . && git commit -m "hello2.txt"
git push
--> Remote rejects with message that remote contains work i do not have locally
git push --force
--> Remote rejects again with error: denying non-fast-forward
refs/heads/master (you should pull first)
--> At this point, since the push is rejected, I expect the servers
working tree to not contain any rejected changes. BUT the servers
working tree got updated to delete hello1.txt and create hello2.txt.
Push rejected but not really.

I also noticed the same behavior (incorrect) when the update hook
rejects changes on the server (but not the pre-receive hook).

Thank you
