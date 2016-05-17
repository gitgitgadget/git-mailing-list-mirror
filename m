From: Eric Wong <e@80x24.org>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Tue, 17 May 2016 09:13:42 +0000
Message-ID: <20160517091342.GA10180@dcvr.yhbt.net>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
 <20160513103621.GA12329@dcvr.yhbt.net>
 <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 11:13:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2b4W-0000D9-9T
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 11:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbcEQJNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 05:13:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49710 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078AbcEQJNn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 05:13:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105AA1FA7A;
	Tue, 17 May 2016 09:13:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294862>

Lars Schneider <larsxschneider@gmail.com> wrote:
> I am no expert in "fast-import". Does anyone have a few hints how to
> proceed?

I don't know fast-import or the C internals of git well at all,
either.  But capturing the exact input to fast-import (using
tee) would be useful for non-p4 users to debug the problem
and would go a long way in reproducing a standalone test case.

I'm Python-illiterate , but hopefully this works
to capture the stdin fed to fast-import (totally untested):

--- a/git-p4.py
+++ b/git-p4.py
@@ -3366,7 +3366,8 @@ class P4Sync(Command, P4UserMap):
 
         self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
 
-        self.importProcess = subprocess.Popen(["git", "fast-import"],
+        cmd = [ "sh", "-c", "tee /tmp/gfi-in.$$ | git fast-import" ]
+        self.importProcess = subprocess.Popen(cmd,
                                               stdin=subprocess.PIPE,
                                               stdout=subprocess.PIPE,
                                               stderr=subprocess.PIPE);
