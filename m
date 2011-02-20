From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/72] gettext.h: add no-op _() and N_() wrappers
Date: Sat, 19 Feb 2011 20:01:30 -0600
Message-ID: <20110220020130.GA17225@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 03:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqycR-0003VO-8K
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 03:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab1BTCBh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 21:01:37 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37408 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab1BTCBg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 21:01:36 -0500
Received: by iwn8 with SMTP id 8so731278iwn.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 18:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jyO0jXfrNYMiZ10/1H/bD4rSzYEi6uALgD+gBKz9UzA=;
        b=XIvfFBzVL4dKkSdv4i9hK8Z+K58MR05MiHdfMEsUm+zR9+wFsmgMzRg3wwhRf4p11W
         5yoCpo+jr3B98AVrgrbQm7brwjj7OI/IPV5bgJiZGJ4PdbMExdFrlxOA9bX8eGvC5P99
         mYJhn1tF10Z/LPo83JP1EIR+3pNIX9SpPrNTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jDJNTV/kcNV1RKdLzGkHX5h5dyXjKnoamNSitJ3bGsdPiZlQuw48zaht5qHDZ8dMsV
         A5tVHahCxi+YIZPKpnzlYtVI6hkuv/PFs+YPDN662Mx81zHMvrgwvMjr5f6p40mAi/9/
         AKsPEuqK3uYVsPKLBk/uHi/DFmNjlIWDls0ko=
Received: by 10.231.30.76 with SMTP id t12mr1766782ibc.163.1298167296307;
        Sat, 19 Feb 2011 18:01:36 -0800 (PST)
Received: from elie ([69.209.79.88])
        by mx.google.com with ESMTPS id i16sm3446644ibl.18.2011.02.19.18.01.34
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 18:01:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298143495-3681-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167390>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add a new header called gettext.h which is currently a no-op.

Thanks.  I'd suggest squashing this with patch #2 (#including
gettext.h in cache.h).

> --- /dev/null
> +++ b/gettext.h
> @@ -0,0 +1,9 @@
> +/*
> + * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason

Is such a simple header file copyrightable?  But I don't mind.

> + *
> + * This is a skeleton no-op implementation of gettext for Git. It'll
> + * be replaced by something that uses libintl.h and wraps gettext() =
in
> + * a future patch series.
> + */
> +#define N_(s) (s)

Might be nice to make this an inline function, for type safety.

> +#define _(s) (s)

This one can't be a function, though, since it needs to transform
literals to literals.

Some possible tweaks:

 - protect against double inclusion
 - make _ into a function
 - add a comment vaguely explaining N_
 - avoid confusing errors if some other header has pre-defined _.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 gettext.h |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/gettext.h b/gettext.h
index c68bbe9..2f806cb 100644
--- a/gettext.h
+++ b/gettext.h
@@ -1,3 +1,10 @@
+#ifndef GETTEXT_H
+#define GETTEXT_H
+
+#ifdef _
+#error "namespace conflict: '_' is pre-defined?"
+#endif
+
 /*
  * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
  *
@@ -5,5 +12,13 @@
  * be replaced by something that uses libintl.h and wraps gettext() in
  * a future patch series.
  */
-#define N_(s) (s)
-#define _(s) (s)
+
+static inline const char *_(const char *msgid)
+{
+	return msgid;
+}
+
+/* Mark msgid for translation but do not translate it. */
+#define N_(msgid) (msgid)
+
+#endif
--=20
1.7.4.1
