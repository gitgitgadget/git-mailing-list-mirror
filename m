From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 23:21:13 +0200
Message-ID: <20050919212113.GB8862@puritan.pnetwork>
References: <20050919134838.GC2903@pasky.or.cz> <20050919163219.GA8862@puritan.pnetwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 19 23:24:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHT58-0000UJ-Rt
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 23:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVISVVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVISVVP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 17:21:15 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:39097 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932350AbVISVVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 17:21:15 -0400
Received: from puritan.petwork ([213.112.43.228] [213.112.43.228])
          by mxfep01.bredband.com with ESMTP
          id <20050919212113.JVBM12537.mxfep01.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Mon, 19 Sep 2005 23:21:13 +0200
Received: by puritan.petwork (Postfix, from userid 1000)
	id C47C7ADFEA; Mon, 19 Sep 2005 23:21:13 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050919163219.GA8862@puritan.pnetwork>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8909>

Nikolai Weibull wrote:

> If we stop using GECOS, then can we please start using $EMAIL (or
> perhaps use it regardless of whether we use GECOS or not)?  A lot of
> applications seem to look for $EMAIL and I think that it's universal
> enough for git to use it as well.  To me it seems that both
> GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME, and
> GIT_COMMITTER_EMAIL can use it, as I set $EMAIL as
> 
> EMAIL="Nikolai Weibull <something@something.something>"
> 
> Perhaps I should provide a patch instead of just putting out requests?,

Perhaps something like the following patch will do?,
        nikolai

---
diff --git a/ident.c b/ident.c
--- a/ident.c
+++ b/ident.c
@@ -127,18 +127,22 @@ char *get_ident(const char *name, const 
 	char date[50];
 	int i;
 
-	if (!name)
-		name = real_name;
-	if (!email)
-		email = real_email;
+	if (!name && !email && getenv("EMAIL")) {
+		i = copy(buffer, sizeof(buffer), 0, getenv("EMAIL"));
+		i = add_raw(buffer, sizeof(buffer), i, " ");
+	} else {
+		if (!name)
+			name = real_name;
+		if (!email)
+			email = real_email;
+		i = copy(buffer, sizeof(buffer), 0, name);
+		i = add_raw(buffer, sizeof(buffer), i, " <");
+		i = copy(buffer, sizeof(buffer), i, email);
+		i = add_raw(buffer, sizeof(buffer), i, "> ");
+	}
 	strcpy(date, real_date);
 	if (date_str)
 		parse_date(date_str, date, sizeof(date));
-
-	i = copy(buffer, sizeof(buffer), 0, name);
-	i = add_raw(buffer, sizeof(buffer), i, " <");
-	i = copy(buffer, sizeof(buffer), i, email);
-	i = add_raw(buffer, sizeof(buffer), i, "> ");
 	i = copy(buffer, sizeof(buffer), i, date);
 	if (i >= sizeof(buffer))
 		die("Impossibly long personal identifier");

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
