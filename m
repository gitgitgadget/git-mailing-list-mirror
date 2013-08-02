From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/6] send-pack: fix parsing of --force-with-lease option
Date: Fri, 02 Aug 2013 16:13:22 -0700
Message-ID: <7va9kzptyl.fsf@alter.siamese.dyndns.org>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 01:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5OXS-0001fX-4U
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 01:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab3HBXNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 19:13:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407Ab3HBXNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 19:13:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EB9D35A78;
	Fri,  2 Aug 2013 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zc18u9MqKqRyWyRYPPQM8BMt774=; b=L9IGn/
	/5Ysn8L09AowGLZAVv8Cd04YxtS5xo8djqWwT6hB8xbPxuUQx/3t7GwM9S+6dYjV
	pzTX2/lSBzPdIz3YmTOarkBhEe3AWszHshNuCq+YxezPtaDt3l+Rpwu9c13uPFGJ
	/zev7rOjNRHuNlgkOu2Us/TaK13LOt47dzdos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iBYUXCNmoNYBbFw5NzeLxzuHd/S4w/Kh
	IZoHhRWvJIv9mqTo9VJBchiAcWfQOTM3+1xRMSCYwfRfnmCMxI31VHEOcQlIgH75
	njxo8boMpSq7k8c3vC0a6dqzFLAZxIvjxzw6PkdBrcpq+nR4hFuPNEgEnOuCWZm9
	Y+FHYheILpY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33B9335A76;
	Fri,  2 Aug 2013 23:13:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9595335A75;
	Fri,  2 Aug 2013 23:13:23 +0000 (UTC)
In-Reply-To: <1374561800-938-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 22 Jul 2013 23:43:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 210FAD32-FBC9-11E2-A393-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231542>

The last argument for parse_push_cas_option() is if it is "unset"
(i.e. --no-force-with-lease), and we are parsing the option with an
explicit value here, so it has to be 0.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 41dc512..4482f16 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -183,7 +183,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 			}
 			if (!prefixcmp(arg, "--" CAS_OPT_NAME "=")) {
 				if (parse_push_cas_option(&cas,
-							  strchr(arg, '=') + 1, 1) < 0)
+							  strchr(arg, '=') + 1, 0) < 0)
 					exit(1);
 				continue;
 			}
-- 
1.8.4-rc1-129-g1f3472b
