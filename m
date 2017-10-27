Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD9420560
	for <e@80x24.org>; Fri, 27 Oct 2017 22:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbdJ0W27 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 18:28:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:47027 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbdJ0W26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 18:28:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id p87so5886261pfj.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yisb3i83NnrXsb+f8pp0/MwUIdat6MM+LH8IyEj+5MM=;
        b=EnX+rZ0alPsaN50qRinKm5An/HGk5+mK7m7QzBIFldMO8d8FhSxQRw5SP2lz4LmGx9
         UvMxHAYKQu07pmw7RmgxEdw8pQWVANZ+PmCOoIPjWomXjJ+mdt+z3GVK63O3076TFjdi
         Gu4PBGnHoAM2R7b+GeQjwhwreA2KBjjOIR8VO5416Em6grWftPx1uEOg9IaH9aRHyFKa
         7RTyn3wmDUJJTG8hcPa8M22Fr4VDDLWPmKtwMZb320HWIG5lXn/5Trb+05zzswrwbbNZ
         oLp4wt/C6u2yN0S2YkGhBtEk+LIX0aLHHFx2FA/y8P7pjaQeFWjf+I5oxgLnkjfNauuy
         rbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yisb3i83NnrXsb+f8pp0/MwUIdat6MM+LH8IyEj+5MM=;
        b=n2EuHN3RfOy+gTE3KB2IMliRuSHDbORtebDHvBxs1gysm5JyMUCoM0aYdJMCRD7OtT
         46g/EY4M3+1PhZcQ3qwzl11/A4VAJUIahz+ygRy/12RN4j6Vm8ne3zK/Ybc4LapL72mo
         h9jMOCro/VemUY/pgaDr3oCdp65h6u3sc7feU1tcM3WFVSULi9nP8Mzrg4/7Jv9IPlw0
         IgfguGTvgoMwHcN8Q0rrIWEe3WTOd3n+zjie6AhnZnBMFPGjcysFVHb/fneGIGbVc2zu
         gprVrRjmzQ70L+FWjr0+6Mbus3GXLPz8pgM2Dhvx/CBGc8JMawl1XIzK1IOszF+0CUh6
         QhSw==
X-Gm-Message-State: AMCzsaUhBUm8NDPSMYvJZsVYpAeMCxF/lmYS0FpWWCqHSS+Iz96ikgis
        KeoKsEec5xdMuE9LUisA0RJq73zREF0=
X-Google-Smtp-Source: ABhQp+TOyTDxFGxMm1J1YPSwD2WyRoz2dgtDHaqLkiLFKVoyfsEruWR5oL/MWAd548EvnQKyXQNCaA==
X-Received: by 10.159.207.129 with SMTP id z1mr1467508plo.174.1509143337228;
        Fri, 27 Oct 2017 15:28:57 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id c127sm16486842pga.34.2017.10.27.15.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 15:28:56 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/3] convert diff flags to be stored in a struct
Date:   Fri, 27 Oct 2017 15:28:50 -0700
Message-Id: <20171027222853.180981-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc2.357.g7e34df9404-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has be some desire to add additional flags to the diff machineery
(https://public-inbox.org/git/20171024000931.14814-1-sbeller@google.com/) but
due to the limits of the number of bits in an unsigned int on some systems we
can't add any additonal flags to the 'flags' variable.  This series converts
the flags to be stored in bitfields in a struct instead of in bit positions in
an unsigned int.

Some thoughts:
 * We may want to do a follow on patch to convert all the flags from being in
   uppercase to lower case.
 * Maybe we can figure out how to remove the 'touched_flags' things (since its
   only used in one place) and then we may even be able to stop needing to use
   macros to set/clr/test the flags.

Brandon Williams (3):
  add: use DIFF_OPT_SET macro to set a diff flag
  reset: use DIFF_OPT_SET macro to set a diff flag
  diff: convert flags to be stored in bitfields

 builtin/add.c    |  2 +-
 builtin/commit.c |  7 +++--
 builtin/log.c    |  2 +-
 builtin/reset.c  |  2 +-
 diff-lib.c       |  6 ++--
 diff.c           |  3 +-
 diff.h           | 96 +++++++++++++++++++++++++++++++++-----------------------
 sequencer.c      |  5 +--
 8 files changed, 72 insertions(+), 51 deletions(-)

-- 
2.15.0.rc2.357.g7e34df9404-goog

