From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 10/16] update-index: enable/disable watchman support
Date: Wed,  6 Apr 2016 18:11:56 -0400
Message-ID: <1459980722-4836-11-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhA-0004rp-6P
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbcDFWMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:12:50 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33612 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbcDFWMr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:47 -0400
Received: by mail-qk0-f182.google.com with SMTP id k135so19821449qke.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zFNzZjvvTxmWTcKe/LI11MXuaMgJp6qS3yKiIbNqxGg=;
        b=AJZptIlJJkD3LPqM2ZETjp+YA0HqiJMwSvFU/HfhCjg9encd4rcxclHDeG4yGwXuIc
         y7D9Qr0ZZSTNLXIeXoJi/qUtqmWWC+w0+whx5FB7YptkANKNQXL86qIIYz2dZCZrZ4+d
         /cSUo2UTipuDMqQISyTeM4o/zZuD0ZORzCwRxilNJ+1rMjpJgaenhG3dE5NVrI+yBqjP
         XAxNUztVTp9KXl1UJgftrnccrGHIom+tvA6x94wOQ2ukfdUd6qAZWMxfM9IN+x8ZQaHt
         +KglcJS9848Nm5SVFmYJrXnStTNad7hvbLFW8YrrvnB8CWe6CIqNNiRtTrNu9CbDTOj8
         b7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFNzZjvvTxmWTcKe/LI11MXuaMgJp6qS3yKiIbNqxGg=;
        b=b+3GN8DKXZooZxwL66XwghRKT5RJ483Y9TVVDJBCVoO8kOfTBbye+MbWl9Pcq5ePN4
         LEMr3MdxBH+DK6lpCB3AgP8eIxihlCGMaXGYxkMmujOfjzGHBGT2klKUf66yBH8avgOR
         +9AdHRowmxVfRqt6ZD9TPBVxCrm2MmanRptW304dJfRkOJo1w5/cfyLzuK6+I6SL/XI3
         qGsJgxz38EUvLkAGYHhd6ncfjoQn6DvLeFolMZmI8iWF8oCLEecZ959b/QxdXzWcFfM3
         VuBy0ERnv2Itgaq9lJ0vH3YWa4kNQMMcwd2JRab9MMKry22Er3skoKJkQ5wB33ORk/mU
         1EWw==
X-Gm-Message-State: AD7BkJIFFmI6LDjpJ4IF/+bxO+zx11eDKZmmVNWvTEI28f+olFJ6lQRBfHRrRn8f5DROcQ==
X-Received: by 10.55.200.133 with SMTP id t5mr51070129qkl.55.1459980766240;
        Wed, 06 Apr 2016 15:12:46 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:45 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290878>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1c94ca5..7c08e1c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -914,6 +914,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 {
 	int newfd, entries, has_errors =3D 0, nul_term_line =3D 0;
 	enum uc_mode untracked_cache =3D UC_UNSPECIFIED;
+	int use_watchman =3D -1;
 	int read_from_stdin =3D 0;
 	int prefix_length =3D prefix ? strlen(prefix) : 0;
 	int preferred_index_format =3D 0;
@@ -1012,6 +1013,8 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 			    N_("test if the filesystem supports untracked cache"), UC_TEST)=
,
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), UC=
_FORCE),
+		OPT_BOOL(0, "watchman", &use_watchman,
+			N_("use or not use watchman to reduce refresh cost")),
 		OPT_END()
 	};
=20
@@ -1149,6 +1152,14 @@ int cmd_update_index(int argc, const char **argv=
, const char *prefix)
 		die("Bug: bad untracked_cache value: %d", untracked_cache);
 	}
=20
+	if (use_watchman > 0) {
+		the_index.last_update    =3D xstrdup("");
+		the_index.cache_changed |=3D WATCHMAN_CHANGED;
+	} else if (!use_watchman) {
+		the_index.last_update    =3D NULL;
+		the_index.cache_changed |=3D WATCHMAN_CHANGED;
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
--=20
2.4.2.767.g62658d5-twtrsrc
