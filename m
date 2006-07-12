From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Wed, 12 Jul 2006 09:37:46 +0200
Message-ID: <44B4A6CA.3020206@innova-card.com>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>	<44B37893.5090501@innova-card.com> <7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 09:34:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0ZE0-0001f5-NT
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 09:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWGLHdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 03:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWGLHdd
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 03:33:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:50421 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750780AbWGLHdc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 03:33:32 -0400
Received: by nz-out-0102.google.com with SMTP id z3so55808nzf
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 00:33:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=kZdD8JgL9B1HVVOa+y4S1UILDSfStwVL4JoceVtPejomPzPxcNF+b9fDtCWBtggu/dmNgYsisWVW7+CK8wBVF6Fg/sbmXXngl8jXR6aGzQU3s4rMTtRgwaiNRhnboUzyg+W+5bpscfHacojq6YHS3I09wjoo8nZ0V4tD1/Hz0MU=
Received: by 10.64.83.10 with SMTP id g10mr342159qbb;
        Wed, 12 Jul 2006 00:33:31 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id e18sm174600qbe.2006.07.12.00.33.27;
        Wed, 12 Jul 2006 00:33:31 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23769>

Junio C Hamano wrote:
> 
> Haven't checked the code around the patch yet, but does it work
> when the original commit log message ends with a blank line and
> existing signed-off-by lines by other people?  You do not want
> an extra blank lines there.
> 

argh, no I just tested the previous case. Here is an update
which fix all cases.

-- >8 --

[PATCH] Add a newline before appending "Signed-off-by:"

It looks nicer.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 log-tree.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 9d8d46f..69d5c8a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -17,9 +17,10 @@ static int append_signoff(char *buf, int
 	int signoff_len = strlen(signoff);
 	static const char signed_off_by[] = "Signed-off-by: ";
 	char *cp = buf;
+	int has_signoff = 0;
 
 	/* Do we have enough space to add it? */
-	if (buf_sz - at <= strlen(signed_off_by) + signoff_len + 2)
+	if (buf_sz - at <= strlen(signed_off_by) + signoff_len + 3)
 		return at;
 
 	/* First see if we already have the sign-off by the signer */
@@ -32,8 +33,11 @@ static int append_signoff(char *buf, int
 		    !strncmp(cp, signoff, signoff_len) &&
 		    isspace(cp[signoff_len]))
 			return at; /* we already have him */
+		has_signoff = 1;
 	}
 
+	if (!has_signoff)
+		buf[at++] = '\n';
 	strcpy(buf + at, signed_off_by);
 	at += strlen(signed_off_by);
 	strcpy(buf + at, signoff);
-- 
1.4.1.g55b7
