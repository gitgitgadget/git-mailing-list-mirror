Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CE31F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 09:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeKQTqG (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 14:46:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50388 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeKQTqG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 14:46:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48FF5373FA;
        Sat, 17 Nov 2018 04:29:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hP95tATUiCdO
        GGh7NACfptClBpA=; b=AUh5Zf9sS1Etq838rKxtpW3v8triEN+/twgaomsyY3Nh
        gB77FAOU/yLqQimaU77jyKkYI0NMXbduAUGdlbkHbRzdaoMjBwqjmrn13e9qvwc8
        HPCO6m1xF/42bspjmnMQohCl4Q5jhfsODLpWL56hrSKTopPofkT7CvpEAHP/wvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pRgWXm
        ydqTFpAXOxRNr91YpVzS0dcNO/okrTBtkB3JasdvBWK/VFJY3z20NGTpcxhZW1vy
        kV4BD3IKn2ykiqMFiiqio7Jz8elJSmJ16qXy4CzJPK2hROzTgXGJxIHLhMto+Ii+
        TvCXaOqMRmWEB/fdTH8lFvfWkKAf3kfna+fmg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40077373F9;
        Sat, 17 Nov 2018 04:29:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32191373F8;
        Sat, 17 Nov 2018 04:29:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
References: <20181116173105.21784-1-chriscool@tuxfamily.org>
Date:   Sat, 17 Nov 2018 18:29:49 +0900
In-Reply-To: <20181116173105.21784-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 16 Nov 2018 18:31:05 +0100")
Message-ID: <xmqqpnv4gigi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56114812-EA4B-11E8-A511-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> However, as noted in those commits we'd still create the file as 0600,
> and would just re-chmod it depending on the setting of
> core.sharedRepository. So without core.splitIndex a system with
> e.g. the umask set to group writeability would work for the members of
> the group, but not with core.splitIndex set, as members of the group
> would not be able to access the shared index file.

I am not sure what the above wants to say.  If we are not making
necessary call to adjust-shared-perm, then it is irrelevant that the
lack of the call does not immediately cause an apparent problem for
users who happens to have non-restrictive group perm bit in their
umask.  Another group member whose umask is tighter will eventually
use the repository and end up creating a file unreadable to group
members.

Are you saying that we _lack_ necessary call when core.sharedRepository
is set?  If so, a commit that fixes such a bug would be the best
place to have a paragraph like the above.  If not, the above description
simply misleads the readers.

> Let's instead make the two consistent by using mks_tempfile_sm() and
> passing 0666 in its `mode` argument.

On the other hand, this is a relevant description; this patch kills
an inconsistency that is very short lived (I am assuming that there
is no bug in the current code before this patch and we make
necessary calls to adjust-shared-perm when core.sharedrepository is
set).

> Note that we cannot use the create_tempfile() function itself that is
> used to write the main ".git/index" file because we want the XXXXXX
> part of the "sharedindex_XXXXXX" argument to be replaced by a pseudo
> random value and create_tempfile() doesn't do that.

Sure.  Pseudo-random-ness is less important than the resulting
filename being unique.  "Because we are asking for a unique file to
be created, we cannot use create_tempfile() interface that is
designed to be used to create a file with known name."

But is that really worth saying, I wonder.

> Ideally we'd split up the adjust_shared_perm() function to one that
> can give us the mode we want so we could just call open() instead of
> open() followed by chmod(), but that's an unrelated cleanup.

I would drop this paragraph, as I think this is totally incorrect.
Imagine your umask is tighter than the target permission.  You ask
such a helper function and get "you want 0660".  Doing open(0660)
would not help you an iota---you'd need chmod() or fchmod() to
adjust the result anyway, which already is done by
adjust-shared-perm.

> We already have that minor issue with the "index" file
> #leftoverbits.

The above "Ideally", which I suspect is totally bogus, would show up
whey people look for that keyword in the list archive.  This is one
of the reasons why I try to write it after at least one person
sanity checks that an idea floated is worth remembering.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> This is a simpler fix iterating from =C3=86var's RFC patch and the
> following discussions:
>
> https://public-inbox.org/git/20181113153235.25402-1-avarab@gmail.com/
>
>  read-cache.c           |  3 ++-
>  t/t1700-split-index.sh | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 8c924506dd..ea80600bff 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3165,7 +3165,8 @@ int write_locked_index(struct index_state *istate=
, struct lock_file *lock,
>  		struct tempfile *temp;
>  		int saved_errno;
> =20
> -		temp =3D mks_tempfile(git_path("sharedindex_XXXXXX"));
> +		/* Same permissions as the main .git/index file */
> +		temp =3D mks_tempfile_sm(git_path("sharedindex_XXXXXX"), 0, 0666);
>  		if (!temp) {
>  			oidclr(&si->base_oid);
>  			ret =3D do_write_locked_index(istate, lock, flags);
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 2ac47aa0e4..fa1d3d468b 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -381,6 +381,26 @@ test_expect_success 'check splitIndex.sharedIndexE=
xpire set to "never" and "now"
>  	test $(ls .git/sharedindex.* | wc -l) -le 2
>  '
> =20
> +test_expect_success POSIXPERM 'same mode for index & split index' '
> +	git init same-mode &&
> +	(
> +		cd same-mode &&
> +		test_commit A &&
> +		test_modebits .git/index >index_mode &&
> +		test_must_fail git config core.sharedRepository &&
> +		git -c core.splitIndex=3Dtrue status &&
> +		shared=3D$(ls .git/sharedindex.*) &&
> +		case "$shared" in
> +		*" "*)
> +			# we have more than one???
> +			false ;;
> +		*)
> +			test_modebits "$shared" >split_index_mode &&
> +			test_cmp index_mode split_index_mode ;;
> +		esac
> +	)
> +'
> +
>  while read -r mode modebits
>  do
>  	test_expect_success POSIXPERM "split index respects core.sharedreposi=
tory $mode" '
