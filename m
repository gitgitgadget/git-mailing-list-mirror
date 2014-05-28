From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 0/1] check_refname_component: Optimize
Date: Wed, 28 May 2014 17:04:14 -0400
Message-ID: <1401311055-480-1-git-send-email-dturner@twitter.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed May 28 23:04:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpl1m-00022r-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbaE1VEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:04:46 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:42922 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbaE1VEp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 17:04:45 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so19786286qga.28
        for <git@vger.kernel.org>; Wed, 28 May 2014 14:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Pj++Mcd5GXHnleDqvnGntADCBSzmiX+5E0bYohf7I+o=;
        b=HALZx2SezVCL/pHsh5H9weDJn5DK64OBSKMjCTKKui660CEQwhmpzalxNfvUI72CMJ
         zYPHvb2TV62Vj7iTBxU3PQFrqoK5JWt6n+YXMm+SXKlVxxVxYy5pVMGWhECVV4nPmv0+
         DIyAP//eF79voPmxLmk116xgiXD3ZDNya0bFrenm3bnshPO7xFGk8R5wT4tzwEtQImGV
         MF25bg91sMYKH6Q/SL7TvPGrh5x/rxmSDW5j+jwCk0NgOAjiWeKNP3J/pHxCC/SzGCnp
         adYJ6WWXfsCjmLOxkTPMJLOH/M+ucWWo/7Peet+xdbi2INnBtDO3tsU1Mu0pXcW2q8ox
         vVkQ==
X-Gm-Message-State: ALoCoQnWMnun36U3m4CTMeqqZ4t7ap4rkUE59+Y/9dxd1yu5WltftGSvNIzduLlOEVaaj9zVo7tp
X-Received: by 10.224.147.80 with SMTP id k16mr3613392qav.40.1401311085000;
        Wed, 28 May 2014 14:04:45 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id 91sm12856578qgp.41.2014.05.28.14.04.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 May 2014 14:04:43 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.18.gf763c0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250328>

I just tested the previous patch on a Mac with clang and it needed
some tweaks.

Also, I should clarify that this represents a real use-case: we really
do have tens of thousands of branches on some repos.  It would be nice
if people would clean up after themselves, but they don't.

(Also, it's probably worth adding a shortcut for HEAD at some point,
since that is the most-commonly-used ref, but that's for a later
patch)
