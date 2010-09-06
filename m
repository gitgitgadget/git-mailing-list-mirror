From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] en/object-list-with-pathspec update
Date: Mon,  6 Sep 2010 14:47:05 +1000
Message-ID: <1283748429-31076-1-git-send-email-pclouds@gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 06:47:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTc2-0001HM-NI
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 06:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943Ab0IFErS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 00:47:18 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:43384 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0IFErR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 00:47:17 -0400
Received: by pxi10 with SMTP id 10so914378pxi.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2ve4liKlRvtbqfgMwquaPGPq9+DTezo5J6CGy4ypg+k=;
        b=TYddO5JavjeJeiQ5q2EcqdvFO1qUa3xxrCh+B95ROUlrCGMCJT5Q/nBpTdwsQ/EK0g
         WoBw07VKeEoHd8mS6J62HmxyW9N8sxXX85SBaeWmaSWzVvC08m982iAE8FXU3EYy80tK
         aFWBi6YaMj1FWkAxYb5yLkctb/UtKo5xNfLg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NsXgq2txgMlNLzsjJiKXSG8Aacq9vNDxPBeI/M3W8t3BcQINn5zCkaSvKVK8nhKYng
         ljz1jJCozmyED9kijpuWwdaFr1IVKPlo4JuaX1vO9Yp09YYFiBLs3kQnL+7aBWM6JAum
         g5c4W5OMO43l2+NVC8t31ZuChphm6GEKlwIiI=
Received: by 10.114.46.8 with SMTP id t8mr3249896wat.32.1283748436852;
        Sun, 05 Sep 2010 21:47:16 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id r37sm10437979wak.23.2010.09.05.21.47.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 21:47:15 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  6 Sep 2010 14:47:10 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283645647-1891-8-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155521>

On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wrote=
:
> diff --git a/cache-tree.c b/cache-tree.c
> index c60cf91..2ba6a76 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -2,6 +2,7 @@
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "cache-tree.h"
> +#include "diff.h"  /* FIXME: for tree_entry_interesting; maybe it sh=
ould be in tree-walk.h? */

Yes, please. And I'd rather see it done sooner than later, before
tree_entry_interesting() usage is spread over the place.

Elijah Newren (2):
  Add testcases showing how pathspecs are ignored with rev-list
    --objects
  Make rev-list --objects work together with pathspecs

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  tree-walk: copy tree_entry_interesting() as-is from tree-diff.c
  tree-walk: actually move tree_entry_interesting() to tree-walk.c

 list-objects.c           |   25 ++++++++++
 revision.c               |    8 ++-
 revision.h               |    3 +-
 t/t6000-rev-list-misc.sh |   51 +++++++++++++++++++
 tree-diff.c              |  121 ++------------------------------------=
--------
 tree-walk.c              |  110 ++++++++++++++++++++++++++++++++++++++=
+++
 tree-walk.h              |    3 +
 7 files changed, 201 insertions(+), 120 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh
