From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/4] parse-options: introduce OPT_PATH
Date: Mon, 23 Feb 2015 17:17:43 +0100
Message-ID: <cccf3d14e5582996e5be1467849121a262f9c9f1.1424707497.git.git@drmicha.warpmail.net>
References: <20150223144214.GA31624@peff.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 17:17:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPvhk-0003ia-BA
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 17:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbBWQRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 11:17:51 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44897 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752145AbbBWQRt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 11:17:49 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CF21D20884
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 11:17:48 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 23 Feb 2015 11:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=iyNoxw91nivzYDZglYkzKTySBp0=; b=THBhBIPQQl72bbM+Rym7
	th4OcP6NdI0BIi3OXBO2OEgQbOEfSKMhcoGY5JZueT6f40MC40UVZgZLjEHjGW+4
	bmiytnq9YDKbcuXY61dN4Fvj4K/ZvF/YBqKWHbCYf/Cp1QB61eP6IhMceaK9RH+7
	wDUzwNFZTuQzjR1wpWUGbKY=
X-Sasl-enc: 0U0vSYaj1hp5lnrJhNJsiDdimNWYGx4oT22PIqv6liei 1424708269
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 26570C0028C;
	Mon, 23 Feb 2015 11:17:49 -0500 (EST)
X-Mailer: git-send-email 2.3.0.296.g32c87e1
In-Reply-To: <20150223144214.GA31624@peff.net>
In-Reply-To: <cover.1424707497.git.git@drmicha.warpmail.net>
References: <cover.1424707497.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264268>

Many options are paths, but not files. Introduce OPT_PATH which does
the same path processing as OPT_FILENAME but allows to name the argument.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/technical/api-parse-options.txt | 5 +++++
 parse-options.h                               | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 1f2db31..109903c 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -187,6 +187,11 @@ There are some macros to easily define options:
 	The filename will be prefixed by passing the filename along with
 	the prefix argument of `parse_options()` to `prefix_filename()`.
 
+`OPT_PATH(short, long, &var, arg_str, description)`::
+	Introduce an option with a path argument named arg_str.
+	The filename will be prefixed by passing the filename along with
+	the prefix argument of `parse_options()` to `prefix_filename()`.
+
 `OPT_ARGUMENT(long, description)`::
 	Introduce a long-option argument that will be kept in `argv[]`.
 
diff --git a/parse-options.h b/parse-options.h
index 7940bc7..5127a5d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -149,6 +149,8 @@ struct option {
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
 #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
 				       N_("file"), (h) }
+#define OPT_PATH(s, l, v, a, h)    { OPTION_FILENAME, (s), (l), (v), \
+				       (a), (h) }
 #define OPT_COLOR_FLAG(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }
-- 
2.3.0.296.g32c87e1
