From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] diff: reject unknown change class given to --diff-filter
Date: Wed, 17 Jul 2013 17:30:04 -0700
Message-ID: <1374107406-14357-5-git-send-email-gitster@pobox.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
 <1374107406-14357-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 02:30:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzc7C-0006fN-BO
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934401Ab3GRAaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 20:30:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934244Ab3GRAaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 20:30:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 963DE20AB4;
	Thu, 18 Jul 2013 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6vAO
	2LARKEB91qqYlZGIDbgLwB8=; b=co8wzbW0uQ0bsdklD1JsvzguByvDLr1+J5JM
	MaC6cl7wx/xfsdNmmSrJ1WzfRRQXBV1tFSNybfJSQn8bSlR/6kYjyRswiO7amMjc
	d2tJ1M/JY5O1+h0sypDcTQ5zveaDvc/KIz2xD6Vf17fM5yEfgCXikeMQbvOsjN5G
	RP1J5CU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	adDm4mXvrxx5fpEudtSzqPAOJOyAZ4ZFNpmMgAtEz4hvFVlL1Z8LjWKEZZYpNlSF
	yzd+Jb64hULotBEQdNfe0yZz65tTCVoH2z8oHaWEWKXDynLxU1L0INXHMv9j9j19
	D7EXIRiedFPP1ZrkMEV5lnGENvnxL+vWX6HGqaSaDRQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E40C20AB2;
	Thu, 18 Jul 2013 00:30:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F08B420AB0;
	Thu, 18 Jul 2013 00:30:17 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-962-gf04df43
In-Reply-To: <1374107406-14357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 38D50EA6-EF41-11E2-92E8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230669>

We used to accept "git diff --diff-filter=Q" (note that there is no
such change class 'Q') silently and showed no output (because there
is no such change class 'Q').

Error out when such an input is given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 03f10e6..3d37b56 100644
--- a/diff.c
+++ b/diff.c
@@ -3537,7 +3537,7 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 
 		bit = (0 <= optch && optch <= 'Z') ? filter_bit[optch] : 0;
 		if (!bit)
-			continue; /* ignore unknown ones, like we always have */
+			return optarg[i];
 		opt->filter |= bit;
 	}
 	return 0;
-- 
1.8.3.3-962-gf04df43
