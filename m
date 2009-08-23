From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete line
Date: Mon, 24 Aug 2009 06:07:08 +0900
Message-ID: <20090824060708.6117@nanako3.lavabit.com>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
	<1250999357-10827-3-git-send-email-git@tbfowler.name>
	<7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
	<20090823171819.6117@nanako3.lavabit.com>
	<7v1vn2yklo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:08:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfKID-00086F-54
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbZHWVHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934105AbZHWVHu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:07:50 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36749 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886AbZHWVHt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 17:07:49 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 8843411B850;
	Sun, 23 Aug 2009 16:07:51 -0500 (CDT)
Received: from 2794.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id LCDQJFFX79EB; Sun, 23 Aug 2009 16:07:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=eABe/fprlkkVvEpzLQIyNAtIGH5orrxC3fNfkhrAwU9aG+iMIMPljip4qh59JCRVLIh7+GfR07WzbJq+ORNTuGIyNBbhqr1xNgYb45PgOqcCCjR+0OsQ5MWf30HkI5OFyVNPnvY4RgpWY6C8peq1ps4/EPVk/Gx0eq6w5nCB5Cs=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126880>

Quoting Junio C Hamano <gitster@pobox.com>

> Having said that, I could use something like this.
>
> -- >8 -- cut here -- >8 -- 
> Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
>
> This teaches mailinfo the scissors -- >8 -- mark; the command ignores
> everything before it in the message body.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

There are left handed people whose scissors run in the wrong direction.

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b0906ef..38c01e4 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -725,7 +725,8 @@ static int scissors(const struct strbuf *line)
 			scissors_dashes_seen |= 02;
 			continue;
 		}
-		if (i + 1 < len && !memcmp(buf + i, ">8", 2)) {
+		if (i + 1 < len &&
+		    !memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2)) {
 			scissors_dashes_seen |= 01;
 			i++;
 			continue;

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
