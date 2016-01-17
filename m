From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/4] builtin/ls-remote: add support for showing symrefs
Date: Sun, 17 Jan 2016 12:16:21 +0100
Message-ID: <20160117111621.GB7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453028643-13978-5-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Jan 17 12:16:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKlJP-00050z-Jz
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 12:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbcAQLP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 06:15:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34408 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbcAQLPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 06:15:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so11178874wmb.1
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 03:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zEAWrpA5aQnxICIhK20dJWcM0Y3MYomMCbKQGKa38lc=;
        b=WVTsqm8up86/Vin3drVEP+2oDBnyI1xmKY41I4TW3WkAA8FEXC/rk50Rm8IqYBe5mm
         WPfPgyTCP3NdeRCVT3zvyan0MSo7TtyL14vXABlhi9Qtyhs8RI2xg5F/OzFiE2qr39SE
         cIF5g3V9A4PRRZz6sMCZM27IP0irFHLgEPYF4/+JCTVrIJqcrUcrcMpI9m/VNgB1twI2
         XPSa7lFvz/QUJhdOK46RNrsu1kEMvgF3Z+h5pv+Saza9sGMTfnYAVRc6P7tKrwA2yN4/
         sowYkoHZxLxMJAN3lp7RMKb+jeG4sn351LBd8S/+iqngPIj1Muazus3qEzbleIzzE6x2
         xqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zEAWrpA5aQnxICIhK20dJWcM0Y3MYomMCbKQGKa38lc=;
        b=JDj6zUgsmMyZD7aDz3lmhUQr6JUB4l1ei6heigLOwfbYos6bLVNm5d6vUIDMqkkpxP
         qsPSfhNAhdK5bScmXCZYLaJuERKZwYbxulU0uceqkp3blJZUaj+7apMPp+9bUmHyzFVk
         2B70geS3AIouDxcHFj6YvGz1o/5kjvdzgr/iUJ4PntAHf6FvB09kHdx8QdNAC0oXVP+H
         ZLuNNG8JN9hO9tzhngynDvU5ZK3a2qPrOexFBACcimGMqkA68K/HvLSqd+DLPcj0GrmP
         vkTy1bTrNuqj5tcc/K7ZaN86DTDIT6ACGDYarqEs7UfVpEMkAcqLrsFCjgt1t5WvwEKT
         DRMA==
X-Gm-Message-State: AG10YOR1ys8lPSqFHx4SgJyTAJttCMFdmHJVCVSuDx9cdWmktugJpPR/mXPID2SmtCoq6A==
X-Received: by 10.28.158.194 with SMTP id h185mr8302247wme.48.1453029353952;
        Sun, 17 Jan 2016 03:15:53 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id a126sm10763793wmh.0.2016.01.17.03.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 03:15:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453028643-13978-5-git-send-email-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284255>

On 01/17, Thomas Gummerer wrote:
> Sometimes it's useful to know the main branch of a git repository
> without actually downloading the repository.  This can be done by
> looking at the symrefs stored in the remote repository.  Currently git
> doesn't provide a simple way to show the symrefs stored on the remote
> repository, even though the information is available.  Add a --symrefs
> command line argument to the ls-remote command, which shows the symrefs
> on the remote repository.
>
> Suggested-by: pedro rijo <pedrorijo91@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---

I meant to delete this, the other 4/4 has the re-worded commit
message.  Please ignore this one.

>  Documentation/git-ls-remote.txt |  8 +++++++-
>  builtin/ls-remote.c             |  9 ++++++++-
>  t/t5512-ls-remote.sh            | 20 ++++++++++++++++++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 31c1427..5efef9e 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -10,7 +10,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git ls-remote' [--heads] [--tags]  [--upload-pack=<exec>]
> -	      [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]
> +	      [-q | --quiet] [--exit-code]
> +	      [--symrefs] [--get-url] [<repository> [<refs>...]]
>
>  DESCRIPTION
>  -----------
> @@ -50,6 +51,11 @@ OPTIONS
>  	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]) and
>  	exit without talking to the remote.
>
> +--symrefs::
> +	Show the symrefs on the server.  Shows only the symrefs by
> +	default, and can be combined with --tags and --heads to show
> +	refs/heads and refs/tags as well.
> +
>  <repository>::
>  	The "remote" repository to query.  This parameter can be
>  	either a URL or the name of a remote (see the GIT URLS and
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 6ee7b0e..f33ada9 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -5,7 +5,8 @@
>
>  static const char * const ls_remote_usage[] = {
>  	N_("git ls-remote [--heads] [--tags]  [--upload-pack=<exec>]\n"
> -	   "                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]"),
> +	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
> +	   "                     [--symrefs] [<repository> [<refs>...]]"),
>  	NULL
>  };
>
> @@ -38,6 +39,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	int quiet = 0;
>  	int status = 0;
>  	int tags = 0, heads = 0, refs = 0;
> +	int symrefs = 0;
>  	const char *uploadpack = NULL;
>  	const char **pattern = NULL;
>
> @@ -58,6 +60,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			    N_("take url.<base>.insteadOf into account"), 1),
>  		OPT_SET_INT(0, "exit-code", &status,
>  			    N_("exit with exit code 2 if no matching refs are found"), 2),
> +		OPT_BOOL(0, "symrefs", &symrefs, N_("show symrefs")),
>  		OPT_END()
>  	};
>
> @@ -98,6 +101,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	if (!dest && !quiet)
>  		fprintf(stderr, "From %s\n", *remote->url);
>  	for ( ; ref; ref = ref->next) {
> +		if (symrefs && ref->symref)
> +			printf("symref: %s	%s\n", ref->symref, ref->name);
> +		if (symrefs && !flags)
> +			continue;
>  		if (!check_ref_type(ref, flags))
>  			continue;
>  		if (!tail_match(pattern, ref->name))
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index aadaac5..68a1429 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -163,4 +163,24 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
>  	grep refs/tags/magic actual
>  '
>
> +test_expect_success 'ls-remote --symrefs' '
> +	cat >expect <<-EOF &&
> +	symref: refs/heads/master	HEAD
> +	EOF
> +	git ls-remote --symrefs >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'ls-remote with symrefs and refs combined' '
> +	cat >expect <<-EOF &&
> +	symref: refs/heads/master	HEAD
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
> +	EOF
> +	git ls-remote --symrefs --refs >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.7.0.14.g2b6d3d6
>

--
Thomas Gummerer
