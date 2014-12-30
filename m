From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 0/9] atomic pushes
Date: Mon, 29 Dec 2014 18:36:38 -0800
Message-ID: <1419907007-19387-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Dec 30 03:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5mgv-0002J6-QG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 03:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbaL3ChE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 21:37:04 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47678 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaL3ChD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 21:37:03 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so13082357iec.10
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 18:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=k1Borwb3CVhtIjYPyKd3Ym8gyCf//Y+aM/8/f4LJub4=;
        b=OfRwsPyUxFt9BXYn/P18pIQd5EkmBxwP8SgnKAW4k5a12miRaPkJyw7TOZqds0DuP8
         TRpyuK17B6yHV9jz8QrP3la8B/REq8nZHka1u50lJexyL93Ns7cbbaCcRJo399F+Nj/e
         /nX4G85xZDZ8eTnUBQWBQh6qBV8FCjRTcSTmdoXFh8RQwjopHK+XqAKdX7ZWs1y6Y6ks
         fufTwxgRLkELDeTJb3GTGbPhF7JBlYm8oQaZ8HhceK8ZPc3k3sks6QOetELaYUBafbV5
         Aql0IoXoEM/hvp05EPRpph2lz3PvrJKo40DJDUgVMbnxHtz2ydyGL3STC2Id1WtRTnPy
         DUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k1Borwb3CVhtIjYPyKd3Ym8gyCf//Y+aM/8/f4LJub4=;
        b=UN+c2Ljnp/LN6khCoZBrxENK40ZR8pFQ9iN84zln08NNGQytnB7QTNEglK9tvrTTus
         Fr5yMhjTiMo7PfEjYxU2A6rV1WqMC3oLuntyLOuh674rgA8ShOdGgiqrJ9BcAW8VxQON
         +pSUzHwdZzghfThT+zhtQlUne+KBy7X89lBhHXHl/0twVp1mJ9yqbZ7bFQ0lxTOK3yDN
         kzIAC4VEfnBjV0t2OP2bnlmpdMZbbcRuy2J9+3mPQo4mt3m1HOyL2lLbwpz171PEc1zE
         tfvd3BWvqZe9EN0tY6bXVU1aJj4a/W5t7P3Gosuxh+CE5nUOQn/QkIBKFhhkkFkviCDk
         xy+g==
X-Gm-Message-State: ALoCoQnaG9y3O03CrfOn3w121GLLscLTO9jNup+u35TfejtfhlPctnchEn1OFJqUKTCEEBpP5bRY
X-Received: by 10.107.154.198 with SMTP id c189mr53661533ioe.68.1419907021935;
        Mon, 29 Dec 2014 18:37:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id qr1sm15072255igb.18.2014.12.29.18.37.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 18:37:01 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261909>

The patch
        [PATCH 4/7] receive-pack.c: receive-pack.c: use a single ref_transaction for atomic pushes
was dropped and redone as 3 separate patches. This wasn't just done for doing it,
but the end result has also changed. We have more smaller functions doing
one thing instead of these larger functions. Thanks for the ideas, Eric!

Also the advertisement of the atomic capabilites was moved to a later new patch
in this series. This helps when you want to bisect this series later.
Thanks Michael for pointing this out!

Thanks,
Stefan
Ronnie Sahlberg (3):
  receive-pack.c: add documentation for atomic push support
  send-pack.c: add --atomic command line argument
  push.c: add an --atomic argument

Stefan Beller (6):
  send-pack: rename ref_update_to_be_sent to check_to_send_update
  receive-pack.c: simplify execute_commands
  receive-pack.c: move transaction handling in a central place
  receive-pack.c: add execute_commands_atomic function
  receive-pack.c: enable atomic push protocol support
  t5543-atomic-push.sh: add basic tests for atomic pushes

 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   5 +
 builtin/receive-pack.c                            | 168 +++++++++++++++-----
 builtin/send-pack.c                               |   6 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  65 +++++++-
 send-pack.h                                       |   3 +-
 t/t5543-atomic-push.sh                            | 178 ++++++++++++++++++++++
 transport.c                                       |   5 +
 transport.h                                       |   1 +
 12 files changed, 410 insertions(+), 51 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.2.1.62.g3f15098
