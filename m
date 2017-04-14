Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B906F20970
	for <e@80x24.org>; Fri, 14 Apr 2017 19:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754491AbdDNTRk (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 15:17:40 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36723 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbdDNTRi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 15:17:38 -0400
Received: by mail-wm0-f43.google.com with SMTP id o81so184939wmb.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 12:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RH63Gmp3+dEk2awjU4pDwvjhlpFB0LsYxmokwNGWZHs=;
        b=Rc9Z2L1kheJZLrpTMFVa1FjgJ+Maxi42Gtm/xgVrUyPzJJPQkJ7aqYfWo4pnudwEHO
         MUecf7yzJCyRv4S6gQeHjeJy9ZRlrZSmaFR1xT5B6Ayl8zX+H/27HOwXKLePyWRiPF7F
         2jV9QZxz+zqO/nRqAt8PjII7oYizauee2MU0NYbmGBGG3VhO2TIxwRbeiLLJ/gUx4XlP
         kWY56QXY/3I3meT5xKeU0NR0XGdKqZ/h7vRRqGaHG7Sn7/pynIm2HVycfaI/cNBupSMf
         k1WpCYKZdJWoJjfv51oFxxw2I6jNX/l1rZueLe6KwQdFMcT+T9BDr4hHj0GuqenF/NbM
         KBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RH63Gmp3+dEk2awjU4pDwvjhlpFB0LsYxmokwNGWZHs=;
        b=rp9QKjyBALp+x0Ny02UHRTJ2G/KcbJdnx1F3MwDbWlhQOl8YdX4VK5LYYNZDPUmzjC
         VBpJ/tTqQmGRXCsD/vCJNa+5c9GVNsbKULMUhmwnOlhKtagP1dAKAVLOHcZt5hlygBdX
         e8tzFN3/VtlOAKzNwJYGDc67SAJNqueejWixiM4E6hc+JJITd4Yycu0esqDIjwRgPCQl
         wmL4YfLtPr8/76sJPR3E5Ay5qC+yu5JgHnek8nqvO2tsSRaTKYPaNj0S77Cx5EG4zs+I
         2kOkLGnA/8XXDq10BfzjNH+X+bdCjf7dxiQruROY71okt/HBIJ3MdQAG2tNWvnJHZ4G2
         cBww==
X-Gm-Message-State: AN3rC/6xnEOIMZTxcOSfFCIafLIRB9XGLkdlaVzlWeKCLNRTn6npZOZu
        d9IzK/mAzoSu5AlqvPvnW3xHKbN272y1
X-Received: by 10.28.175.209 with SMTP id y200mr81431wme.81.1492197457459;
 Fri, 14 Apr 2017 12:17:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.173.78 with HTTP; Fri, 14 Apr 2017 12:17:37 -0700 (PDT)
From:   Alistair Buxton <a.j.buxton@gmail.com>
Date:   Fri, 14 Apr 2017 20:17:37 +0100
Message-ID: <CAO-Op+GujOUuueqwOKbb1NosZ-VYY5KVWm1+HNMC8xhd0ApEDw@mail.gmail.com>
Subject: [BUG] ls-files '**' globstar matches one or more directories instead
 of zero or more directories
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To reproduce, go to any git repository and run:

    diff <(git ls-files '**/*' | sort) <(git ls-files | sort)

Expected result: No output since both commands should produce identical output.

Actual result: '**/*' only matches files at least one directory deep.

The same happens with eg '**/Makefile' - only Makefiles in
subdirectories are listed.

I have personally tested with 2.7.8 and 2.12.0. Others on IRC report
that this happens in the next branch.

-- 
Alistair Buxton
a.j.buxton@gmail.com
