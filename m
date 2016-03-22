From: Stefan Beller <sbeller@google.com>
Subject: [RFC_PATCHv4 0/7] Git submodule labels
Date: Mon, 21 Mar 2016 19:06:05 -0700
Message-ID: <1458612372-10966-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 03:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiBiH-0000cY-GD
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 03:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117AbcCVCGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 22:06:24 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35471 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbcCVCGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 22:06:23 -0400
Received: by mail-pf0-f175.google.com with SMTP id n5so287710323pfn.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 19:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=d5M1tK2IvGvXLLDrFeCcjo/NBS1kotnpxZuSg/BCg5g=;
        b=AHKuHKNONfMrPNuNKx7cR9EZzravM7dQjdhMH4WruV3yLauTNhdLesyKBbI6ut2lhA
         wpsW684YOcvEkxb8wkB4SCLP5W013Sa11qYofpqTkXXGXcYlbRkb4gYBTrnwUOQM3qlj
         EYp/jciySHVhOOlkHWju7cSJ9utZ+AaJ9MrkNGxfGKf8pAqV1tGGau/jC2MmcidtRwmQ
         cEQpZQbpavtDnNujDtfKZwNRCPa4VjeLDrnLLg+3RhKUafreXzu97X0bUG3AGxLuHGK0
         wdvqSDPZ4czWo7ag7RT5BodpzHvVQp3i1Ufle35FkyoiytxilK/33paQaonTiCZFvxRV
         O1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d5M1tK2IvGvXLLDrFeCcjo/NBS1kotnpxZuSg/BCg5g=;
        b=AfHtmS5U9GcyuHZw1sx34/nS+1vN/XSQu1E/6MOuTouc1X14V0AMwROC0mVElTcAgo
         CJqyZ8cSZEsLq54hClA85hCNf6J/qTwikxfJ4uMyLGGaDRRb0Ksx9xQiZVzQppoHLchJ
         +rb31tirqdqrBT1CXZSbdzOwCf/70rhmIVBocmmtx5P1fPek/CAdOUSSaAdQveTif+h0
         WB3FwI3vHGcUJ/zSIAcQtKqfl+8uDUubZNHx9+7gOAd7x3ce15zyFjcLi71kATFVmws2
         gi7ApihZ5I0nfSdNMYXefTHlUt4JqtOQRsRbmXzgezqM9kky7yecX6evmwHJ2Txhy+4/
         O7Dw==
X-Gm-Message-State: AD7BkJJEWUHGsyL08rzXRb1RJvqG9Gzhq/DLfh+MCcsriQvQ/9kEi6rVR/oE+XnPCBhFs64K
X-Received: by 10.66.192.195 with SMTP id hi3mr49945086pac.149.1458612383072;
        Mon, 21 Mar 2016 19:06:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id w62sm43615738pfa.79.2016.03.21.19.06.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 19:06:21 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.45.g6b4c145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289479>

This series introduces labels which you can attach to submodules like so:

    $ cat .gitmodules
    [submodule "gcc"]
        path = gcc
        url = git://...
        label = default
        label = devel
    [submodule "linux"]
        path = linux
        url = git://...
        label = default
        
    $ git submodule add --name emacs --label "editor" --label default git://...
    
    # If upstream has submodules properly labeled, you can make use of them:
    $ git config --add submodule.actionOnLabel "*default"
    $ git config --add submodule.actionOnLabel ":name"
    $ git config --add submodule.actionOnLabel "./by/path"
    # The prefix * denotes a label as found in .gitmodules
    # : goes before names 
    # path are prefixed ./ currently
    # both path and names need work

    # no --init necessary, partially initializes submodules (only those which
    # were specified by label, name or path)
    $ git submodule update
    
    # time passes, upstream may have added new submodules and we get them without
    # extra commands!
    $ git submodule update

    # The above configuration can be given to git clone directly via:
    $ git clone --init-submodule=*labelA ...
    
    # diff/status only apply to label-selected submodules
    git status

New since last round:
* Renamed to submodule.actionOnLabel as it is generic enough to be applicable
  for lots of commands (submodule update, status, diff, etc)
* Restructured the code to have a generic "Given these labels, would I
  want to operate on this submodule", which made the implementation for
  "submodule update" easier, as well as the new WIP patch for diff/status.

Any feedback would be welcome!
Thanks,
Stefan

An earlier version was posted at
http://thread.gmane.org/gmane.comp.version-control.git/284612

This applies on top of origin/sb/submodule-init or can be found at
https://github.com/stefanbeller/git/tree/submodule-groups-v4

Stefan Beller (7):
  git submodule: teach `add` to label submodules
  submodule-config: keep labels around
  submodule-config: add method to check for being labeled
  submodule init: redirect stdout to stderr
  submodule update: respect submodule.actionOnLabel
  clone: allow specification of submodules to be cloned
  WIP status/diff: respect submodule.actionOnLabel

 Documentation/git-clone.txt     |   6 +
 Documentation/git-submodule.txt |   5 +-
 builtin/clone.c                 |  40 +++++-
 builtin/submodule--helper.c     |  25 +++-
 git-submodule.sh                |  14 +-
 submodule-config.c              |  66 ++++++++-
 submodule-config.h              |   5 +
 submodule.c                     |  15 ++
 t/t7400-submodule-basic.sh      | 294 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 462 insertions(+), 8 deletions(-)

-- 
2.7.0.rc0.45.g6b4c145
