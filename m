From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Towards sane shallow clones with submodules
Date: Tue, 15 Mar 2016 18:12:14 -0700
Message-ID: <1458090737-14030-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, pclouds@gmail.com,
	larsxschneider@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 16 02:12:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag00n-0007we-9V
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 02:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbcCPBM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 21:12:28 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32782 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbcCPBM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 21:12:26 -0400
Received: by mail-pf0-f176.google.com with SMTP id 124so51688729pfg.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zAqEeCoqnfa6wBhOGiYqxERo5K1GBvJQXG0bir92P9k=;
        b=D7BNfAs1mGKEM3xG5qzf/zAR6oy9DmVltwJQ1BOJ0HR5n5cPRlmnedQGHmQ/vq17+d
         Tncvpi7lgVXLC1IGHUTuUfswigF/xZ/cO3KNuppqIpgGsk2J/ACnOenzDBoOuocI2k7M
         6qi84YuumDo813gFU2ruX6ANpzDabD3n+yhQfbTg2oHvwsdO28RzHJHfwfCwm/nn1Vw2
         qK5RJtAx9q5uWYNzkg7rdEmoODb7vL+u/CZWg58C9jDH5fD7v8yhhXPwqpbkm9Xl1BZ+
         unk7MaoQYJHVz7ROB2cZrIAgQdsR0HgUjb8BPq8U4InNKRydfbtmr3LM/mdV3b9oqxt3
         PEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zAqEeCoqnfa6wBhOGiYqxERo5K1GBvJQXG0bir92P9k=;
        b=RHSS1jZRw91m9ps4rbAeSTqp+l+0k0wCYK7agyzsLH0bExoGhNAwS3FZU/rwXmmyP7
         ys7lFDfzYh9a4Z/iFrbbJh5XKpoKwTocGBLJc+OvmToqOKD+T30zAEURLXwsaINrLkL+
         Bw/4m3+GfLBNF9kCosULiTMhTg+ByMKjlrIJAytHIgQExvnSYuuh2BDr4085gPciVCdM
         o71RmYCU8IIgy28ynFbOapgG8rVEPcBGH+/3c9r0o6BbmNaKyCh/pcP8Oh6MotYbV0T5
         9Q1dXEFccaIM7wegH6HQghsNZQt7VRNZNHETdGtLUyxt1wPzdnGLmNLgTKpYuf4U+rcT
         JN8Q==
X-Gm-Message-State: AD7BkJLUXct0P5CPqlnue11SSPOUZqDCFI0FNqUJpLrKto/LpF6gt1DQuxg57cdPT4kSZfl+
X-Received: by 10.66.199.66 with SMTP id ji2mr1676040pac.34.1458090745354;
        Tue, 15 Mar 2016 18:12:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f8a9:c435:807a:de5e])
        by smtp.gmail.com with ESMTPSA id b74sm644743pfd.24.2016.03.15.18.12.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 18:12:24 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.42.g8e9204f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288940>

This is a first real series following the RFC-y $gmane/288720.

For using submodules as they are now, I would imagine this is a strict
improvement.  See the tests in last patch to see what a workflow would
look like.

Thanks,
Stefan

Stefan Beller (3):
  clone: add `--shallow-submodules` flag
  submodule clone: pass along `local` option
  clone: Add t5614 to test cloning submodules with shallowness involved

 Documentation/git-clone.txt | 13 +++++--
 builtin/clone.c             | 21 ++++++++++++
 builtin/submodule--helper.c | 22 ++++++++++--
 git-submodule.sh            |  7 ++++
 t/t5614-clone-submodules.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 6 deletions(-)
 create mode 100755 t/t5614-clone-submodules.sh

-- 
2.7.0.rc0.42.g8e9204f.dirty
