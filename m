From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/6] Fix path bugs in submodule commands executed from sub dir
Date: Tue, 29 Mar 2016 18:27:40 -0700
Message-ID: <1459301266-12403-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 03:27:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4vN-00047S-UQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbcC3B1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:27:53 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33761 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbcC3B1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:27:52 -0400
Received: by mail-pa0-f51.google.com with SMTP id zm5so27425935pac.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hQWTEd2Z4HFLVMDOskg0jcMDA1aq6mYVw5KDkzpq7XM=;
        b=gNOguhTBEzjn0pWZDANPDjURZURUw2hN29KQdOXadrqd1GQGfDKbdl7V/4No/LBW9d
         ClOOCHcgb0Z/e3+OfGWI0kvz2VEn/sKOOeflZu6Jf/Rki8UL1gwiTkqTswyifhbxDLZJ
         vol3J3/d0DXMaNvBl+ZS/OX77Cub8dPl68OINST9Kt//EIcRFlzWajipcD/HhJrmW85F
         lXmjEPXc+X7PrWIZo3WmyzlhrjjP+yjYYJ6oJgodhQsSSs228sOYK1IobYYGyY9nLKJJ
         XubW3hLW0p+xIg5SfHY6g3JEw00veJ3navus77q9Hb4oPpASK0g4bs51ttS/+P3909df
         JIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hQWTEd2Z4HFLVMDOskg0jcMDA1aq6mYVw5KDkzpq7XM=;
        b=FuetypTqF9RKT6W2CkqzHYqgTPBi33iP+e1LkxqnqcB1CqKS1jMUoFeUGl/0sCSOs/
         NkOrcT1S1/nb8pxe3ZHQVuAs0Uo9WqtBH/6y8mz2Y8ajVxu++pqZfYq/CbAxt19QtpxG
         cfHJcPwwSFFuowzPjeLXqHDHwBoy3UQ0g5a2MK+kc9rONo0r++lGAE9oqDFhnzKUcGJH
         1yVbUprOYATFupptyzpHtx/z4N19HgIdeXq1SKIh4Z9W0sssNRm86n0SnMYbZaK8LUle
         1zzFyD0186Ckpn5nqm66SIjbMphKvUPjpOqRVzU0O9+6qnj1So4RFJSz/eoY51WDtsK/
         dDmw==
X-Gm-Message-State: AD7BkJJf+2WIeNa4I9qpdyxC0JJUXkXGRHzR/AQOqe+OPmD4CDXagX1KG0TXJZ7wKiQqUaAk
X-Received: by 10.66.154.233 with SMTP id vr9mr8484541pab.66.1459301271327;
        Tue, 29 Mar 2016 18:27:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id 82sm1110536pfi.78.2016.03.29.18.27.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 18:27:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290252>

v4:
* addressed Junios comments in patch 1&2, which is:
1)
    * reworded commit message
    * when writing the commit message I discovered a new way to fix the bug
      (fix the computation of the displaypath instead of its parameters
       wt_prefix and prefix.)
    
      The result is the same, but I am not yet sure if I like it more.

2)
    * Use `git -C <path>` instead of `cd <path> && git`.
    * Reword commit message

v3:
Resending without `test_pause` in the last test.

v2:

The first 3 commits are
* Test and bugfix in one commit each
* better explained than before

The expansion of an expected test result moved to the back of the series.

There are two new commits
* one being another bugfix of the display path for `submodule update`
* another test for `submodule update` as I suspect it may break further on
  refactoring and we currently have no tests for it.

Thanks,
Stefan

Stefan Beller (6):
  submodule foreach: correct path display in recursive submodules
  submodule update --init: correct path handling in recursive submodules
  submodule status: correct path handling in recursive submodules
  submodule update: align reporting path for custom command execution
  submodule update: test recursive path reporting from subdirectory
  t7407: make expectation as clear as possible

 git-submodule.sh             | 13 +++----
 t/t7406-submodule-update.sh  | 82 ++++++++++++++++++++++++++++++++++++++++++--
 t/t7407-submodule-foreach.sh | 49 ++++++++++++++++++++++++--
 3 files changed, 133 insertions(+), 11 deletions(-)

-- 
2.8.0.2.gb331331
