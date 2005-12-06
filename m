From: Junio C Hamano <junkio@cox.net>
Subject: Re: type_size_sort
Date: Tue, 06 Dec 2005 13:45:03 -0800
Message-ID: <7vpso92940.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 22:46:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjkcW-0006AT-UL
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 22:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbVLFVpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 16:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVLFVpF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 16:45:05 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24831 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932642AbVLFVpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 16:45:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206214414.REHI20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 16:44:14 -0500
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
	(Morten Welinder's message of "Tue, 6 Dec 2005 16:19:21 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13295>

Morten Welinder <mwelinder@gmail.com> writes:

> static int type_size_sort(const struct object_entry *a, const struct
> object_entry *b)
> {
> ...
>   return a < b ? -1 : (a > b);
> }
>
> This does not look valid.

Then something like this?

---
diff --git a/pack-objects.c b/pack-objects.c
index a62c9f8..c27fee5 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -296,7 +296,7 @@ static int type_size_sort(const struct o
 		return -1;
 	if (a->size > b->size)
 		return 1;
-	return a < b ? -1 : (a > b);
+	return memcmp(a->sha1, b->sha1, 20);
 }
 
 struct unpacked {
