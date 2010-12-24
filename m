From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Custom extended SHA-1 syntax
Date: Fri, 24 Dec 2010 21:07:44 +0700
Message-ID: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kevin@sb.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 15:09:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW8Kj-0006tf-JC
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 15:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab0LXOJL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 09:09:11 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34972 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab0LXOJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 09:09:09 -0500
Received: by pzk35 with SMTP id 35so236960pzk.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 06:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Qfqslx09oQseSbWCSAc8cLoaqjuDIO+disDhmqInhYw=;
        b=yIH82/qnzBFGxfDAeXp12Kx/Y/8B0Ci7R/T+qlT+ygvu4O/m/PjOjAL0V2ZI96/KYq
         oEh+mYXDCrCYxjCqwpQuy8Pn18uJsphPCUiydJND9loVgs/iPCUMqa2tL9Ps3eJiR8YL
         7mTE9pINpS280DN4WQBsjKS6vUmVO0/UWYo0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=e4MDBcV0l0b9a/91A2Z8wlUh38ewJsDlYIAobHj8GFV2OHr7al+xh7oNGM2+cCe0gH
         hTfmPVN7n0jF+OLe6qm9aqycANDzQj71Vo+GrnB4zobYo6mnzvtP9Eq1PMJ/pegZfQwk
         dtOk/NIvSp9G0MN/cN7ocT8V+CPsXMCzMUsS0=
Received: by 10.142.225.1 with SMTP id x1mr7559321wfg.0.1293199748572;
        Fri, 24 Dec 2010 06:09:08 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id p8sm12364509wff.16.2010.12.24.06.09.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 06:09:07 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Dec 2010 21:07:50 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164155>

Merry Christmas!

This series introduces two new syntax: @{~foo} and ^{~foo}.
Both syntax allow an external program to run and return the result. So
users can extend the ref/sha1 syntax as they want. External commands ar=
e
defined similar to aliases in config.

The former does ref->ref mapping. The latter does SHA-1->SHA-1
mapping. Both allow @{} and ^{} in the result respectively, so you can
make a chain of mapping (*). This should allow Kevin to add "search
the n-th commit that matches 'foo'" syntax.

I think this is something nice to have. For one thing, commonly used
mappings can be collected in config file and distributed. Shell require=
ments
can be loosened because you don't need shell backquotes
(OK I'm always on a shell so this is moot, but an IDE, maybe).

OK time for movies..

(*) They can also make infinite chain. I don't think I can stop them
from doing that.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  alias: add functions to do param substitution and alias running
  get_sha1: allow custom SHA-1 mapping with $SHA1^{~alias} syntax
  sha1_name: move interpret_nth_prior_checkout closer to
    interpret_branch_name
  interpret_branch_name: takes @{u} code out and reorder the function
  get_sha1: allow custom ref mapping with $ref@{~alias} syntax

 Documentation/config.txt    |   18 +++
 Documentation/revisions.txt |   12 ++
 alias.c                     |  167 ++++++++++++++++++++++-
 cache.h                     |   13 ++
 sha1_name.c                 |  321 ++++++++++++++++++++++++++++++++---=
-------
 t/t1511-rev-parse-caret.sh  |   45 ++++++
 t/t1512-rev-parse-at.sh     |   63 +++++++++
 7 files changed, 557 insertions(+), 82 deletions(-)
 create mode 100755 t/t1512-rev-parse-at.sh

--=20
1.7.3.3.476.g10a82
