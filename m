From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/4] Some cleanups
Date: Thu, 31 Mar 2016 11:04:02 -0700
Message-ID: <1459447446-32260-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 20:04:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algxA-0001Ix-14
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbcCaSEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:04:15 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36292 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbcCaSEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:04:14 -0400
Received: by mail-pf0-f182.google.com with SMTP id e128so53420491pfe.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZDUG3Pnm9AQSPeL4JW5JMuKPLgdSnHIASZSQQ5yge+Y=;
        b=bjtB/BXIVHgmBhN5kJKnljIgGrfox4nAPFgFURMG5bhBJ4NVJVn1m0U/mEjrJ7ZEbs
         Y9gfZcDq6LaAgdTIXCyX2Q543W0+9sBvkcy0QJPx+P0SlHHFnbhmz00MdfFBEA0knMrW
         uMm0BHWz64IWIB2kRKqhfMyFWV3n+W/tXBhlDszEEsawBcAfegRxIv2kxDUdAC2PTfLU
         tqGdJP8POsWm3fyhlpLnNRR12LEjSWo6sGELGc1pHkCScU5jOhL7F6ZaEMXNojjnGPLj
         x2kTdz+fC6z4IbWt1cxS3mv6dZRKIwL3CXZs7cW6r39tFGV9ktBxP/tUv6/+zeuj34q7
         Va5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZDUG3Pnm9AQSPeL4JW5JMuKPLgdSnHIASZSQQ5yge+Y=;
        b=kYBaP/Vh1PsuoxcCmt9sybPn75PDFKapVtsQErqhPFNKhlJO4qcxYe892zsBlTdLHl
         St6GZN/a7KXg3iQYhR94GPNslBvxoMXDm/VvI0Q9HfFpPiyW28Th1q25J6FZCHWyH/Jt
         hbJ4aai9ilSJsg8ETpXsOIFGYIF5tpRpAmg4F297/nfu1aRsAtIHiwvkDaEmmStrSsSy
         UiI2J8vtLdWFp8K1BrHcDZ7iXb+ZkQtdv64tZREDZyCUVq0exg+RTx+uS/QjdfdFxnZL
         Zs+J+7vFpyRV4oNtJlo0hKf+HCwpJH3Yt1OQrY6X9c7nwlBN6HBSL2Ru3TXYaXjdfC7A
         qmAA==
X-Gm-Message-State: AD7BkJKxV3xhI9uda7jViFjlrz2F6pnJjAm1/l2ytPImEItbzwduG10HA9+XsRd3b1NEdXWz
X-Received: by 10.98.40.200 with SMTP id o191mr23970462pfo.83.1459447453696;
        Thu, 31 Mar 2016 11:04:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id p79sm14950304pfi.61.2016.03.31.11.04.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 11:04:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290434>

v3:
Thanks Eric, Jeff, Junio for discussion!
* use git_config_get_value instead of git_config_get_string in patch 1
* Improve commit message to explain why strbuf_list_free frees more memory
  (hence is the right thing to do)
* the bundle code doesn't have a dedicated return variable,
  but the error path always returns -1  
* removed a duplicate of
        +	if (!bundle_to_stdout)
        +		close(bundle_fd);
  in the bundle patch.
* This applies on v2.8.0.

v2:
Thanks Eric, Jeff, Junio for discussion, I picked up all hints and here
is a v2.

* drop the overallocation patches (1&2)
* use git_config_get_string instead of its _const equivalent, such that
  we don't need a cast when freeing in git_config_get_notes_strategy
* Use strbuf_list_free instead of cooking our own.
* have a dedicated error exit path in bundle.c, create_bundle

v1:
One of my first patches to Git were cleanup patches, and I fell back
to my old pattern here, while thinking on how to write better commit
messages for the submodule bugfixes I currently have in flight.

Just some one liners to not leak memory or file descriptors.

They are bundled as a series, but no patch relies on any predessor.

This applies on v2.8.0.

Thanks,
Stefan

Stefan Beller (4):
  notes: don't leak memory in git_config_get_notes_strategy
  abbrev_sha1_in_line: don't leak memory
  bundle: don't leak an fd in case of early return
  credential-cache, send_request: close fd when done

 builtin/notes.c    |  2 +-
 bundle.c           | 17 ++++++++++++-----
 credential-cache.c |  1 +
 wt-status.c        |  4 +---
 4 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.5.0.264.g4004fdc.dirty
