From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: [PATCH v2 0/2] Show suggested refs when ref unknown
Date: Sat,  4 May 2013 05:34:18 +0530
Message-ID: <1367625860-20746-1-git-send-email-vikrant.varma94@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Vikrant Varma <vikrant.varma94@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYPz8-0000jt-7c
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760550Ab3EDAFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:05:49 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:64900 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab3EDAFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:05:48 -0400
Received: by mail-da0-f51.google.com with SMTP id h15so965473dan.24
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=DXSYjxJ5jGTDke3Y1kDj25vm2I9sVLec1rKs6KFYXMc=;
        b=1CXSUvmHSb11JehcQdIYGlsoiKxKBcVsWN1KYlbCgCSKN5OqKGz7LQA39iRZ0NOltT
         FivSUFDAFBhWARKOM8n0rziYDEKJ6YD//WL73KodAoadUz6urN11xRmi+vrZOGIDhlnP
         0wtfQPiNOZsggacF5EOz/kkc69X8Y/dwbgj9n3OvXaEPX9YGkvtErbvXW7/xSBzqiQPN
         epsjCSINkqYZwJC3kMAquyxjocdRc9mxtXoi5lxmcCJU8qeLNls/AtyRKYahQkDhCm29
         OEPdAALUgJZQs6MclDw+lYI7Rl1sdg5mgl8G+vv6w5VPLYWhJZwMEkwkJ7PlhQHkdA28
         1BbQ==
X-Received: by 10.66.7.138 with SMTP id j10mr16755705paa.221.1367625948457;
        Fri, 03 May 2013 17:05:48 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-59.183.134.119.mtnl.net.in. [59.183.134.119])
        by mx.google.com with ESMTPSA id ea15sm14689710pad.16.2013.05.03.17.05.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:05:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223337>

If origin/foo exists, but foo doesn't:

   $ git merge foo
   fatal: foo - not something we can merge

This patch series improves the error message. If a remote branch exists with the
same name, it now says:

     $ git merge foo
     fatal: foo - not something we can merge

     Did you mean this?
     	 origin/foo

It does this by adding a new help function, help_unknown_ref, that takes care of
printing the more friendly error message, and modifies builtin/merge.c to use it.

This function can easily be used by other operations involving refs that don't
exist instead of providing blanket failure error messages (eg. git checkout foo).

Vikrant Varma (2):
  help: add help_unknown_ref
  merge: use help_unknown_ref

 builtin/merge.c |    3 ++-
 help.c          |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 help.h          |    5 +++++
 3 files changed, 57 insertions(+), 1 deletion(-)

-- 
1.7.10.4
