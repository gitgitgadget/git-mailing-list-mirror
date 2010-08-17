From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/24] merge script: handle many-way octopus
Date: Tue, 17 Aug 2010 02:09:58 -0500
Message-ID: <20100817070958.GT22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:11:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGKk-0002on-1z
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab0HQHLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:11:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55584 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab0HQHLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:11:34 -0400
Received: by gwj17 with SMTP id 17so1311605gwj.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yfjPoFVAuxARwh6aXTTdAjU6H/bqxACPqcPs+pe1R4Y=;
        b=DSvWm+2J7Hc+MDLl/+iQqGKdBnFYGDXHC/J0lxbkO12m/vqfr8MPwsQ2wsOwzJ0MJV
         S4GREqWk0LPalVXC4OGb6MVgcZVgHDp3dzaKcs1UqwmgKcub0DFTnZ3E7uFVX+pf0UeU
         bWQEQW1XRh+wlQqtskLBSkMySAEnX7H73yeLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pcAfWCHkLg3OleitmIKOCMwDnuz1rKCYb8EEhAs01bD6AsCAo1A+C4N4Ke48uO6Vlg
         1glUYsHZg3/Wg0Uu3NupF43mM5R2Uc8VqFu0qzTJzt9nAMpjgKHc2WzuQZ/J3WliTgX1
         Qyu8uGQw92YQjm4h+gOnsRAJ7aGWZtgU0hYXc=
Received: by 10.100.151.11 with SMTP id y11mr7144066and.4.1282029093528;
        Tue, 17 Aug 2010 00:11:33 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c25sm577125ana.39.2010.08.17.00.11.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:11:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153723>

Based on v1.6.0-rc0~51^2~5 (Build in merge, 2008-07-07).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 91e33a3..410fa3c 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -374,7 +374,7 @@ case "$#" in
 	common=$(git merge-base --all $head "$@")
 	;;
 *)
-	common=$(git show-branch --merge-base $head "$@")
+	common=$(git merge-base --all --octopus $head "$@")
 	;;
 esac
 echo "$head" >"$GIT_DIR/ORIG_HEAD"
@@ -528,9 +528,9 @@ if test '' != "$result_tree"
 then
     if test "$allow_fast_forward" = "t"
     then
-        parents=$(git show-branch --independent "$head" "$@")
+	parents=$(git merge-base --independent "$head" "$@")
     else
-        parents=$(git rev-parse "$head" "$@")
+	parents=$(git rev-parse "$head" "$@")
     fi
     parents=$(echo "$parents" | sed -e 's/^/-p /')
     result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree $result_tree $parents) || exit
-- 
1.7.2.1.544.ga752d.dirty
