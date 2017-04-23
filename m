Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA8D207D6
	for <e@80x24.org>; Sun, 23 Apr 2017 06:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbdDWGVh (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 02:21:37 -0400
Received: from mail.aegee.org ([144.76.142.78]:58466 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755712AbdDWGVf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 02:21:35 -0400
X-Greylist: delayed 771 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Apr 2017 02:21:35 EDT
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org v3N69v7V005228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
        t=1492927798; i=dkim+MSA-tls@aegee.org; r=y;
        bh=VMr+Y60eepZarYV7BU4Pd4OrxiqQWw79GZ7Lki7EWlI=;
        h=To:From:Subject:Date;
        b=WMU0sqyxlGtaHV397SieU9VJ8ApaxwYU6+BMv485Fv7+KAHKBBAois/kuvnmie3et
         zZStdWTo8j513zpVPPH3XiIB/UfOA5gr48wSACz0uypkm9fzeZUi2xVc9R+jG3hMoA
         IiWx1xc66cgtM5PsTvgG1WSPTlsM4rHRTURHSjJaJbgWh6M4/Tg3biuWYxKEq8UPtn
         kse/HtZWiNweXboXBDVVhRFLneksCtJF5n/NF6Fb2e8dCO3hb9RD7gjcFwyOsTFMym
         7hqfph8kMsb27I5tIYlcLfnt5pyaV3mZQ3nejuyvyA2nsvi0+BZjAWrFykFM9Izsc3
         iX/zk/5LCnmbpDCkpgnhw2j2qHhy6llt1DonVEsiX3Oc4Lyrglm1tqn/FPRYfE1GQF
         pDuqDlTN2iaA4SSvLhysksyCEVb1ACDBxdvvRZsvuAvIZziWIaem21Dc8NX+LQqVgA
         EEdX+98Lf/MbMgVdWg/FmfcFrYLJbcKfSQL815JIq9s4oHS+jPxgN1qDLqqrSzW12F
         xL0sMYn6LiP7gREIUiNXkNeXiaa+DvrxGWALHP1rcBAssu2tyNTZW9pGWcfAxe92F0
         r1uqipVjjU7EBFGFFKIZd2g5atbLkZjThwyOjYz5SeNCOSalcZYHwtH4TeFPFvwB1/
         DLsXhnMdBR6G/y/DgEnLrwoE=
Authentication-Results: mail.aegee.org; dkim=none
Received: from [192.168.178.39] (x5f74eb01.dyn.telefonica.de [95.116.235.1])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id v3N69v7V005228
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 06:09:58 GMT
To:     git@vger.kernel.org
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Subject: git log --ignore-space-change -L start,end:file does not ignore
 indentation changes
Message-ID: <e18acd03-e10b-34b6-3883-bf91136bf299@aegee.org>
Date:   Sun, 23 Apr 2017 08:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

$ git version
git version 2.12.2.89.g49800c940

$ git init
Initialized empty Git repository in .git/

$ cat a.c
int main() {
  int result;
}

$git add a.c

$git commit -m I
[master (root-commit) ef9ab63] I
  1 file changed, 3 insertions(+)
  create mode 100644 a.c

$cat a.c  # now the indentation of result changed
cat a.c
int main() {
    int result;
    return 0;
}

$git commit -am J
[master 1bed130] J
  1 file changed, 2 insertions(+), 1 deletion(-)

$git -oneline -b -L:main:a.c
1bed130 J

diff --git a/a.c b/a.c
--- a/a.c
+++ b/a.c
@@ -1,3 +1,4 @@
  int main() {
- int result;
+   int result;
+   return 0;
  }
ef9ab63 I

diff --git a/a.c b/a.c
--- /dev/null
+++ b/a.c
@@ -0,0 +1,3 @@
+int main() {
+ int result;
+}

I expect that the result-line is not displayed as changed, when git log 
is called with -b.

Likewise:
git log --oneline  -b -L2,2:a.c
1bed130 J

diff --git a/a.c b/a.c
--- a/a.c
+++ b/a.c
@@ -2,1 +2,1 @@
- int result;
+   int result;
ef9ab63 I

diff --git a/a.c b/a.c
--- /dev/null
+++ b/a.c
@@ -0,0 +2,1 @@
+ int result;

Regards
   Дилян
