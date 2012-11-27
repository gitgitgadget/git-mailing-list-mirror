From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t4041 (diff-submodule-option): parse digests
 sensibly
Date: Tue, 27 Nov 2012 09:38:36 -0800
Message-ID: <7vtxsblzdv.fsf@alter.siamese.dyndns.org>
References: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
 <1354005692-2809-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:38:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdP7X-0006XR-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181Ab2K0Rik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:38:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755959Ab2K0Rij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:38:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7793A1F5;
	Tue, 27 Nov 2012 12:38:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+3hx4S8sESFPVrvVL6+oYptCB0=; b=YXYpCE
	dOFzDAm6w7Kvuk597fvSkFSiNj86cVfQJb7Jfn2809INaHv+PkDaH5q845vTbjK9
	IKE0SrJHbM6toi6EuIwSU7EGDOwMkZ+jEZ8/GXJDkTzlorjgFD2zn4VPe30DPuUp
	RYhAKdxyN/5/UReRSPQN4G7aih+GDIFMQk3z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GIGB3zD6uo+CLdy7nr44PpOx3MOe1wyJ
	5lgpPy3pccu+YdVwIwGl3aLw46ROXaoahI9ErlTKBX+yJfpxMSN67Lt3l22zeCey
	AZu3tM85CGMnz3l6QIn219Z9o4WbjD3n3PGW8TKOSkX6+o+VSRadTzR8ayz0vJyx
	+gNBMUS3sdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1BA3A1F4;
	Tue, 27 Nov 2012 12:38:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0995FA1EF; Tue, 27 Nov 2012
 12:38:37 -0500 (EST)
In-Reply-To: <1354005692-2809-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 27 Nov 2012 14:11:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46AE42DE-38B9-11E2-8E5E-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210570>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> `git rev-list --max-count=1 HEAD` is a roundabout way of saying `git
> rev-parse --verify HEAD`; replace a bunch of instances of the former
> with the latter.  Also, don't unnecessarily `cut -c1-7` the rev-parse
> output when the `--short` option is available.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t4041-diff-submodule-option.sh |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index 5377639..cfb71e5 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -21,7 +21,7 @@ add_file () {
>  		test_tick &&
>  		git commit -m "Add $name"
>  	done >/dev/null
> -	git rev-parse --verify HEAD | cut -c1-7
> +	git rev-parse --short --verify HEAD
>  	cd "$owd"
>  }
>  commit_file () {
> @@ -33,7 +33,7 @@ test_create_repo sm1 &&
>  add_file . foo >/dev/null
>  
>  head1=$(add_file sm1 foo1 foo2)
> -fullhead1=$(cd sm1; git rev-list --max-count=1 $head1)
> +fullhead1=$(cd sm1; git rev-parse --verify $head1)

That still is a roundabout way to say "git rev-parse --verify HEAD",
no?  Why feed a shortened one to get the expanded result when you
know the full representation of HEAD is what you want?

>  test_expect_success 'added submodule' "
>  	git add sm1 &&
> @@ -116,8 +116,8 @@ EOF
>  	test_cmp expected actual
>  "
>  
> -fullhead2=$(cd sm1; git rev-list --max-count=1 $head2)
>  test_expect_success 'modified submodule(forward) --submodule=short' "
> +fullhead2=$(cd sm1; git rev-parse --verify $head2)
>  	git diff --submodule=short >actual &&
>  	cat >expected <<-EOF &&
>  diff --git a/sm1 b/sm1
> @@ -135,7 +135,7 @@ commit_file sm1 &&
>  head3=$(
>  	cd sm1 &&
>  	git reset --hard HEAD~2 >/dev/null &&
> -	git rev-parse --verify HEAD | cut -c1-7
> +	git rev-parse --short --verify HEAD
>  )
>  
>  test_expect_success 'modified submodule(backward)' "
> @@ -220,8 +220,8 @@ EOF
>  rm -f sm1 &&
>  test_create_repo sm1 &&
>  head6=$(add_file sm1 foo6 foo7)
> -fullhead6=$(cd sm1; git rev-list --max-count=1 $head6)
>  test_expect_success 'nonexistent commit' "
> +fullhead6=$(cd sm1; git rev-parse --verify $head6)
>  	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  Submodule sm1 $head4...$head6 (commits not present)
> @@ -318,8 +318,8 @@ EOF
>  "
>  
>  (cd sm1; git commit -mchange foo6 >/dev/null) &&
> -head8=$(cd sm1; git rev-parse --verify HEAD | cut -c1-7) &&
>  test_expect_success 'submodule is modified' "
> +head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
>  	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  Submodule sm1 $head6..$head8:
> @@ -461,7 +461,7 @@ EOF
>  	test_cmp expected actual
>  "
>  
> -fullhead7=$(cd sm2; git rev-list --max-count=1 $head7)
> +fullhead7=$(cd sm2; git rev-parse --verify $head7)
>  
>  test_expect_success 'given commit --submodule=short' "
>  	git diff-index -p --submodule=short HEAD^ >actual &&
