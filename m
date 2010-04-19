From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] t5704 (bundle): add tests for bundle --stdin
Date: Mon, 19 Apr 2010 03:03:03 -0500
Message-ID: <20100419080303.GA23609@progeny.tock>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100419071449.GA23166@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 10:03:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3lwx-0006UW-9u
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab0DSIC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 04:02:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54150 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab0DSICz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 04:02:55 -0400
Received: by pva18 with SMTP id 18so2819744pva.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=caeemK9UVJUnl13y8kolhdgEoUu2FQGRKuf4sFc0cn4=;
        b=cVHU8McPCzpsNjQixzlz3WnE82iaRJnYxtyS1SyLwaH7fSAmUZzkMulWlwdL5S13o8
         t5UPMpzNY7pjC5MJIuWHxaVDFiXxSkcj3fSNDgTyQxi3QwT45f+kHdo7vugQDiJexTKY
         nAknUBms0KX6HXWJA0LKvr+VpLoWA6pO4d8xM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MjTSpM0OX/P36WfjpPPkIWaUIdwQSNwmh0CrZ+rKufXAYommEWyDtq+3+iyn0iPSr/
         epikb6CjI4p2lGoXcW1rCRcSoCAhMijFkZ2Pk5u7YlbSJxWPXdfOA/wIc8GE0Ku0BqAW
         jJ442SwVNk0LE2Ni7Jq+mM/AL+umHXGCFUnqQ=
Received: by 10.141.88.2 with SMTP id q2mr1829265rvl.241.1271664175105;
        Mon, 19 Apr 2010 01:02:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4744712iwn.3.2010.04.19.01.02.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 01:02:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100419071449.GA23166@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145275>

As long as no rev-list arguments are supplied on the command line,
git bundle create --stdin currently segfaults.  With added rev-list
arguments, it does not segfault, but the revisions from stdin are
ignored.

Thanks to Joey Hess <joey@kitenet.net> for the report.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5704-bundle.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index a8f4419..1154a4e 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -30,4 +30,20 @@ test_expect_success 'tags can be excluded by rev-list options' '
 
 '
 
+test_expect_failure 'bundle --stdin' '
+
+	echo master | git bundle create stdin-bundle.bdl --stdin &&
+	git ls-remote stdin-bundle.bdl > output &&
+	grep master output
+
+'
+
+test_expect_failure 'bundle --stdin <rev-list options>' '
+
+	echo master | git bundle create hybrid-bundle.bdl --stdin tag &&
+	git ls-remote hybrid-bundle.bdl > output &&
+	grep master output
+
+'
+
 test_done
-- 
1.7.1.rc1
