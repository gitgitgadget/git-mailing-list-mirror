From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/4] Restructuring git-merge.sh
Date: Wed, 26 Mar 2008 05:40:43 -0700 (PDT)
Message-ID: <m3od91vetv.fsf@localhost.localdomain>
References: <402c10cd0803252056n122cae6cv1a6f4e46a5fb5096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 13:41:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeUwa-00050F-G3
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 13:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241AbYCZMkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 08:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756231AbYCZMkr
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 08:40:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:42087 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbYCZMkq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 08:40:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4345494wah.23
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 05:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Qunm7ef5zsGkPSlj7H2yvr1vzbVILsrTRhmI/WRZJIU=;
        b=Ri+QW8pCqhKiYJ9UwPvlfiM4vwk0gF1PBFVIyL0iFoAc+WUECom8nw95SCQ3tw0xekDtMBjL8egxPP6GSCCxcC8bAGAZyDe4AjQqExlscLrVDXliHfwAYntNrodfIaZj+RlfRRLWJ03CBokW3d4M+okgKdQbHB3FqNCEnNAu94o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Yy4aeGtnzaFPNNjOu5/P0PyJMSUFy11wgr0DEpCtsQJDiL/l+rz5HqLPz5fzHKCRw1AWbQg44Lr9JE15WZ0Xrkc5IWLrgsfjWZIF1XCaUMAiL/ecPzRDSu4/YRYKBJAgLl5YKmnOVlpSB8PL7W2pUYLRr2zX+uPy23oSzWrQ+S8=
Received: by 10.114.180.1 with SMTP id c1mr915528waf.121.1206535244480;
        Wed, 26 Mar 2008 05:40:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.230.153])
        by mx.google.com with ESMTPS id g12sm17985721nfb.27.2008.03.26.05.40.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Mar 2008 05:40:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2QCeSbg005143;
	Wed, 26 Mar 2008 13:40:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2QCeOwl005136;
	Wed, 26 Mar 2008 13:40:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0803252056n122cae6cv1a6f4e46a5fb5096@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78282>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> for preparation of new feature:

A bit of nit-picking: I'd like to have full sentences in commit
message (in the commit description); continuing first line isn't the
best style, IMHO.  I'd write instead the following:

  Restructure git-merge.sh, adding find_real_parents() function,
  in preparation for new feature:
 
>    Head reduction before selecting merge strategy
> 
> Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
> ---
>  git-merge.sh |  166 ++++++++++++++++++++++++++++++----------------------------
>  1 files changed, 85 insertions(+), 81 deletions(-)
> 
> diff --git a/git-merge.sh b/git-merge.sh
> index 17f40f2..2acd2cc 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -207,6 +207,29 @@ parse_config () {
>         args_left=$#
>  }
> 
> +# Find real parents
> +# Set the following variables as followd:
> +#   real_parents: The parents specified on the command line

Not specified_parents, or arg_parents?

> +#   common:       All common ancestors or not_queried
> +#   ff_head:      Fast forward of head
> +find_real_parents () {

Very nice.

> +       real_parents=$(git rev-parse "$@")
> +       real_parents=${real_parents#$LF}

Why this trick with adding $LF?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
