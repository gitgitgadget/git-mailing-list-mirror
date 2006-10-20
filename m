From: Liu Yubao <yubao.liu@gmail.com>
Subject: hooks--pre-commit: chomp() in cygwin perl does not strip "\r"
Date: Fri, 20 Oct 2006 14:14:06 +0800
Message-ID: <4538692E.6030404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 20 08:14:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ganek-0001hu-Kz
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 08:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992509AbWJTGOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 02:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992510AbWJTGOw
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 02:14:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:40545 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2992509AbWJTGOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 02:14:51 -0400
Received: by wx-out-0506.google.com with SMTP id h28so871241wxd
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 23:14:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=BbIIMWdZiDP8+4EmQ/Y/UaSPBo50JbG069P7Qq0N8t0i8tg3RcVHekypjLpf1fPXF6GrhzgJe2ZZqn4wOgo9S7DeLn6hTQMe9aPBO8ksw1hF6fGSqXQ9rn3e2ujW7rVHlG2jINpvt7DM3lV6E14cczcnR+EbLOEHvCFJhXbMTl4=
Received: by 10.90.54.20 with SMTP id c20mr764894aga;
        Thu, 19 Oct 2006 23:14:51 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id 24sm671163wrl.2006.10.19.23.14.49;
        Thu, 19 Oct 2006 23:14:50 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29411>

perl v5.8.7 built for cygwin-thread-multi-64int, its chomp() doesn't strip
trailing "\r" so that pre-commit reports "trailing whitespace" for every line.
ActiveState Perl v5.8.8 can strip "\r" and "\n" properly.

Changing
	if (/\s$/) {
to
	if (/[:blank:]$/) {
is also ok.

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 723a9ef..6a55612
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -54,7 +54,7 @@ perl -e '
         }
         if (s/^\+//) {
             $lineno++;
-           chomp;
+           s/[\r\n]+$//;
             if (/\s$/) {
                 bad_line("trailing whitespace", $_);
             }
