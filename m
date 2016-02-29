From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Change type of signed int flags to unsigned
Date: Mon, 29 Feb 2016 11:26:07 -0800
Message-ID: <xmqqmvqj9v3k.fsf@gitster.mtv.corp.google.com>
References: <1456754667-9462-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Saurav Sachidanand <sauravsachidanand@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:26:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTST-0003g7-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbcB2T0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 14:26:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752354AbcB2T0L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 14:26:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD17A48278;
	Mon, 29 Feb 2016 14:26:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E3GezfXMNSgP
	nlgiEj0Fr1ylHtA=; b=JuF1X9vKeuqHM48RAwDHCBAT6dkb1af/bvm4vgfA3QGL
	VB0VOZGYu6udHTfrwiifHz4ytyGpcr0+t/W4qA7OGlEk0fDcvx9qlWqr/t2dzwbW
	LIcy58Z2wL74srG+VAHA8v0+9SjxTP3NnpnOTlQ2aKqZH2kZIyXKXQkBlXririU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=b7CB/o
	ICIkaGcTxKM6yvboPD8k64fBpU5PiynX28atMpRPcRJ8pjFz/aKpWQ7x1rY4Wo2X
	fKDYay6Siqv+Bvqj/qIvGw+ph2Och9nDMFLdG9/ZvvPLcDNvldyYpCMkefKnRkDT
	O6pfED9iA41Gw5FVOQ4ynNsa7AIzmUzBDTTIs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3EFA48277;
	Mon, 29 Feb 2016 14:26:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 049DB48276;
	Mon, 29 Feb 2016 14:26:08 -0500 (EST)
In-Reply-To: <1456754667-9462-1-git-send-email-sauravsachidanand@gmail.com>
	(Saurav Sachidanand's message of "Mon, 29 Feb 2016 19:34:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 48ED2852-DF1A-11E5-94A2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287886>

Saurav Sachidanand <sauravsachidanand@gmail.com> writes:

> =E2=80=9Cpattern=E2=80=9D and =E2=80=9Cexclude=E2=80=9D are two struc=
ts defined in attr.c and dir.h
> respectively. Each contain a =E2=80=9Cflags=E2=80=9D field of type in=
t that takes on
> values from the set of positive integers {1, 4, 8, 16}, that are
> enumerated through the macro EXC_FLAG_*.
>
> That the most significant bit (used to store the sign) of these two
> fields is not used in any special way is observed from the fact that
> the "flags" fields (accessed within attr.c, dir.c, and
> builtin/check-ignore.c) are either checked for their values using the
> & operator (e.g.: flags & EXC_FLAG_NODIR), or assigned a value of 0
> first and then assigned any one of {1, 4, 8, 16} using the | operator
> (e.g.: flags |=3D EXC_FLAG_NODIR). Hence, change the type of "flags"
> to unsigned in both structs.
>
> Furthermore, =E2=80=9Cflags=E2=80=9D of both structs is passed by val=
ue or by reference
> to the functions parse_exclude_pattern, match_basename and
> match_pathname (declared in dir.h), that have an =E2=80=9Cint=E2=80=9D=
 or =E2=80=9Cint *=E2=80=9D type
> for "flags" in their signatures. To avoid implicit conversion to type=
s,
> or pointers to types, of different sign, change the type for =E2=80=9C=
flags=E2=80=9D to
> =E2=80=9Cunsigned=E2=80=9D and =E2=80=9Cunsigned *=E2=80=9D in the re=
spective function signatures.
>
> And while we=E2=80=99re at it, document the "flags" field of "exclude=
" to
> explicitly state the values it=E2=80=99s supposed to take on.

The above is overly verbose for two reasons, I think.

 * You seem to start from "I have to change the type of struct
   fields", which leads you to describe "these fields are passed as
   parameters to functions, so their signatures also need to change"
   cascade of changes.  Instead, think of this change is about
   "store EXC_FLAG_* flags in an unsigned integer" (which can be the
   title of the patch).  Then the first and the third paragraphs do
   not have to even exist ;-)

 * The second paragraph could just be:

     No variable (or structure field) that hold these bits is tested
     for its MSB with (variable < 0), so there is no reason to hold
     them in a signed integer.

   Here, also notice that your version stressed "of these two
   fields" too much; the reasoning applies equally to any variable
   that holds copies of values from these fields (or in general,
   anything that holds combination of EXC_FLAG_* flags).

Otherwise it looks good to me.

Thanks.


> Signed-off-by: Saurav Sachidanand <sauravsachidanand@gmail.com>
> ---
>
> This patch is for the suggested microproject for GSoC 2016 titled
> "Use unsigned integral type for collection of bits." It is the third
> patch for this project (technically second, considering only the
> subject of the email) that incorporates changes to the commit message
> suggested by Moritz Neeb and Eric Sunshine, and to some function
> signatures suggested by Duy Nguyen. Thanks to them for their feedback=
=2E
>
>  attr.c | 2 +-
>  dir.c  | 8 ++++----
>  dir.h  | 8 ++++----
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 086c08d..679e13c 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -124,7 +124,7 @@ struct pattern {
>  	const char *pattern;
>  	int patternlen;
>  	int nowildcardlen;
> -	int flags;		/* EXC_FLAG_* */
> +	unsigned flags;		/* EXC_FLAG_* */
>  };
>
>  /*
> diff --git a/dir.c b/dir.c
> index 552af23..82cec7d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -459,7 +459,7 @@ int no_wildcard(const char *string)
>
>  void parse_exclude_pattern(const char **pattern,
>  			   int *patternlen,
> -			   int *flags,
> +			   unsigned *flags,
>  			   int *nowildcardlen)
>  {
>  	const char *p =3D *pattern;
> @@ -500,7 +500,7 @@ void add_exclude(const char *string, const char *=
base,
>  {
>  	struct exclude *x;
>  	int patternlen;
> -	int flags;
> +	unsigned flags;
>  	int nowildcardlen;
>
>  	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen)=
;
> @@ -811,7 +811,7 @@ void add_excludes_from_file(struct dir_struct *di=
r, const char *fname)
>
>  int match_basename(const char *basename, int basenamelen,
>  		   const char *pattern, int prefix, int patternlen,
> -		   int flags)
> +		   unsigned flags)
>  {
>  	if (prefix =3D=3D patternlen) {
>  		if (patternlen =3D=3D basenamelen &&
> @@ -836,7 +836,7 @@ int match_basename(const char *basename, int base=
namelen,
>  int match_pathname(const char *pathname, int pathlen,
>  		   const char *base, int baselen,
>  		   const char *pattern, int prefix, int patternlen,
> -		   int flags)
> +		   unsigned flags)
>  {
>  	const char *name;
>  	int namelen;
> diff --git a/dir.h b/dir.h
> index 3ec3fb0..e942b50 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -28,7 +28,7 @@ struct exclude {
>  	int nowildcardlen;
>  	const char *base;
>  	int baselen;
> -	int flags;
> +	unsigned flags;		/* EXC_FLAG_* */
>
>  	/*
>  	 * Counting starts from 1 for line numbers in ignore files,
> @@ -229,10 +229,10 @@ struct dir_entry *dir_add_ignored(struct dir_st=
ruct *dir, const char *pathname,
>   * attr.c:path_matches()
>   */
>  extern int match_basename(const char *, int,
> -			  const char *, int, int, int);
> +			  const char *, int, int, unsigned);
>  extern int match_pathname(const char *, int,
>  			  const char *, int,
> -			  const char *, int, int, int);
> +			  const char *, int, int, unsigned);
>
>  extern struct exclude *last_exclude_matching(struct dir_struct *dir,
>  					     const char *name, int *dtype);
> @@ -244,7 +244,7 @@ extern struct exclude_list *add_exclude_list(stru=
ct dir_struct *dir,
>  extern int add_excludes_from_file_to_list(const char *fname, const c=
har *base, int baselen,
>  					  struct exclude_list *el, int check_index);
>  extern void add_excludes_from_file(struct dir_struct *, const char *=
fname);
> -extern void parse_exclude_pattern(const char **string, int *patternl=
en, int *flags, int *nowildcardlen);
> +extern void parse_exclude_pattern(const char **string, int *patternl=
en, unsigned *flags, int *nowildcardlen);
>  extern void add_exclude(const char *string, const char *base,
>  			int baselen, struct exclude_list *el, int srcpos);
>  extern void clear_exclude_list(struct exclude_list *el);
> --
> 2.7.1.339.g0233b80
