From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v2] git-am: add option to extract email Message-Id: tag
 into commit log
Date: Wed, 02 Jul 2014 16:18:12 +0200
Message-ID: <53B414A4.2060909@gmail.com>
References: <1404291113-4424-1-git-send-email-avi@cloudius-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Avi Kivity <avi@cloudius-systems.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 16:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2LMe-000898-D4
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 16:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbaGBOSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 10:18:20 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:54432 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbaGBOSU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 10:18:20 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so11069744wgh.33
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ghCN+cbHwW8I1DHrUG9GW0dTOq9VNqbbsc1thuJ/CVw=;
        b=F58nGuhV0QJRsXdLYnEOQMsLAPp53PWw1H2HaF6jo0PKrT5n0CtTbeJo15r4uKP64y
         L71QJKOVP6SRycSOuoVXHihLgoKJHC5+wm1K732oaFq4z12nJD6X8mzhFxHpQIjcWJnI
         0xLK7tWPUtJ/y5BhB34OSDHN714E8ri9zzo5/nxn9T5Nji1K5WiZ0SYuywJI/MsNASYK
         9sWOQ4NXRInLbncfutt2X5LPFqJcvIyX/Pz1sJXFItHdnkNcAUO8Kemg8r4lgN/CSDbE
         7reNGm9FTQPCpgivTHI1ug1gPbHnQD6bu5NVouHngaDxEsHdy1TN4kCEVFrPXHZVOJqv
         f1Qw==
X-Received: by 10.180.13.139 with SMTP id h11mr44431829wic.40.1404310697891;
        Wed, 02 Jul 2014 07:18:17 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id gq4sm21859105wib.8.2014.07.02.07.18.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 07:18:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1404291113-4424-1-git-send-email-avi@cloudius-systems.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252781>

Hi Avi,

On 07/02/2014 10:51 AM, Avi Kivity wrote:
> Some workflows prefer to track exactly which email message was used to
> generate a commit.  This can be used, for example, to generate an
> automated acknowledgement when a patch is committed as a response to
> the patch email, or as a reference to the thread which introduced the
> patch.
> 
> Support this by adding a --message-id option (abbreviated as -m) to
> git-am, which will then extract the message ID and append it to the
> email commit log.
> 
> Signed-off-by: Avi Kivity <avi@cloudius-systems.com>
> ---
> 
> v2: adjust to pass test suite (t5100)
> 
>  Documentation/git-am.txt |  6 ++++++
>  builtin/mailinfo.c       |  2 +-
>  git-am.sh                | 10 +++++++++-
>  t/t5100/info0004         |  1 +
>  t/t5100/info0005         |  1 +
>  t/t5100/info0012         |  1 +
>  6 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 9adce37..8a251a1 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -15,6 +15,7 @@ SYNOPSIS
>  	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
>  	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
>  	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
> +	 [--message-id]
>  	 [(<mbox> | <Maildir>)...]
>  'git am' (--continue | --skip | --abort)
>  
> @@ -121,6 +122,11 @@ default.   You can use `--no-utf8` to override this.
>  	user to lie about the author date by using the same
>  	value as the committer date.
>  
> +-m::
> +--message-id::
> +	Extract the Message-Id: header from the e-mail and
> +	append it to the commit message's tag stanza.
> +
>  --skip::
>  	Skip the current patch.  This is only meaningful when
>  	restarting an aborted patch.
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index cf11c8d..f1e1fed 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -278,7 +278,7 @@ static void cleanup_space(struct strbuf *sb)
>  
>  static void decode_header(struct strbuf *line);
>  static const char *header[MAX_HDR_PARSED] = {
> -	"From","Subject","Date",
> +	"From","Subject","Date","Message-Id"
>  };
>  
>  static inline int cmp_header(const struct strbuf *line, const char *hdr)
> diff --git a/git-am.sh b/git-am.sh
> index ee61a77..c0e7bdd 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -39,6 +39,7 @@ committer-date-is-author-date    lie about committer date
>  ignore-date     use current timestamp for author date
>  rerere-autoupdate update the index with reused conflict resolution if possible
>  S,gpg-sign?     GPG-sign commits
> +m,message-id    copy the Message-Id: header to the commit's tag stanza
>  rebasing*       (internal use for git-rebase)"
>  
>  . git-sh-setup
> @@ -371,7 +372,7 @@ split_patches () {
>  prec=4
>  dotest="$GIT_DIR/rebase-apply"
>  sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
> -resolvemsg= resume= scissors= no_inbody_headers=
> +resolvemsg= resume= scissors= no_inbody_headers= message_id=
>  git_apply_opt=
>  committer_date_is_author_date=
>  ignore_date=
> @@ -442,6 +443,8 @@ it will be removed. Please do not use it anymore."
>  		gpg_sign_opt=-S ;;
>  	--gpg-sign=*)
>  		gpg_sign_opt="-S${1#--gpg-sign=}" ;;
> +	-m|--message-id)
> +		message_id=t ;;

Doesn't the message-id line in OPTIONS_SPEC make the negated long
option --no-message-id available as well? If that's the case, then
the corresponding case arm is missing from here.

>  	--)
>  		shift; break ;;
>  	*)
> @@ -565,6 +568,7 @@ Use \"git am --abort\" to remove it.")"
>  	echo " $git_apply_opt" >"$dotest/apply-opt"
>  	echo "$threeway" >"$dotest/threeway"
>  	echo "$sign" >"$dotest/sign"
> +	echo "$message_id" > "$dotest/message-id"

To match the local style conventions, the space character after the
redirection operator should be removed.

Also, isn't the patch missing the bits where the state of message-id
is read? Like so:

    if test "$(cat "$dotest/message-id")" = t
    then
    	message_id=t
    fi

>  	echo "$utf8" >"$dotest/utf8"
>  	echo "$keep" >"$dotest/keep"
>  	echo "$scissors" >"$dotest/scissors"
> @@ -757,6 +761,10 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
>  		then
>  			cat "$dotest/msg-clean"
>  		fi
> +		if test 't' == "$message_id"
> +		then
> +			grep ^Message-Id: "$dotest/info" || true

Why is the true guard needed here? The exit status of grep seems to
never be checked.

Although I cannot come up with an example where this would matter,
you might want to consider using the grep wrapper sane_grep from
git-sh-setup.sh instead. It resets the environment variable
GREP_OPTIONS before calling grep so that no unexpected user options
come into play.

> +		fi
>  		if test '' != "$ADD_SIGNOFF"
>  		then
>  			echo "$ADD_SIGNOFF"
> 
> [..]

   Fabian
