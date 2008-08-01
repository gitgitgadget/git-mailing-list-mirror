From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Sat, 2 Aug 2008 03:10:24 +0400
Message-ID: <20080801231024.GL7008@dpotapov.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com> <200807311257.49108.litvinov2004@gmail.com> <20080731104529.GE7008@dpotapov.dyndns.org> <200808011023.32139.litvinov2004@gmail.com> <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com> <7vbq0dtawp.fsf@gitster.siamese.dyndns.org> <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com> <7vmyjwserv.fsf@gitster.siamese.dyndns.org> <20080801220932.GK7008@dpotapov.dyndns.org> <7vr698qt6w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 01:11:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP3mU-0001nA-VC
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 01:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208AbYHAXKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 19:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbYHAXKb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 19:10:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:36720 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbYHAXKa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 19:10:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so647878fgg.17
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=azZdRE6ZbxewFB4kCBrfxRmbWE67/nJnWrtQx39WpOA=;
        b=HPv4obDaz00HhBQox5fe+QrFdtOf0eVYMYlo3ndvormG8WlK5fvFbHCTDIicQAqV/0
         CGKY5arhcGMbFEdNYS+jXb3y63axKiN+Y3YqVlcwy0Q+BSThjeifMb5dAbC1Kz0MStm2
         o2R37mwpztn9fJDaGKoKjvt9JGSTggIQ78SYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aMkpX/nRABXAlGkrLUghDPmBdxqQIGOu5v5/WdUwB1vujzqSzwlzMq856JruWZwTWS
         8PRUCKb9Z9BTIsuXOdldzE4GBHhefIrz6CvM5zJ3dPEALKhnSywAl+K7sswRVPlFdM4A
         jfk1M99jiuaccdqCSIT3jUgd8PY9Iusij7yPE=
Received: by 10.86.97.7 with SMTP id u7mr6494949fgb.38.1217632228148;
        Fri, 01 Aug 2008 16:10:28 -0700 (PDT)
Received: from localhost ( [85.141.191.26])
        by mx.google.com with ESMTPS id 12sm812293fgg.0.2008.08.01.16.10.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 16:10:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr698qt6w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91123>

On Fri, Aug 01, 2008 at 03:14:15PM -0700, Junio C Hamano wrote:
> 
> Even though the patch was not compile tested, I did check the existing
> call sites are giving only 0 or 1, but I think converting these "please
> write -- I give you 1" callers to pass the bitmask would be a sane thing
> to do.

Here it goes. It turned out that there are only two places that actually
needs correction, while two others use '0'. I have run 'make test' and
it's passed the tests.

-- 8< --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Sat, 2 Aug 2008 02:56:45 +0400
Subject: [PATCH] convert index_path callers to use bitmask instead of 1

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 builtin-update-index.c |    5 +++--
 read-cache.c           |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 38eb53c..d3e212c 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -85,7 +85,7 @@ static int process_lstat_error(const char *path, int err)
 
 static int add_one_path(struct cache_entry *old, const char *path, int len, struct stat *st)
 {
-	int option, size;
+	int option, flags, size;
 	struct cache_entry *ce;
 
 	/* Was the old index entry already up-to-date? */
@@ -99,7 +99,8 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(ce->sha1, path, st, !info_only))
+	flags = info_only ? 0 : HASH_OBJECT_DO_CREATE;
+	if (index_path(ce->sha1, path, st, flags))
 		return -1;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
diff --git a/read-cache.c b/read-cache.c
index 2c03ec3..afd6005 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -550,7 +550,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		alias->ce_flags |= CE_ADDED;
 		return 0;
 	}
-	if (index_path(ce->sha1, path, st, 1))
+	if (index_path(ce->sha1, path, st, HASH_OBJECT_DO_CREATE))
 		return error("unable to index file %s", path);
 	if (ignore_case && alias && different_name(ce, alias))
 		ce = create_alias_ce(ce, alias);
-- 
1.6.0.rc1.34.gad373
