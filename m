From: Pascal Obry <pascal.obry@gmail.com>
Subject: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Thu, 24 Jan 2008 19:13:59 +0100
Message-ID: <1201198439-3516-1-git-send-email-pascal@obry.net>
Cc: gitster@pobox.com, Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 19:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6b1-0005cs-3a
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbYAXSOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 13:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYAXSOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:14:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:32071 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbYAXSOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:14:07 -0500
Received: by fg-out-1718.google.com with SMTP id e21so316027fga.17
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=Ww0rQm/ZQjfbeRV6KUwW6BZrTzVWIJzPLSK0mvgIed0=;
        b=lv0KgOr6oBwBFwsn7xLujLGUWx/F6YZ0OkZRegzFkvHsMOMsOL57vzIrDwZF+/kc1LiTOTxMtRH+vKb9ESp+ONVxLezhiniS1Er5L46UfEG0Ftap2ezoEg8t4Kd0KGzvDbC6x7jnP2/W52cfZsSNm6neM2BMj9+58caCuMk5YS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=PFiHhG4FwzO+s6D7VKDXiJ6zN8LL+ZBIEVIap8T/Fy4ij2vIWdKmhhGmMFVZ9QiktXfysecMdF8+AGOtF9c2KXpWH653Bb+t2py8nXgSiUw9o/7Tuv5p980Xymsjme7WVcppphq482tkFePlmBMg8eki8vUMsAB8gjZ1yQ2QbOI=
Received: by 10.82.187.2 with SMTP id k2mr1780012buf.16.1201198445783;
        Thu, 24 Jan 2008 10:14:05 -0800 (PST)
Received: from pascal.obry@gmail.com ( [82.120.149.190])
        by mx.google.com with ESMTPS id v23sm2188927fkd.1.2008.01.24.10.14.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 10:14:03 -0800 (PST)
Received: by pascal.obry@gmail.com (sSMTP sendmail emulation); Thu, 24 Jan 2008 19:13:59 +0100
X-Mailer: git-send-email 1.5.4.rc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71639>

It happens from time to time to type -amend (with a single
dash) when --amend is meant. In those case there is no mistake
and git commit all files modified with the log message set
to "end". As -amend is just doing something stupid it is
better to check for this wrong usage and give hint to the
user about the possible mistake.

Signed-off-by: Pascal Obry <pascal@obry.net>
---
 parse-options.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 7a08a0c..248515d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -233,6 +233,13 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			continue;
 		}
 
+		if (!strcmp(arg + 1, "amend")) {
+		        error("-amend looks suspicious, don't you meant --amend\n");
+		        args.argc--;
+		        args.argv++;
+		        break;
+		}
+
 		if (arg[1] != '-') {
 			args.opt = arg + 1;
 			do {
-- 
1.5.4.rc4.23.gcab31
