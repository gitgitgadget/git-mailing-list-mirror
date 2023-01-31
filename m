Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CD3C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 08:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjAaIIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 03:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjAaIIl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 03:08:41 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA30C2CFF7
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 00:08:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 203so8380876pfx.6
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 00:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0VZD5u9kvj5KX6aTs8nl4lLqRjnlWzAQRDBDOCvE5Zk=;
        b=RlQudUnYnkIuz+TsA8z8m1Azj2X2bCzJ/QeFKwdfoVGQlCePa3AdFI6/V0LpOaGbOq
         lghJZDU9KKdXchhNzBF8UHjh+uBkBv3LVP63Bt65a1xrrRKR0L776xzygm/QTMUXCVyh
         6E+Wn4aimDzRXUgx9ErT3z9KZ8DG2nCQrKacSRLKLODLtn9mmjy6mH9Tr+aoCCDBIue0
         B6ySIdVp5IbAzJRD6uRS8T49ZWWPNhvHdyIYQkYohFrgRJ1GeQv95xhWy44M+TSq15/i
         ptWdfCXowxQn5SKM1t0JhMy4KdZZ2Dp1baYmA7S2KagBCBTXGk6UgsooKRSckeVplfFe
         25FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VZD5u9kvj5KX6aTs8nl4lLqRjnlWzAQRDBDOCvE5Zk=;
        b=a6xHZIcfHToxCi3aLczTTBrsTzjHzwU2ptPBWC5eRALstkFvZ0Db1ufcSIxD19r8c/
         oxSEy5lETfeLvgmjBSHK2WY60oJAQ0O6Fac0cEjPYE5FrhnFembk6uBfCg8wvBOam0p5
         T2YKSKYhXKc5DXLaFCTq1WsGCVwbqWUWyHEH676doPCapE697HpkkI3SkOEJQS7O7Ttk
         sC+qkQcHXj4FywhL0KfT03D7ktrrWGUdeJeLXciZNC3vJbSC1wAsIdyG2p0Js2J+cB0m
         4GOqKDZmVBJTI0vjd+V3m1beLwKeVE1s89Ha6Bg7UMf5TdQb9pQ+4zrp3flERxvy/4CH
         ue5w==
X-Gm-Message-State: AO0yUKXTzaRjBm/ZJ5137lwZXKcNhiQljnbaTAibiy6xcgPdiTo0QPCl
        8XYrFMBD7JwEnQePa5AO/WzVBdWRaKW5ZCuvvojzvcYHNJc=
X-Google-Smtp-Source: AK7set9+FKF2gNbppmU6atLRqYoG8kf2Szt9SrGNIYLRjBy/JbuNmwW4IGPPdqj9WoAxrktk/N8K8A+NR7tvudRHov8=
X-Received: by 2002:a05:6a00:451b:b0:593:a079:639a with SMTP id
 cw27-20020a056a00451b00b00593a079639amr1654288pfb.44.1675152519951; Tue, 31
 Jan 2023 00:08:39 -0800 (PST)
MIME-Version: 1.0
From:   Alessandro Arici <alessandro.arici@gmail.com>
Date:   Tue, 31 Jan 2023 09:08:28 +0100
Message-ID: <CAMvf6PPcKQYLWbj1x8P0Y=8rG19i8DNNPG=fCBUvaHLCRKXDmg@mail.gmail.com>
Subject: =?UTF-8?Q?Git_loses_untracked_files_during_=E2=80=9Cstash=E2=80=9D_if_ther?=
        =?UTF-8?Q?e_are_conficts?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using git stash -u, but, as title, when there are conflicts untracked
files are gone.

This is a link, for example:
https://www.databasesandlife.com/git-stash-loses-untracked-files/

And this is a reproduction of the bug

# Create a Git repo with a single file committed
git init
echo contents > original-file.txt
git add original-file.txt
git commit -m "Creating the file"

# Create a new file, modify an old one, stash
echo foo > new-file.txt
echo contents2 > original-file.txt
git stash push -u

# Modify the old file in a different way, commit
echo contents3 > original-file.txt
git commit -am "Altering the file"

# Apply the stash, see conflict, but what about the new file?
git stash pop
cat new-file.txt



Git version, on Linux: 2.34.1

Thank you
