From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] WAS: [PATCH] mv: allow moving nested submodules
Date: Mon, 18 Apr 2016 16:41:22 -0700
Message-ID: <1461022884-30819-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, gmane@otterhall.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 01:41:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asInS-0007Z8-PW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 01:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbcDRXle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 19:41:34 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35506 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbcDRXld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 19:41:33 -0400
Received: by mail-pa0-f41.google.com with SMTP id fs9so24672pac.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MyEclju7LBMPJEKmDIebjW7K7/PU9gtKzO23dZC6oEQ=;
        b=jpbD/8Cg+SVtd0np+oUkk9qRXGkJTBy61LpEsDK0uMEk2f77sviHsD9updrQjySrCN
         O5upTxtWFU2QNaZP/msZ5TlFGfkpXlA0FwcgEc/9NcAkjmQLosG46NwCmEm3iyKnZNAu
         giwvDDvv/1eCR5BIcUgNQIf0aAXndz6zmMlVMt9h5Um75i9E1N3NXC1Q9y47zgj2CiOn
         gKGvh521Jnk2Btm7Tb7whPAnXkdkE21kv2J/cQuHWqyVL3IYgZN5Bh4kvcT+d8qTwW9K
         FMOgzMRVA1fLME5OQ1Ieg5WQKF6ZFpzEozwCoAo2wLi9u5zXK+zCVv27wcOBHaQnE75D
         Uvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MyEclju7LBMPJEKmDIebjW7K7/PU9gtKzO23dZC6oEQ=;
        b=C4iK8+YJCrkrmgrEz6Vn1feXwXo/Y+4V0MDFb7bIekjpdahegai19i87lhezHpsVOw
         g8EOXnmeW+4y60ERRe4Y3YnKiQm16JN2KQsES778OS3yN48IdGh7kYfryYNHLBlH+0GA
         rX5U9j0whld2pZS9PNuP2IfFIeE9OBpBugyT5G2bPFcEAoyj4DkyEj6v5Cmwc0hUOiGS
         3gPmrI5T+Y+C0YGOgsJ9NbG+cop2a+bvQSnjb2xsggtIsbVniiuDaUDQLC/yBP1GHukG
         kjqjaxCmX2wbW1089J+USL/H0cP8+ar/YqbPvYbtrGZANUoM4wcxmYFR4uwBlSTFJ++w
         3Neg==
X-Gm-Message-State: AOPr4FXgWLDwo4OHSINTK8Zkvj6WCUd6ZKuiml3nXjhZ3pEmubDkTTgiqpqdPXX4Cr/t0kcj
X-Received: by 10.66.231.73 with SMTP id te9mr54137602pac.62.1461022892614;
        Mon, 18 Apr 2016 16:41:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6869:43f:e72f:2f19])
        by smtp.gmail.com with ESMTPSA id w1sm28171401paa.6.2016.04.18.16.41.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 16:41:31 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.211.g24879d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291836>

A single patch evolves into a series.
The second patch is essentially a resend with Junios suggestion squashed[1].

That patch alone doesn't quite fix it yet, as we need to make sure the
submodule code respects the ignore_errors flag as instructed by the user.
Patch 1 libifies the used functions from submodule.c and handles the errors
appropriately.

[1] http://thread.gmane.org/gmane.comp.version-control.git/291810/focus=291829

Thanks,
Stefan

Stefan Beller (2):
  mv submodule: respect ignore_errors for errors in submodule code
  mv: allow moving nested submodules

 builtin/mv.c  | 32 +++++++++++++++++++++++---------
 submodule.c   | 33 ++++++++++++++++++++++++---------
 submodule.h   |  6 ++++--
 t/t7001-mv.sh | 16 ++++++++++++++++
 4 files changed, 67 insertions(+), 20 deletions(-)

-- 
2.8.1.211.g24879d1
