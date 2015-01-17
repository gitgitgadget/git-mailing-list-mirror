From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: support exclude in 'git p4 sync'
Date: Sat, 17 Jan 2015 20:56:37 +0000
Message-ID: <1421528198-16749-1-git-send-email-luke@diamand.org>
Cc: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 21:57:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCaQj-0001es-0o
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 21:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbbAQU5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 15:57:04 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:65125 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbAQU5D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 15:57:03 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so17497330pdj.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2015 12:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ggGtxVyf7UhCuJ/yL7ySY5JdruMWnQ45c/6kX/JABBM=;
        b=PCQiSRHArFnxYNW/jci989M3U4mJZl8FPBWAPhRjy2jyXORUdNFwbxbm5o12zmQx5n
         jgqSMO4yispGXv4GSiek1v0N6HvdeiZjbGYuvukbzp7JEkRtDqL/zE21GAINmSzDTAyx
         mS1XSwLg0puFcT+tUX5cN0sDCn9hhIGqUu30k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ggGtxVyf7UhCuJ/yL7ySY5JdruMWnQ45c/6kX/JABBM=;
        b=WTmszVT3VrczR5UcPd2QIKXmNvQfaU8PO9QBAYIfvSFUK8TOeu35pgug+UdHZNQ+YW
         CXIh8ALk9I5WBFCjGnWj78s7OdWkmZ0uIBC+L3DhcumOKjP0zGD7KcHGnJVfGs0wh80t
         PkgvrwXc2yfHG2jWz5DNPHoxnmrRjLanp2Qatdtf24m1PWoy4wEkSGYPApV0YdvD8q2P
         PBh8kU0pCPN1DHDzqDMA6a44Heu1DGPduJqXWnqLLNRYeVwCN5uTLfsZNGVlZa5ZEvWv
         PSHJ80xaI8pJx79HtxW8qCi2GeOGS12u6ekxFsTok9CCiSYyxdhe2QqmgbLWqXyRlhtV
         tJZQ==
X-Gm-Message-State: ALoCoQkBOTwMjkhVInxGtRxFdHMav9gir7Ygv87p8a5FVIXc22uBHFWy/rCJFT0tRmscEWx5Hmg7
X-Received: by 10.70.137.66 with SMTP id qg2mr20017515pdb.73.1421528221939;
        Sat, 17 Jan 2015 12:57:01 -0800 (PST)
Received: from lgd-kipper.roku.com (cpc14-cmbg17-2-0-cust690.5-4.cable.virginm.net. [86.14.230.179])
        by mx.google.com with ESMTPSA id rx1sm7413803pbc.86.2015.01.17.12.56.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jan 2015 12:57:01 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.45.g2e81bcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262590>

The git-p4 'clone' subcommand has long had the option to specify
parts of the repo to be excluded, on the command line. But this has
not been present in 'sync', which makes it less than useful: as
soon as you do a sync, the excluded parts start being repopulated
as those directories are changed.

(You can achieve the same effect by using a client specification to
do the exclusion, but that's then an extra step).

The code for doing the exclusion is actually all present in the base
'P4Sync' class: this change turns that on by moving the definition
of the command-line switch.

It also updates the documentation and adds a test-case.

Thanks,
Luke

And yes, I'm back to using version control systems other than git :-(

Luke Diamand (1):
  git-p4: support excluding paths on sync

 Documentation/git-p4.txt  |    6 ++--
 git-p4.py                 |   18 ++++++------
 t/t9817-git-p4-exclude.sh |   71 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 12 deletions(-)
 create mode 100755 t/t9817-git-p4-exclude.sh

-- 
1.7.10.4
