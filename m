From: "David Aguilar" <davvid@gmail.com>
Subject: Re: [PATCH] Fix submodule sync with relative submodule URLs
Date: Wed, 24 Sep 2008 00:29:21 -0700
Message-ID: <402731c90809240029l308726aeme14c0e7fe2d54a3c@mail.gmail.com>
References: <200809221808.31730.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Mark Levedahl" <mdl123@verizon.net>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 24 09:30:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiOpU-00080P-By
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 09:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYIXH3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 03:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbYIXH3W
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 03:29:22 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:14600 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYIXH3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 03:29:22 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2631822wfd.4
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xtkhmMifsPXRspmJosdhrT/GzDBiWKxAIOfhcmlR50Q=;
        b=D9MTCAf4OWnqOc9DOrlXyepJkqLTU0yPVoAozMxLRuXwKcUXfclt7UX6s3IJo/f7Ho
         49MHGqgKHD979yl8JLoW1RVz8nuUuvNhE6EWaaO1eZC7Gn0I+WU9QkzwwttUYR+hG3Cr
         VXRGXVla1sgMgPzStI3v6oyenQp3Aq9LAzBI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BzgKDoL+Trd+gMkLwo6XDjVxSpNedFGT6Qag4ikplwpaiyQLH8VAtmuLSGEzwHol6r
         gK3+9EbEUlFNoF0cfp0j+v/ILoqvXtx7o3ITV4boxJMciW1PHarTMRoLVrJLqQ0lfmRK
         suL9YJzNA7MkRvkPe3qNRqEFwqT0R1eDrg/e0=
Received: by 10.142.238.12 with SMTP id l12mr2395963wfh.204.1222241361469;
        Wed, 24 Sep 2008 00:29:21 -0700 (PDT)
Received: by 10.142.126.21 with HTTP; Wed, 24 Sep 2008 00:29:21 -0700 (PDT)
In-Reply-To: <200809221808.31730.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96621>

On Mon, Sep 22, 2008 at 9:08 AM, Johan Herland <johan@herland.net> wrote:
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  git-submodule.sh |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 1c39b59..92be0fe 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -634,6 +634,14 @@ cmd_sync()
>        do
>                name=$(module_name "$path")
>                url=$(git config -f .gitmodules --get submodule."$name".url)
> +
> +               # Possibly a url relative to parent
> +               case "$url" in
> +               ./*|../*)
> +                       url=$(resolve_relative_url "$url") || exit
> +                       ;;
> +               esac
> +
>                if test -e "$path"/.git
>                then
>                (
> --
> 1.6.0.1.400.gd2470
>

Instead of just doing an "|| exit" shouldn't it report an explanation
of the error?
Other than that, it looks good to me.

Mark, Junio?


-- 
 David
