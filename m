From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] cached_object: learn empty blob
Date: Thu, 21 Aug 2008 01:43:44 -0700
Message-ID: <7v8wuqkbb3.fsf_-_@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7viqtukbec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW5mn-0000ox-KP
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 10:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbYHUInv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 04:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbYHUInv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 04:43:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYHUInt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 04:43:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A16A5942E;
	Thu, 21 Aug 2008 04:43:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6F6A25942D; Thu, 21 Aug 2008 04:43:46 -0400 (EDT)
In-Reply-To: <7viqtukbec.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Aug 2008 01:41:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 462C42F4-6F5D-11DD-A486-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93122>

We have hardcoded an empty tree for a long time.  This teaches the code
about an empty blob object.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d9e342e..1e5de12 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2002,6 +2002,15 @@ static struct cached_object empty_tree = {
 	0
 };
 
+static struct cached_object empty_blob = {
+	/* empty blob sha1: e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 */
+	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b"
+	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91",
+	OBJ_BLOB,
+	"",
+	0
+};
+
 static struct cached_object *find_cached_object(const unsigned char *sha1)
 {
 	int i;
@@ -2013,6 +2022,8 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 	}
 	if (!hashcmp(sha1, empty_tree.sha1))
 		return &empty_tree;
+	if (!hashcmp(sha1, empty_blob.sha1))
+		return &empty_blob;
 	return NULL;
 }
 
-- 
1.6.0.51.g078ae
