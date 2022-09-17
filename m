Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67057ECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 08:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIQIPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIQIPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 04:15:18 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F26D4104
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=m+8ZC
        JEBxM5fLXJUdXM+G/h/H/YSQDzOa5hdFhjlb10=; b=NDTxCI+9TGC/MH6OTFS0g
        Wr8mzeDEJA06nAlyC0rhjp/rvmXTFEeehxdrcSjBQHuFR/MmLSpWxXsvmNYEwAIn
        4iVhiu69UF89OLMlINbkOAN8nZzao2Ryvj2ieQuncfFtQNJacBO9ErATP1ndTuaf
        mj0jdDn5dwgAICmfcta7mw=
Received: from smtpclient.apple (unknown [119.3.119.21])
        by smtp8 (Coremail) with SMTP id DMCowADX3ycAgiVjF0WgbQ--.4676S2;
        Sat, 17 Sep 2022 16:14:57 +0800 (CST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v5 1/5] hiderefs: add hide-refs hook to hide refs
 dynamically
From:   =?utf-8?B?5a2Z6LaF?= <16657101987@163.com>
In-Reply-To: <xmqq5yhni4uj.fsf@gitster.g>
Date:   Sat, 17 Sep 2022 16:14:56 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Sun Chao <sunchao9@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DBFEA215-476E-4D41-8B5F-C6080F883C9D@163.com>
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
 <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
 <278bd185aec26285f8c00aca838f89e5f3877748.1662735985.git.gitgitgadget@gmail.com>
 <xmqqedwf9pjr.fsf@gitster.g> <xmqq5yhni4uj.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-CM-TRANSID: DMCowADX3ycAgiVjF0WgbQ--.4676S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFy5KrWDGF4fKw4Uur4fAFb_yoW7Kw47pF
        WYgw1DKFsrJF4jywn2qw1xXr4FkryfK3W5J34kKr95A398Grn7KFn3Wr4F9a1UGr1fXw47
        KFW0vaykGa90yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jneOJUUUUU=
X-Originating-IP: [119.3.119.21]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiQwV-glc7baYNfgAAsv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Sep 14, 2022, at 01:01, Junio C Hamano <gitster@pobox.com> wrote:
>=20
>> Gerrit is implemented by JGit and is known as a centralized workflow =
system
>> which supports reference-level access control for repository. If we =
choose
>> to work in centralized workflow like what Gerrit provided, =
reference-level
>> access control is needed and we might add a reference filter hook
>> `hide-refs` to hide the private data.
>=20
> Please rewrite the above so that it does not sound like "Gerrit
> supports it, there are tons of users of Gerrit, we must support it,
> too".  If this feature is meaningful for us, even if Gerrit folks
> were deprecating and planning to remove the support of it, we would
> add it.  If it is not, even if Gerrit folks support it, we wouldn't.

Hi Junio, thanks for your advice here, I cannot agree with you more, I =
will do it.

>=20
>> +
>> +		/*
>> +		 * the prefix 'hook:' means that the matched refs will =
be
>> +		 * checked by the hide-refs hook dynamically, we need to =
put
>> +		 * the 'ref' string to the hook_hide_refs list
>> +		 */
>=20
> I am not sure if this deserves a five-line comment.  We didn't need
> to have a comment that says "value without hook: means the matched
> refs will be hidden and we need to remember them in the hide_refs
> string_list" for over 10 years after all.

Agree, and I will remove them.

>=20
>> +		if (skip_prefix(value, "hook:", &value)) {
>> +			if (!strlen(value))
>> +				return error(_("missing value for '%s' =
after hook option"), var);
>=20
> I am not sure it is a good idea to special case an empty string,
> especially here at this point in the code flow.  There would be
> strings that cannot be a refname prefix (e.g. "foo..bar") and such a
> check is better done at the place where the accumuldated list of ref
> patterns are actually used.  If you are using prefix match, a value
> of an empty string here would be a very natural way to say "we pass
> all the refs through our hook".

Yes, this is a good advice. Previously I cannot pass all the refs =
through
the new hook unless set two config items like:

         [transfer]
             hiderefs =3D hook:HEAD
             hiderefs =3D hook:refs

I thinks it is a good idea to use only one config item to replace them:

         [transfer] hiderefs =3D hook:
>=20
> By the way, how does the negated entry work with this new one?  For
> static ones,
>=20
> 	[transfer] hiderefs =3D !refs/heads/
>=20
> would hide everything other than refs/heads/ hierarchy, I suppose.
> Would we spell
>=20
> 	[transfer] hiderefs =3D hook:!refs/heads/
>=20
> or
>=20
> 	[transfer] hiderefs =3D !hook:refs/heads/
>=20
> to say "send everything outside the branches to hook"?  If the
> former, you'd also need to special case "!" the same way as you
> special case an empty string (in short, I am saying that the special
> case only for an empty string does not make much sense).

In my patch I put the "!" after the "hook:", and negate passing all the =
refs to the
hook would like

         [transfer] hiderefs =3D hook:!

however according to the match mechanism of hiderefs, it will be better =
to delete
the config item above. If there are no config item, the hook will not be =
called.

So if I want to pass all the refs but some scope of them, it will be =
like (use a empty
string to match all the refs)

         [transfer]
             hiderefs =3D hook:
             hiderefs =3D hook:!refs/pull/

which means pass all the refs except for the ones begins with =
'refs/pull/'


> How does this mechanism work with gitnamespaces (see "git config =
--help"
> and read on transfer.hideRerfs)?

In my patch Git will send refname and refnamefull(with namepsace) to the =
hook, the hook
will check it and response with 'hide' or not. In the following example, =
the letter
'G' stands for 'git-receive-pack' or 'git-upload-pack' and the letter =
'H' stands for
this hook

       # Send reference filter request to hook
       G: PKT-LINE(ref <refname>:<refnamefull>)
       G: flush-pkt

       # Receive result from the hook.
       # Case 1: this reference is hidden
       H: PKT-LINE(hide)
       H: flush-pkt

       # Case 2: this reference can be advertised
       H: flush-pkt

I'm not sure if it is suitable or not, I think it will be better to send =
both the refname
and the refnamefull to the hook.

> That's a somewhat duplicated code.  I wonder
>=20
> 	/* no need for "hook" variable anymore */
> 	struct string_list **refs_list=3D &hide_refs;
>=20
> 	if (strip "hook:" prefix from value)
> 		refs_list =3D &hook_hide_refs;
> 		...
> 	if (!*refs_list) {
>        	*refs_list =3D xcalloc(1, sizeof(*refs_list));
> 		(*refs_list)->strdup_strings =3D 1;
> 	}
> 	string_list_append(*refs_list, ref);
> 	=09
> would be a better organization.  I dunno.

Agree, it looks better, I will do it.

>=20
>> +
>> +	/*
>> +	 * Once hide-refs hook is invoked, Git need to do version =
negotiation,
>> +	 * with it, version number and process name ('uploadpack' or =
'receive')
>> +	 * will send to it in pkt-line format, the proccess name is =
recorded
>> +	 * by hide_refs_section
>> +	 */
>=20
> Grammar.

Will fix.

> On Sep 17, 2022, at 01:52, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> ... ...
>=20
>> +	if (hook && hide_refs_section.len =3D=3D 0)
>> +		strbuf_addstr(&hide_refs_section, section);
>> +
>=20
> that is only set inside the body of the if statement of the first
> conditional that ensures that we are reading *.hiderefs variable,
> but it would make more sense to move it inside it.

Agree, it will be better to move it inside.

>=20
> Or even better would be to clean the function up with a preliminary
> patch to return early when we are not looking at *.hiderefs variable,
> perhaps like the attached, and then build on top.
>=20
> ... ...
>=20
> +
> +	/*
> +	 * "section" is either "receive" or "uploadpack"; are we looking
> +	 * at transfer.hiderefs or $section.hiderefs?
> +	 */
> +	if (strcmp("transfer.hiderefs", var) &&
> +	    !(!parse_config_key(var, section, NULL, NULL, &key) &&
> +	      !strcmp(key, "hiderefs")))
> +		return 0; /* neither */
> +	if (!value)
> +		return config_error_nonbool(var);
> +	ref =3D xstrdup(value);
> +	len =3D strlen(ref);
> +	while (len && ref[len - 1] =3D=3D '/')
> +		ref[--len] =3D '\0';
> +	if (!hide_refs) {
> +		CALLOC_ARRAY(hide_refs, 1);
> +		hide_refs->strdup_strings =3D 1;
> 	}
> +	string_list_append(hide_refs, ref);
> +
> 	return 0;
> }

Thanks for the advice here, I Will do it.=

