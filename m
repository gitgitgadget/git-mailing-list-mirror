From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH/RFC 3/6] tag: copy parsed buffer unconditionnaly
Date: Sun, 22 Feb 2009 20:06:53 +0200
Message-ID: <e29894ca0902221006v647322c2p5d0c78519ed28473@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 19:08:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIl1-00047r-Fr
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbZBVSG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbZBVSG4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:06:56 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:1832 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbZBVSGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:06:55 -0500
Received: by ey-out-2122.google.com with SMTP id 25so358071eya.37
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vSVm9huq/6pmdSfx+AmzGgwQVIQGoGkOQoVxa6SEEv8=;
        b=oAHc6O/ECmQ59PkCOnObP+EZYt4M4XqRxrhkjOMgQsGRl8xqOK3yYJBW96TB1HIIyA
         fsejEUYpn5g0wQ3o04cW42H9u6cHMfWly9jzmW4JwkIgW0CiK4hi3OYHYgVL0uYvQQxt
         h+fg2TGnM4p4HcokmTpdpS0KhkSA5CHJfIZgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=KxrPhkL0dCsZH3wKp2YNgxtatdfHjRj8t9PxTuzhilj+yW8SlNlpCAIIhr+2cY/uNA
         6soXbO4XKWulw3TeVFbPNeCzz7qzOpNN2hJKA55i65yAVCTyXU34W1XCfYjqY3DXG8gO
         bHTZVwD9CeWl+gqqqszRbrOL3Lfu4WJwO/DfU=
Received: by 10.210.136.10 with SMTP id j10mr2718014ebd.37.1235326013234; Sun, 
	22 Feb 2009 10:06:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111038>

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
---
 tag.c |    3 +++
 tag.h |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tag.c b/tag.c
index eecc636..b53056c 100644
--- a/tag.c
+++ b/tag.c
@@ -82,6 +82,9 @@ int parse_tag_buffer(struct tag *item, void *data,
unsigned long size)
 	if (date)
 		item->date = strtoul(++date, NULL, 10);

+	item->buffer = xmemdupz(data, size);
+	item->size = size;
+
 	if (!strcmp(type, blob_type)) {
 		item->tagged = &lookup_blob(sha1)->object;
 	} else if (!strcmp(type, tree_type)) {
diff --git a/tag.h b/tag.h
index e6edfcf..d7a6846 100644
--- a/tag.h
+++ b/tag.h
@@ -11,6 +11,8 @@ struct tag {
 	char *tag;
 	char *signature;
 	unsigned long date;
+	char *buffer;
+	unsigned long size;
 };

 extern struct tag *lookup_tag(const unsigned char *sha1);
-- 
1.6.2.rc1.28.g05ef4.dirty
