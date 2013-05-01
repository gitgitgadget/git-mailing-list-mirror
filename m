From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: [PATCH 0/2] Better advice on merge
Date: Wed,  1 May 2013 16:52:05 +0530
Message-ID: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
Cc: Vikrant Varma <vikrant.varma94@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 13:24:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXV8x-0004hd-UK
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 13:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3EALYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 07:24:12 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:52599 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab3EALYL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 07:24:11 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so632553dad.1
        for <git@vger.kernel.org>; Wed, 01 May 2013 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=wpqYyBlAOW2Tfd1Z5kbUqSjBIMDrhcqU4u1oAZlgayA=;
        b=FnkR2UHfeF1IukUAw6HrT3jvpvfTPdepVLAmOKmrpjofucp7okAA4aJqALKJISYhXa
         sCu/mslAHw6Q64DdUP0la8/2iH4zByhJqcs4j+ZhgaizqSS4PajIcb9pAKFeCNNY/b/a
         1uDTkboeJ7Mwh9t2NAKlba3HDID+vOi53u07r+WceyoMWfyGs4Sj/1/kH9YuRRSDxrV9
         0EbXEBofxNufKvTJzirlC67DcIhbLo1f+rT9VyNVDgW7foSWs+FGVaj/T/VBLg56f+ci
         X4aaS9qXXQIWv80a9kRzlHSRuQCeSxkR0tMfD/MqvZw9f7LWB+FGq6uOcPfyVvNbCAyo
         LeKw==
X-Received: by 10.66.233.34 with SMTP id tt2mr4346862pac.160.1367407450548;
        Wed, 01 May 2013 04:24:10 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-59.183.189.195.mtnl.net.in. [59.183.189.195])
        by mx.google.com with ESMTPSA id ea15sm3299675pad.16.2013.05.01.04.24.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 04:24:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3-rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223086>

If origin/foo exists, but foo doesn't:

   $ git merge foo
   fatal: foo - not something we can merge

This patch series improves the error message. If a remote branch exists 
with the same name, it now says:

     $ git merge foo
     fatal: foo - not something we can merge

     Did you mean this?
     	 origin/foo

It does this by adding a new help function, help_unknown_ref, that takes 
care of printing the more friendly error message, and modifies builtin/merge.c
to use it. In the future, this could also be extended to other operations
involving branches that don't exist locally, instead of providing blanket
failure error messages (eg. git checkout foo).

Vikrant Varma (2):
  help: add help_unknown_ref
  merge: use help_unknown_ref instead of die

 builtin/merge.c |  4 ++--
 help.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 help.h          |  6 ++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

-- 
1.8.3-rc0
