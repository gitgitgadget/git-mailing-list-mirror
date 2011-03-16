From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH nd/struct-pathspec] declare 1-bit bitfields to be unsigned
Date: Tue, 15 Mar 2011 22:42:32 -0500
Message-ID: <20110316034232.GA26027@elie>
References: <20110316024959.GA24932@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 04:42:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzhdG-0007G2-MP
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 04:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab1CPDmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 23:42:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47566 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab1CPDmi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 23:42:38 -0400
Received: by gyf1 with SMTP id 1so493800gyf.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 20:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aCzYM3YZ5Q8EJA8rShfaGlszACwJRcnoKgtYS8LX3kw=;
        b=RWUFixvZj6rB/FseHx91WMwrxkd9NmS0Q+wmCyVEtXlLkLrjc5yR1pwO9KobZ7A0Uh
         +5xv4PzWIzQqKxcE3+pG+W4IJac95rnq50XEPJcE76DDOMZbNfLROWv5iCWFhdB9ilAH
         FbyqMm/M4AMaXJPexPu5aagb4IBil6N8kLqq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nO7lkM6RjTNbHIwVD6gb6a7R254B4BPf6V49+8/maMRVOXoppnH8Y/faKh54ujSCrQ
         aFoA/jV3yoFNDUBplwALgkHClV0nlxGYWeX3kDH90CyRzPjIOZGy6aG5jQaR4TaJy3fM
         /K0s2kVYWA+OoqaB+ZStpswt6sZpAtBVMo0ro=
Received: by 10.150.141.13 with SMTP id o13mr780800ybd.381.1300246957808;
        Tue, 15 Mar 2011 20:42:37 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id p29sm464377ybk.1.2011.03.15.20.42.36
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 20:42:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316024959.GA24932@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169099>

As "gcc -pedantic" notices, a two's complement 1-bit signed integer
cannot represent the value '1'.

 dir.c: In function 'init_pathspec':
 dir.c:1291:4: warning: overflow in implicit constant conversion [-Woverflow]

In the spirit of v1.7.1-rc1~10 (2010-04-06), 'unsigned' is what was
intended, so let's make the flags unsigned.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> I had the somewhat
> insane idea of turning on as many warnings as feasible and getting git
> to build with -Werror.

Here's another one.  Based against f577b92 from master (aka
nd/struct-pathspec).

 cache.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 4beb2dc..edd5b5a 100644
--- a/cache.h
+++ b/cache.h
@@ -503,13 +503,13 @@ extern int ie_modified(const struct index_state *, struct cache_entry *, struct
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspec() */
 	int nr;
-	int has_wildcard:1;
-	int recursive:1;
+	unsigned int has_wildcard:1;
+	unsigned int recursive:1;
 	int max_depth;
 	struct pathspec_item {
 		const char *match;
 		int len;
-		int has_wildcard:1;
+		unsigned int has_wildcard:1;
 	} *items;
 };
 
-- 
1.7.4.1
