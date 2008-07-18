From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 3/3] gitk: On Windows use a Cygwin-specific flag for kill.
Date: Fri, 18 Jul 2008 09:47:40 +0400
Organization: TEPKOM
Message-ID: <200807180947.40515.angavrilov@gmail.com>
References: <200807180944.48570.angavrilov@gmail.com> <200807180945.43504.angavrilov@gmail.com> <200807180946.43560.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 07:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJipk-0002N6-E6
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 07:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbYGRFrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 01:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYGRFrt
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 01:47:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:4474 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYGRFrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 01:47:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so78739nfc.21
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 22:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LN12ze92JeEPsgCR3w1R+bU8khOkopknAiEoXK9j0sA=;
        b=ASw4gq2rpynyHSihT1NLO4NX18N0UA4eoU+7s9vhmZye+oGgDpL0bUFY9xhgTqrsNj
         NT6PlCZ1q/51D3p397dLucKFQriVGtG0aGJZm6wJHSs1v8EGsjFxxAUFnXDU/9rwwwBj
         OewoCgiVROpIEz+YT2H5cT+HT41Yl7HsvT6iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=g0Tna5NyLyJGnEwPMDEexyi7wsP9nuPyVRcjMxJTlPAOiHfLbMBYaF1gECImOLPONj
         C5Gjwl7Qa9rfDS8dWEqhB5KkozYNnyOcqO/QdLMTvpg/7G04MiOK12ClKN/PGvCV9Dpx
         u0S8BSRIS1WjudlkEJYd8+d8gDOnbdBo9mluE=
Received: by 10.210.46.12 with SMTP id t12mr1896779ebt.23.1216360067353;
        Thu, 17 Jul 2008 22:47:47 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id y37sm1148705iky.8.2008.07.17.22.47.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 22:47:46 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807180946.43560.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88990>

MSysGit compiles git binaries as native Windows executables,
so they cannot be killed unless a special flag is specified.

This flag is implemented by the Cygwin version of kill,
which is also included in MSysGit.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index b523c98..d7fea26 100755
--- a/gitk
+++ b/gitk
@@ -388,7 +388,12 @@ proc stop_instance {inst} {
     set fd $commfd($inst)
     catch {
 	set pid [pid $fd]
-	exec kill $pid
+
+	if {$::tcl_platform(platform) eq {windows}} {
+	    exec kill -f $pid
+	} else {
+	    exec kill $pid
+	}
     }
     catch {close $fd}
     nukefile $fd
-- 
1.5.6.2.39.gd084
