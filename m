From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv2 2/2] format-patch: produce non colorized patches
 when ui.color=always
Date: Mon, 12 Sep 2011 11:43:09 -0700
Message-ID: <7vobyp7gaq.fsf@alter.siamese.dyndns.org>
References: <1315849601-26497-1-git-send-email-pangyanhan@gmail.com>
 <1315849601-26497-3-git-send-email-pangyanhan@gmail.com>
 <7vsjo17hws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	martin.von.zweigbergk@gmail.com, sdaoden@googlemail.com,
	ib@wupperonline.de
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:43:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3BTi-0005JS-Oy
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 20:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab1ILSn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 14:43:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab1ILSnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 14:43:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE31F416F;
	Mon, 12 Sep 2011 14:43:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DUuXt/1olDaAAsViOfNQYSjSX30=; b=C+UMjf
	tp3bAF/3n9ZPqscR2DdqPVwa+NZwI/8AVSKwVaWxXxunZZF9fbvxdfmGri/Q+DjE
	iZY7VZWUKwfIQyvgiOJgEKiWLUvCMl0ToDSbTRn8jiDV5/J1k20gJcxKuGCt2/t1
	praE/xUcFzNHTk01I0eiP0KKIuhvjct+K+Sn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TE2mg5w6yUJYD5aEUGdCASOqjE6kBWzR
	XCiQt3a/GHQFzubhWbQeCilzdjZZRDETqZ2/pSPDean4sRr6Rl/8HVYLx9FBkMhv
	7K8KNLmOGPyMS050I7MNCUELB5n52EG138VTsEn77NvpP4FAs3l9rVExMWuj8943
	mCG0ya9Bdz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5849416E;
	Mon, 12 Sep 2011 14:43:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3ED91416B; Mon, 12 Sep 2011
 14:43:13 -0400 (EDT)
In-Reply-To: <7vsjo17hws.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 12 Sep 2011 11:08:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11EC42B8-DD6F-11E0-A295-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181234>

I've queued this. Thanks.

-- >8 --
From: Pang Yan Han <pangyanhan@gmail.com>
Date: Tue, 13 Sep 2011 01:46:41 +0800
Subject: [PATCH] format-patch: ignore ui.color

commit c9bfb953 (want_color: automatically fallback to color.ui,
2011-08-17) introduced a regression where format-patch produces colorized
patches when color.ui is set to "always".

In f3aafa4 (Disable color detection during format-patch, 2006-07-09),
git_format_config was taught to intercept diff.color to avoid passing it
down to git_log_config and later, git_diff_ui_config.

Teach git_format_config to intercept color.ui in the same way.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c           |    3 ++-
 t/t4014-format-patch.sh |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d760ee0..f5d4930 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -608,7 +608,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		string_list_append(&extra_cc, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
+	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff") ||
+	    !strcmp(var, "color.ui")) {
 		return 0;
 	}
 	if (!strcmp(var, "format.numbered")) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5cbc066..7e405d7 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -886,4 +886,12 @@ test_expect_success 'empty subject prefix does not have extra space' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format patch ignores color.ui' '
+	test_unconfig color.ui &&
+	git format-patch --stdout -1 >expect &&
+	test_config color.ui always &&
+	git format-patch --stdout -1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.7.rc1
