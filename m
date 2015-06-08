From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Mon, 08 Jun 2015 13:42:34 -0700
Message-ID: <xmqqvbey7wzp.fsf@gitster.dls.corp.google.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:42:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23sa-0000I4-M3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbbFHUmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 16:42:40 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35629 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbbFHUmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 16:42:39 -0400
Received: by iesa3 with SMTP id a3so1448608ies.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OEfToJ94FgxWwUlYRHTgQhf6miwy8hpiI4H4cnThT9c=;
        b=ZLnsonn5Td6iwe+BMXo0X0qW0q+t6vePKDf7EOhc0sTP5gEzVDI7j2yZzLXp/cX2uc
         4P6QXNWGiqaxXJ4OsTPt+nrIpT875qeCcVikbY851pwYSxilXbSw7NP1TibdsceyAZa5
         4JqVFH9gZ1kJaHwTblFuZ5UVTi1r02fsRta1dS228nsyQapOkmjbCgicdqv0GskLXefp
         iOE2q9S3WA7Os45rXawPTacLadE15ZbKAzxD4bShLKcSOTU9tV30s6oRb9m7yLGdsVza
         KGnScOEQdbFBeniHaQ2NRDflwAPEaEZPTeoBgb7eCV2/zvddrNEkwYcQg90wS935WReb
         IcAQ==
X-Received: by 10.107.39.209 with SMTP id n200mr22528699ion.59.1433796156811;
        Mon, 08 Jun 2015 13:42:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id l128sm2488032iol.1.2015.06.08.13.42.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 13:42:36 -0700 (PDT)
In-Reply-To: <1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Mon, 8 Jun 2015 22:22:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271130>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> We create a file BISECT_TERMS in the repository .git to be read during a
> bisection. The fonctions to be changed if we add new terms are quite
> few.
> In git-bisect.sh :
> 	check_and_set_terms
> 	bisect_voc
> In bisect.c :
> 	handle_bad_merge_base
>
> Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
> Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
> Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---

This step seems very straight-forward and makes sense from a cursory
look.

>  /*
> + * The terms used for this bisect session are stocked in
> + * BISECT_TERMS: it can be bad/good or new/old.
> + * We read them and stock them to adapt the messages
> + * accordingly. Default is bad/good.
> + */

s/stock/store/ perhaps?  I think the idea is not to have this file
in the default case so that absence of it would mean you would be
looking for a transition from (older) good to (more recent) bad.

> +void read_bisect_terms(void)
> +{
> +	struct strbuf str = STRBUF_INIT;
> +	const char *filename = git_path("BISECT_TERMS");
> +	FILE *fp = fopen(filename, "r");
> +
> +	if (!fp) {

We might want to see why fopen() failed here.  If it is because the
file did not exist, great.  But otherwise?

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 1f16aaf..529bb43 100644
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -77,6 +77,7 @@ bisect_start() {
>  	orig_args=$(git rev-parse --sq-quote "$@")
>  	bad_seen=0
>  	eval=''
> +	start_bad_good=0
>  	if test "z$(git rev-parse --is-bare-repository)" != zfalse
>  	then
>  		mode=--no-checkout
> @@ -101,6 +102,9 @@ bisect_start() {
>  				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
>  				break
>  			}
> +
> +			start_bad_good=1
> +

It is unclear what this variable means, or what it means to have
zero or one as its value.

>  			case $bad_seen in
>  			0) state='bad' ; bad_seen=1 ;;
>  			*) state='good' ;;
> @@ -172,6 +176,11 @@ bisect_start() {
>  	} &&
>  	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
>  	eval "$eval true" &&
> +	if test $start_bad_good -eq 1 -a ! -s "$GIT_DIR/BISECT_TERMS"

Avoid "test <condition1> -a <condition2>" (or "-o").

> +get_terms () {
> +	if test -s "$GIT_DIR/BISECT_TERMS"
> +	then
> +		NAME_BAD="$(sed -n 1p "$GIT_DIR/BISECT_TERMS")"
> +		NAME_GOOD="$(sed -n 2p "$GIT_DIR/BISECT_TERMS")"

It is sad that we need to open the file twice.  Can't we do
something using "read" perhaps?

Don't we want to make sure these two names are sensible?  We do not
want an empty-string, for example.  I suspect you do not want to
take anything that check-ref-format does not like.

Same comment applies to the C code.

> +bisect_voc () {
> +	case "$1" in
> +	bad) echo "bad" ;;
> +	good) echo "good" ;;
> +	esac
> +}

What is voc?

What if "$1" is neither bad/good?

Did you mean to translate 'bad' to $NAME_BAD and 'good' to $NAME_GOOD?
