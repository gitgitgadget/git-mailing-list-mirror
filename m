From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/7] Rerolling sb/submodule-parallel-fetch for the time after 2.7
Date: Tue, 15 Dec 2015 16:04:05 -0800
Message-ID: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:04:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8zZv-0005XB-UI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbbLPAEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:04:20 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34690 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbLPAET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:04:19 -0500
Received: by mail-pa0-f45.google.com with SMTP id wq6so13369547pac.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dptSeo4/TQwl1CzoyJcJmUP0k9WcncS1u69CA2qtkoo=;
        b=KnN2yFdfG9fwnjbGK303QC2d4Dg8JAcHrTiDSqQIKBA5vvthU0WrOodOCwxiAty38R
         9wMr0q18pvy2m1dXPITx7YJIzTMKmZ4jIb1iDw2RHxat6beV8MUA1IPqZdqzzqotoufF
         bp7ntFEMZ7Po4u/pjmIDKcELxGJXTC/UOw7H0xqPjJKrhpxqYFmq1qoeNwZXInKP/DFV
         x44RQ3truQYbC4OWj5TiKqKVXqE6dUgptBSG3SM5qHkFbphfvxL1nuthJ4uc0dYVjJ3M
         aEpgTqKhkaeQV8fHL/t8jg1ZsMvkTimRfXA5GdRQUdi354oQbRuJVGfzV4qWZO3tDQs1
         pAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dptSeo4/TQwl1CzoyJcJmUP0k9WcncS1u69CA2qtkoo=;
        b=KuSwm52bHQ4WvBkEv0CnaIpjv+MaoHdgM5PiEyrXCDhV/10OPooLbzdXhHqGBDP1lS
         Cdy+YFVXOADgAKPIxa2GpCjs7s8RGe+KKPG8IoFHo+Ai2boAaYTrrnT9mRZHco+ETM7z
         /ztEkagT60dP12QDgle+jPgZr4x+NlWWWsRJh7drx0bhu32K7c8YozBdK1b5n+FgYoVl
         KwdgUS6VIV3Co9FUfVDaY83LPSbm02v9oAL9T8MwaJZ2s+VZnknBRkNLQ1j/T0zwmfIF
         EdetSBAr81HZl70D4pmCJhw7v30JOYYSN+ZGLIHuMZGhvjygX4FHgpMJLPoyRntmB1Cb
         0xrw==
X-Gm-Message-State: ALoCoQnX+VICEtnto+ghi67iwbeejRJKxTyGvgIL4T2G6OffSMxbH8yODH2gSKb2Ayuk4RBS9DGVd/8nvNmSTsMqkW9rLqDvnw==
X-Received: by 10.66.162.38 with SMTP id xx6mr58962870pab.57.1450224258500;
        Tue, 15 Dec 2015 16:04:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id w16sm392742pfa.18.2015.12.15.16.04.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:04:17 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282514>

I am sending out a new version for replacing sb/submodule-parallel-fetch for
the time after the 2.7 release.

* Dropped the patch, which introduces xread_nonblock
* strbuf_read_once uses xread now. This is safe as we poll before using
  strbuf_read_once, so we know we won't stall.
* have the commit message reworded for "run-command: add an asynchronous parallel child processor"
  with Johannes' suggestion.
  
  Thanks,
  Stefan

Jonathan Nieder (1):
  submodule.c: write "Fetching submodule <foo>" to stderr

Stefan Beller (6):
  xread: poll on non blocking fds
  strbuf: add strbuf_read_once to read without blocking
  sigchain: add command to pop all common signals
  run-command: add an asynchronous parallel child processor
  fetch_populated_submodules: use new parallel job processing
  submodules: allow parallel fetching, add tests and documentation

 Documentation/fetch-options.txt |   7 +
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 +
 run-command.c                   | 335 ++++++++++++++++++++++++++++++++++++++++
 run-command.h                   |  80 ++++++++++
 sigchain.c                      |   9 ++
 sigchain.h                      |   1 +
 strbuf.c                        |  11 ++
 strbuf.h                        |   8 +
 submodule.c                     | 141 +++++++++++------
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  53 +++++++
 t/t5526-fetch-submodules.sh     |  71 ++++++---
 test-run-command.c              |  55 ++++++-
 wrapper.c                       |  20 ++-
 15 files changed, 731 insertions(+), 74 deletions(-)

-- 
2.6.4.443.ge094245.dirty
