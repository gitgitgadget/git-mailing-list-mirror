From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 0/3] Avoid runaway processes in gitk
Date: Fri, 18 Jul 2008 09:44:48 +0400
Organization: TEPKOM
Message-ID: <200807180944.48570.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 07:46:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJinf-0001ty-6p
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 07:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYGRFo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 01:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbYGRFo6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 01:44:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:4598 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbYGRFo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 01:44:57 -0400
Received: by nf-out-0910.google.com with SMTP id d3so78592nfc.21
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 22:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RMW1Bfn8aHNKfyRtKexDpchSTNt0xVwo0bSo38BcUDs=;
        b=lwoknJkFhMwkU/XjdzcvpA+P94GCySmvVPFBuTz+AjAwGUuFPYB85SQ4tF2i9gQ2xq
         QIrvr2eimFGFMfFk/jhPud4tNzkngsCjS1/j2PxgQYXAIgdVUMHORc9p+rwDiiSNb7tl
         iVbJc2ZQQMCeFwkMezaEiDwzjjRKqzjbB/19o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=L21QrtwHEwz59o/gZnIUAEnIZn9keOAR7XwDc1LKPen5PthQhbGQDEJ3FetxC6/V70
         vUXDteSGJTQlxUsW6piS38w7GY0sXWbkh/zXrsZcR08xfym1YuPorr8b/0FZBi5EU0XX
         pV5YsJEs6NCyqw29wyeFSsFlxDcm1yVN1ZAzo=
Received: by 10.210.65.2 with SMTP id n2mr1886050eba.48.1216359895898;
        Thu, 17 Jul 2008 22:44:55 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id z33sm1133295ikz.0.2008.07.17.22.44.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 22:44:55 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88986>

As in the 'git gui blame' case, gitk back-end processes can sometimes
run for a while without producing any output, e.g. diff-files on a slow
filesystem.

These patches make gitk explicitly kill its back-end processes.

Alexander Gavrilov (3):
      gitk: Kill back-end processes on window close.
      gitk: Register diff-files & diff-index in commfd, to ensure kill.
      gitk: On Windows use a Cygwin-specific flag for kill.

 gitk |   79 ++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 53 insertions(+), 26 deletions(-)
