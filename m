Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271F8C43457
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA7922203
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie4m7JdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbgJNNUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbgJNNUG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 09:20:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C565C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:20:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l8so4897219ioh.11
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m5XQg2s6ZKN93ShwZtG1wK8WY6E182/oqbyzXP9Ii6U=;
        b=Ie4m7JdPeQM3yxaf/YLvPZDtaYol+jZW8Ur6j9kJjD59bmcNBZ0dc7JK8Ep5GwWW80
         bGoJ6eDeVF2PjSOt4HmMOE+KAwncjqVUGiZDQ/IJZe2l8N8KyScuNHgCxIapadgaEPwm
         Jkk5CL2t0Cq8xoilq1Xav2jqgVljLr/seb7LigMURbUzQkTW3wHEKnppuw/kZa6ozkP6
         gZbei2bEAdt2wL9ozrhYsqJhXCtfq2LyxeTdOWJL4bizCp3J5sOqMESKtmjCSVR5fUKY
         JjYVxPeiMp8LaY+J0KxCrMRryT4GfhY9FB8qZTsWIiTpmVaCXO+fZQZOEriliQP86fho
         9tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m5XQg2s6ZKN93ShwZtG1wK8WY6E182/oqbyzXP9Ii6U=;
        b=qyD4ctHJWAPrkn6RWeWHmeL0wqebNQurSoIHcMhIOfTQ88u1+tnFFfgJq7/XSUU8wc
         w3DLJFdi4ZV2XKK011GGDOlT6OCNTIjsIOY0QD6iO9AuJVahMzkAGpTHXczERJrHU+IN
         p0UKrj3w9UbN+uPj6xPcLQrk4ki2Ah2bBFokPrcDx88PF0WoN7IM44eYlIB6lPMjTKJ8
         vDIHDDv6xm/uX2H40J8yaV6Uregh0GHZO6DDzja/TvKb8TZGmiSPfKuoCST8HOyatI9W
         Zv6JhzgOUlvolT7pylCWbAa7bYICXM5OnQN9ZJWKLMJ8wdFiDt771JzAxnzVOyhf9Ch7
         MOrA==
X-Gm-Message-State: AOAM533gsiwC5msgfUM5Pv8UZGje40xtCd5/ChmchirYs4Zh3+cNAOzN
        Q2toSxfIckDDeDpuyWvF55r7cZFfb9MPpw==
X-Google-Smtp-Source: ABdhPJxJGI9Y5ZECIc3X0nFXUJweTJMhArYx3G4CiIjsf+G5ngSqVPHdInZDbuJ7V76jDXqQiG9kjQ==
X-Received: by 2002:a5d:9243:: with SMTP id e3mr2782948iol.193.1602681605644;
        Wed, 14 Oct 2020 06:20:05 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id l78sm3265203ild.30.2020.10.14.06.20.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2020 06:20:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages containing CRLF
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20201012224706.GA4318@flurp.local>
Date:   Wed, 14 Oct 2020 09:20:02 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC87B74C-5EC2-4129-82A5-2CD0C81188B9@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com> <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com> <20201012224706.GA4318@flurp.local>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

> Le 12 oct. 2020 =C3=A0 18:47, Eric Sunshine <sunshine@sunshineco.com> =
a =C3=A9crit :
>=20
> On Mon, Oct 12, 2020 at 06:09:27PM +0000, Philippe Blain via =
GitGitGadget wrote:
>> Add a test library (t/lib-crlf-messages.sh) that creates refs with =
such
>> commit messages, so that we can easily test that this bug does not
>> appear in other commands in the future.
>=20
> In addition to Junio's review comments...
>=20
>>=20
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>> diff --git a/t/lib-crlf-messages.sh b/t/lib-crlf-messages.sh
>> @@ -0,0 +1,90 @@
>> +create_crlf_ref () {
>> +	message=3D"$1" &&
>> +	subject=3D"$2" &&
>> +	body=3D"$3" &&
>> +	branch=3D"$4" &&
>> +	printf "${message}" >.crlf-message-${branch}.txt &&
>> +	printf "${subject}" >.crlf-subject-${branch}.txt &&
>> +	printf "${body}" >.crlf-body-${branch}.txt &&
>> +	LIB_CRLF_BRANCHES=3D"${LIB_CRLF_BRANCHES} ${branch}"
>=20
> Broken &&-chain.
>=20
>> +	test_tick &&
>> +	hash=3D$(git commit-tree HEAD^{tree} -p HEAD -F =
.crlf-message-${branch}.txt) &&
>> +	git branch ${branch} ${hash} &&
>> +	git tag tag-${branch} ${branch} -F .crlf-message-${branch}.txt =
--cleanup=3Dverbatim
>> +}
>> +
>> +create_crlf_refs () {
>> +	message=3D"Subject first line\r\n\r\nBody first line\r\nBody =
second line\r\n" &&
>> +	body=3D"Body first line\r\nBody second line\r\n" &&
>> +	subject=3D"Subject first line" &&
>> +	branch=3D"crlf" &&
>> +	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" =
&&
>=20
> This is somewhat onerous to digest and compose. Have you considered
> making it more automated and easier to read? Perhaps something like
> this:
>=20
>    create_crlf_ref () {
>        branch=3D$1
>        cat >.crlf-message-$branch.txt &&
>        sed -n "1,/^$/p" <.crlf-message-$branch.txt | sed "/^$/d" | =
append_cr >.crlf-subject-$branch.txt &&
>        sed -n "/^$/,\$p" <.crlf-message-$branch.txt | sed "1d" | =
append_cr >.crlf-body-$branch.txt &&
>        ...
>    }
>=20
>    create_crlf_refs () {
>        create_crlf_ref crlf <<-\EOF
>        Subject first line
>=20
>        Body first line
>        Body second line
>        EOF
>        ...
>    }

I did not try to do that because I did not think of it.=20
However, I think it's clearer using printf, this way '\n' and '\r'
appear clearly on all platforms, whatever editor is in use
and whatever settings this editor is using to hide or not hide
control characters.

>=20
>> +test_create_crlf_refs () {
>> +	test_expect_success 'setup refs with CRLF commit messages' '
>> +		create_crlf_refs
>> +	'
>> +}
>=20
> This almost seems like an unnecessary indirection since callers could
> just as easily do this on their own, like this:
>=20
>    test_expect_success 'setup refs with CRLF commit messages' '
>        create_crlf_refs
>    '
>=20
> which isn't very burdensome. However, I suppose doing it this way
> gives consistent test titles between scripts, so not necessarily a
> strong objection on my part.

Yes, that was the reason. Given Junio's comments I'll surely
refactor his library into a script, so there won't be a need for
this indirection.

>=20
>> +cleanup_crlf_refs () {
>> +	for branch in ${LIB_CRLF_BRANCHES}; do
>=20
> Our style is to place 'do' on its own line:
>=20
>    for branch in $LIB_CRLF_BRANCHES
>    do
>        ...
>=20
> This would be a syntax error if LIB_CRLF_BRANCHES is empty for some
> reason, but I suppose we don't really have to worry about it here(?).
>=20
>> +		git branch -D ${branch} &&
>> +		git tag -d tag-${branch} &&
>> +		rm .crlf-message-${branch}.txt &&
>> +		rm .crlf-subject-${branch}.txt &&
>> +		rm .crlf-body-${branch}.txt
>> +	done
>> +}
>> +
>> +test_cleanup_crlf_refs () {
>> +	test_expect_success 'cleanup refs with CRLF commit messages' '
>> +		cleanup_crlf_refs
>> +	'
>> +}
>> +
>> +test_crlf_subject_body_and_contents() {
>> +	command_and_args=3D"$@" &&
>> +	command=3D$1 &&
>> +	if [ ${command} =3D "branch" ] || [ ${command} =3D =
"for-each-ref" ] || [ ${command} =3D "tag" ]; then
>> +		atoms=3D"(contents:subject) (contents:body) (contents)"
>> +	elif [ ${command} =3D "log" ] || [ ${command} =3D "show" ]; then
>> +		atoms=3D"s b B"
>> +	fi &&
>=20
> Style:
>=20
>    if test "$command" =3D "branch" || test ...
>    then
>        ...
>    elif test ...
>    then
>        ...
>    fi &&
>=20
>> +	files=3D"subject body message" &&
>> +	while  [ -n "${atoms}" ]; do
>=20
> Too many spaces after 'while'.
>=20
> Style:
>=20
>    while tests -n "..."
>    do
>        ...
>=20
>> +		set ${atoms} && atom=3D$1 && shift && atoms=3D"$*" &&
>> +		set ${files} &&	file=3D$1 && shift && files=3D"$*" &&
>> +		test_expect_success "${command}: --format=3D'%${atom}' =
works with CRLF input" "
>> +			rm -f expect &&
>> +			for ref in ${LIB_CRLF_BRANCHES}; do
>=20
> Style.
>=20
>> +				cat .crlf-${file}-\"\${ref}\".txt =
>>expect &&
>> +				printf \"\n\" >>expect
>> +			done &&
>> +			git $command_and_args --format=3D\"%${atom}\" =
>actual &&
>> +			test_cmp expect actual
>> +		"
>> +	done
>> +}

Thanks for the review! (and I'll re-read the shell coding guidelines
before sending v4).

Cheers,
Philippe.

