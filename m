From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule: Include check for objects when fetching
Date: Mon, 22 Feb 2016 14:35:47 -0800
Message-ID: <1456180548-20996-2-git-send-email-sbeller@google.com>
References: <1456180548-20996-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, dborowitz@google.com,
	jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXz6q-00085V-BB
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbcBVWhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:37:33 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34474 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051AbcBVWh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:37:27 -0500
Received: by mail-pa0-f54.google.com with SMTP id fy10so98016985pac.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 14:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KRjn8XrlrMniiLCfEWgcyMBee9l93loix+srNqeRKKg=;
        b=D/tZM+DbhJ7ooNFTy64b/ILQiTSHkeACoLfUNTobqblTjSeScNP45zlN6Tt3LRyaHF
         KaokhkWvXQCLecJxIJzMQ9yUNlpNm9FspDMlYvWR+8sDW4VSMMpBGehoOievA0AKC20Y
         RRVS4FXCIAagpW/wrqi3wwqjywGYQ1z5dEcRBGfy37cS1AiR1P2n6zcvYgMBaufkA96s
         WCj2Au3axi4VWC9WV3h3FdQtw8NedgSvVrpBdJHe+1dwOJlOF9zSpYO5ig4xgVz7xpHb
         bB5H5CFDdot23WN2j5jJDzlU0ouLn3MreW0ok9c/h6Aq2ECyenz/FleE54mNDq9aSgW/
         JALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KRjn8XrlrMniiLCfEWgcyMBee9l93loix+srNqeRKKg=;
        b=QKDAiqLlj9BPyxqq4srJdGJi4bR29aA+jI2AgOR1/y22wpbkYCVguDh+KviwZEPO8z
         9Z6UX+oHRBqGlieWwIKv8epIzfO79phrB9LYkU+cDm7I2nbt0+uyFwluBIqW9XCakRAm
         Mj9s99PV/euvrj7CE+kPqPGziNOtAAfOOouwXrki8ad6qa31FqrKBh/urL9fJENQ++OQ
         +ZpVub3p/7qyFFc8EPgdiNcWlTB/5gje1prHZNt8oo2MYh64fUu1B3w2bQlIW8R1QF4t
         moJxN0wgNZijRRtdztlYkMRqBwdANAcM99In84551caJ+gIGlTAgbYUE75TdWNuO7sck
         6lUw==
X-Gm-Message-State: AG10YOQgyBrNSd9FrI98vkoHYjv+ZD8jv0dipt/Qh8u5M3/aFjx+SjN28TDOmv3ny/mCI/Sd
X-Received: by 10.66.147.164 with SMTP id tl4mr40715701pab.40.1456180647335;
        Mon, 22 Feb 2016 14:37:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c420:8149:fd30:c3e3])
        by smtp.gmail.com with ESMTPSA id z67sm39093420pfa.71.2016.02.22.14.37.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 Feb 2016 14:37:26 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1456180548-20996-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286968>

Junio wrote:
> To be complete, the rev-list command line should also run with
> "--objects"; after all, a commit walker fetch may have downloaded
> commit chain completely but haven't fetched necessary trees and
> blobs when it was killed, and "rev-list $sha1 --not --all" would not
> catch such a breakage without "--objects".

By adding the --objects switch to rev-list we make sure to do a complete
check.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..f5d6675 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -746,7 +746,7 @@ Maybe you want to use 'update --init'?")"
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
 				(clear_local_git_env; cd "$sm_path" &&
-					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
+					( (rev=$(git rev-list --objects -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 			fi
-- 
2.7.0.rc0.34.ga06e0b3.dirty
