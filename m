From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/pack-objects.c: Fix a printf format compiler warning
Date: Wed, 19 Oct 2011 20:10:37 +0100
Message-ID: <4E9F20AD.4020209@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: dpmcgee@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 20 19:08:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGw6Z-0004gh-2g
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 19:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab1JTRI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 13:08:27 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:42770 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754108Ab1JTRI0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 13:08:26 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1RGw6S-0000fo-bm; Thu, 20 Oct 2011 17:08:25 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184030>


In particular, on systems that define uint32_t as an unsigned long,
gcc complains as follows:

        CC builtin/pack-objects.o
    pack-objects.c: In function `compute_write_order':
    pack-objects.c:600: warning: unsigned int format, uint32_t arg (arg 3)

In order to suppress the warning, we use the C99 format specifier
macro PRIu32.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Dan,

If you need to re-roll your pack-objects series (dm/pack-objects-update
branch in pu), could you please squash this change into your final commit
0a8145bd (pack-objects: don't traverse objects unnecessarily, 18-10-2011).

If you don't need to re-roll, then I'm hoping Junio will notice and squash
this in before it hits next. ;-)

ATB,
Ramsay Jones

 builtin/pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6db45fa..4bbd815 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -597,7 +597,7 @@ static struct object_entry **compute_write_order(void)
 	}
 
 	if (wo_end != nr_objects)
-		die("ordered %u objects, expected %u", wo_end, nr_objects);
+		die("ordered %u objects, expected %"PRIu32, wo_end, nr_objects);
 
 	return wo;
 }
-- 
1.7.7
