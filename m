From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] pack-objects: produce a stable pack when --skip is given
Date: Fri,  5 Feb 2016 15:57:51 +0700
Message-ID: <1454662677-15137-3-git-send-email-pclouds@gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:58:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcDi-0007Bs-5x
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbcBEI6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 03:58:22 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35639 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcBEI6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:58:20 -0500
Received: by mail-pf0-f172.google.com with SMTP id 65so65655638pfd.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NGabDpPprfWQi8SENa/ZGT6Vy4jTANvbDKH3/jVrCh8=;
        b=0HuzCQDJakCGxdhZ2cjoeTfBCHHrLbSBgU6aJWaerpJI5MRqJ4z+9R1tBoxLOXH97H
         aqgH0MdMVQoHAMni6BOEo3qIws+n1/OVtKNslRlS+GUeP/+9kT+89UyKfA94wDlbM5+T
         MW0WyJXPZ9mtWmySl8xA+2Z2uBWlZUnU35oF4AUtNvSLEgCWi/52er+A787liPY7E3hX
         7QExs56/cQyU415bSoA9qiy5I8M0k0mkg8Cx/YRURl2wP/sMOy3OVFCYTXl/5YAcqk9Z
         ZqccqWbcOPJuai9aEI1vTn8XCcOJ/mFOmXvO1ImrkuZHbU2EzVQDimLJ31E12eMhJH6Y
         Ethg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NGabDpPprfWQi8SENa/ZGT6Vy4jTANvbDKH3/jVrCh8=;
        b=kgZOXyDv8gM9Upo5nVwuvHREha/5zz7U/mOyp2yrOdKoOyXcQYm4l6F/SfQiVifxkJ
         dVyfO9XWJdmM/4KhSXqxwBqY++S6xD0L2dyHZezUQdIh2iU4/yQ+xOIqm+6xllr1f+bN
         7jAyY8HBSu9hCcFzrEq0dNKttyzoLokYLmM6vUe+evJ1It4TG5KoUD1FkwNX1Qg9PV0C
         uPRFWryyyHxG7Nv6BWIFZU5R7e8SFfO75estPed29DX4H5wN2xQBONMDPCbpNIf32rFo
         z2/ddo+HlMAx47/u6DCGp9wRtU80P8zlV0j1ZYY5B4qPyx4ZzHj4C2bCkxcgXHk0Otgb
         KcDw==
X-Gm-Message-State: AG10YORqzkXgC1xarV9Psis0PzGrLOqEKk/7BcK5mO4oMW8DyjXknbgq8Lk56jvcui0cNw==
X-Received: by 10.98.67.153 with SMTP id l25mr18281720pfi.111.1454662700054;
        Fri, 05 Feb 2016 00:58:20 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id k65sm20219137pfb.30.2016.02.05.00.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 00:58:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Feb 2016 15:58:33 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285556>

Parallel delta search does not produce a stable pack so it's disabled
when --skip is used. zlib compression algorithm is stable. Ref
negotiation should be stable (at least on smart http). Ref changes
will be addressed separately.

So unless configuration files or git binary is changed, we should be
able to produce a stable pack. And if config or binaries are changed,
it's ok to abort and fetch a new (resumable) pack again.

Alternatively (and not implemented), pack-objects can be taught to
save the output pack when --skip=3D0 is passed in, then somehow find th=
e
cached version and send the remaining when --skip=3D<non-zero> is
given. This saves processing power at the cost of disk and cache
management.

The key thing for caching though, is "find the cached version". We do
not provide any way for pack-objects to send a "key", like http
cookies, to the client, so that the client can pass it back on the
next fetch. Regardless, the input from client must be identical
between fetches, the server should be able to extract a signature from
that and use it to associate with a cached pack. So no need for
sending keys from the server side.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 417c830..c58a9cb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2709,6 +2709,11 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 			if (get_oid_hex(skip_hash_hex, &skip_hash))
 				die(_("%s is not SHA-1"), skip_hash_hex);
 		}
+
+		/*
+		 * Parallel delta search can't produce stable packs.
+		 */
+		delta_search_threads =3D 1;
 	}
=20
 	argv_array_push(&rp, "pack-objects");
--=20
2.7.0.377.g4cd97dd
