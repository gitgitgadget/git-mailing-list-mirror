From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 0/2] gitk: alter the ordering for the "Tags and heads" view
Date: Wed,  9 Mar 2016 13:18:08 -0500
Message-ID: <1457547490-12249-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Mar 09 19:18:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adige-0002Sr-LU
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618AbcCISSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:18:17 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:32878 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbcCISSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:18:15 -0500
Received: by mail-yw0-f193.google.com with SMTP id g6so2983575ywb.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xc3lBs4PsTdCGpVnVpq/q0UWixANSgX1m2nhkvF2q0Q=;
        b=GZfyoyzvqNBd9Bx3sYdA2Cm81u3gdGPH28P9UefEKA4u0p8LWPfymQ9hfnBll00LEa
         ORDlcLEGg2zy4/J6ylfC/D7GQVJp+bNbK8Pdm7QHsYrE8F2WBQRlp2MBp8apb8z/zmcu
         7mLFaan7VMsgQ2/K/FreD3CwvE311Ge1uWE2jy9vduvAxVpU/iTuhe1XZ751ZHeZ0yO2
         rDKIrHIJ1CN5MoK7PlXLdiH6IzdqFEKA4mst7cN0+Dw7gL1TkgyNy4c3KB+AQ4MpKxCc
         mlBzTq3iEuuCwrpo5FrGunItr9QqpYhNznlmM/kf5yB5jrz+CBl4oaHQ7awshchWQaIf
         5IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xc3lBs4PsTdCGpVnVpq/q0UWixANSgX1m2nhkvF2q0Q=;
        b=mgFfMxuFMS9l6278u6E4XspFM5MndRcb6wJWXNTzv89re2XD7YjTy21szd6B/BjXLn
         SNGS/ThbQ4dHWkJBIh7DAp2Y2UfyXGwFpZhly9k+iR+14FtlVzBBfvk1X0EZUCTPggLn
         wPi+j24AMRIaz+W4PjhE/HY075nBRzQ8dcEAY+CGLeodO2gjymw5h/LqvtQ3ysO2dqNV
         Q50xd60zSM8WUHiom8jjGnzIn26N5u1LB3UdlQ86okGFT5obfqF8fRd2DvYF/B1IDo6f
         /vzZwSnYAG2APJvRsce6+gdN0LABE5SnMgRKhndOV2ld/Wx17LzaC2i41xWHfeKmKcvR
         cNHg==
X-Gm-Message-State: AD7BkJKlHpXl8s9zAoT3PEvs7dz4L+kflzKV11oXyUeA1d3Gpp42oSBSs4IByFgghB1HRw==
X-Received: by 10.13.221.87 with SMTP id g84mr8698313ywe.229.1457547494946;
        Wed, 09 Mar 2016 10:18:14 -0800 (PST)
Received: from MRappazzo-8.infor.com (pool-100-35-119-77.nwrknj.fios.verizon.net. [100.35.119.77])
        by smtp.gmail.com with ESMTPSA id o185sm2561964ywb.9.2016.03.09.10.18.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 10:18:14 -0800 (PST)
X-Mailer: git-send-email 2.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288544>

In a codebase with a large number of remote branches, the "Tags and heads"
view can split the local refs around the name "remotes".  I wanted to make
this view more useful as a quick view of the refs that are important to me
at the moment (the branches that I am actively working on).

This patch series adds a command line option to change the ordering of the
view (`--sort-refs-by-type`) which will sort the refs in the following
order:

    local refs
    remote refs which are tracked (upstream) by local refs
    remote refs
    tags
    other refs

Each of these lists is independently sorted before being put into the main
ref list.  Also note that the upstream refs are _not_ duplicated in the
remote refs list.

Michael Rappazzo (2):
  gitk: alter the ordering for the "Tags and heads" view
  gitk: add an option to enable sorting the "Tags and heads" view by ref
    type

 gitk | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 7 deletions(-)

-- 
2.7.2
