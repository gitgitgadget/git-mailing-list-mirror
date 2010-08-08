From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] unpack-trees: only clear CE_UPDATE|CE_REMOVE when
 skip-worktree is always set
Date: Sun, 8 Aug 2010 17:39:24 -0500
Message-ID: <20100808223924.GA7946@burratino>
References: <1280556869-707-1-git-send-email-pclouds@gmail.com>
 <1280556869-707-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 00:40:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiEY4-0007m0-VT
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 00:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab0HHWkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 18:40:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42350 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab0HHWku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 18:40:50 -0400
Received: by gxk23 with SMTP id 23so3254332gxk.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4wOrJVkyojg5qKx5QoROpMnUGnljQVbO7kq0MF8uscw=;
        b=GBLVfxlORSZ5Zy754IXl+7SvG1+jlitShabCOzILJd2X6P98dlBaFItDcxVp5wMXC7
         v4sgCCOlB7gNvdrlvdcDmvzAhIqvWeGLCipvGtKKki/9RvCmOWkvptCkCScZ0ABiIxTO
         GxQ0ImspzSuH0BR6DOOqzh03vru+J2m1zFO6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mzPiUAsCke1r18zYRikWvxiBNJ/8mMCfjg+YS89oTMy3Tl5TUBaCpCmUlRPJW3DUPW
         pha5wiLWs7vLMeJ//xy71JOrrc+YUPTguvpMAwEh1UFdYPOqIe8vxhLsxrAIoBGt6WEA
         mDvC9Akc5p8biA1o8Q+bfV4O90jDEKoxHaNx0=
Received: by 10.100.165.18 with SMTP id n18mr16805628ane.252.1281307249927;
        Sun, 08 Aug 2010 15:40:49 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c6sm7162883anj.31.2010.08.08.15.40.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 15:40:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280556869-707-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152938>

Hi Duy,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> +++ b/t/t1011-read-tree-sparse-checkout.sh
> @@ -155,4 +155,16 @@ test_expect_success 'read-tree adds to worktree,=
 dirty case' '
>  	grep -q dirty sub/added
>  '
> =20
> +test_expect_success 'index removal and worktree narrowing at the sam=
e time' '
> +	>empty &&
> +	echo init.t >.git/info/sparse-checkout &&
> +	echo sub/added >>.git/info/sparse-checkout &&
> +	git checkout -f top &&
> +	echo init.t >.git/info/sparse-checkout &&
> +	git checkout removed &&
> +	git ls-files sub/added >result
> +	test ! -f sub/added &&

Missing =E2=80=9C&&=E2=80=9D.  Sorry to miss this before.

Patch for squashing follows.

-- 8< --
Subject: t1011 (sparse checkout): fix &&-chaining

Make sure errors from =E2=80=9Cgit checkout=E2=80=9D are detected.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 04d4450..9a07de1 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -162,7 +162,7 @@ test_expect_success 'index removal and worktree nar=
rowing at the same time' '
 	git checkout -f top &&
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout removed &&
-	git ls-files sub/added >result
+	git ls-files sub/added >result &&
 	test ! -f sub/added &&
 	test_cmp empty result
 '
--=20
1.7.2.1.544.ga752d.dirty
