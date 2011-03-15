From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] tests: protect against GIT_ATTR_NOGLOBAL from environment
Date: Tue, 15 Mar 2011 01:56:17 -0500
Message-ID: <20110315065617.GA29530@elie>
References: <20110315064909.GA25738@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Petr Onderka <gsvick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 07:56:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzOBB-0007gv-RA
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 07:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab1COG4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 02:56:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38751 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab1COG4X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 02:56:23 -0400
Received: by gwaa18 with SMTP id a18so112971gwa.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ot/iG0BE+RJnxN6sQw3ozn7rBlsZMgErRtTZmYRbOiM=;
        b=cj+GyS9oegxONC6YWzWGUMzjbsnn2nLhBPbVvzZyS0i9qK96cqrgN9bjREOVU0w4x1
         HoPSwVwfHbfkU+eC+ejbHD50ptSW9IoL+kpy3DbV9OkGJt9gf2myKCxGIF73SI1q5+8W
         mVZJwNmjDnLD9bRn61S9buEOVjkI4QRtXAWgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N4VXVsFBzNiXB/8p+XA4VhcdC8bsST0GCEOtdR/WcgoDTavIKTPPZoTMEIfiYDyvFx
         TK5YeEjh3ohJXQLVbpoSlnPcDg/Svr2U4CitRKzuSjMoaYSC4fTjkedziqHLhSendAe0
         BXH0aV9H0wvcfT4VDs5F1g71q07ccwSIQORiM=
Received: by 10.150.1.1 with SMTP id 1mr6941605yba.151.1300172182558;
        Mon, 14 Mar 2011 23:56:22 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id v35sm2592656yba.4.2011.03.14.23.56.21
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 23:56:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315064909.GA25738@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169046>

The GIT_ATTR_NOGLOBAL environment variable simulates a totally clean
environment with no ~/.gitattributes present.  The intent is to
make test results more easily reproducible, but it currently has
the opposite effect --- if GIT_ATTR_NOGLOBAL is set to 1, t0003.3
(core.attributesfile) fails.

Unset GIT_ATTR_NOGLOBAL in the affected test script.  test-lib already
sets $HOME to protect against pollution from user settings, so this
should be safe.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0003-attributes.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index ebbc755..3cfc824 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -18,6 +18,7 @@ attr_check () {
 
 test_expect_success 'setup' '
 
+	sane_unset GIT_ATTR_NOGLOBAL &&
 	mkdir -p a/b/d a/c &&
 	(
 		echo "[attr]notest !test"
-- 
1.7.4.1
