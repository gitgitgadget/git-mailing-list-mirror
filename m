From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/4] repack: do not fall back to incremental repacking with
 [-a|-A]
Date: Thu, 06 Nov 2008 19:55:20 -0600
Message-ID: <-NKrpBlnD0U49OczAyUd7HiIBqhMblkOkU4lOc2bc9qfTrGNrwpLTg@cipher.nrlssc.navy.mil>
References: <P5afFyDEMjF9ynd9dfSfGeRo_GFY_K6ZAn2nIYo8_xGgSl4LapbSOA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 02:56:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyGad-0006E7-Qt
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 02:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbYKGBz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 20:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYKGBz1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 20:55:27 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44248 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbYKGBz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 20:55:26 -0500
Received: by mail.nrlssc.navy.mil id mA71tKuL017507; Thu, 6 Nov 2008 19:55:20 -0600
In-Reply-To: <P5afFyDEMjF9ynd9dfSfGeRo_GFY_K6ZAn2nIYo8_xGgSl4LapbSOA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Nov 2008 01:55:20.0805 (UTC) FILETIME=[E40E0950:01C9407B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100278>

When repack is called with either the -a or -A option, the user has
requested to repack all objects including those referenced by the
alternates mechanism. Currently, if there are no local packs without
.keep files, then repack will call pack-objects with the
'--unpacked --incremental' options which causes it to exclude alternate
packed objects. So, remove this fallback.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-repack.sh |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 8bb2201..4d313d1 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -71,13 +71,10 @@ case ",$all_into_one," in
 				existing="$existing $e"
 			fi
 		done
-	fi
-	if test -z "$args"
-	then
-		args='--unpacked --incremental'
-	elif test -n "$unpack_unreachable"
-	then
-		args="$args $unpack_unreachable"
+		if test -n "$args" -a -n "$unpack_unreachable"
+		then
+			args="$args $unpack_unreachable"
+		fi
 	fi
 	;;
 esac
-- 
1.6.0.3.552.g12334
