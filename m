From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] clone: do not segfault when specifying a nonexistent branch
Date: Fri,  4 Oct 2013 16:20:59 +0200
Message-ID: <1380896459-6451-1-git-send-email-stefanbeller@googlemail.com>
References: <524EC896.3050703@opensoftware.pl>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, ralf.thielow@gmail.com,
	robert.mitwicki@opensoftware.pl, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 04 16:21:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS6FX-0005NQ-BA
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 16:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab3JDOU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 10:20:56 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:58668 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab3JDOUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 10:20:55 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1789978eak.8
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gGl7Kp15ZLRKfnNyEdFIc04Tv9WGCo7LxYAqv5v4TRA=;
        b=wVhLdLtopzoNM+QAppQSqQUY434Cof9TAIs7LqUorKyI5pvpI9RMcXyqdMsdgx1g6U
         ssvdL2jHEIILk/oDLKAe0UYmEYNXgrJf1dOc/Ps2e1/OkxHujc1vL2N2TFm7KDSnTgdd
         VFFwxphRwDfMT5cKLDUUA0fnbe+sExKslRncRwVsfWyEt4Ofa8Cv6Yelf5oRhZExxSpr
         T/jhsMbCRuxw3nbxKZFzo3vZWotbVT5hT3RM5wBileUjkEIeO1sA5bcyq0Mg8PkiU/6t
         4AIsw9WjFSLxDZBsSDj2rVGJok8YQeSck6JL6ADRZNdp7HwFAPeruxPwloTPiD6iFtYd
         flhg==
X-Received: by 10.14.178.195 with SMTP id f43mr1230eem.138.1380896454088;
        Fri, 04 Oct 2013 07:20:54 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r48sm28562147eev.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 04 Oct 2013 07:20:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.469.gb38b9db
In-Reply-To: <524EC896.3050703@opensoftware.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235714>

I think we should emit a warning additionally?

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0aff974..b764ad0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -688,7 +688,7 @@ static void write_refspec_config(const char* src_ref_prefix,
 
 	if (option_mirror || !option_bare) {
 		if (option_single_branch && !option_mirror) {
-			if (option_branch) {
+			if (option_branch && our_head_points_at) {
 				if (strstr(our_head_points_at->name, "refs/tags/"))
 					strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
 						our_head_points_at->name);
-- 
1.8.4.1.469.gb38b9db
