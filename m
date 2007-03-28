From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: Re: [PATCH] use xrealloc in help.c
Date: Tue, 27 Mar 2007 20:53:52 -0400
Message-ID: <3f80363f0703271753h631f52f4v3899b877285962@mail.gmail.com>
References: <1175034608589-git-send-email-jbowes@dangerouslyinc.com>
	 <118833cc0703271540l6615b413gd1df3dc5525a2d00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
To: "Morten Welinder" <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWMQJ-00061J-AR
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 02:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbXC1Ax4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 20:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbXC1Ax4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 20:53:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:2937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbXC1Axz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 20:53:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so59339uga
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 17:53:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=jZStj9jcWbfhw8+Nn2VkRr/YqW6ZoHoPZs8kynpDx0PfVr6pHI8LwayKDMz7jKo0h8Np8UD7j1YmgX4WlyZ46LFrVGWBROEZSjWXlr6xidGwL1bJmlZGXKQ/5/4jBx14DgGegQICxbhNVIbO2EU9OjODj9sFqVlngJpwa7lcPnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Lu4YI0mNMFl3srdFUvvLnmV0P0f+6s0apooRhsyYS3Ygmo+oUYF9XpSCW7/9guMKS5WcKt9FVrNIAu+0wqh5uPiliniWGjzt1647xe+aMG2K1FszMvWBdLlknOywsxpjP5Xz5i0Knm32xoRmlc5xA7Ke7A5SGT27THcDUvO8ifY=
Received: by 10.114.183.1 with SMTP id g1mr3428742waf.1175043232840;
        Tue, 27 Mar 2007 17:53:52 -0700 (PDT)
Received: by 10.114.194.4 with HTTP; Tue, 27 Mar 2007 17:53:52 -0700 (PDT)
In-Reply-To: <118833cc0703271540l6615b413gd1df3dc5525a2d00@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 23eeadcbf635e4fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43336>

oom() is not needed any more either, since the x* functions check the return
themselves. So get rid of it.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

On 3/27/07, Morten Welinder <mwelinder@gmail.com> wrote:
> If you are using xrealloc, shouldn't kill the oom check here too?

Good point. There's no need for oom() at all then, anymore.

 help.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/help.c b/help.c
index be8651a..6a9af4d 100644
--- a/help.c
+++ b/help.c
@@ -31,12 +31,6 @@ static int term_columns(void)
 	return 80;
 }

-static void oom(void)
-{
-	fprintf(stderr, "git: out of memory\n");
-	exit(1);
-}
-
 static inline void mput_char(char c, unsigned int num)
 {
 	while(num--)
@@ -54,13 +48,9 @@ static void add_cmdname(const char *name, int len)
 	struct cmdname *ent;
 	if (cmdname_alloc <= cmdname_cnt) {
 		cmdname_alloc = cmdname_alloc + 200;
-		cmdname = realloc(cmdname, cmdname_alloc * sizeof(*cmdname));
-		if (!cmdname)
-			oom();
+		cmdname = xrealloc(cmdname, cmdname_alloc * sizeof(*cmdname));
 	}
 	ent = xmalloc(sizeof(*ent) + len);
-	if (!ent)
-		oom();
 	ent->len = len;
 	memcpy(ent->name, name, len);
 	ent->name[len] = 0;
-- 
1.5.0.5
