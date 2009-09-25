From: Christian Himpel <chressie@googlemail.com>
Subject: [PATCH 2/2] git-am: force egrep to use correct characters set
Date: Fri, 25 Sep 2009 17:17:31 +0200
Message-ID: <dc8a4205128d65e69587292a42c714792315a9df.1253891124.git.chressie@gmail.com>
References: <d7d039c304614d8d39fd2e7ad8d036a77121cc4f.1253891124.git.chressie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 17:17:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrCYF-0001TC-KB
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 17:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZIYPRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 11:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbZIYPRa
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 11:17:30 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:44309 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbZIYPR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 11:17:29 -0400
Received: by fxm18 with SMTP id 18so2278420fxm.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LI+FFLz/dvl6zjaudYzRAaDkW+BrypBDInZDxRv6W50=;
        b=mfxtq6sQdT2tRG58XwWzVwpgOTKvPbKBXqE6aLSy0u0tEXPzeMmbtlftM7B2K6GXsb
         ClyZ5iW1Z/gpcuzxz68GBAKbrAW5kWfSyKf6S996l7gy2EmK5/9jTx4FtWZ6IbgCdehc
         5w7GHI+cQSyKQ9b3Ft1oqAq+9SieuH40e6o6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HwhEh8x4DHZN8COK07FfU2O6WqbYXvx0gGQxRletHTYs7QQsjVlSUWS4swyVhQDZFc
         +XOxDEqjJFf1KoFEZH+3wjYoGHgVwRuxq9MNErGx2B18u4ONRrd6idPPMHfM/qwBEgzb
         Vo3uRwILEN06mZpnYbs8SNpFMP1iWEfQP2q4g=
Received: by 10.204.143.139 with SMTP id v11mr222568bku.95.1253891852792;
        Fri, 25 Sep 2009 08:17:32 -0700 (PDT)
Received: from mrslave (HSI-KBW-078-043-091-043.hsi4.kabel-badenwuerttemberg.de [78.43.91.43])
        by mx.google.com with ESMTPS id 28sm801449fkx.58.2009.09.25.08.17.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 08:17:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d7d039c304614d8d39fd2e7ad8d036a77121cc4f.1253891124.git.chressie@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129091>

According to egrep(1) the US-ASCII table is used when LC_ALL=C is set.
We do not rely here on the LC_ALL value we get from the environment.

Signed-off-by: Christian Himpel <chressie@gmail.com>
---

I don't know if this kind of patch is desired, but according to egrep(1)
it's not reliable to use the range expression with different character
sets than US-ASCII.

So this patch forces the usage of US-ASCII.

Regards,
chressie


 git-am.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 0ddd80f..e4dd49a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -204,9 +204,13 @@ check_patch_format () {
 			# discarding the indented remainder of folded lines,
 			# and see if it looks like that they all begin with the
 			# header field names...
+			_tmp_locale=$LC_ALL
+			export LC_ALL=C
 			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
 			egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
+			export LC_ALL=$_tmp_locale
+			unset $_tmp_locale
 		fi
 	} < "$1" || clean_abort
 }
-- 
1.6.4.4
