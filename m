From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/10] nd/clone-detached
Date: Tue, 10 Jan 2012 16:56:57 +0700
Message-ID: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:57:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYSJ-0004vf-Rj
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630Ab2AJJ5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:57:19 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48718 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab2AJJ5S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:57:18 -0500
Received: by iabz25 with SMTP id z25so664914iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=riDV/rl6FfCZyt5Q7vd/UaJdhC74nJL5nncgvLZ+SjY=;
        b=FxiDAhLrRDboxsqWIPiGAfIfN2IPsPkv7aqb30dO7aqG3+oV2fUx62AhUt0qZT2Pa2
         qRw5QhACXksQJ0VYZcaRRCsBIZE9xzIeIP8u1xuNt+BiQ74MJuTLykK8X2UQbKuJ5H6O
         rmHsHelkNhlgzFCagFyfE27B+KmlzynKewHy4=
Received: by 10.50.76.162 with SMTP id l2mr1439171igw.1.1326189438110;
        Tue, 10 Jan 2012 01:57:18 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id l28sm261446341ibc.3.2012.01.10.01.57.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:57:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:57:08 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188232>

Compare to v2, this round does more refactoring, which makes
cmd_clone() looks easier to follow in the end, in my opinion.

There's also 7/10 that refuses --branch=3D<nonexistent>. I don't know i=
f
I react too strong. The current behavior is fall back to remote's HEAD
(and detached HEAD if remote's HEAD is detached). Maybe we should only
refuse it when it leads to detached HEAD and let it fall back to
remote's HEAD otherwise.

The last two patches remain debatable. If we disallow detached HEAD
from new clones, perhaps we could put <tag>^{commit} to
refs/heads/master then drop the last patch. t3501.6, t5527.2, t5707.5,
t7406.29 likes to have detached HEAD, but those can be fixed.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  t5601: add missing && cascade
  clone: write detached HEAD in bare repositories
  clone: factor out checkout code
  clone: factor out HEAD update code
  clone: factor out remote ref writing
  clone: delay cloning until after remote HEAD checking
  clone: --branch=3D<branch> always means refs/heads/<branch>
  clone: refuse to clone if --branch points to bogus ref
  clone: allow --branch to take a tag
  clone: print advice on checking out detached HEAD

 Documentation/git-clone.txt |    5 +-
 advice.c                    |   14 +++
 advice.h                    |    1 +
 builtin/checkout.c          |   16 +---
 builtin/clone.c             |  252 +++++++++++++++++++++++++----------=
--------
 t/t5601-clone.sh            |   40 ++++++-
 t/t5706-clone-branch.sh     |    8 +-
 transport.c                 |    5 +-
 8 files changed, 207 insertions(+), 134 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
