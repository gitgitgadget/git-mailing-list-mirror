From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made) (was ANNOUNCE
 git-what-branch)
Date: Fri, 24 Sep 2010 03:33:20 +0200
Message-ID: <4C9BFFE0.5040406@gmail.com>
References: <201009222326.o8MNQJ2E022410@no.baka.org>	<32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com> <AANLkTinw2bWWYD7UcS8P=uDJm8p3TGuWA133+BsnZPGH@mail.gmail.com> <4C9BC757.3050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 03:33:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyxAg-0003ib-Ro
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 03:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab0IXBdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 21:33:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46648 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab0IXBdY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 21:33:24 -0400
Received: by wyb28 with SMTP id 28so1481671wyb.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 18:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=M+Ndz0sai9cZi8EBOReyhIg6TEJfDhsdIySMbajj8YE=;
        b=OU0AaAbKyo1nUHfuek6SvMF91+ARaeonsA1gQmRW5cgDoL/jXlckfLik8HFMgVDiwi
         HX6Zjj1uLTckTN1NklCcxYAN1K9Pfzsvy4XG7i0LOYejr1diSSNqph1FnK4bnFCeykDu
         9Tqn6zAXRIM1p0WaoMcQAluwS3Ht+S5RFSxBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=MV9QRv4ElEVFg9qOBoreLN5Uktl7zwrj4sOe2jzlDo/8jjahIimkOVoRStjNvjivBL
         4n/h41axyD4jfFN2jocomUnA34Ek6cF2wY99ftgyYCSQNtyUbzDyLl5NW7za7V47olf7
         H+U7rl9l0Iwn/2hPNyZpMTxrgX1OgNTFOurAk=
Received: by 10.216.185.211 with SMTP id u61mr8957227wem.12.1285292002833;
        Thu, 23 Sep 2010 18:33:22 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-124-162.multimo.pl [89.174.124.162])
        by mx.google.com with ESMTPS id u32sm945203weq.11.2010.09.23.18.33.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 18:33:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <4C9BC757.3050803@gmail.com>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156931>

> There's still a bug in there somewhere; 

JIC someone actually wants to use that script -- you'll need this:

--- git-show-merge-path	2010-09-23 20:13:59.000000000 +0000
+++ git-show-merge-path	2010-09-24 01:09:10.000000000 +0000
@@ -90,21 +89,21 @@
         	desc[id] = 1;
 	 if (sizeof(commits[id]["parent"])>1)
             if (!desc[commits[id]["parent"][0]]) {
-	       mapping reached = ([]);
-	       if (commits[id]["Branch"])
-	          reached = commits[id]["Branch"]&branchnames;
 	       int comtime = (int)commits[id]["committer"][-2];
                write("%.12s %-56.56s %.12s\n", id, 
 	              squeeze_subject(commits[id][""][1]),
 		      cal->Second(comtime)->format_time_xshort() );
-               if (sizeof(reached)>0) {
-	          branchnames -= reached;
-                  write("# Merged into %s\n", 
-		          String.implode_nicely(indices(reached)) );
-		  if (sizeof(branchnames)==0)
-		     exit(0);
-	       }
 	    }
+	 if (mapping reached = commits[id]["Branch"]) {
+	    reached = reached&branchnames;
+            if (sizeof(reached)>0) {
+               branchnames -= reached;
+               write("# Merged into %s\n",
+		       String.implode_nicely(indices(reached)) );
+	       if (sizeof(branchnames)==0)
+		  exit(0);
+	    }
+	 }
       }
       m_delete(commits, id);
    }
