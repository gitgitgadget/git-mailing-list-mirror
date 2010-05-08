From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] pretty: initialize new cmt_fmt_map to 0
Date: Sat, 8 May 2010 16:07:39 -0500
Message-ID: <20100508210739.GA6486@progeny.tock>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
 <1272798044-10487-4-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 23:07:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OArEm-0000sl-KQ
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 23:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab0EHVGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 17:06:46 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:62445 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab0EHVGp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 17:06:45 -0400
Received: by qyk13 with SMTP id 13so3738084qyk.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Wvp2e2QSDPI02xnUmKJfWkw0lxmUifTypgpr9UyRBhQ=;
        b=IHZU+hcQ4ErCS1D82KOvz9yUxL+ygITySsWk1g6xG3AVzLCqp31wivbcO6pt4h4XaC
         /65rx9gUuakeGnTv7n3HPH1GdoP91hqN2npMWSNfsdz43qka63ZJ9K6lw4EedI6WnTuk
         iJfUjuPm5+K0h4voqLuVWRK2dvpWngTTkMtCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZqSOUxxFL8gLF402ifcd3iune1IdakmAgnjrdHJaimffRCXnl5HIWUDD5HytvMuaGS
         IbiHkdFt9R/4NwsEHAzsTMuE9FVVIdy3H4RoGnRbLW47XPdVk9Lzi1NCFsKl53Gao/Pe
         yMtIZJm34abv1F3dISCrrnjQinFUgOVowxjLM=
Received: by 10.229.221.84 with SMTP id ib20mr1457234qcb.93.1273352804621;
        Sat, 08 May 2010 14:06:44 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x34sm2326358qce.3.2010.05.08.14.06.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 14:06:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272798044-10487-4-git-send-email-wmpalmer@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146673>

Without this change, is_alias is likely to happen to be nonzero,
resulting in "fatal: invalid --pretty format" when the fake alias
cannot be resolved.

Use memset instead of initializing the members one by one to make it
easier to expand the struct in the future if needed.

t4205 (log --pretty) does not pass for me without this fix.

Cc: Will Palmer <wmpalmer@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sorry I missed this before.  Sane?

Jonathan

 pretty.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index aaf8020..4784f67 100644
--- a/pretty.c
+++ b/pretty.c
@@ -59,6 +59,7 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 		ALLOC_GROW(commit_formats, commit_formats_len+1,
 			   commit_formats_alloc);
 		commit_format = &commit_formats[commit_formats_len];
+		memset(commit_format, 0, sizeof(*commit_format));
 		commit_formats_len++;
 	}
 
-- 
1.7.1
