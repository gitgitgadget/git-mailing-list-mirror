From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v2] Fix testcase failure when extended attributes are in use
Date: Mon, 13 Oct 2008 22:10:16 -0400
Message-ID: <20081014021016.GB14994@riemann.deskinm.fdns.net>
References: <20081011154107.GA14994@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, heikki.orsila@iki.fi
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 04:14:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpZQd-0007cE-8i
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 04:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbYJNCNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 22:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbYJNCNR
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 22:13:17 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:2676 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbYJNCNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 22:13:16 -0400
Received: by yw-out-2324.google.com with SMTP id 9so470017ywe.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 19:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=hbs0skb742AYwtUBhytHEU6Vb0RQYATSmboEECL+yyk=;
        b=X3JGpXQqmjF+hkahfPyXTG3j7ttjnYfYNjjk6oMgm71xIn7x56H0OQAzu3bmb2WD3k
         7NS0O2fGpD3pMPT0mfhWbOuUIwoYbI7XT7ixUeVzI2n53XX0S31eAiLiMxURWvPn8RSy
         rg8ScacX8Sx9CUdFvl5DzayZcR+fAaf8A9viY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=CafxNHx6MOC0NUJC4f1/ZjzFcj1uUMrZKx2lgDiLC+uoUpP20YWHbBhLmEL3SGU/0+
         zmX7igU+SCYoy2zISE4MsHgqRagyLYTeYqBHniJlKTEIOfHrDtRkFwGL8LW36DDCRkCB
         2ql4EGxRScdJiaQ+hsZYMW4inFXmBJ+wasFcQ=
Received: by 10.151.45.6 with SMTP id x6mr9270235ybj.110.1223950394311;
        Mon, 13 Oct 2008 19:13:14 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id d25sm12429337elf.17.2008.10.13.19.13.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 19:13:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081011154107.GA14994@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98170>

06cbe855 (Make core.sharedRepository more generic, 2008-04-16) made
several testcases in t1301-shared-repo.sh which fail if on a system
which creates files with extended attributes (e.g. SELinux), since ls
appends a '+' sign to the permission set in such cases.  This fixes the
testcase to strip any such sign prior to verifying the permission set.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
...and then I discovered Documentation/CodingGuidelines: no ? in regular
expressions.  I really need to learn these shell variable-manipulation
builtins.

Apologies if for some reason the previous version got used, I haven't seen it
anywhere, however.

Deskin Miller

 t/t1301-shared-repo.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index dc85e8b..4d2db62 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -84,6 +84,7 @@ do
 		git update-server-info &&
 		actual="$(ls -l .git/info/refs)" &&
 		actual=${actual%% *} &&
+		actual=${actual%+} &&
 		test "x$actual" = "x-$y" || {
 			ls -lt .git/info
 			false
@@ -97,6 +98,7 @@ do
 		git update-server-info &&
 		actual="$(ls -l .git/info/refs)" &&
 		actual=${actual%% *} &&
+		actual=${actual%+} &&
 		test "x$actual" = "x-$x" || {
 			ls -lt .git/info
 			false
-- 
1.6.0.2.514.g23abd3
