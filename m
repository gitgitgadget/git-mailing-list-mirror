Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8436C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 12:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiEPMmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiEPMmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 08:42:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9475E38BD5
        for <git@vger.kernel.org>; Mon, 16 May 2022 05:42:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v10so13947535pgl.11
        for <git@vger.kernel.org>; Mon, 16 May 2022 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mantisbt-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=EA1PVva3FV/wD53ebs+MD4xw7vtei+n60X0Ma9JUfVA=;
        b=eD9Be0K9gKkYBQR3HLl/mmUfeLMPF7SlQD0fcNKHTtFcg0qtV+C43UHfc/x8pIE4+5
         +FKDQv7uD81YFNossbZ8QrEvlDQzzZgqAYlnrkyTbykJYIwh2Hvu/l4bxHWgqZk3knlU
         dJNfSn7gH+hIAbw7eAPHubU9BaoVnAILaPozXSa7SnMndMpMyMS2kFxMOc6qd3kXyxSZ
         5Fpxv7mGy5R5l2LgJu6Prr6v9T1B/t02T2F1bYrSgNq2J1tFUr3SpS8EjbiPOWzBBKK1
         ydG6X3bdQ7XKemSqjM5QAgDlxOIfdn1B8JK6ZvN/knCQBJ3hBss7+AnVkc1s7l3Fe+Dh
         aomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EA1PVva3FV/wD53ebs+MD4xw7vtei+n60X0Ma9JUfVA=;
        b=AtGCJAg/7q9YOjXW1a7DYYlL7vpaPsGW6ttLFVX1CBgdC/raGjKk4iCgEGjW6mLS4B
         Bze+P+JoJcZ3tNxnvDcAgEpnH2QHB6QxZs93mNNl5jDNfvDWI7/pSIh6tmjBfvFz/Czd
         VW0DjWrZQNoG9xdcWqSgdtHc6mfO+6Ixq+olkOir8/anwkLxk9ogRRAk1By3FeCYuXzO
         tkK8N3qHxZJJ7++9AYkMLSvmfrJvvMdPFgHjCmKMTfv3PhBNS65yeX0BZ8xvg9KtvCS9
         64bYA8JVRxPPNnNapYCUj/tv5Nrkn6sL21kEZT1RN+mm0vS3epgmfWKdKl7GERZz/O7l
         jiwg==
X-Gm-Message-State: AOAM533xsvZbJK8ru/bOsZdgBfkUlNamk2dBa1qeGsjpYrRpyE1m3dh0
        oUmGGy8abboMJUwkXJM/CaUya8Hydsb6wExeQGpSrR6ocB4=
X-Google-Smtp-Source: ABdhPJwq6ICna1fGp+Z17D18jxZdW3oweb6HHbjmjanneC5Nn7ThuZcKNroFg4eNFvbTMEyA2tLnVbGACRfLhT5yebg=
X-Received: by 2002:a63:2324:0:b0:3c6:a80e:50a9 with SMTP id
 j36-20020a632324000000b003c6a80e50a9mr15104422pgj.169.1652704936737; Mon, 16
 May 2022 05:42:16 -0700 (PDT)
MIME-Version: 1.0
From:   Damien Regad <dregad@mantisbt.org>
Date:   Mon, 16 May 2022 14:42:05 +0200
Message-ID: <CA+zp4VNWMxZ2ieS8KP2-uUu90AMmdzyR31VGkf78KdG4jY4eug@mail.gmail.com>
Subject: Date in git-commit output inconsistent with log.date format
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was amending a commit message, and noticed the date in the output is
printed in 'default' format, as shown below:

$ git commit --amend --no-edit
[x bf63ada92] Test commit
 Date: Mon May 16 14:25:57 2022 +0200
 1 file changed, 32 insertions(+)
 create mode 100644 test.txt

Since I have set log.date=iso, I was expecting the date to use the
format defined in that configuration. Is it intentional that the
default format is applied instead ?

Thanks
Damien


PS: Apologies if this has been asked before, I did search the list
archive without finding anything relevant.
