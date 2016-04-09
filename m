From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] rewrite t1500-rev-parse.sh
Date: Sat,  9 Apr 2016 07:19:26 -0400
Message-ID: <1460200767-32864-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	szeder@ira.uka.de, Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 13:19:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoqvF-0000Kn-DH
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 13:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcDILTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 07:19:18 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35276 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbcDILTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 07:19:17 -0400
Received: by mail-qg0-f66.google.com with SMTP id b32so12165482qgf.2
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2Won9VYahLtGEWeAlZp7woTUAWm6l7wCIWwBWt64xRQ=;
        b=mRLjg6gQCCQaCSq6VzaccNWsaGdstueqydrXcarUM2JszUnVxI/nixsvwKZP2HkqS5
         31n419MkvO11pkilyPSk3eKbdyfkfB6TtI5gFQ2jMB+Y/vDUs509NhrFEIIpClbRfAy+
         q6UlQoST0vuvu6ogbGvf73l7lRQsP7IkCu9STi4kSuykQviiqNLKjdU9AF+OhNgAi/rY
         O2VXSpLDGBR4C7SATj0ggIlqFdD/GNJP1+Qk+hf/ly8vZqXQI47TAG+9xM5XXAVN6ogd
         AEoiByDNa+GXgwytW/PHAOsBz8j5H+QvAU+CjhTPnlZCHirswiRbCSQP5bH9zIjMDUgq
         b+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Won9VYahLtGEWeAlZp7woTUAWm6l7wCIWwBWt64xRQ=;
        b=W0VYlml+OGGUsyOnG3bFpJms3XvoQzYfpe6aH/E6SpPxAk8WCxwXqTPl7Uvdzo9Yx9
         CH55FH9L4VZXQaiUogJih62CY+Qlk2Ds+xfYqR8zGw97vaFH1IQ+v+Hg8bgVirsZLkpT
         pgeBrZxk9RNwdGD009AH/fRUZUsQKt+r+uvDADW/UfxQizLDA7c5B/NiTgA6eO5yvmpO
         c2Umm1ZFOqZMYkxq2EbDNdkr2f5vWkVebODx9pwK9WIWzOgUoMJ2arwMuRwhoYu/9f0g
         2YiWNBxXSFsEcuKF+iPVCMh3tfJeXFeHGBzl5peJu9ZMgd8EFUbSfYzMLXZEsDrPHY3j
         ILog==
X-Gm-Message-State: AD7BkJJb3jLPu4hjmAOOyr+u8PJ8l3itB30sQZl5w5fD+dCGv8Bmi07Xg3pBk0bP6iiNtg==
X-Received: by 10.140.16.133 with SMTP id 5mr16816134qgb.50.1460200756286;
        Sat, 09 Apr 2016 04:19:16 -0700 (PDT)
Received: from MRappazzo-8.local.info (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id c32sm7245961qgf.36.2016.04.09.04.19.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 04:19:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291087>

I was working on a simple bug fix[1], and I wanted to add a test to t1500.  I put
the new test at the beginning rather than try to decipher what state the test run
would be in at the end. In the review, Eric Sunshine described the test:

> this script is ancient and cd's all around the place with wild abandon and
> leaks environment variables

I decided to rewrite this test in (what I hope is) the modern test format.  In
doing so, I expanded the size of the test file greatly, but I think it is much
clearer to read and understand as you go through it.  This also has the advantage
of allowing a tester to use verbose options when testing.  As noted in the commit
comment, tests which compare text (rather than booleans) were also adjusted to use
the test_cmp function.

This patch is based on 'pu' because of a feature to add `--absolute-git-dir` to
rev-parse[2].

I considered including this patch as the first commit in the aforementioned bug
fix, but I wanted to get it out for review to make sure that it is acceptible.


[1]http://thread.gmane.org/gmane.comp.version-control.git/290669
[2]http://article.gmane.org/gmane.comp.version-control.git/287462

Michael Rappazzo (1):
  t1500-rev-parse: rewrite each test to run in isolation

 t/t1500-rev-parse.sh | 607 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 545 insertions(+), 62 deletions(-)

-- 
2.8.0
