From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] make cg-export use tar-tree
Date: Wed, 27 Apr 2005 03:16:25 +0200
Message-ID: <426EE7E9.5010108@lsrfire.ath.cx>
References: <200504261928.44538.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 27 03:12:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQb5v-0002ZN-PV
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 03:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVD0BQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 21:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVD0BQ5
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 21:16:57 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:54672 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261882AbVD0BQi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 21:16:38 -0400
Received: from [10.0.1.3] (p508E5FF1.dip.t-dialin.net [80.142.95.241])
	by neapel230.server4you.de (Postfix) with ESMTP id 8159A55;
	Wed, 27 Apr 2005 03:16:33 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
In-Reply-To: <200504261928.44538.jcorbin@wunjo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Joshua T. Corbin schrieb:
> Here it is (this time with real tabs instead of two spaces ;) ), requires 
> Rene's tar-tree patch. Works quite speedily too I might add.

Maybe it's just Thunderbird, but I see single spaces instead of tabs
there.

> +  tar=$(mktemp -t cg-export.tar.XXXXXX)
> +  tar-tree $id "$base" > $tar
> +  case $ext in
> +  .tar.gz|.tgz)
> +   gzip -c9 $tar > $dest
> +   rm -f $tar
> +   ;;
> +  .tar.bz2)
> +   bzip2 -c $tar > $dest
> +   rm -f $tar
> +   ;;
> +  .tar)
> +   mv $tar $dest
> +   ;;
> +  esac

You don't need to create a temporary file using tar-tree.  The above can
be done like this:

  case $ext in
  .tar.gz|.tgz)
      tar-tree $id "$base" | gzip -9
      ;;
  .tar.bz2)
      tar-tree $id "$base" | bzip2
      ;;
  .tar)
      tar-tree $id "$base"
      ;;
  esac > $dest

This is both shorter and (a bit) faster.  More easily readable, too,
IMO.  Don't fear the pipe. ;-)  And I don't think we need to avoid
the triplication of tar-tree calls.

Thanks,
Rene
