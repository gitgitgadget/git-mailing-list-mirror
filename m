From: Knittl <knittl89@googlemail.com>
Subject: [PATCH] builtin/fetch: print hash of deleted tag when updating
Date: Sun, 26 Sep 2010 18:10:47 +0200
Message-ID: <AANLkTi=KVDRzE3-NW+GTO_CL-KtNZ+BjkErgNKMPPtGf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 26 18:11:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oztot-00050T-8s
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 18:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab0IZQLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 12:11:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58507 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0IZQLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 12:11:09 -0400
Received: by wwd20 with SMTP id 20so224863wwd.1
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=yskW3+ZSFXp2iR8zGvl4wgsU2ISx4s1trEFLdK1vCtY=;
        b=lpx99gfRRURUsK/UVv25NqcH08gGRmkcgiui/bMvOjOiYNnFIt+s8oVNg6keXxB9mQ
         Vkn1Df49UkQq6GiKBM6wsvWEFszeWRYkUAuivnt6ZwSDj4cQ4tRwfSxSik9sAvuXLrcf
         gDTPHyDvYhjgTIlHaVz75mU/kcqTySg+ah8iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ryx58OxzLus/vZPkaQCIs+d5AyGkYcID/gmWKLlJ0sGECmaxiVJuJo0N1O/GLypyDm
         9rUxcgGHgCoH/n8ljb/bn/6n25pr5BmXbCU/K1QcgAyg/JRWYy7ZdV2LDptI8rnQXwd+
         pqoraekZGgb7YAjQNP8WDajYddka8MYnsDRu0=
Received: by 10.216.182.202 with SMTP id o52mr5110594wem.29.1285517468304;
 Sun, 26 Sep 2010 09:11:08 -0700 (PDT)
Received: by 10.216.157.197 with HTTP; Sun, 26 Sep 2010 09:10:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157236>

>From b1c2b07aa1f5db25ebdf190aa12ccb66a17f131a Mon Sep 17 00:00:00 2001
From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Sun, 26 Sep 2010 11:29:16 +0200
Subject: [PATCH] builtin/fetch: print hash of deleted tag when updating

`git fetch --tags` will unconditionally update (and thus overwrite)
existing tags, which is especially annoying for annotated and signed
tags.

Print the hash of the deleted tag so users can manually
recover their tags from such an update.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 builtin/fetch.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6fc5047..3c2eac4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -253,9 +253,10 @@ static int update_local_ref(struct ref *ref,
 	    !prefixcmp(ref->name, "refs/tags/")) {
 		int r;
 		r = s_update_ref("updating tag", ref, 0);
-		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '-',
+		sprintf(display, "%c %-*s %-*s -> %s%s (was %s)", r ? '!' : '-',
 			TRANSPORT_SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
-			pretty_ref, r ? "  (unable to update local ref)" : "");
+			pretty_ref, r ? "  (unable to update local ref)" : "",
+			find_unique_abbrev(ref->old_sha1, DEFAULT_ABBREV));
 		return r;
 	}

-- 
1.7.3.68.gb1c2b


-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
