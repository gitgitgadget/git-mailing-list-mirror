From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [GUILT] [PATCH 4/7] Handle empty patches and patches with only a
 header.
Date: Tue, 15 Jan 2013 18:28:27 -0800
Message-ID: <20130116022827.GM12524@google.com>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:28:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIkG-0001c2-S0
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab3APC2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:28:32 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:59505 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab3APC2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:28:32 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so424909pbc.16
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KxjHyNYDwVjYL2HjUx2BYzFDxwuXVqrPRQZUR1IlzyU=;
        b=TbwrZ75yLx4kgeMdqKcvbH8MBMR6moSjD3nAS0c7q1PWI9NuUcfh8EbfoL/LhbTCsr
         iUvpg+K9K0xc0kZtlsb+nvKtinZQjQvFD517gD/sOtc4RdDcVKnTXukDRjcj4jZqK25o
         SrsFamNEoPYLUR0JV37+o0Ad51a8abGAOcAzR4Kb1MB+Rg9hFChKsMCWramVcIAivXQu
         eQHt/C3nPgsJJ4QnfLuSUawITZaRqmBF4Ii9ZKp7KM83ccJWe/rQR1zCyfOF56uSA/JD
         SPhQ+MQPoWM4PCEJT7aGQ99Jcrza4ETC8Fszmu9ddLhbDsR1NxzWYJ/1t8a2o6/z/h7G
         KdHQ==
X-Received: by 10.68.231.10 with SMTP id tc10mr267766295pbc.81.1358303311786;
        Tue, 15 Jan 2013 18:28:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id rk6sm11292631pbc.20.2013.01.15.18.28.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:28:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213712>

From: Per Cederqvist <cederp@opera.com>
Date: Mon, 30 Apr 2012 12:29:55 +0200

"git apply --numstat" in Git 1.7.10 gives an error message unless the
patch contains a diff, so don't attempt to apply it unless we find a
'^diff'.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Acked-by: Jeff Sipek <jeffpc@josefsipek.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 guilt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt b/guilt
index 7f6806e..5bcc498 100755
--- a/guilt
+++ b/guilt
@@ -611,7 +611,7 @@ push_patch()
 		cd_to_toplevel
 
 		# apply the patch if and only if there is something to apply
-		if [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
+		if grep -q '^diff ' "$p" && [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
 			if [ "$bail_action" = abort ]; then
 				reject=""
 			fi
-- 
1.8.1
