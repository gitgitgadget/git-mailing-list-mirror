From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 3/3] pack-objects: honor '.keep' files
Date: Mon, 3 Nov 2008 12:49:58 -0800
Message-ID: <20081103204958.GN15463@spearce.org>
References: <-RiFxYEd9Wiq2fWX74zYGUiEwrzLeoFDb1KuG3-Xo-s@cipher.nrlssc.navy.mil> <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:51:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx6OH-0008Id-FF
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 21:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYKCUt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbYKCUt7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 15:49:59 -0500
Received: from george.spearce.org ([209.20.77.23]:40130 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYKCUt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 15:49:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1CE0D3835F; Mon,  3 Nov 2008 20:49:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99994>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> From: Brandon Casey <drafnel@gmail.com>
> 
> By default, pack-objects creates a pack file with every object specified by
> the user. There are two options which can be used to exclude objects which
> are accessible by the repository.
> 
>    1) --incremental
>      This excludes any object which already exists in an accessible pack.
> 
>    2) --local
>      This excludes any object which exists in a non-local pack.
> 
> With this patch, both arguments also cause objects which exist in packs
> marked with a .keep file to be excluded. Only the --local option requires
> an explicit check for the .keep file. If the user doesn't want the objects
> in a pack marked with .keep to be exclude, then the .keep file should be
> removed.
> 
> Additionally, this fixes the repack bug which allowed porcelain repack to
> create packs which contained objects already contained in existing packs
> marked with a .keep file.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

This one and the one before it (2/3):

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  builtin-pack-objects.c |    2 +-
>  t/t7700-repack.sh      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 15b80db..8be9113 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -701,7 +701,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  				break;
>  			if (incremental)
>  				return 0;
> -			if (local && !p->pack_local)
> +			if (local && (!p->pack_local || p->pack_keep))
>  				return 0;
>  		}
>  	}
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 27af5ab..5b1cd05 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -4,7 +4,7 @@ test_description='git repack works correctly'
>  
>  . ./test-lib.sh
>  
> -test_expect_failure 'objects in packs marked .keep are not repacked' '
> +test_expect_success 'objects in packs marked .keep are not repacked' '
>  	echo content1 > file1 &&
>  	echo content2 > file2 &&
>  	git add . &&
> -- 
> 1.6.0.3.552.g12334
> 

-- 
Shawn.
