From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v4 0/2] rev-parse: fix some options when executed from subpath of main tree
Date: Thu, 26 May 2016 07:19:14 -0400
Message-ID: <1464261556-89722-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, szeder@ira.uka.de,
	mh@glandium.org, sunshine@sunshineco.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 13:19:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5tJx-0004oE-Qe
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 13:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbcEZLTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 07:19:12 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33307 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcEZLTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 07:19:11 -0400
Received: by mail-yw0-f178.google.com with SMTP id h19so73402935ywc.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xvvr/yjRjWH+799mdTYZBLJptt/J8+lrhqSE/NlVBR0=;
        b=pQXhsw3HcUvQAdW7y+tK0QbLS23PqwkXzOBytoreCLzDP6S+uJ/AdJSzYkvqZo8ba7
         EpWHwVHpzF3qmjt9cT2vNVTq3/GmzKV6kmBRFeupOa8RSOQr8dO7ODvFCARf2+boa2ch
         IfSWdjSymwVsBzJTEV4Hw7C/DqgYOHixRILiT8R7avdJD8igkJNZ0cslYC2Tm5S0jAi5
         AIheiupArx+n2eq68ZLzpc5a5yL/pwnuvuhH+gRR/Bx1GJqetB7dM4jts6i+zAb7sb5j
         kZghfyGVwScqt2AxieiOOnNQGEjxrxDYdYeQaqSyAr2B5PUqD4ZtkmQK1g4wFuHT8Elx
         pNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xvvr/yjRjWH+799mdTYZBLJptt/J8+lrhqSE/NlVBR0=;
        b=SP8XFRI2jjbA2EjCS5wp7U/uplFCvT5KzMl9hRC5UISCi0Uu+ZjbHVcuxkgdFf2V6M
         rs7tb4nGNCvDugfrm0nsWbs5HK0MBL8x1bMpfa2zkQzzLf7C8tYfaTQYK7HP4M/K2Msp
         QpKqD+pvAQG7Y1hiawue9rQ9oyIMpg4L91pPJvr6xxc844BbzJTHIep0fs18r4jPv9te
         LLtxaJYVxTS/hYMMprj8H0hO51lbG/IEKpKe2BGt4aTg1g9bnPJtjLvgXUEb2MjYq1Ke
         b0k2U8RLv9OlDgpaZAySlhFF64/xFr02Jn9fsCDvbND0EclP4jMWoCCZg5hD3RKW0DZ8
         4wqA==
X-Gm-Message-State: ALyK8tKZcICLHethteB5x1zaRhir6YqHKj4zQiy2kWhxAU97hTdlTXE9UHtYPM0EcrrahA==
X-Received: by 10.129.119.4 with SMTP id s4mr5092472ywc.234.1464261549631;
        Thu, 26 May 2016 04:19:09 -0700 (PDT)
Received: from localhost.localdomain (146.sub-70-208-87.myvzw.com. [70.208.87.146])
        by smtp.gmail.com with ESMTPSA id l200sm2095979ywe.40.2016.05.26.04.19.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 26 May 2016 04:19:08 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295644>

Changes since v3 [1]:
 - Rebased onto 'pu' which includes the cleanup of t1500 by Eric Sunshine
 - Fixed a memory leak due to misusing xstrfmt()

[1] http://thread.gmane.org/gmane.comp.version-control.git/293778

Michael Rappazzo (2):
  rev-parse tests: add tests executed from a subdirectory
  rev-parse: fix some options when executed from subpath of main tree

 builtin/rev-parse.c      | 22 +++++++++++++++++-----
 t/t1500-rev-parse.sh     | 28 ++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 17 +++++++++++++++++
 t/t2027-worktree-list.sh | 10 +++++++++-
 4 files changed, 71 insertions(+), 6 deletions(-)

-- 
2.8.0
