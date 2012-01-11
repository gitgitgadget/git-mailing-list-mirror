From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: add --skip-intent-to-add to allow commit
 with i-t-a entries in index
Date: Wed, 11 Jan 2012 15:55:51 -0800
Message-ID: <7vipkh6bg8.fsf@alter.siamese.dyndns.org>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
 <1326275982-29866-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 00:56:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl81n-0000BO-GV
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab2AKXz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 18:55:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab2AKXzz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 18:55:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8304F6238;
	Wed, 11 Jan 2012 18:55:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+KBclyBRvOM+
	l2Cn8KZyBFsVlwI=; b=uNSccgHnOhSMIaGOqHG39CjwJMrAGfAKurVVp2A1IgV8
	1t47IIkjLkRT9s/+wNfoxRVfA+O+CJB7fXMkAwdwEXKcpdEg6xAYLmRwWb8r4Uo8
	Wsu25NmNAX8uZk2vGc7cIqxMFuA0F7P5f21IBGJase0O+v3IYy21j/T36xvz+Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=T0bz8v
	LjWyNqXkM0SsU/VE1r8c6hQ3mYjsUyBuzizP4MZDdPv70bjyCMfuYrOAvDg+edUv
	dytJI7d2t7ArMOm4KB8t3ghEt71w3+q/Ec0YRoRtCrhyq/HPezl2wGR78ubIcETQ
	SDKaIFhq5M/izXeuytK2NmYlMAZbvRQRtPHw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79D5D6237;
	Wed, 11 Jan 2012 18:55:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D4356234; Wed, 11 Jan 2012
 18:55:53 -0500 (EST)
In-Reply-To: <1326275982-29866-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 11 Jan
 2012 16:59:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBC25E94-3CAF-11E1-8B06-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188406>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ---
>  builtin/commit.c      |   10 +++++++---
>  cache-tree.c          |    8 +++++---
>  cache-tree.h          |    1 +
>  t/t2203-add-intent.sh |   17 +++++++++++++++++
>  4 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index bf42bb3..021206e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -86,6 +86,7 @@ static int all, also, interactive, patch_interactiv=
e, only, amend, signoff;
>  static int edit_flag =3D -1; /* unspecified */
>  static int quiet, verbose, no_verify, allow_empty, dry_run, renew_au=
thorship;
>  static int no_post_rewrite, allow_empty_message;
> +static int cache_tree_flags, skip_intent_to_add;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg=
;
>  static char *sign_commit;
> =20
> @@ -170,6 +171,7 @@ static struct option builtin_commit_options[] =3D=
 {
>  	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
>  	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-re=
write hook"),
>  	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mod=
e", "show untracked files, optional modes: all, normal, no. (Default: a=
ll)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> +	OPT_BOOL(0, "skip-intent-to-add", &skip_intent_to_add, "allow inten=
t-to-add entries in index"),

This is more like "ignore", not "allow", from end user's point of view,
no? The user earlier said "I cannot decide what contents to put in the
commit yet for this path", and normally we catch it and remind the user
that she needs to decide. This option gives her a quick way to say "I
decide that I do not want to add this path at all to this commit I am
creating, so please ignore it in the meantime."

> @@ -1088,6 +1090,8 @@ static int parse_and_validate_options(int argc,=
 const char *argv[],
>  		cleanup_mode =3D CLEANUP_ALL;
>  	else
>  		die(_("Invalid cleanup mode %s"), cleanup_arg);
> +	if (skip_intent_to_add)
> +		cache_tree_flags =3D WRITE_TREE_INTENT_TO_ADD_OK;

The name WRITE_TREE_INTENT_TO_ADD_OK says "it is OK to call write-tree
with i-t-a entries in the index, please do not barf", but I think "when
writing a tree, ignore i-t-a entries" would be a more appropriate way t=
o
say the same thing, i.e. WRITE_TREE_IGNORE_INTENT_TO_ADD.

Other than that, I do not see an issue in the implementation of the
patch. It is a separate design level issue if we want to worsen
proliferation of the options, though.

Thanks.
