From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make gitfakemmap standalone to fix linking error in git.c
Date: Mon, 5 Dec 2005 14:24:47 +0100
Message-ID: <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19855_20706532.1133789087816"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 14:26:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjGKq-0006cs-FA
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 14:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVLENYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 08:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVLENYu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 08:24:50 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:52389 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932420AbVLENYt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 08:24:49 -0500
Received: by nproxy.gmail.com with SMTP id m18so15146nfc
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 05:24:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Ccv+Ajf3RJa3qEYvuNuV0QEj8poPlt+EqdfQcQQqa5A3RDIXPWZAWamWNCnAzbYGrrq3HJ20xXUu8c9OJe9sSegmfEGVnXmxg7jQw3raIcoSWNTjlriI0LHBXBsQ9Evki7hAY/LpepJZgDvEMJxr3v9GRI0P4vdOBb9IDZqPqPc=
Received: by 10.48.42.7 with SMTP id p7mr142426nfp;
        Mon, 05 Dec 2005 05:24:47 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 5 Dec 2005 05:24:47 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13213>

------=_Part_19855_20706532.1133789087816
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The patch is to fix the error introduced by previous patch, which
inverted condition of checking for the supported case (start must be
NULL).

On 12/5/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> The patch is to fix linking error because of gitfakemmap referencing
> die living in usage.c, and git.c not linking in the file. Instead of
> hardcoding usage.o in git.c prerequisites, I separated mmap from the
> main sources.

Why does it always happen...

------=_Part_19855_20706532.1133789087816
Content-Type: text/plain; 
	name=0002-fix-bug-introduced-by-previous-change.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0002-fix-bug-introduced-by-previous-change.txt"

Subject: [PATCH] fix bug introduced by previous change

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>


---

 compat/mmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

58d38f03086fe30f3f758f2f27fde0ad05107b4a
diff --git a/compat/mmap.c b/compat/mmap.c
index 98cf3cb..cfa1f25 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -9,7 +9,7 @@ void *gitfakemmap(void *start, size_t le
 {
 	int n = 0;
 
-	if (!start || !(flags & MAP_PRIVATE)) {
+	if (start || !(flags & MAP_PRIVATE)) {
 		fprintf(stderr, "Invalid usage of gitfakemmap.\n");
 		exit(128); /* see die() in ../usage.c */
 	}
-- 
0.99.9.GIT

------=_Part_19855_20706532.1133789087816--
