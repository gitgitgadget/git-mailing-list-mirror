From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] upload-pack: send non-HEAD symbolic refs
Date: Tue, 17 Sep 2013 19:31:26 -0700
Message-ID: <1379471489-26280-4-git-send-email-gitster@pobox.com>
References: <20130906155608.GF12966@inner.h.apk.li>
 <1379471489-26280-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 04:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM7YQ-0006Mb-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 04:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab3IRCbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 22:31:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab3IRCbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 22:31:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BDF53917C;
	Wed, 18 Sep 2013 02:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+s9H
	wwgYu4vEFH0HKMed1dOSoqE=; b=TXDYUMc9HEk6b0FBL0rGL8PXTCCw+Njjbh7D
	56226s7Cd9uZ8b0TkyHzylMqUitGg/1lQPMLzAlJhbxuLXt16Tm1lVeu8iC2Co4t
	xfymQ2BNmmTX2ICU7YNFGefeHgrUNVS3d4OESmYh2q3+RKUEiBj8Kaz1qGS3loQl
	d+Eu0xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ZshhzqMUOcRTJW10CtWO3OhdR9L3i4KbfktyYKqu17vao8iBgt3Z3xmRCxJ65Zqe
	q7DdlRJIy7aYERI9A1NzucpLvFZnIwQs/gbN+TUQGg53XhN5NpMl8GGxNXhae/Og
	XtuyHEINwW9VkIefwaozxZZDsTwCropgFB5/uUs3yhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00B1139178;
	Wed, 18 Sep 2013 02:31:39 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 619AB39175;
	Wed, 18 Sep 2013 02:31:38 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379471489-26280-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 71E8A28A-200A-11E3-BE8D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234944>

With the same mechanism as used to tell where "HEAD" points at to
the other end, we can tell the target of other symbolic refs as
well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/upload-pack.c b/upload-pack.c
index 53958b9..7ca6154 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -798,6 +798,7 @@ static void upload_pack(void)
 	struct string_list symref = STRING_LIST_INIT_DUP;
 
 	head_ref_namespaced(find_symref, &symref);
+	for_each_namespaced_ref(find_symref, &symref);
 
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
-- 
1.8.4-585-g8d1dcaf
