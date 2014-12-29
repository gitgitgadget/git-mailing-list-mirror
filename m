From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 0/9] atomic pushes
Date: Mon, 29 Dec 2014 13:35:06 -0800
Message-ID: <1419888915-31760-1-git-send-email-sbeller@google.com>
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:35:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hyG-0001Ru-MA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbaL2VfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:35:20 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:57485 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaL2VfT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:35:19 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so12863933iec.39
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KBVUWxgPJ4P3Pb2mlS1ZMGf/LX8hLqZlJkf/MOffzyo=;
        b=VoFtK86sRUxOtOT/XOxIZ7an/irAcbfvxmOKSPeLwYm6EhOoHpEv4BadtRCkLhZ9o8
         Zb8o0FZ9WA7Ede2PlXFAZlGrKaPpq+bYNS9n3HZdRza3F8Ig53Sx7odMMIAUklGTB+nU
         D7p2NGXSHH3R7SMhfskWe7Si4WkjdWWhkEk/mxfLOWmq78x7GuoLtqFWYceEt8OWjX8w
         o7Di63D3J3I9/zeKZvrABPhtRfFh+stcN2Ox2VxLltDxSXni8/K7y6Xl7gL0V96scohO
         OhWv6NOXDFZ0YMwYMdPkohHcma7epEtbz7ovzrHTI+Cchr+ZX4zvKkfqb30pywDesHHh
         8uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KBVUWxgPJ4P3Pb2mlS1ZMGf/LX8hLqZlJkf/MOffzyo=;
        b=mhYwUl+afSrRMIB7bHqFbebq5HJ7y49oitXoUr+WHg3M8b3gryPIGg3idZGLHrk4Kg
         SIcWEg7cWnqoI2mQB+mTltYmj4jT6nQDtefPw/h+JRBNDvMLNsbXys7wbX+Nfz+jVQh0
         un0TagMIExkqgcb5VyyNOrCMczSdOxcvb3mWg6GwqPbmBlyXvC1gZ/BFFFbE+IjH4tol
         O7kHdHUz2x5iSeDV9t78LXrzZH/qKZOyJ0DAFTQk69s4WIvvnZgjzKreHw6H1ocQ51cV
         O4yE5vT9n1dljozpTYZD3Y46yjOZQcvFlPkT3EmEJi/oXy8aYihS1Kb5TaokJBZoSQhz
         xmSA==
X-Gm-Message-State: ALoCoQml86TrAV0YbKlUq/o307ZJOwe4S0ugjVXbyDBvkrsyH5Drw1SCAJ3e/dQg0+I/e2ZMdVyx
X-Received: by 10.42.61.130 with SMTP id u2mr43074441ich.61.1419888918657;
        Mon, 29 Dec 2014 13:35:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id mi3sm175719igb.13.2014.12.29.13.35.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 13:35:18 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261880>

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
  send-pack: Rename ref_update_to_be_sent to check_to_send_update
  receive-pack.c: simplify execute_commands
  receive-pack.c: move transaction handling in a central place
  receive-pack.c: add execute_commands_atomic function
  receive-pack.c: enable atomic push protocol support
  t5543-atomic-push.sh: add basic tests for atomic pushes

 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   5 +
 builtin/receive-pack.c                            | 154 +++++++++++++++----
 builtin/send-pack.c                               |   6 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  65 +++++++-
 send-pack.h                                       |   3 +-
 t/t5543-atomic-push.sh                            | 178 ++++++++++++++++++++++
 transport.c                                       |   5 +
 transport.h                                       |   1 +
 12 files changed, 404 insertions(+), 43 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.2.1.62.g3f15098
