From: Joshua Juran <jjuran@gmail.com>
Subject: Git, C89, and older compilers
Date: Tue, 31 Mar 2009 12:26:57 -0700
Message-ID: <9D199AAA-5EC6-4E7C-AC26-0CDA68341D00@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 21:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LojdV-0002li-TR
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 21:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbZCaT1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 15:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZCaT1G
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 15:27:06 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:14350 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZCaT1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 15:27:03 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3338775wff.4
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:mime-version:content-type
         :message-id:content-transfer-encoding:from:subject:date:to:x-mailer;
        bh=IrVPwnvh/M4bJ3ROn3d4BeiFhFy81K+4pCalYC2IdLU=;
        b=Wglnn7LGdxX8eTJ/cVQ8akiacSOMcSJQj7BMlntWD95UwMU7+6BKmyZ4Tr9FftIdoa
         GJCZQBhPAEwUfksDRWqsSwVUtlLLiLGRm92x7BvFJPAmhF0obPzwkHOa3KLve6mrYWcP
         XYVErYTrchuLcBCkfmOnT4Gc1T67m4GHalVZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:content-type:message-id:content-transfer-encoding:from
         :subject:date:to:x-mailer;
        b=Vf3afcqOW3y+nakNWun8kROqeG5r6Cj+q3rTBUwDQ+E77229OHkrayu6OJe7JXev6l
         MATFW5x0c0eFojSaZUOEZMHGBmYbUhE34XCqW4HBvKLssSCOW502pU04Hag8XI9bGwOQ
         1G795fm/W+7HZYR7zdSS0VJGP5n3SEC4A55eI=
Received: by 10.143.31.4 with SMTP id i4mr2758143wfj.102.1238527621787;
        Tue, 31 Mar 2009 12:27:01 -0700 (PDT)
Received: from ?192.168.1.24? (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 32sm11614667wfc.9.2009.03.31.12.27.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 12:27:00 -0700 (PDT)
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115301>

Hello,

I'm porting Git to Lamp (Lamp ain't Mac POSIX), a Unix-like  
environment which runs in classic Mac OS, much like Cygwin.

One of the complications I've run into is that Metrowerks C 2.4.1  
(released in 2001) doesn't support some of the constructs git uses,  
such as initializing an aggregate's member with the address of a  
local variable, illustrated by the patch below:

diff --git a/builtin-commit.c b/builtin-commit.c
index 46e649c..8b98547 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -605,7 +605,8 @@ static int prepare_to_commit(const char  
*index_file, const c

         if (use_editor) {
                 char index[PATH_MAX];
-               const char *env[2] = { index, NULL };
+               const char *env[2] = { NULL, NULL };
+               env[0] = index;
                 snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s",  
index_file);
                 if (launch_editor(git_path(commit_editmsg), NULL,  
env)) {
                         fprintf(stderr,

Is git intended to compile on a C89 compiler?  In any case, if I  
produce a complete set of patches, will they be applied?

Josh
