From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/6] i18n win32: add git-pull eval_gettext variable prefix
Date: Wed, 25 May 2011 23:19:51 +0000
Message-ID: <1306365594-22061-4-git-send-email-avarab@gmail.com>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 01:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNNF-0007w3-L7
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab1EYXUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 19:20:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65287 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab1EYXUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:20:06 -0400
Received: by ewy4 with SMTP id 4so77568ewy.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=x4ThvdPITj7RNvjuXICm5Nvq0ZzE14YFE6Nttx5iqCk=;
        b=p1NF5ww9TO9M/BdOMhMzXx3qbR49LUnE5gkWGamMbpjqJZz8nKHm9Ae3PVpWYjGC5F
         6gv4o434s2+QZa+8s35x39d0wX3EYFNcdf3TbUKIpGC+YFX59AyW26hdXFr7N3xDOFnE
         /DU27ol0QDP5/iKVV5AsI8e68F9vnH1i86AbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GAxVn64X3dbTuZUkbIXqg0aM6Bk9C9XfmocKetfu/AVA6YjcDYtoSHL6Fnp+r1pMXh
         1W3tfaVpfvcV4FKfYgQeRK2v077uiVYP4UBVDxNq12SXaPEgik/4S3jTLEc5hRiyQhMv
         KXeuTB1uWbqnuInKng3heyDfkIyGW7sOHm0a8=
Received: by 10.213.14.209 with SMTP id h17mr85407eba.23.1306365604949;
        Wed, 25 May 2011 16:20:04 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b1sm102972eeg.19.2011.05.25.16.20.03
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 16:20:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174476>

Change the eval_gettext() invocations to use the GIT_I18N_VARIABLE_
prefix for variables used in eval_gettext. On Windows environment
variables are case insensitive, so e.g. $PATH clashes with $path. By
using a sufficiently unique prefix we work around that issue.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index a10b129..d5f25a6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -217,17 +217,18 @@ then
 	# $orig_head commit, but we are merging into $curr_head.
 	# First update the working tree to match $curr_head.
=20
+	GIT_I18N_VARIABLE_orig_head=3D$orig_head
 	(
 		eval_gettext "Warning: fetch updated the current branch head.
 Warning: fast-forwarding your working tree from
-Warning: commit \$orig_head." &&
+Warning: commit \$GIT_I18N_VARIABLE_orig_head." &&
 		echo
 	) >&2
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
 		die "$(eval_gettext "Cannot fast-forward your working tree.
 After making sure that you saved anything precious from
-$ git diff \$orig_head
+$ git diff \$GIT_I18N_VARIABLE_orig_head
 output, run
 $ git reset --hard
 to recover.")"
--=20
1.7.5.1
