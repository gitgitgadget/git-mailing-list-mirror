From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 0/3] Improve gui blame usability for large repositories
Date: Thu, 17 Jul 2008 00:42:29 +0400
Organization: TEPKOM
Message-ID: <200807170042.29462.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDqd-0003Xy-4C
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079AbYGPUmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757997AbYGPUmk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:42:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:35164 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757720AbYGPUmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:42:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2506132fgg.17
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Z1dCQW/Sq86cRsP0TyTlemRlMmzmdoHVfXMXvyifLuM=;
        b=eRCcfLRbiQQCMDQYLX/DSIvkcmGpn9cO4DnOUU7AP4EpQ4bjzCmGQQes5T0eLz3j7Z
         Nb1M9lZa6jmDCPmYGVBuFa+WKTQ0+7AU2Xw2+uZ43uMPLBuwQg7b6ji0dCZZQRMvGMNt
         S57wTfTRseYzdOKw/yfDXxZ3Lem7Xcx7wbZhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Yh/q4qXhOMTOiMP+RcvL1tyqaH6fW04Rkr8pTjpBU08W13XC8ukyVQ5vzLk+JvpY5K
         CM89h4lYbie/y8pWsDXDIhcBCk2cf+oZC7MS1Ecb2bWW5kYA18EvlLMIWU6HHnkFprus
         t3ePk7JUDAFJk5a05vmBrrv6Y24pvB0HKTNOE=
Received: by 10.86.63.19 with SMTP id l19mr2640180fga.77.1216240956587;
        Wed, 16 Jul 2008 13:42:36 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id e20sm1212217fga.1.2008.07.16.13.42.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 13:42:36 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88747>

Full copy detection can take quite some time on large repositories, which
substantially decreases perceived usability of the 'git gui blame' command.
This set of patches tries to overcome it by:

1) Allowing the user to disable '-C -C' and/or set the detection threshold.

2) Explicitly killing back-end processes, which don't produce any output
  during copy detection, and thus normally won't receive SIGPIPE until
  it is finished. Runaway processes are annoying.

3) To compensate for (1), adding a context menu item to manually invoke
  blame -C -C -C on a group of lines.

Alexander Gavrilov (3):
      Add options to control the search for copies in blame.
      Kill the blame back-end on window close.
      Add a menu item to invoke full copy detection in blame.

 git-gui.sh     |   16 ++++++++
 lib/blame.tcl  |  105 +++++++++++++++++++++++++++++++++++++++++++++++++------
 lib/option.tcl |    2 +
 3 files changed, 111 insertions(+), 12 deletions(-)
