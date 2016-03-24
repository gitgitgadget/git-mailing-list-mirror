From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/4] submodule helper: cleanup prefix passing
Date: Thu, 24 Mar 2016 16:34:24 -0700
Message-ID: <1458862468-12460-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 00:34:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEm5-0005ha-5G
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbcCXXel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:34:41 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35121 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbcCXXek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:34:40 -0400
Received: by mail-pf0-f170.google.com with SMTP id n5so69222636pfn.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9sWHENsGxAza/VBNckyP5GyfappH2xBXtVAPE04UVxY=;
        b=CCIwhZxP7YNtljHrpcE2eesgLF75nd/qXxjjtPPb56U0/gxr4y651nTB+e1ftOciZm
         +uBAwM9q5IykVdhVX7faRF4AgbhC2pIVQiwTM6IecRjHAjyCL2zFawa38fax70dcfF7r
         xLv67N5tSGZvDVMU5hxNSwRwHV9xaM4UIRCwQAXtiPHgTatv4iYIzDCUm1wkHw00IQrs
         s9tZg2bS26+z4NlTPYKfB3LzJLB5FDlwyoiViF5x14rP52XGsYG20R+ffdg+dVetSvT5
         Q7PqyguF3ocQAz6RIdC5SLFHYRaz4yxMyMhN8tMiP2abx14hi2PZqv0NkwXQhBN9ebk1
         FY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9sWHENsGxAza/VBNckyP5GyfappH2xBXtVAPE04UVxY=;
        b=U1d5keI/JLuw7lIRS6FoH0WDz6tuo5pwCDrtt+9Nt7ZgILG7AJZISgUVyJBoB93Qtr
         vWr4kNsQ+wlhBeEopcgKTteD9NMCX6mGBpkJIcJYq4xGpBZ9PLvqwIck9jHZmyTHSWCb
         r5ElgXrKaAA1DTZjKZsfVCcb1UYNAfpfJmxBiRotRFYv8HX9j3j0DTz/yK4YRI/vyFEG
         USXla5f7czk7beWQVt+X89aWdlk4Nu6WKnVWIou9V7ovH9AIZT/C0woGqMwUNPpfDTdO
         olNqGSqC/fQXi7i8WXbJzpIWhea1XlASoXAG1wKts6wLEPhj1H3wMcEYrs3vKXxX/GWW
         qE+A==
X-Gm-Message-State: AD7BkJIKk4zK8fEca54wZ/BzAYGTdWFSl3CkB3ng6f8KcLsQJVOn6jSJ9w8Q7T5/fRfno068
X-Received: by 10.98.32.211 with SMTP id m80mr16608380pfj.3.1458862479529;
        Thu, 24 Mar 2016 16:34:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a88b:7b22:8e5b:edac])
        by smtp.gmail.com with ESMTPSA id ah10sm12413407pad.23.2016.03.24.16.34.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 16:34:38 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289825>

The first two patches fix two subtle bugs that would show up if we'd
apply the third patch without them. The third patch replaces
 
    git submodule--helper --prefix $wt_prefix list

by the more Git idiomatic 

    git -C $wt_prefix submodule--helper list

The series is finished by adding more tests which would have helped
to have when developing this series.

This applies to origin/master.

A prior version can be found at 
$gmane/287620

Thanks,
Stefan

Stefan Beller (4):
  submodule: fix recursive path printing from non root directory
  submodule: fix recursive execution from non root directory
  submodule--helper list: lose the extra prefix option
  submodule: add more tests for recursive submodule behavior

 builtin/submodule--helper.c |  5 +----
 git-submodule.sh            | 19 +++++++++++--------
 t/t7403-submodule-sync.sh   | 13 +++++++++----
 t/t7406-submodule-update.sh | 12 ++++++++++++
 4 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.8.0.rc4.10.g52f3f33
