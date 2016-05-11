From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 33/94] builtin/apply: move 'p_value_known' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:44 +0200
Message-ID: <20160511131745.2914-34-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3U-00036O-JI
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbcEKNTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35881 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcEKNTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9347388wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uv9EcSZuz0SjvennYR+fsHKjnNpKrpZq9VxE+DqXSV0=;
        b=hkwLNCvZwsqahwFLiY5IoSZQdaWd4cKke+mPP2ML78HI8FlmaItsAYwodHdtJSZGGZ
         KnVPypB/WxP2SvSwp6QOSBpilaWG7VdMJtG7V6m9ri+bpSNb1O3X4kXCRJLQqtODgECr
         DaMoBqYpvzaxwfLXCbHHTzfy6Qhwr+0G468ZjtWes8mBM1R+A5BWlXyV9nU9a7U941Dk
         aYxz0cpkW4bvMLSVljCMG3Jr7YhCl2ctqmFPa2XAgyH2PRYYo8c+BqQ8z98SMBiSwcYj
         tGH2iYI0QKb3BFSSQuaVu3go4Lf/Bg4X14kmPYFc/aE1WDPnVm12YA0GnlXBAIbcPZR9
         hADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uv9EcSZuz0SjvennYR+fsHKjnNpKrpZq9VxE+DqXSV0=;
        b=M1mmKrXAVd0YToUfAme97BY0PN7HfkRZ4mMBipb8EPVg2MolAhwp5ybS3Bvfwnma9L
         myFMMZRYrEeS9YmkljKBUYpiCmyv8Os5mfZ9XqaENh5PH/LoP4BLnAU2jUpQ/GqFkG0D
         OGlfOwQaoEuV5B4QZo2fZM9Lf4A6ZNVAbeuluSzt/3bHQRVAocfC7cvg4dFo0cIVJogZ
         6FVLMsDccMSMY2ikd5zblEvXD5g3G6RYBLZoqfC3xoIMdn9UTVxAT0OKYEE3q+9WLH0E
         yKcHoea97H43LANOO/bt+7Axd6eJC6wVxgf/PgMJriDRTo/zBxQDFVymY0JfS6qBlSVG
         hmRQ==
X-Gm-Message-State: AOPr4FWtbwGvsjuHVCpKX6KB4RjbU60doaYP0x76Z2dbh436HQ2aMDLoPz8uuA7LPYct+w==
X-Received: by 10.194.3.84 with SMTP id a20mr3740529wja.77.1462972773419;
        Wed, 11 May 2016 06:19:33 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:32 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294270>

To libify the apply functionality the 'p_value_known' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4e476d5..30eea9c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -63,13 +63,12 @@ struct apply_state {
 	int line_termination;
 
 	int p_value;
+	int p_value_known;
 	unsigned int p_context;
 };
 
 static int newfd = -1;
 
-static int p_value_known;
-
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -882,14 +881,14 @@ static void parse_traditional_patch(struct apply_state *state,
 
 	first += 4;	/* skip "--- " */
 	second += 4;	/* skip "+++ " */
-	if (!p_value_known) {
+	if (!state->p_value_known) {
 		int p, q;
 		p = guess_p_value(state, first);
 		q = guess_p_value(state, second);
 		if (p < 0) p = q;
 		if (0 <= p && p == q) {
 			state->p_value = p;
-			p_value_known = 1;
+			state->p_value_known = 1;
 		}
 	}
 	if (is_dev_null(first)) {
@@ -4595,7 +4594,7 @@ static int option_parse_p(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	state->p_value = atoi(arg);
-	p_value_known = 1;
+	state->p_value_known = 1;
 	return 0;
 }
 
-- 
2.8.2.490.g3dabe57
