From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 17:53:20 +0530
Message-ID: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 14:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUyk6-0008Pc-5F
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 14:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252Ab3DXMYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 08:24:04 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57539 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248Ab3DXMYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 08:24:01 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so1959905ieb.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 05:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=HqRQfSzkd1YeB/PSZgFDfiYFq7NTTG6XpbQZpMVqPjQ=;
        b=XeYGtDiBRuaLHCSdkZ0D42i21imWHzT7frVzyK1cYjla71hxQ+9iUkvRn0mdmiDsCN
         mPgAORbm0WXhlgVaNh1Wk8p2BOvUbYI6VcVp84RXClTdeT6s/heUXhgcmxCDZEFVWfsG
         f2eQ1PUrr6EuTFMVyRcb9QoHjuYBuAX0D9/N6oSdFMXC/bDYnaC/pxo5zzMjda4Eh7z3
         eGn/7ZFoJQOjd959otMdo/8u/krs2h81xZtWEoApRr1a2S619ocw3T/eATJYpMrwDw9e
         jd1EtlcxyPXKuSdAjTlF1nJQtQ4bE1iLzmXc4Z2UwOtCKdp1VQo9RjHmE/CmplengNnn
         /VSw==
X-Received: by 10.50.55.73 with SMTP id q9mr21839495igp.44.1366806241322; Wed,
 24 Apr 2013 05:24:01 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 05:23:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222248>

Hi,

The 'git diff <commit> <commit>' form is perfectly fine: I can
understand that diff takes two commit^{tree}s to compare.
Unfortunately, it also shows off the examples 'git diff A..B' and 'git
diff A...B', where A..B and A...B do not correspond to the meaning
specified in gitrevisions.txt.  There's a note in the documentation
saying this, but I'm very unhappy.

I can understand that rev-parse parses A..B into ^A B.  'git diff
A..B' is the same as 'git diff A B', 'git diff B ^A', and 'git diff ^A
B'?  (Yeah, I saw the code and found out that it swaps the arguments
only if the second argument is UNINTERESTING)

rev-parse parses A...B into A B ^$(merge-base --all A B).  But 'git
diff A...B' means 'git diff $(git merge-base A B) B'?  And the
merge-base is picked at random (found out that from the code)?

What about other things like 'git diff ^A ^B' and 'git diff A^!'?  Why
is diff so inconsistent with everything else?  Why are A..B and A...B
almost coded in as special cases?  What should we do to improve the
situation?

Thanks for listening.
