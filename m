From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH v2] pre-push.sample: remove unwanted `IFS=' '`.
Date: Sun, 21 Dec 2014 11:26:00 -0800
Message-ID: <1419189960-21264-1-git-send-email-gjthill@gmail.com>
References: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 20:26:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2m8s-0008Li-5q
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 20:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbaLUT0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 14:26:09 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:40122 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaLUT0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 14:26:08 -0500
Received: by mail-yh0-f51.google.com with SMTP id a41so1779231yho.10
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PdFvOGOdqLBWNEUW8wS+DlcaG6N/WoNHl5Vz8KqZVFM=;
        b=iLepUf33IvHG5JZR4QDzLh4NE/BwlK96bzxjmomkGTUkmzfj+MCzM37ng1wFlhcAuK
         EGsvTiLy+S4N79UchC5BOQpDG09M2VhRESJAA4cFvG7FM0knyX7pyzbe1g4B3ElEd4Qm
         yV47U6N9F+SyvSkp17L7UkdPbWZj1JWuj/uP3b6ZOlSuKRPtwXNAp3tuQfQhLoHPJId8
         aoSCRjFl9k9kV3D+u7qZaeoptfOycR+yEODK6QHrev1cTiWT+xyGKmPoREheb1GVAYaI
         JdruATtKLKrVhsJVnNUeAKgMU9DXBp91jB2eah/q811GBmTTptxGtw/KzMMa7rwcnkVx
         UmWg==
X-Received: by 10.170.51.199 with SMTP id 190mr17266296ykt.104.1419189967317;
        Sun, 21 Dec 2014 11:26:07 -0800 (PST)
Received: from gadabout.domain.actdsltmp (pool-71-189-147-248.lsanca.fios.verizon.net. [71.189.147.248])
        by mx.google.com with ESMTPSA id x27sm10258369yha.15.2014.12.21.11.26.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Dec 2014 11:26:06 -0800 (PST)
X-Mailer: git-send-email 2.2.1.212.g51be871
In-Reply-To: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261624>

Limiting the shell's word splitting breaks command substitution from
e.g. `git rev-list` output, the motivating example is

    range="$local_sha $(
            git for-each-ref --format='^%(refname)' refs/remotes/$remote
    )"
    # ...
    commit=`git rev-list -n 1 --grep '\bbad string\b' $range`

which fails with IFS=' ' because newlines aren't valid in commit id's

Signed-off-by: Jim Hill <gjthill@gmail.com>
---
 templates/hooks--pre-push.sample | 1 -
 1 file changed, 1 deletion(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 69e3c67..6187dbf 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -24,7 +24,6 @@ url="$2"
 
 z40=0000000000000000000000000000000000000000
 
-IFS=' '
 while read local_ref local_sha remote_ref remote_sha
 do
 	if [ "$local_sha" = $z40 ]
-- 
2.2.1.212.g51be871
