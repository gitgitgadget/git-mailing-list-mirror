From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 4/6] transport.c::transport_push(): make ref status
 affect return value
Date: Thu, 24 Dec 2009 15:43:52 +0800
Message-ID: <20091224154352.ecefd242.rctay89@gmail.com>
References: <20091224154258.08b4fe44.rctay89@gmail.com>,
 <20091224154158.15ba580f.rctay89@gmail.com>,
 <20091224154057.33611ae7.rctay89@gmail.com>,
 <20091224154005.a642c8ec.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 08:44:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNiMn-0006p4-Cd
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870AbZLXHoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756818AbZLXHoF
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:44:05 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:43784 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846AbZLXHoB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:44:01 -0500
Received: by yxe17 with SMTP id 17so7444670yxe.33
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 23:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NNjJdrsR+yt+OQf4gj6Zyc/mX/B9hpoYxNJ5L/zyn1I=;
        b=KnxSmjC6eOtWTWpB7JCJUY/F7kA66xMz0YSLQTJauGlFOy4pAtS9dZBuw97g7hcvVr
         GzMTZsIgx5qWrpLPp66/JRg9aAekgjp9CVBUiuNFzAQAlC3RV+y7QUgNEnT+8Dytpw97
         z/DXtx9HpQP80Mj6r/u/ygmUrL5eayzibJ8cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=srNLTlwxra2C/BjtHYrBiofNMQ0JVvBfdM6CKvHBReM9m9+Nzij+G4ss7ZyvYi+yKj
         mQR5XlYgH4moQ6G8AC8QmjAc4TchYPqefjwNu/Ynnk/+8LcGyGZnUm7T90fvrHTi4aDH
         c1rZaxza6Abv2v6oX4BmSBlLEi5RscbTzPcpw=
Received: by 10.90.17.2 with SMTP id 2mr4051576agq.100.1261640640123;
        Wed, 23 Dec 2009 23:44:00 -0800 (PST)
Received: from your-cukc5e3z5n (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4246560gxk.10.2009.12.23.23.43.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 23:43:59 -0800 (PST)
In-Reply-To: <20091224154258.08b4fe44.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135647>

Use push_had_errors() to check the refs for errors and modify the
return value.

Mark the non-fast-forward push tests to succeed.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed nothing from v2 except tests and mentioning it in the commit
message.

 t/t5541-http-push.sh |    4 ++--
 transport.c          |    7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 86dbcb2..fee9494 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -88,7 +88,7 @@ test_expect_success 'used receive-pack service' '
 	test_cmp exp act
 '

-test_expect_failure 'non-fast-forward push fails' '
+test_expect_success 'non-fast-forward push fails' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout master &&
 	echo "changed" > path2 &&
@@ -104,7 +104,7 @@ test_expect_success 'non-fast-forward push show ref status' '
 	grep "^ ! \[rejected\][ ]*master -> master (non-fast-forward)$" output
 '

-test_expect_failure 'non-fast-forward push shows help message' '
+test_expect_success 'non-fast-forward push shows help message' '
 	grep \
 "To prevent you from losing history, non-fast-forward updates were rejected
 Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
diff --git a/transport.c b/transport.c
index 12c4423..9b23989 100644
--- a/transport.c
+++ b/transport.c
@@ -875,7 +875,7 @@ int transport_push(struct transport *transport,
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
 		int quiet = flags & TRANSPORT_PUSH_QUIET;
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
-		int ret;
+		int ret, err;

 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -892,8 +892,11 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_FORCE);

 		ret = transport->push_refs(transport, remote_refs, flags);
+		err = push_had_errors(remote_refs);

-		if (!quiet || push_had_errors(remote_refs))
+		ret |= err;
+
+		if (!quiet || err)
 			print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
 					nonfastforward);
--
1.6.6.rc1.249.g048b3
