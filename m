From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] print an error message for invalid path
Date: Sat, 11 Oct 2008 20:39:37 +0400
Message-ID: <20081011163937.GA21650@dpotapov.dyndns.org>
References: <20081005004036.GO21650@dpotapov.dyndns.org> <1223172881-4948-1-git-send-email-dpotapov@gmail.com> <1223172881-4948-2-git-send-email-dpotapov@gmail.com> <48E9B7FE.2000503@viscovery.net> <20081007002221.GS21650@dpotapov.dyndns.org> <48EAFBC2.7020305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 18:41:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KohWS-00053y-59
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 18:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbYJKQjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 12:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbYJKQjo
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 12:39:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:61162 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbYJKQjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 12:39:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so672283fgg.17
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=flEekHbaqPdxSZzU+737+R+B2Y0p2cRmTAwZkHWA5cg=;
        b=HW9scu/pQBbH9tkKsrwMLcN/Zt8tYhQOj930UlD9RgtRDsYMSKm8yH2z0cQOSOYZ4t
         KR2hcaxk3m2VaUU3l7y4G3zsTJklIljpJ+61Wf3vSmEssOBnALQY8mz/T5I3Edg1zwWI
         xBlDOdd+ajVFc0GLBMs8Y3GZO5qFkkc589BaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=He7xjowJy8kYgEqL/wskYd/6uKjhiimi62HtB742TUQycm7A1dyogVdAaVqqoM/5+u
         UmetrupvLU7+Ewh41KmTkaBgvsOogjrE562yAB6sd6Psz9RMm5rdZdd6qxk6br6dRzJZ
         K1KWyB03CGo5tl9qoUEGKpfpWzUIbZVN32axo=
Received: by 10.86.83.2 with SMTP id g2mr3001008fgb.54.1223743181179;
        Sat, 11 Oct 2008 09:39:41 -0700 (PDT)
Received: from localhost (ppp85-141-237-231.pppoe.mtu-net.ru [85.141.237.231])
        by mx.google.com with ESMTPS id l19sm4194029fgb.7.2008.10.11.09.39.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Oct 2008 09:39:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48EAFBC2.7020305@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97982>

If verification of path failed, it is always better to print an error message
saying this than relying on the caller function to print a meaningful error
message (especially when the callee already prints error message for another
situation).

Because the callers of add_index_entry_with_check() did not print any error
message, it resulted that the user would not notice the problem when checkout
if an invalid path failed.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

On Tue, Oct 07, 2008 at 08:03:46AM +0200, Johannes Sixt wrote:
> 
> Look at the original patch. You did not change the behavior except to
> write more error messages. Maybe I misunderstand the words "to error out".
> I understand them as "to detect an error and return early", but not "write
> an error message".

For me, to "error out" means to show an error to the user. Usually, it
implies that the program will return after that, though not necessary
immediately. (Like gcc may print an error but it continues to parse the
program and may report more errors).

You are right that I have not changed anything in terms of exiting
earlier, and because I am aware about any commonly accepted definition
of what "error out" means, I have replaced the comment with less
ambiguous and detail description.


 builtin-update-index.c |    2 +-
 read-cache.c           |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 417f972..3a2291b 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -218,7 +218,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	struct cache_entry *ce;
 
 	if (!verify_path(path))
-		return -1;
+		return error("Invalid path '%s'", path);
 
 	len = strlen(path);
 	size = cache_entry_size(len);
diff --git a/read-cache.c b/read-cache.c
index 901064b..aff6390 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -591,8 +591,10 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	int size, len;
 	struct cache_entry *ce;
 
-	if (!verify_path(path))
+	if (!verify_path(path)) {
+		error("Invalid path '%s'", path);
 		return NULL;
+	}
 
 	len = strlen(path);
 	size = cache_entry_size(len);
@@ -874,7 +876,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	if (!ok_to_add)
 		return -1;
 	if (!verify_path(ce->name))
-		return -1;
+		return error("Invalid path '%s'", ce->name);
 
 	if (!skip_df_check &&
 	    check_file_directory_conflict(istate, ce, pos, ok_to_replace)) {
-- 
1.6.0.2.447.g64b01
