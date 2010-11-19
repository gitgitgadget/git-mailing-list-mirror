From: Dowlin Yang <dowlin0820@gmail.com>
Subject: how git pull works?
Date: Fri, 19 Nov 2010 23:15:51 +0800
Message-ID: <4CE3FBA5-3DF0-493F-9600-6D424B5CBA2F@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 19 16:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJShW-0008Sy-SN
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 16:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab0KSPQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 10:16:30 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37217 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab0KSPQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 10:16:29 -0500
Received: by gyh4 with SMTP id 4so2724457gyh.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 07:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=uBsvaYQwnlMY2e8EK5YuCkcpFpb6vo9Yog44pHgPbyA=;
        b=ElUqkg9ZcxdewQr3EF0PjIexC6YQASWhYPk2oDx4DDZ/JQCW6UdSQB84atik78bFn9
         0sjv59lCqXPQWnSmdpNcwfiMYnJnULbUY4JIOC+rUefKNt9TxHRJzT0Why635h5aGv0X
         nmQ372JgK0ZWCU3HMm3kYTSwQ8fz1gKepdi6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=mlDH4rjQ6m7NXE4RWWDiyeb+fiPeBcgrLFdmNgkxzgg6DHEc0Eq2iZgTFlldwGlVfb
         HUc+XEGYW1cf+ZOQBs82MhBsgK98GyQoXzVU8tnM1Fc3g3YXeYN8mrdLbUvenbuaSOjw
         B9Elpkli/Oh/aX4x1U471wIiETbXhuVcmpkoM=
Received: by 10.42.171.196 with SMTP id k4mr1731608icz.431.1290179787372;
        Fri, 19 Nov 2010 07:16:27 -0800 (PST)
Received: from [192.168.1.103] (114-37-162-150.dynamic.hinet.net [114.37.162.150])
        by mx.google.com with ESMTPS id d21sm1624355ibg.9.2010.11.19.07.16.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 07:16:27 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161755>

Hello

I sent an email earlier but it seems rejected. I resent again with plain text format. I am sorry for any inconvenience if you receive my messages twice, and please read the new one.

We have been using git for a while and it always works like a magic. We have several teammates and each of us may work on one or multiple branches at the same time. Sometimes one person may have to merge another's branch for getting the latest version. We always use git pull origin branch-name to get the remote branch merged and it always works nicely until recently we face a problem that we cannot figure it out. The following is the scenario we faced.

Suppose A had a branch b1 and B had a branch b2. They work on their own branch separately but b1 and b2 share the same file f1. Suppose A made a few changes to f1 on Nov 5th. Here are A's changes:

======= In branch b1, changes that were made by A on Nov 5th


@@ -1,6 +1,6 @@
 <?
 $COMMON_JS = array(

-    'lib/jquery-1.3.2.min.js'
,
+    'lib/jquery-1.4.3.min.js',

     'lib/jquery-ui-1.7.2.
custom.min.js',
     'lib/jquery.metadata.js',

     'lib/jquery.form.js',


@@ -26,6 +26,7 @@ $JS = array(
         'files' => array(
             'com/categories.js',
             'com/searcher.js',

+            'com/category_
bar.js',
             'com/query_refiner.js',

             'com/fast_input.
js',
             'com/subscribe_form.js',    

@@ -50,6 +51,7 @@ $JS = array(
         'files' => array(
             'com/categories.js',
             'com/searcher.js',

+            'com/category_
bar.js',
             'com/product_image_loader.js',                    

             'com/tab_toggle.
js',
             'page.deal.js'
=======

A removed one line and added a few lines to f1 and then committed on Nov 5th. On the other hand, B made a few changes to f1 too on the next day Nov 6th. Here are B's changes:

======= In branch b2, changes that were made by B on Nov 6th



@@ -26,7 +26,6 @@ $JS = array(
         'files' => array(
             'com/categories.js',
             'com/searcher.js',

-            'com/category_
bar.js',
             'com/query_refiner.js',

             'com/fast_input.
js',
             'com/subscribe_form.js',    

@@ -51,7 +50,6 @@ $JS = array(
         'files' => array(
             'com/categories.js',
             'com/searcher.js',

-            'com/category_
bar.js',
             'com/product_image_loader.js',                    

             'com/tab_toggle.
js',
             'page.deal.js'
=======

B removed a few lines and then committed on Nov 6th. They kept updating other files in the following days. After a few days, we decide to merge A's branch b1 with B's branch b2. So A did git pull origin b2 in b1, and the expected resultant file is sth like this:

======== Expected resultant file
 $COMMON_JS = array(
-    'lib/jquery-1.3.2.min.js',

+    'lib/jquery-1.4.3.min.js'
,
     'lib/jquery-ui-1.7.2.custom.min.js',

     'lib/jquery.metadata.js',

     'lib/jquery.form.js',
.....

         'files' => array(

             'com/categories.js',

             'com/searcher.js'
,
-            'com/category_bar.js',

             'com/query_
refiner.js',
             'com/fast_input.js',

             'com/subscribe_
form.js',    

.....
         'files' => array(
             'com/categories.js',

             'com/searcher.js'
,
-            'com/category_bar.js',

             'com/product_
image_loader.js',                    
             'com/tab_toggle.js',

             'page.deal.js'



========

We expect com/category_bar.js will be removed and lib/jquery-1.3.2.min.js will be replaced by lib/jquery-1.4.3.min.js However, it did not work like we expected. Instead, com/category_bar.js are still there, and jquery is replaced. We wonder why it works like this. Aren't newer changes supposed to be applied? Why older changes are the final results? Perhaps we misunderstand git pull? Please enlighten us where we may make any mistake. Else we just feel like we cannot trust git pull. :(

Oh, I forgot to mention one thing in the above scenario. B's b2 branch had com/category_bar.js added earlier than A's b1. A manually added the same changes to b1 on Nov 5th, but later B decided to remove com/category_bar.js from b2 on Nov 6h as I described.

So, is it possible that git assumes com/category_bar.js are added twice and removed once, so it means the final result will be com/category_bar.js is added once? It is not easy to describe the scenario... Any help is appreciated! Thanks very much.

Huiting 