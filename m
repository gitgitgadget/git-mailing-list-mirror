From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/3] make commit --verbose work with --no-status
Date: Sat, 22 Feb 2014 03:09:19 +0800
Message-ID: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 20:09:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGvTs-0000Ms-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 20:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbaBUTJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 14:09:44 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47386 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbaBUTJl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 14:09:41 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so3836166pab.34
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 11:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Mj8+ZjLk87+uCLTcH+cAhH9VjsPdhquv43be7DMoMv8=;
        b=kuRe5IID9b3gPeFSGGW1Fj5ibUntJdI4cC6yNxAT5nEOCIb2TCs4XWCuSsx9qNc2J3
         AHf4eDdcFXLL+w63qWDs5AxOvInbhBCD/Sji3IwELto58So5wZgK6Ch7TsuyLXTi1vjG
         u5ixTk5bLwFhZlZP2Pgswd8a83guL4t1SBuQPcvwiwgxgEFF1Jo4PdFGBGVyYGQoJzFT
         TIPLufoAXoA9Fheto/AV+mUx6BqiGMmdH9veCn5QSfEBwy12NZuuFxsgqypoHb3+J/O2
         g69blUKId8HhzgRm/kr5idEE7nn3f9cUspmWqkx0a5nTYLuq1LGMaglJTvRLrNqyBKSg
         rhVA==
X-Received: by 10.68.125.164 with SMTP id mr4mr10880272pbb.27.1393009781498;
        Fri, 21 Feb 2014 11:09:41 -0800 (PST)
Received: from chiliad.localdomain (cm245.gamma242.maxonline.com.sg. [202.156.242.245])
        by mx.google.com with ESMTPSA id vf7sm23887999pbc.5.2014.02.21.11.09.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 11:09:40 -0800 (PST)
X-Mailer: git-send-email 1.9.0.291.g027825b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242487>

One would expect 'git commit --verbose --no-status' to give a commit
message with a diff of the commit, sans the output of git-status.
However, this does not work currently; the commit message body is
entirely empty (diff is absent as well). This patch series attempts to
make this work, as one would expect.

[PATCH 1/3] rename STATUS_FORMAT_NONE to STATUS_FORMAT_DEFAULT

We first rename STATUS_FORMAT_NONE to *_DEFAULT, so that we can use it
to mean "no status output at all".

[PATCH 2/3] extract setting of wt_status.commitable flag out of
wt_status_print_updated()

Currently, the wt_status.commitable flag is set only when we call
wt_status_print(). * Extract this logic, so that we don't have to go
through the git-status output code.

* In fact, it is not set when --short or --porcelain are used. This
  series does not attempt to fix the bug, though it should be trivial to
  do so with this patch.

[PATCH 3/3] make commit --verbose work with --no-status

Actual work here.

-- 
1.9.0.291.g027825b
