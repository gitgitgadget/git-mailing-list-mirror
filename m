From: David Rientjes <rientjes@google.com>
Subject: Re: git-mv is broken in master
Date: Tue, 15 Aug 2006 14:02:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151401510.3965@chino.corp.google.com>
References: <20060815205150.GA467@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 23:03:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD64U-0000Ml-N6
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 23:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWHOVDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 17:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWHOVDc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 17:03:32 -0400
Received: from smtp-out.google.com ([216.239.45.12]:53605 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750710AbWHOVDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 17:03:31 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7FL35lU005246;
	Tue, 15 Aug 2006 14:03:10 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=qojEfNoDlK7Jgv4MH3iHrJBf//xCd5O+FLoe6De//WcZWrmR2nRlmsh9dGeec6X1X
	qP6SSxzk6I8Hn/9NBp+kg==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7FL2dI9008200;
	Tue, 15 Aug 2006 14:02:43 -0700
Received: by localhost (Postfix, from userid 24081)
	id 051EC87D71; Tue, 15 Aug 2006 14:02:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id A87E987D70;
	Tue, 15 Aug 2006 14:02:38 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060815205150.GA467@c165.ib.student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25484>

On Tue, 15 Aug 2006, Fredrik Kuivinen wrote:
> With the current master I get the following:
> 
>     $ git-mv README README-renamed
>     fatal: can not move directory into itself, source=README, destination=README-renamed
> 

Please try the following patch.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-mv.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index a731f8d..1d11bbb 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -203,8 +203,7 @@ int cmd_mv(int argc, const char **argv, 
 			}
 		}
 
-		if (!bad &&
-		    !strncmp(destination[i], source[i], strlen(source[i])))
+		if (!bad && !strcmp(destination[i], source[i]))
 			bad = "can not move directory into itself";
 
 		if (!bad && cache_name_pos(source[i], strlen(source[i])) < 0)
-- 
1.4.2.g460c-dirty
