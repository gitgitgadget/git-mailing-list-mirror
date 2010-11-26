From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Sparse checkout fixes
Date: Sat, 27 Nov 2010 01:17:42 +0700
Message-ID: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>, tfransosi@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 26 19:19:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM2tA-0003DD-E8
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab0KZSTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 13:19:03 -0500
Received: from mail-px0-f194.google.com ([209.85.212.194]:35506 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZSTB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:19:01 -0500
Received: by pxi13 with SMTP id 13so480150pxi.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 10:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=+uDyFZVIVwSmo45QOMhIDaFUmvEP0dXa5eiusXu5LlI=;
        b=u+K7IzsrxWPctYj4qwais0gNu3Q2OuIpEDq6r9mArgXZz2oZILitRd8y6WPb5G5Cyk
         wn4dP5FbuHhNjh931uok58t4X42bW5DO54J7G0Pcf/4xwJgvwiAnQLzEcIhCXKzP6uZ1
         a2x5+eBe/OcvxuUdCYcORfbiB4TYkGL+6uz48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=btChc4BSUqzWLJ9yAl9P1xe6QKJhBv8MaQfkFbP5qBe9HEvh3U5o1zDDZ74WTxY/ZY
         zCWpxqS+M3tBUhma31JSRBcqHHW7Xy2YApUVJ6bTQ2W7txZImugHVs7dP0ynMI17cvlS
         q7EX9S+UjIzq7Usj1+97X1KhRzbYtLf/IUkPw=
Received: by 10.142.164.9 with SMTP id m9mr2739903wfe.97.1290795541095;
        Fri, 26 Nov 2010 10:19:01 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id b11sm2860676wff.9.2010.11.26.10.18.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 10:18:58 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Nov 2010 01:17:56 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162265>

[on top of nd/maint-fix-add-typo-detection]

This fixes a sparse pattern sometimes won't match a directory if
 - it does not end with a slash
 - it has wildcards

The series also improves performance a bit, thanks to 3/5, skip-worktre=
e
bits are precomputed.

Improvements in the previous round [1] are left out. I will need to
polish them a bit more.

[1] http://thread.gmane.org/gmane.comp.version-control.git/161477

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  cache.h: remove surrounding brackes and realign CE_* constants
  dir.c: add free_excludes()
  unpack-trees: move all skip-worktree checks back to unpack_trees()
  unpack-trees: fix sparse checkout's "unable to match directories"
  Revert "excluded_1(): support exclude files in index"

 Documentation/git-read-tree.txt      |    7 -
 cache.h                              |   26 ++--
 dir.c                                |   19 ++-
 dir.h                                |    1 +
 t/t1011-read-tree-sparse-checkout.sh |   14 ++-
 unpack-trees.c                       |  240 ++++++++++++++++++++++++++=
++++----
 6 files changed, 254 insertions(+), 53 deletions(-)

--=20
1.7.3.2.316.gda8b3
