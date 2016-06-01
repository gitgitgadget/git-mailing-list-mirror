From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/4] reachable.c: mark reachable objects in index from
 all worktrees
Date: Wed, 01 Jun 2016 14:57:15 -0400
Organization: Twitter
Message-ID: <1464807435.3988.9.camel@twopensource.com>
References: <574D382A.8030809@kdbg.org>
	 <20160601104519.16563-1-pclouds@gmail.com>
	 <20160601104519.16563-3-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	mhagger@alum.mit.edu
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 20:57:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8BKa-0001aV-Pb
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbcFAS5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 14:57:19 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34968 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbcFAS5S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 14:57:18 -0400
Received: by mail-qg0-f50.google.com with SMTP id e93so112459972qgf.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7KeE6y3Z0FK8PpDm61ecozDT7SPvneTXUwDYH2ZPP74=;
        b=amQjRTBnZ+K7uKQQVUfMyk/vX1smzhaafNyl8vLyTGEy/LiYj+95Bf5O5uM7WH2Jc+
         yanjHuZ4sib7787kJtw1qBVthZ8OvaJ8TgzSf74zF/8l1/jBxEnQFo5S/aoBxmK6DBOg
         dQgnxnZg5US5fO1fLpy8UJXxAZhPHb21C9hy7R3BCDPxU9aAeb9+ya2yZnkIDGgQDb5g
         4Ad90d2c5SYQrYPy+IYLGTSdcfzP5F8jQnTIav3kCNxaTgR8jt32WNiuXRiYaEL0uYjA
         mYhMJzBZmbxp6FdG4kNkI3QBiccEa8hmHZE5JDoXxGTXfmQU080sRDCXCwE+JKg0OZp+
         1KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7KeE6y3Z0FK8PpDm61ecozDT7SPvneTXUwDYH2ZPP74=;
        b=Ey79lusbWJ8tttddx90k/sBksnaY873pTw0l/yLOrnXF/JXKd29RONq/BEu7pC8OHu
         qddaeUoyqbjRcHQjnvMYFyqIC9F9A61t7Ks1OK+jdgnLEVUpWW/xCQQ4pAaDbu9eo3N6
         fuXJZM7AcI8HvNvOGp56fco6os+bkz6nN3BCN/h3Fnm6pXLf4me4GJP7LCOIaL31CngP
         0D9yPI8y8bCPwVKMDvSQshnQ9cT6nwv4pWbi/xHjgasDT/5LFS1boSO41+jv5YH4JTEw
         zkpH2Lyl/EFQPnn7c+ke8dLhSG8Gu2ck51kd3gT3urSKL2B8Y2Ixf+ooxcsKkE4RBKem
         IiWQ==
X-Gm-Message-State: ALyK8tIauanTjdRg6SppJBCPrEiyh5YFW3j7Y4Vu2N7BpnZgDZ7qBgBbpyz4W+tYWIJw2A==
X-Received: by 10.140.100.146 with SMTP id s18mr36122456qge.76.1464807437747;
        Wed, 01 Jun 2016 11:57:17 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id m135sm12729822qke.36.2016.06.01.11.57.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2016 11:57:16 -0700 (PDT)
In-Reply-To: <20160601104519.16563-3-pclouds@gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296149>

On Wed, 2016-06-01 at 17:45 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> Current mark_reachable_objects() only marks objects from index from
> _current_ worktree as reachable instead of all worktrees. Because
> this
> function is used for pruning, there is a chance that objects
> referenced
> by other worktrees may be deleted. Fix that.
>=20
> Small behavior change in "one worktree" case, the index is read again
> from file. In the current implementation, if the_index is already
> loaded, the index file will not be read from file again. This adds
> some
> more cost to this operation, hopefully insignificant because
> reachability test is usually very expensive already.
>=20
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  reachable.c      | 33 +++++++++++++++++++++++++++++----
>  t/t5304-prune.sh |  9 +++++++++
>  2 files changed, 38 insertions(+), 4 deletions(-)
>=20
> diff --git a/reachable.c b/reachable.c
> index 15dbe60..8f67242 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -9,6 +9,7 @@
>  #include "cache-tree.h"
>  #include "progress.h"
>  #include "list-objects.h"
> +#include "worktree.h"
> =20
>  struct connectivity_progress {
>  	struct progress *progress;
> @@ -155,6 +156,32 @@ int
> add_unseen_recent_objects_to_traversal(struct rev_info *revs,
>  				      FOR_EACH_OBJECT_LOCAL_ONLY);
>  }
> =20
> +static void add_objects_from_worktree(struct rev_info *revs)
> +{
> +	struct worktree **worktrees, **p;
> +
> +	worktrees =3D get_worktrees();
> +	for (p =3D worktrees; *p; p++) {
> +		struct worktree *wt =3D *p;
> +		struct index_state istate;
> +
> +		memset(&istate, 0, sizeof(istate));


Why not just struct index_state istate =3D {0}; ?
