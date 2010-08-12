From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] index-pack: Don't follow replace refs.
Date: Thu, 12 Aug 2010 05:17:53 +0200
Message-ID: <201008120517.53874.chriscool@tuxfamily.org>
References: <1281401149-23141-1-git-send-email-nelhage@ksplice.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nelson Elhage <nelhage@ksplice.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 05:18:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjOJ4-0006p8-VV
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 05:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759562Ab0HLDSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 23:18:05 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44584 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759623Ab0HLDSD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 23:18:03 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D4DAF818028;
	Thu, 12 Aug 2010 05:17:55 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <1281401149-23141-1-git-send-email-nelhage@ksplice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153332>

On Tuesday 10 August 2010 02:45:49 Nelson Elhage wrote:
> Without this, attempting to index a pack containing objects that have been
> replaced results in a fatal error that looks like:
> 
> fatal: SHA1 COLLISION FOUND WITH <replaced-object> !

I think it is a good patch except for a nit pick below.

> Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
> ---
>  builtin/index-pack.c |    2 ++
>  t/t6050-replace.sh   |    6 ++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a89ae83..fad76bf 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -884,6 +884,8 @@ int cmd_index_pack(int argc, const char **argv, const
> char *prefix) if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(index_pack_usage);
> 
> +	read_replace_refs = 0;
> +
>  	/*
>  	 * We wish to read the repository's config file if any, and
>  	 * for that it is necessary to call setup_git_directory_gently().
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index 203ffdb..b5635a7 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -219,6 +219,12 @@ test_expect_success 'bisect and replacements' '
>       git bisect reset
>  '
> 
> +test_expect_success 'index-pack and replacements' '
> +     git --no-replace-objects rev-list --objects HEAD | \
> +       git --no-replace-objects pack-objects test-

Maybe you could add "&&" at the end of the above line to make sure that an 
error in the commands is caught.

So, for what it's worth, if the above is fixed:

Acked-by: Christian Couder <chriscool@tuxfamily.org>

> +     git index-pack test-*.pack
> +'
> +
>  #
>  #
>  test_done

Thanks,
Christian.
