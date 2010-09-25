From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 4/4] rev-parse: make --flags imply --no-revs for remaining arguments.
Date: Sun, 26 Sep 2010 00:20:42 +1000
Message-ID: <3C9522B3-1386-4FD2-8607-F1A6A58D6D9A@gmail.com>
References: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com> <1285421633-22684-5-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0 (iPhone Mail 8B117)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"robbat2@gentoo.org" <robbat2@gentoo.org>,
	"casey@nrlssc.navy.mil" <casey@nrlssc.navy.mil>,
	"avarab@gmail.com" <avarab@gmail.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 16:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzVcs-0007PC-Pt
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 16:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab0IYOVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 10:21:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47148 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab0IYOVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 10:21:13 -0400
Received: by pvg2 with SMTP id 2so901858pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-transfer-encoding:content-type:message-id:cc
         :x-mailer:from:subject:date:to;
        bh=Bypa7/2C0xbskyzTYucn0Qk7VOB2c0aVrKex4YCDnUA=;
        b=UlVt82Fjp5kzooJQJ3T/GZvw3nXCEEXU/Q9ZNrXf1AK+J2FKnWuxjqCaR6xPzbEmJM
         e5+oCxElEyB/ldB65/GF8GNeuqBn/F9w9shjja8NJJjiDBGvBdr38BBa0FD8g+ir1J7m
         UknWysFQudOBgyi3jX9LRTTMnka7JyBd0CX40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        b=RImpGT4EtjgYQ3YqbpMkqvjq30NEfPyswpIwCPKxKFEsMl9rVRHYRYu/gIdnScgvQ0
         INNoBV3bDyroQW4Sm7N1qLuw4NPQj4spH5d0m9MgtU1ym2keifRMHnbU/RFpuc2ytIFo
         JAD7EKL/rQ04G0+9x5xRRmNopmOkagWtSX0/Q=
Received: by 10.114.26.6 with SMTP id 6mr5334583waz.82.1285424472967;
        Sat, 25 Sep 2010 07:21:12 -0700 (PDT)
Received: from [10.248.247.7] ([110.140.201.104])
        by mx.google.com with ESMTPS id r37sm5862010wak.23.2010.09.25.07.21.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 07:21:11 -0700 (PDT)
In-Reply-To: <1285421633-22684-5-git-send-email-jon.seymour@gmail.com>
X-Mailer: iPhone Mail (8B117)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157156>

Oops - 4/4 breaks --no-revs.

Will issue v5 with guarding test shortly.

jon.

On 25/09/2010, at 23:33, Jon Seymour <jon.seymour@gmail.com> wrote:

> This change ensures that git rev-parse --flags complies with its documentation,
> namely:
> 
>   "Do not output non-flag parameters".
> 
> Previously:
>   $ git rev-parse --flags HEAD
>   <sha1 hash of HEAD>
>   $
> 
> Now:
>   $ git rev-parse --flags HEAD
>   $
> 
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
> Documentation/git-rev-parse.txt |   24 +++++++++++++-----------
> builtin/rev-parse.c             |    6 +++++-
> t/t1510-rev-parse-flags.sh      |    2 +-
> 3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index f5e6637..f26fc7b 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -49,20 +49,22 @@ OPTIONS
>    'git rev-list' command.
> 
> --flags::
> -    Do not output non-flag parameters which are not also revisions.
> -    +
> -    If specified, this option causes 'git rev-parse' to stop
> -    interpreting remaining arguments as options for its own
> -    consumption. As such, this option should be specified
> -    after all other options that 'git rev-parse' is expected
> -    to interpret.
> +    Do not output non-flag parameters.
> ++
> +If specified, this option causes 'git rev-parse' to stop
> +interpreting remaining arguments as options for its own
> +consumption. As such, this option should be specified
> +after all other options that 'git rev-parse' is expected
> +to interpret.
> ++
> +If `--flags` is specified, `--no-revs` is implied.
> 
> --no-flags::
>    Do not output flag parameters.
> -    +
> -    If both `--flags` and `--no-flags` are specified, the first
> -    option specified wins and the other option is treated like
> -    a non-option argument.
> ++
> +If both `--flags` and `--no-flags` are specified, the first
> +option specified wins and the other option is treated like
> +a non-option argument.
> 
> --default <arg>::
>    If there is no parameter given by the user, use `<arg>`
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 2ad269a..84f9f07 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -13,7 +13,7 @@
> #define DO_REVS        1
> #define DO_NOREV    2
> #define DO_FLAGS    4
> -#define DO_NONFLAGS    8
> +#define DO_NONFLAGS    (8|DO_REVS)
> static int filter = ~0;
> 
> static const char *def;
> @@ -521,6 +521,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                continue;
>            }
>            if (!strcmp(arg, "--flags")) {
> +                if (!(filter & DO_FLAGS)) {
> +                    /* prevent --flags being interpreted if --no-flags has been seen */
> +                    continue;
> +                }
>                filter &= ~DO_NONFLAGS;
>                continue;
>            }
> diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
> index 53002df..4dd6228 100755
> --- a/t/t1510-rev-parse-flags.sh
> +++ b/t/t1510-rev-parse-flags.sh
> @@ -31,7 +31,7 @@ test_expect_success 'git rev-parse --no-revs --flags HEAD -> ""' \
> 
> test_expect_success 'git rev-parse --symbolic --flags HEAD -> "HEAD"' \
> '
> -    echo HEAD > expected &&
> +    : > expected &&
>    git rev-parse --symbolic --flags HEAD >actual &&
>    test_cmp expected actual
> '
> -- 
> 1.7.3.3.gc4c52.dirty
> 
