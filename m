From: David Turner <dturner@twopensource.com>
Subject: [PATCH 00/43] refs lmdb backend
Date: Wed,  2 Sep 2015 21:54:30 -0400
Message-ID: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:55:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkS-0005xh-Et
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbbICBz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:27 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34600 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbbICBz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:26 -0400
Received: by qkfq186 with SMTP id q186so15069496qkf.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Tr2FQJYCL+GNOeDPmUv6zGWEGJ7uBolUORsB2FEGnpI=;
        b=Tltj95qAkUBQ1MGtPbopmVY1QY8j5dauITNsihhlUayp/Adum72DVfOdfXfJeX74Qj
         YOjFmPeEAWmDUn/Lzj8f0u1WaxjzhwLa+umN+Mu1YcINRf8o90KKGanbvju+JreFTeyX
         L5d5t9QPveITbV0L4bRNPC3xsoRgLf2ZjPeLKx4xlI8z3YJq0YabkYMrM+PJUxbBEhq4
         qoNQC5d6hMAl0/zSuhhBbAXf82yo/5GrcavSjnxiR1ubUqvl26Yp387GPA+tq6za5qwM
         yupEcopAIJLsEdzS7Bf92bq/PksZjsS4k/I350llmXYECTTDAlZoJwF9qBVTxG4prz7l
         HaqA==
X-Gm-Message-State: ALoCoQmRf00nLC/EhhrRg5Tj9VUjOV0vZ20QGx0tn13yHPAZ8toEEPTlYHiRBAZ//Z5hLIcSDivo
X-Received: by 10.55.204.208 with SMTP id n77mr33603051qkl.46.1441245325916;
        Wed, 02 Sep 2015 18:55:25 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277138>

I think I've broken about all of the standalone stuff out, so here's
the main enchilada.

This series depends on at least the following topics in pu:
dt/refs-bisection
dt/refs-pseudo
dt/reflog-tests
kn/for-each-tag (patch 21 and corresponding bits of 42 depend on this;
we could skip them, but I wanted this to apply on top of pu)

As before, I tested by hacking the test suite to run under the lmdb
backend and changing a few dozen tests.  The remaiing failures are
documented in Documentation/technical/refs-be-lmdb.txt, except for one
in t1404 where this version gives a different error message (but still
an error).

As Jeff King suggested last time I sent this around, I've made the
reflog format slightly more efficient.  Now it stores shas in a binary
format, and only uses a header entry if there are no real entries.

Also, now per-worktree refs live in the filesystem.

I've also made a number of fixes to memory leaks, formatting,
factoring, etc.

As Michael Haggerty suggested, I'm now using struct ref_transaction as
a base struct for the ref transaction structs.

Looking forward to reviews.
