From: Stefan Beller <sbeller@google.com>
Subject: Re: Coccinelle for automated refactors
Date: Mon, 6 Jun 2016 10:43:49 -0700
Message-ID: <CAGZ79kbDgP6PJ6F6ksA33qDs==FHDBe8EwE=iBOWe8as_oFLkA@mail.gmail.com>
References: <20160605205518.GA153578@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 19:43:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9yZA-0003e9-LU
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 19:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbcFFRnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 13:43:52 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33003 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbcFFRnv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 13:43:51 -0400
Received: by mail-qg0-f43.google.com with SMTP id j96so36325818qge.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=+W6/Totr/dwU2Kte+KHGXppxo0DO9WdetitFTgZ9F5U=;
        b=kRJGlo3jfQhyZB9SEYrl/ID+HnsK/GPsm0Q+SMljC38+jE47W6PBiLNE+w9hwghC9z
         HDrdbH3PJVdJVsKYBARBK5C4raXXeDUzI1QhU85Yf/X3ZfoZ/axv5wubL+R2+ms1piWb
         mx/O4n1W1P8telyYHsIIarWeUZW+o8IQ7Go3ifPaPLolu+X6aPZhEh6lmQcySfGcariA
         CM72azn0sTqpZK0pdXO+vn69cpZbHMdoET5ork4KUt7eN4tjuU5Pl1bEyqvkYZPV+tQP
         rGI60zgIYscUQ4Y7zn7c7CH0uXGquAb+yQ0+fUelFotgmmQg1fHQsHuIfp6pG4wyjC5l
         wffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=+W6/Totr/dwU2Kte+KHGXppxo0DO9WdetitFTgZ9F5U=;
        b=MsW2FYT9twiFrDjVlddBFIUb/tTT6+XXLs4cwL4Ip2K3dmhqP2rQcTpA0A+Jd1jQJA
         axNjwsh9Qtac8VPZZpXl/RdW+BCGMNTWDAqQNsDt/CTpjwvP+bdOw5azOXMv/DUEGCPO
         6x80VZj9lfHaqyAk15FjQRWwTco/gBB1BFq6gv510XammV+0npTVoPRJV0wq4ih13L1/
         euXpdTyiaDq8T9vs+2JY/UdgOu/thA87WW3q6TamYbLbf146dtb/B9HUWGEKBe1vAehk
         DFtwlgM2eliuDDgg8KGh0g6DN+GHPeTJ/uQrMIGGMa4avyU4o00WhoHFylFC+3n9xTKz
         aCEA==
X-Gm-Message-State: ALyK8tIxTTG+L2KCgPejMZbngmpnFUnNMi+IZepkgBsFMEwrYuaVAkBBaQSFoSvlLA8wYTzymVGTcKCN2gi8g/sw
X-Received: by 10.140.98.38 with SMTP id n35mr16136092qge.22.1465235030494;
 Mon, 06 Jun 2016 10:43:50 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Mon, 6 Jun 2016 10:43:49 -0700 (PDT)
In-Reply-To: <20160605205518.GA153578@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296541>

On Sun, Jun 5, 2016 at 1:55 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> One thing that I've noticed with the struct object_id conversion is that
> most of the work is mechanical transformations of a data member from one
> type into another.  Doing this by hand is both boring and error-prone,
> and it requires a tiresome review of nearly-identical changes.
>
> I've noticed that Coccinelle[0], a tool for automated refactors, has
> been used with great success on LKML, because it understands C well and
> can perform the transformations precisely and rapidly.  It also does
> nice things like indenting the code it modifies if necessary.
>
> An example semantic patch looks like this:
>
> @@
> expression E1;
> @@
> - is_null_sha1(E1.hash)
> + is_null_oid(&E1)
>
> @@
> expression E1;
> @@
> - is_null_sha1(E1->hash)
> + is_null_oid(E1)

So is this all we have to review then?

>
> This does what you think it does: transforms calls to is_null_sha1 that
> use the struct object_id hash member into calls to is_null_oid.
>
> I'd like to use this for some of the struct object_id work if others
> think this is a good idea.  I feel it's likely to reduce the reviewing
> overhead and allow people to better reason about the quality and
> behavior of the sent patches.  Of course, I would still review the
> patches manually for errors and improvements, and would still accept
> responsibility for the content of the patches.
>
> If there's interest, I can send a patch with a set of basic object_id
> transforms to make it easier for others to make those changes when
> they're doing work elsewhere in the codebase.

I would be interested in reviewing such a patch.

Thanks,
Stefan

>
> [0] http://coccinelle.lip6.fr/
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204
