From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/10] git submodule update: pass --prefix only with a non empty prefix
Date: Wed, 16 Sep 2015 18:39:05 -0700
Message-ID: <1442453948-9885-8-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAv-0006Xn-VD
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbbIQBjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:39 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33375 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbbIQBjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:22 -0400
Received: by pacex6 with SMTP id ex6so4762373pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kKib2uhtCwcTUs1cuM0Sf9b6zd229qIul1jAmVx266Q=;
        b=aig4QKNtxm2p9Nrj+abWX4iv0Jt9FGjkkxeF/Ks2AT69MCKFDn2KN66oBtygZaor5L
         xlOSI2ZlQaV7pLBaEcRst3FCSuw5yFTDvIBg78pJx11HBkZvefVypcG9X99S0i4d+so/
         p31n/1/B5EIizLIcrOrsHjvIeXFcoYB84+P2p9KfmeCY1RlU0ukUEhEgtfsNXzSBVzY/
         3X+ZqrqabNAsORwawldUSKlorHZ+pYbGJDpbLuIXNhXAz0VWB9MZtk0PdPJSbegQWR9u
         5GBm/SrxZnRfWrpMbQNShiec+4QBSdEK14lKZDqGF2yFn4DOTJHBoV4CPnusozbEP2EB
         7oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kKib2uhtCwcTUs1cuM0Sf9b6zd229qIul1jAmVx266Q=;
        b=T+xEbsZxVS5BKZsXlZqCkv6zUMaCNe7/hCkVQBla9laWzTwHIhySuMhN9tjj7vTgDS
         bn7994R/gI44l29FcL/VaICAMlmHdq7w9p72OjM6y7pK5E5k/yGzhNt07BvpQKWhPbt1
         jtO5eCryyVBiOXPubtUtU0SlOoG9apmTWVl6Pn0mX9IEye32t/OhiASi+2Uf1uFBr+cF
         x0A+weAJ7XaD7aIb64jTTBVX7dV2LV20RLCOfhazpt6uC4QqpkQETX8XTSknmEefN8jF
         5oAuMhu3wuh+zqaVLK/oI0sY+3CyWLOlyQdoTEIpCkmPxtSf7CJgC5e9wPcJmjKHc3wy
         dlog==
X-Gm-Message-State: ALoCoQlkg+CIspROvVUbTw1GdRHOvKUj4i9e4c+IYP/hV46vZc6b/7Tl0MeUnIn3AjusHEvloiI+
X-Received: by 10.68.233.134 with SMTP id tw6mr68116655pbc.22.1442453961407;
        Wed, 16 Sep 2015 18:39:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id ts1sm553467pbc.74.2015.09.16.18.39.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:20 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278101>

We should not pass --prefix NULL into the helper. Although the helper
can deal with it, it's just messy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7ef3247..3ccb0b6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -700,7 +700,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
+			git submodule--helper clone ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-- 
2.6.0.rc0.131.gf624c3d
