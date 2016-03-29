From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/6] Fix path bugs in submodule commands executed from sub dir
Date: Tue, 29 Mar 2016 15:23:42 -0700
Message-ID: <1459290228-9069-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 00:24:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al23M-0002HL-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbcC2WX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:23:56 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32901 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbcC2WXz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:23:55 -0400
Received: by mail-pf0-f179.google.com with SMTP id 4so25545383pfd.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=96w2TyjplR+3Lw1ptuPai/UF4SdUxXDnUow14nw43DY=;
        b=YhOgpv3a1l+yxU+TvLCzE30stndqMJci7sSKeG5Rs5iu2hfNa9toCZmFfSEN1r/DLV
         c3nbrTDxrPShfeBQPftj45F3F3xWtpQ4i12WF0Kz0w52zEziru99aTyZf60iHMEu5Jo0
         MxfVq1wzyFBZkwJ1sh/y36s6JCKi+YLmFmSEojuuloYePeVhIDorvtVWDYvyEx/3K/4G
         pP9apF3GAv9/Un8M0q4k8+O2YOeFrVn4fhd3pE4fKqxg1sfl/CAmQJp1ies/tw0T9Yyg
         cThXBg9qo8Y+LU+8pFLODMmD9BFhw5/SNgsOKPhapB5x5rOc+aAon2Pz3GClyRGItRnQ
         UqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=96w2TyjplR+3Lw1ptuPai/UF4SdUxXDnUow14nw43DY=;
        b=MyCNVvCGaRBzUlFacwvKxPN8SLwz6MiwOIvrM1hBHQqALz7mzDpWsX6nNky6wPKc2j
         F8h57NsxxZR9MB1v53m4CMwGr/mLdtTn88KFwqCK65DZsAIo9pqa3xq7mCgnnunizJjy
         fHXB4GhBkM8+pHhPwCutqvjqW/dwF1TcIOWpdIAnUrXwsqSV6r/NL3RI9+ALZZVB9Qup
         24LSay4NCsByimAS3nY0Nl8snSP+xKxznmFTTKZQJIzY3Al/1V4RfRT8QeQ8KAHmcWuC
         7aFnaUei2rOydv2QoGeMRiHMgkfFy51JeVVofuHwp9wkruUGMDj+sqSM8gg3xry5b+Hn
         5sPw==
X-Gm-Message-State: AD7BkJL/t8TOZxgCE4k9ezeYPAGFOo6ZxWiC+NR6CAwtLNoGy+I35UILEgMs85bl+CbDvOEj
X-Received: by 10.98.7.135 with SMTP id 7mr7295943pfh.124.1459290234612;
        Tue, 29 Mar 2016 15:23:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id q2sm629770pfq.88.2016.03.29.15.23.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 15:23:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.4.g5639dee.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290205>

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
  t7407: make expectation as clear as possible
  submodule update: align reporting path for custom command execution
  submodule update: test recursive path reporting from subdirectory

 git-submodule.sh             | 10 +++---
 t/t7406-submodule-update.sh  | 83 ++++++++++++++++++++++++++++++++++++++++++--
 t/t7407-submodule-foreach.sh | 49 ++++++++++++++++++++++++--
 3 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.8.0.4.g5639dee.dirty
