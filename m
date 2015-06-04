From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/2] make commit --verbose work with --no-status
Date: Fri,  5 Jun 2015 01:56:29 +0800
Message-ID: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:57:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0ZO4-0000RV-9O
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbbFDR47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:56:59 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36146 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbbFDR46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:56:58 -0400
Received: by pabqy3 with SMTP id qy3so33899113pab.3
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ryWadFt5JrFYa8MHYXksgXaBCRUFQbJuCpah8EymX5w=;
        b=mJ+vnkqRs0kjwaQieQF3fBvhoepfXWkBNPzgkXAUIu6durxl99Sf201MKS5TZ6GD/L
         7Akt1xmZ6oruB5vbNze2bKu8e9MWpjtKQtZHCGsSZHzIRaUBZhcOkhUHIcXwk0Ow/rPP
         /dFQ3qaKTdQwRhKZnDIdw2PLNIpaYfnUB0C1RLrcMozAzCydOXwmFUNe0hELeUVWeC7D
         em3nf68HUJ9gKY+uRh4Yi4lazE9fvbCMUXvuMcaoCyuqo2B8R/19qvYvy4vYjBXHiKF9
         F4FZbiPa9lbKsjvd14AxZNllB11pkhxnsmUhGF3Dam1jtcpbSLCdjPSTDLOIlXMuv5SC
         V7Nw==
X-Received: by 10.70.55.41 with SMTP id o9mr70452124pdp.80.1433440618225;
        Thu, 04 Jun 2015 10:56:58 -0700 (PDT)
Received: from localhost.localdomain ([202.156.104.43])
        by mx.google.com with ESMTPSA id j9sm4453566pdm.53.2015.06.04.10.56.56
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 10:56:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.581.g64f2558
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270789>

When running git-commit`, --verbose appends a diff to the prepared
message, while --no-status omits git-status output; thus, one would
expect --verbose --no-status to give a commit message with a diff of
the commit without git-status output.

However, this is not what happens - the prepared commit message body is
empty, entirely. (Needless to say, no diff is appended.) This patch
series attempts to make this work, as one would expect.

[PATCH 1/2] extract setting of wt_status.commitable flag out of
wt_status_print_updated()

Currently, the wt_status.commitable flag is set only when we call
wt_status_print(). * Extract this logic, so that we don't have to go
through the git-status output code just to set the flag.

* In fact, it is not set when --short or --porcelain are used. This
  series does not attempt to fix the bug, though it should be trivial to
  do so with this patch. See 9cbcc2a (demonstrate git-commit --dry-run
  exit code behaviour, Feb 22 2014).

[PATCH 2/2] make commit --verbose work with --no-status

Actual work here.

-- 
2.0.0.581.g64f2558
