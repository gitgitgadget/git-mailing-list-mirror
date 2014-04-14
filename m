From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Mon, 14 Apr 2014 10:24:38 +0200
Message-ID: <vpq8ur85neh.fsf@anie.imag.fr>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	<vpqsipkmeum.fsf@anie.imag.fr>
	<D2BF8546-87B4-431A-B86D-6EFAF205279C@gmail.com>
	<vpq4n1zg4f9.fsf@anie.imag.fr>
	<D3916156-0F84-4DD2-833F-64DF675325D3@gmail.com>
	<vpq38hi8oj3.fsf@anie.imag.fr>
	<32c0335e91b9658a9cca007f6851280@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:25:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZcCU-0007Jo-B3
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 10:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbaDNIZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 04:25:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47560 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbaDNIY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 04:24:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3E8ObFK020369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Apr 2014 10:24:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3E8OcfK006453;
	Mon, 14 Apr 2014 10:24:38 +0200
In-Reply-To: <32c0335e91b9658a9cca007f6851280@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Sat, 12 Apr 2014 19:45:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 14 Apr 2014 10:24:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3E8ObFK020369
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398068681.54707@5m4mjRPwRWxh2coRAGcUXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246218>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> So I suggest that in the interest of fixing rebase on FreeBSD in an  
> expeditious fashion, patches 1/3 and 2/3 get picked up (see note  
> below) now and that the follow-on patch below, after being enhanced to  
> pass all tests, be submitted separately at some future point.

Seems a good plan to me.

> Needs-Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

> From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Subject: [PATCH 4/3] rebase: stop using . within function
> 
> Move the whole run_specific_rebase_internal function to
> git-rebase--$type.
> 
> The .-ed script defines the complete function, and then the
> function is used from the toplevel script.
> 
> The goal is to avoid using tricky features that may trigger
> bugs on some shells.
> 
> The result is simpler, just using the basic pattern:
> 
>     1. use '. file' to import a set of functions
>     2. then use these functions
> 
> Needs-Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>  git-rebase--am.sh          |  3 +--
>  git-rebase--interactive.sh |  3 +--
>  git-rebase--merge.sh       |  3 +--
>  git-rebase.sh              | 40 +++++++++++++++++++++-------------------
>  4 files changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 2d3f6d55..b48b3e90 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -4,7 +4,7 @@
>  # Copyright (c) 2010 Junio C Hamano.
>  #
>  
> -git_rebase__am() {
> +run_specific_rebase_infile() {
>  	case "$action" in
>  	continue)
>  		git am --resolved --resolvemsg="$resolvemsg" &&
> @@ -75,4 +75,3 @@ git_rebase__am() {
>  
>  	move_to_original_branch
>  }
> -git_rebase__am
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 42164f11..a7670eb0 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -810,7 +810,7 @@ add_exec_commands () {
>  	mv "$1.new" "$1"
>  }
>  
> -git_rebase__interactive() {
> +run_specific_rebase_infile() {
>  	case "$action" in
>  	continue)
>  		# do we have anything to commit?
> @@ -1044,4 +1044,3 @@ EOF
>  	git update-ref ORIG_HEAD $orig_head
>  	do_rest
>  }
> -git_rebase__interactive
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index b5f05bf5..9550e656 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -101,7 +101,7 @@ finish_rb_merge () {
>  	say All done.
>  }
>  
> -git_rebase__merge() {
> +run_specific_rebase_infile() {
>  	case "$action" in
>  	continue)
>  		read_state
> @@ -153,4 +153,3 @@ git_rebase__merge() {
>  
>  	finish_rb_merge
>  }
> -git_rebase__merge
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 07e2bd48..9e105626 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -175,7 +175,7 @@ run_specific_rebase () {
>  		export GIT_EDITOR
>  		autosquash=
>  	fi
> -	. git-rebase--$type
> +	run_specific_rebase_infile
>  	ret=$?
>  	if test $ret -eq 0
>  	then
> @@ -353,6 +353,26 @@ then
>  	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
>  fi
>  
> +if test -n "$rebase_root" && test -z "$onto"
> +then
> +	test -z "$interactive_rebase" && interactive_rebase=implied
> +fi
> +
> +if test -n "$interactive_rebase"
> +then
> +	type=interactive
> +	state_dir="$merge_dir"
> +elif test -n "$do_merge"
> +then
> +	type=merge
> +	state_dir="$merge_dir"
> +else
> +	type=am
> +	state_dir="$apply_dir"
> +fi
> +
> +. git-rebase--$type
> +
>  case "$action" in
>  continue)
>  	# Sanity check
> @@ -407,24 +427,6 @@ and run me again.  I am stopping in case you still have something
>  valuable there.')"
>  fi
>  
> -if test -n "$rebase_root" && test -z "$onto"
> -then
> -	test -z "$interactive_rebase" && interactive_rebase=implied
> -fi
> -
> -if test -n "$interactive_rebase"
> -then
> -	type=interactive
> -	state_dir="$merge_dir"
> -elif test -n "$do_merge"
> -then
> -	type=merge
> -	state_dir="$merge_dir"
> -else
> -	type=am
> -	state_dir="$apply_dir"
> -fi
> -
>  if test -z "$rebase_root"
>  then
>  	case "$#" in
> -- 
> 1.8.5

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
