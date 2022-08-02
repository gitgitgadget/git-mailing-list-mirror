Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D85C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 08:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiHBIft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 04:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiHBIfq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 04:35:46 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Aug 2022 01:35:44 PDT
Received: from mo3.myeers.net (mo3.myeers.net [87.190.7.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF16570
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=airbus.com; i=@airbus.com; l=1454; q=dns/txt;
  s=eers-ng2048; t=1659429345; x=1690965345;
  h=mime-version:from:date:message-id:subject:to:
   content-transfer-encoding;
  bh=0qOEmkKbUyXMzIRcXDrMiuECq7ioaKoOo5r/1q982Uk=;
  b=nNp1PVBiUPEKH0HjBpIa1CaHSwOzCKcwlV/5Z/oR/x1f0jLKwj0+ETRy
   sxs2k4VY8SRAoHrvODn+p2Ymy/7Op6N0LTprqTSaGsI1rE+dAy2C1Zjg3
   lDBCZ+Rv0VqLHljz4Jzadm87gLDaa36HBz2gUS+1AiNovsQrL1qoylkA1
   tjtfsPDfaAgsRrjmVq3EUCcpjzgMQb1RbdDSrlRaym8c25lGQLYKCkBnf
   ss49ihcBxat8QKWtRKUIlmGDoPwgMjlPRoYsYt4rm11kRpAdEJWhh2GxA
   QczLrIk+o01MGlvAATfx9D1jtGd3pG3vG2zO7+rJy/xrigyNpFGLt0hBI
   A==;
Received-SPF: Fail (MX: domain of
  nicolas.maffre.external@airbus.com does not designate
  209.85.208.197 as permitted sender) identity=mailfrom;
  client-ip=209.85.208.197; receiver=MX;
  envelope-from="nicolas.maffre.external@airbus.com";
  x-sender="nicolas.maffre.external@airbus.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:87.190.7.224/28
  ip4:80.242.167.16/28 ip4:83.125.118.202 ip4:83.125.118.114
  ip4:217.239.138.48/28 ip4:62.217.58.112/28
  include:group1._spf.airbus.com include:group2._spf.airbus.com
  include:group3._spf.airbus.com include:group4._spf.airbus.com
  -all"
Received-SPF: None (MX: no sender authenticity information
  available from domain of postmaster@mail-lj1-f197.google.com)
  identity=helo; client-ip=209.85.208.197; receiver=MX;
  envelope-from="nicolas.maffre.external@airbus.com";
  x-sender="postmaster@mail-lj1-f197.google.com";
  x-conformance=spf_only
Authentication-Results: MX; spf=Fail smtp.mailfrom=nicolas.maffre.external@airbus.com; spf=None smtp.helo=postmaster@mail-lj1-f197.google.com; dkim=pass (signature verified) header.i=@airbus.com
X-Ironport-Dmarc-Check-Result: validskip
IronPort-SDR: KPm39OVUESs9XdiuSSJJsiJQJUhqOTbg4vSjYrqfE5rV1d6/PW7fp328gqThVAvr5xLpow0P1y
 C2uLXfSXxc7Q==
IronPort-Data: A9a23:8Nx02K5GgwCqdYAzHXcztAxRtFLGchMFZxGqfqrLsTDasY5as4F+v
 mcZWm+FM/qPNGShKI1zYdi09U4E6JbUxoBgHVZsrXhhQiMRo6IpJzg4wmQcnc+2BpeeJK5fA
 kl3huDodKjYdFeFzvuWGuWn/CIUOZ2gHOKmUraUYnopHGeIdQ964f5ds79g6mJXqYjha++9k
 YuaT/z3YDdJ6RYtWo4nw/7rRCdUgRjHkGhwUmrSxRx8lAS2e3E9VPrzLEwqRpfyatE88uWSH
 44vwFwll49wEspENz+rrlr7WhVirr/6OAGPjj9SWfHnjEET+Wo91aE0MPdaYkBS49mLt4opm
 ZMd6NrqEVdvZ/yT8Agee0Aw/yVWO6xN/7vOOj66uMKd1UCAfmvwzu9oBUUeNIwC8PtsR2pJ8
 JT0LRhWME/Y2bLvnOjTpu5E35x/dqEHJrg3tXB85S/WAOxgQp3ZRajOo9hC018NampmCa6LP
 IxEfWM6NFKYd0caYhFMVMlhiLz93j+iZ2INgUyzjq8RyHT14AxV8bHLCtrxQMesf9txol6+m
 njgwWXcFkhCYYTbkS7tHmmEg+bOmWb/WttXGuTpqbhlh1qcwmFVAxoTPWZXaMKR0yaWc9teM
 UYJ4Wwlqq1ayaBhZoWgN/FkiBZofyLwWua818U/4QCJj67WukOXXzlbCDFGb9MiuYk9QjlCO
 pplWT/2LWQHjVFXYSr1GnSoQfeaMCkPJ3IZIyQDSGPpJvH99ZorgEunoslLTMaIszEtJQzN/
 g==
IronPort-HdrOrdr: A9a23:7D0bW6xFrnlYKffGuBtWKrPwHb1zdoMgy1knxilNoHtuA7Wlfq
 GV7ZImPHrP4gr5N0tQ++xoVJPwIk80lqQU3WByB8bGYOCOggLBR72KhrGSpwEIdReOkdJ15O
 NNVZVfYeeAdWSSTvyX3OB7KbsdKRW8npxATN2wrktQcQ==
X-IronPort-AV: E=Sophos;i="5.93,210,1654552800"; 
   d="scan'208";a="367368142"
Received: from mail-lj1-f197.google.com ([209.85.208.197])
  by mo3.myeers.net with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 10:34:24 +0200
Received: by mail-lj1-f197.google.com with SMTP id h18-20020a2e9012000000b0025e4f48d24dso1133642ljg.10
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=airbus.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4KTHYaKHAYgqcKWwu2HksQWWoNwtdDwurCa/Os/CSw0=;
        b=VQTaMr7T6Qho7gtuz/KI5UlvZX0Zbr6Pf9bijmjZBRDRVwqrffPVu6YQZAmPak3r8T
         lnY12h5X+f7YBQNmBn22ojr/gdh8Focw1RiDllbcFyjB2eRfvoruKjMshzetW3Zmw5OC
         e6r5G/4zZb/vh1YASinkipNeKA5dywBto13Cz5YwVtiCvRXHMhextFjO8dtB/onyZ0Fq
         Yj9b6wi6Zc0CQ9ZsDmT1pCBBhpzcQyUf4Kmee04VRMAyj2hxoIUc26rS9I5p8ih0UHqH
         qAC7JvD3zjKUb0eipax6Gh5PvSZ3RfbZKeLJbGwNBEsFoL213StypIMCR7vd6Fq6hprE
         BydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4KTHYaKHAYgqcKWwu2HksQWWoNwtdDwurCa/Os/CSw0=;
        b=YAEqWD3JGoZMWHUdnoQRtX34urGXLnCXLVkYqZ3k8GVkbqeexq9ovAaAEYyOL3AoB7
         exLZKhCVCirIZHKMJxwfNn8MuMDZ6Rq5t1HG5Yu5sAuLvKdwEEchfkj9jXlCTZCJOOza
         LMBW0HYngEc10AXuKLdOj4byanmU5+m1Jw/3UBbsOa+F+H/VodLbBaPqI7wTBn5vL1Sj
         SrITVSFVQ+nASmDIY1GanMCtplWaypcePmKn/ptx/P4992nJNG6UzipY/rcnurCgSgoH
         AZO0ye73t84LC/LR8FNe4DDMJPOi7d/rJzTAd8HMLLxoLoOr3rgwUz6c95Q0nmFdSxtC
         WHvg==
X-Gm-Message-State: AJIora8DTmsU/fxDrNWnUgmngSLcnGNtp8jIh4X8BDofNorelodpbBph
        c3vXX/bbCO3Bdyh38JbQcNNvFlJEZ0u5VPx/NrfTJOlMz6ZLfsXkiqjjKNmelgZVdbzfP6FoLDu
        bTLJn3J8UPQGYk5LvXvth61Y2moQD
X-Received: by 2002:a05:651c:997:b0:25d:f3a7:871c with SMTP id b23-20020a05651c099700b0025df3a7871cmr6709636ljq.511.1659429264099;
        Tue, 02 Aug 2022 01:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v3QC22wsSPmIimqHO+PTxjR4rDaORH9KyPlY/Qnq1ugShOLGGFZFumgFNkSalHuRR3IcWXoKhzATeAIuG7nOE=
X-Received: by 2002:a05:651c:997:b0:25d:f3a7:871c with SMTP id
 b23-20020a05651c099700b0025df3a7871cmr6709632ljq.511.1659429263880; Tue, 02
 Aug 2022 01:34:23 -0700 (PDT)
MIME-Version: 1.0
From:   Nicolas MAFFRE <nicolas.maffre.external@airbus.com>
Date:   Tue, 2 Aug 2022 10:34:13 +0200
Message-ID: <CAHWqpUPVAvw5bsvS1DgAQDwxhzYmh6_V=r+TfPxekdy-oMZWmg@mail.gmail.com>
Subject: Git v2.20.1 EOS date
To:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sCgpJJ20gd29ya2luZyBvbiBhIHByb2plY3QgdGhhdCB1c2VzIEdpdCB2Mi4yMC4xIGFu
ZCBJIG5lZWQgdG8ga25vdwppZiB0aGVyZSBpcyBhbiAiRW5kIG9mIHN1cHBvcnQiIGRhdGUgZm9y
IHRoaXMgdmVyc2lvbiBvZiB0aGUgc29mdHdhcmUgR2l0ID8KClRoYW5rIHlvdSBpbiBhZHZhbmNl
LAoKQmVzdCByZWdhcmRzCgpOaWNvbGFzIE1BRkZSRQoKLS0gClNPTk9WSVNJT04gLSBUT1VMT1VT
RQpHcm91cGUgT3J0ZWMKClTDqWwuICsgMzMgKDApNSA2MiA3NCAzMCA3NQoKNCBpbXBhc3NlIEFs
aWNlIEd1eQoKMzEzMDAgVE9VTE9VU0UKVGhlIGluZm9ybWF0aW9uIGluIHRoaXMgZS1tYWlsIGlz
IGNvbmZpZGVudGlhbC4gVGhlIGNvbnRlbnRzIG1heSBub3QgYmUgZGlzY2xvc2VkIG9yIHVzZWQg
YnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGFkZHJlc3NlZS4gQWNjZXNzIHRvIHRoaXMgZS1tYWls
IGJ5IGFueW9uZSBlbHNlIGlzIHVuYXV0aG9yaXNlZC4KSWYgeW91IGFyZSBub3QgdGhlIGludGVu
ZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSBBaXJidXMgaW1tZWRpYXRlbHkgYW5kIGRlbGV0
ZSB0aGlzIGUtbWFpbC4KQWlyYnVzIGNhbm5vdCBhY2NlcHQgYW55IHJlc3BvbnNpYmlsaXR5IGZv
ciB0aGUgYWNjdXJhY3kgb3IgY29tcGxldGVuZXNzIG9mIHRoaXMgZS1tYWlsIGFzIGl0IGhhcyBi
ZWVuIHNlbnQgb3ZlciBwdWJsaWMgbmV0d29ya3MuIElmIHlvdSBoYXZlIGFueSBjb25jZXJucyBv
dmVyIHRoZSBjb250ZW50IG9mIHRoaXMgbWVzc2FnZSBvciBpdHMgQWNjdXJhY3kgb3IgSW50ZWdy
aXR5LCBwbGVhc2UgY29udGFjdCBBaXJidXMgaW1tZWRpYXRlbHkuCkFsbCBvdXRnb2luZyBlLW1h
aWxzIGZyb20gQWlyYnVzIGFyZSBjaGVja2VkIHVzaW5nIHJlZ3VsYXJseSB1cGRhdGVkIHZpcnVz
IHNjYW5uaW5nIHNvZnR3YXJlIGJ1dCB5b3Ugc2hvdWxkIHRha2Ugd2hhdGV2ZXIgbWVhc3VyZXMg
eW91IGRlZW0gdG8gYmUgYXBwcm9wcmlhdGUgdG8gZW5zdXJlIHRoYXQgdGhpcyBtZXNzYWdlIGFu
ZCBhbnkgYXR0YWNobWVudHMgYXJlIHZpcnVzIGZyZWUuCg==

