From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 5/5] pathspec: allow querying for attributes
Date: Thu, 19 May 2016 11:53:40 -0700
Message-ID: <xmqqmvnlj2vf.fsf@gitster.mtv.corp.google.com>
References: <20160519010935.27856-1-sbeller@google.com>
	<20160519010935.27856-6-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:54:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3T58-0002Zq-P1
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 20:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbcESSxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 14:53:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755105AbcESSxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 14:53:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A8B41C22C;
	Thu, 19 May 2016 14:53:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iOra3uO340Jr
	ZmGgjauSYkmioJ8=; b=PytBzWqYiwlY0GoK7UgtIDPRDC5Nnq5n22ec1vd6IFo7
	26iUD/YbSdV+OTRlb+a/x3q1BSXKghOjy3b+rSYY8g/Whp32nYiyg23OF1y+NxWD
	LIdWSlJQWSqYSkN+8+SSQYgw62+1AqqhfS30vsHHb4BBBISWHaS/3dC4wrx83Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pwWw8T
	UnzVkqQ9tZMqIv3OsohmO7B3JUcPmNOUOO/J9h6QQn84kn+ik6g2V/gqZ+Njc2Te
	vuCUYDLqcOVm4BlDrPg/hb4fNkTzxbv8POyJl8e3dMG3RY5Povn698mmuVoIDzH2
	km1mGlMTN6S7OOjPBCdB+ERKUDJWUFEUnS7xs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 82B841C22B;
	Thu, 19 May 2016 14:53:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9E391C22A;
	Thu, 19 May 2016 14:53:42 -0400 (EDT)
In-Reply-To: <20160519010935.27856-6-sbeller@google.com> (Stefan Beller's
	message of "Wed, 18 May 2016 18:09:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 01FDA72E-1DF3-11E6-A9F3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295089>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/Documentation/glossary-content.txt b/Documentation/gloss=
ary-content.txt
> index cafc284..aa9f220 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -384,6 +384,23 @@ full pathname may have special meaning:
>  +
>  Glob magic is incompatible with literal magic.
> =20
> +attr;;
> +	Additionally to matching the pathspec, the path must have the
> +	attribute as specified. The syntax for specifying the required
> +	attributes is "`attr: [mode] <attribute name> [=3Dvalue]`"
> ++
> +Attributes can have 4 states (Set, Unset, Set to a value, unspecifie=
d) and
> +you can query each attribute for certain states. The "`[mode]`" is a=
 special
> +character to indicate which attribute states are looked for. The fol=
lowing
> +modes are available:
> +
> + - an empty "`[mode]`" matches if the attribute is set
> + - "`-`" the attribute must be unset
> + - "`!`" the attribute must be unspecified
> + - an empty "`[mode]`" combined with "`[=3Dvalue]`" matches if the a=
ttribute has
> +   the given value.
> ++

As an initial design, I find this much more agreeable than the
previous rounds.  I however find the phrasing of the above harder
than necessary to understand, for a few reasons.

 * Mixed use of "X matches if ..." and "... must be Y" makes it
   unclear if they are talking about different kind of things, or
   the same kind of things in merely different ways.

 * It does not make it clear "=3Dvalue" is only meaningful when [mode]
   is empty.

Perhaps dropping the '[mode]' thing altogether and instead saying

        After `attr:` comes a space separated list of "attribute
       	requirements", all of which must be met in order for the
       	path to be considered a match; this is in addition to the
       	usual non-magic pathspec pattern matching.

	Each of the attribute requirements for the path takes one of
	these forms:

	- "`ATTR`" requires that the attribute `ATTR` must be set.

	- "`-ATTR`" requires that the attribute `ATTR` must be unset.

        - "`ATTR=3DVALUE`" requires that the attribute `ATTR` must be
          set to the string `VALUE`.

        - "`!ATTR`" requires that the attribute `ATTR` must be
          unspecified.

would make the resulting text easier to read?

> +static int match_attrs(const char *name, int namelen,
> +		       const struct pathspec_item *item)
> +{
> +	int i;
> +
> +	git_check_attr_counted(name, namelen, item->attr_check);
> +	for (i =3D 0; i < item->attr_match_nr; i++) {
> +		const char *value;
> +		int matched;
> +		enum attr_match_mode match_mode;
> +
> +		value =3D item->attr_check->check[i].value;
> +		match_mode =3D item->attr_match[i].match_mode;
> +
> +		if (ATTR_TRUE(value))
> +			matched =3D match_mode =3D=3D MATCH_SET;
> +		else if (ATTR_FALSE(value))
> +			matched =3D match_mode =3D=3D MATCH_UNSET;
> +		else if (ATTR_UNSET(value))
> +			matched =3D match_mode =3D=3D MATCH_UNSPECIFIED;

readability nit:

	matched =3D (match_mode =3D=3D MATCH_WHATEVER);

would be easier to view

> +		else
> +			matched =3D (match_mode =3D=3D MATCH_VALUE &&
> +				   !strcmp(item->attr_match[i].value, value));

and would match the last case above better.

> +static void parse_pathspec_attr_match(struct pathspec_item *item, co=
nst char *value)
> +{
> +	struct string_list_item *si;
> +	struct string_list list =3D STRING_LIST_INIT_DUP;
> +
> +
> +	if (!value || !strlen(value))
> +		die(_("attr spec must not be empty"));
> +
> +	string_list_split(&list, value, ' ', -1);
> +	string_list_remove_empty_items(&list, 0);
> +
> +	if (!item->attr_check)
> +		item->attr_check =3D git_attr_check_alloc();
> +	else
> +		die(_("Only one 'attr:' specification is allowed."));
> +
> +	ALLOC_GROW(item->attr_match, item->attr_match_nr + list.nr, item->a=
ttr_match_alloc);
> +
> +	for_each_string_list_item(si, &list) {
> +		size_t attr_len;
> +
> +		int j =3D item->attr_match_nr++;
> +		const char *attr =3D si->string;
> +		struct attr_match *am =3D &item->attr_match[j];
> +
> +		if (attr[0] =3D=3D '!')
> +			am->match_mode =3D MATCH_UNSPECIFIED;
> +		else if (attr[0] =3D=3D '-')
> +			am->match_mode =3D MATCH_UNSET;
> +		else
> +			am->match_mode =3D MATCH_SET;
> +
> +		if (am->match_mode !=3D MATCH_SET)
> +			/* skip first character */
> +			attr++;
> +		attr_len =3D strcspn(attr, "=3D");
> +		if (attr[attr_len] =3D=3D '=3D') {
> +			am->match_mode =3D MATCH_VALUE;
> +			am->value =3D xstrdup(&attr[attr_len + 1]);
> +			if (strchr(am->value, '\\'))
> +				die(_("attr spec values must not contain backslashes"));
> +		} else
> +			am->value =3D NULL;
> +

Let me try a variant to see if we can improve it (thinking aloud).

	switch (*attr) {
        case '!':
        	am->match_mode =3D MATCH_UNSPECIFIED;
		attr++;
                break;
        case '-':
        	am->match_mode =3D MATCH_UNSET;
		attr++;
                break;
	default:
		attr_len =3D strcspn(attr, "=3D");
		if (attr[attr_len] !=3D '=3D')
			am->match_mode =3D MATCH_SET;
		else {
			am->match_mode =3D MATCH_VALUE;
	                am->value =3D xstrdup(...);
		}
                break;
	}

Using switch/case does not save line counts at all but it may still
make the result easier to follow.  More importantly, it would help
you catch "!ATTR=3DVAR" as an "invalid attribute name 'ATTR=3DVAR' was
requested" error by arranging the code to make sure that scanning
for '=3D' would not happen in !/- case (in other words, while thiking
aloud with an alternative way to write the same thing, I spotted a
bug in the original ;-).

> +		if (!attr_name_valid(attr, attr_len)) {
> +			struct strbuf sb =3D STRBUF_INIT;
> +			am->match_mode =3D INVALID_ATTR;
> +			invalid_attr_name_message(&sb, attr, attr_len);
> +			die(_("invalid attribute in '%s': '%s'"), value, sb.buf);
> +		}
> +
> +		am->attr =3D git_attr_counted(attr, attr_len);

I'd do this the other order, i.e.

	am->attr =3D git_attr_counted(...);
        if (!am->attr) {
		...
                die(...);
	}

It is wasteful to call attr_name_valid() yourself before seeing an
error from git_attr_counted().

> diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-=
labels.sh
> new file mode 100755
> index 0000000..c0d8cda
> --- /dev/null
> +++ b/t/t6134-pathspec-with-labels.sh
> @@ -0,0 +1,166 @@
> +#!/bin/sh
> +
> +test_description=3D'test labels in pathspecs'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup a tree' '
> +	mkdir sub &&
> +	for p in fileA fileB fileC fileAB fileAC fileBC fileNoLabel fileUns=
etLabel fileSetLabel fileValue fileWrongLabel; do
> +		: >$p &&
> +		git add $p &&
> +		: >sub/$p
> +		git add sub/$p
> +	done &&
> +	git commit -m $p &&
> +	git ls-files >actual &&
> +	cat <<EOF >expect &&
> +fileA
> +fileAB
> +fileAC
> +fileB
> +fileBC
> +fileC
> +fileNoLabel
> +fileSetLabel
> +fileUnsetLabel
> +fileValue
> +fileWrongLabel
> +sub/fileA
> +sub/fileAB
> +sub/fileAC
> +sub/fileB
> +sub/fileBC
> +sub/fileC
> +sub/fileNoLabel
> +sub/fileSetLabel
> +sub/fileUnsetLabel
> +sub/fileValue
> +sub/fileWrongLabel
> +EOF

	cat <<-\EOF >expect &&
        fileA
        ...
        EOF

to indent the whole thing?

> +test_expect_success 'setup .gitattributes' '
> +	cat <<EOF >.gitattributes &&

Likewise.

> +fileWrongLabel label=E2=98=BA
> +EOF
> +	git add .gitattributes &&
> +	git commit -m "add attributes"
> +'
> +
> +sq=3D"'"

I do not think you use this $sq variable below, but I may have
overlooked its use.

> +
> +test_expect_success 'check specific set attr' '
> +	cat <<EOF >expect &&
> +fileSetLabel
> +sub/fileSetLabel
> +EOF
> +	git ls-files ":(attr:label)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check specific unset attr' '
> +	cat <<EOF >expect &&
> +fileUnsetLabel
> +sub/fileUnsetLabel
> +EOF
> +	git ls-files ":(attr:-label)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check specific value attr' '
> +	cat <<EOF >expect &&
> +fileValue
> +sub/fileValue
> +EOF
> +	git ls-files ":(attr:label=3Dfoo)" >actual &&
> +	test_cmp expect actual &&
> +	git ls-files ":(attr:label=3Dbar)" >actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success 'check unspecified attr' '
> +	cat <<EOF >expect &&
> +.gitattributes
> +...
> +EOF
> +	git ls-files :\(attr:\!label\) >actual &&

Why not the more normal-looking ":(attr:!label)"?  I do not think
history substitution would trigger in an script.

And no, "I may cut and paste into my interactive shell while
debugging" is not a good reason to make the end-result (i.e. script)
less readable.

> +test_expect_success 'check multiple unspecified attr' '
> +	cat <<EOF >expect &&
> +.gitattributes
> +fileC
> +fileNoLabel
> +fileWrongLabel
> +sub/fileC
> +sub/fileNoLabel
> +sub/fileWrongLabel
> +EOF
> +	git ls-files :\(attr:\!labelB\ \!labelA\ \!label\) >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check label with more labels but excluded path'=
 '
> +	cat <<EOF >expect &&
> +fileAB
> +fileB
> +fileBC
> +EOF
> +	git ls-files ":(attr:labelB)" ":(exclude)sub/" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check label excluding other labels' '
> +	cat <<EOF >expect &&
> +fileAB
> +fileB
> +fileBC
> +sub/fileAB
> +sub/fileB
> +EOF
> +	git ls-files ":(attr:labelB)" ":(exclude,attr:labelC)sub/" >actual =
&&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'abort on giving invalid label on the command li=
ne' '
> +	test_must_fail git ls-files . ":(attr:=E2=98=BA)" 2>actual &&
> +	test_i18ngrep "fatal" actual
> +'
> +
> +test_done
