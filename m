From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] clone: detect extra arguments
Date: Thu, 29 Oct 2009 03:10:30 -0500
Message-ID: <20091029081030.GA11213@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 09:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Pvz-0004Bc-As
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 09:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbZJ2IA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 04:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbZJ2IA2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 04:00:28 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:59417 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZJ2IA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 04:00:28 -0400
Received: by yxe17 with SMTP id 17so1446492yxe.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=N0MlkHxKGJgNEwy2DrD6yak2q8WnBpgB7LMK+PNz58k=;
        b=aB8BQWyivg20WP/eEf36CnUSvF+VS8FuXyYC/L15m2PCtZ5kx01wS1EEuRxeBUP6Et
         MbyEqKblK4DCCM5r2/YNE3Sn744maGDpYm4uDMP654IW0MPpxhiC8JzYnOQde6OGVRSB
         xEbhMDSWMEkBwtngpQ3yXmBqA3VmXSVCQkTww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=g4Wf2rvDp8NJrmJDMVB/ahSfKKtue9ReQjfsaTTDdB3QUhpSF+7JRwPxIuRqXt/lCE
         qgLI40NgmJjjMgN/3aIS5QQDc+fmjGAhvJwvaIDYwr/PkIe+6dUdOpNO85FzROMCaKdD
         gxXnPeyrbj0hJqVVtI1ZUseos/kiyJoy+1kss=
Received: by 10.150.170.2 with SMTP id s2mr5740523ybe.222.1256803232804;
        Thu, 29 Oct 2009 01:00:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm835748gxk.10.2009.10.29.01.00.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 01:00:32 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131573>

If git clone is given more than two non-option arguments, it
silently throws away all but the first one.  Complain instead.

Discovered by comparing the new builtin clone to the old
git-clone.sh.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-clone.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 5762a6f..76ad581 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -377,6 +377,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
+	if (argc > 2)
+		die("Too many arguments.");
+
 	if (argc == 0)
 		die("You must specify a repository to clone.");
 
-- 
1.6.5.2
