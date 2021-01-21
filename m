Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6618DC433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0A5239D1
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbhAUUqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:46:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56371 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbhAUUqF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 15:46:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96F5A108A94;
        Thu, 21 Jan 2021 15:45:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5421CWyT8Irk
        9GWxLmhHP6llIEQ=; b=M1BOEPooiXiUc5VdjOzkC8RAvE8bmEN9ILPNSpIoNl0u
        tgVR8vS/trSMSBy/c6Ac5fKguXMj9Wzq44Fs2zp4RfP2OMqT6YWczCPW18s9fZ1B
        4SproiiNI1akSTNaGGzWw2ls4DqY44d2AhXJjamrWuVbZBxU3wGsTSqDuhEKGhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZUqG5M
        xAGcoiU2LZmSnfo0BfTwPiKjhUbd/eQCcFMqtc8rhkuOyow7MKKIq2PNf8EIwu/y
        2r0y8aGJd8g84YP661vKy+KH0qgNEz26OL35O7Rg924LhzFbI2EZPy++njFPHpH8
        /ByyRyEfgoX8pe7b7yCgY4e+t+HDrrVXzM9Js=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FFCC108A92;
        Thu, 21 Jan 2021 15:45:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D972B108A34;
        Thu, 21 Jan 2021 15:45:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/3] ls-files.c: add --deduplicate option
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
        <xmqq7do7fggn.fsf@gitster.c.googlers.com>
        <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
Date:   Thu, 21 Jan 2021 12:45:16 -0800
In-Reply-To: <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
        (=?utf-8?B?IuiDoeWTsuWugSIncw==?= message of "Thu, 21 Jan 2021 19:00:42
 +0800")
Message-ID: <xmqq1reec943.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9212DFF4-5C29-11EB-AB60-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:

>> OK.  When show_stage is set, skipping_duplicates is automatically
>> turned off (and show_unmerged is automatically covered as it turns
>> show_stage on automatically).  So this feature has really become
>> "are we showing only names, and if so, did we show an entry of the
>> same name before?".
> Yeah,showing only names,so I yesterday ask such question :)
>>
>> >                       if (!show_unmerged || ce_stage(ce))
>> >                               show_ce(repo, dir, ce, fullname.buf,
>> >                                       ce_stage(ce) ? tag_unmerged :
>> >                                       (ce_skip_worktree(ce) ? tag_sk=
ip_worktree :
>> >                                               tag_cached));
>> > +                     if (show_cached && skipping_duplicates)
>> > +                             last_shown_ce =3D ce;
>>
>> The code that calls show_ce() belonging to a totally separate if()
>> statement makes my stomach hurt---how are we going to guarantee that
>> "last shown" really will keep track of what was shown last?
>>
>> Shouldn't the above be more like this?
>>
>> -                       if (!show_unmerged || ce_stage(ce))
>> +                       if (!show_unmerged || ce_stage(ce)) {
>>                                 show_ce(repo, dir, ce, fullname.buf,
>>                                         ce_stage(ce) ? tag_unmerged :
>>                                         (ce_skip_worktree(ce) ? tag_sk=
ip_worktree :
>>                                                 tag_cached));
>> +                               last_shown_ce =3D ce;
>> +                       }
>>
> well,I am also thinking about this question :"last_shown_ce" is not tru=
e
> last shown ce,but may be If "last_shown_ce" truly seen every last shown
> ce ,We may need more cumbersome logic to make the program correct.
> I have tried the processing method of your above code before, but found
>  that some errors may have occurred.

I think judicious use of "goto" without introducing the last_shown
would probably result in a much more maintainable code.  It may look
somewhat like so:

	for (i =3D 0; i < repo->index->cache_nr; i++) {
		const struct cache_entry *ce =3D repo->index->cache[i];
		struct stat st;
		int stat_err;

		construct_fullname(&fullname, repo, ce);

		if ((dir->flags & DIR_SHOW_IGNORED) &&
			!ce_excluded(dir, repo->index, fullname.buf, ce))
			continue;
		if (ce->ce_flags & CE_UPDATE)
			continue;
		if ((show_cached || show_stage) &&
		    (!show_unmerged || ce_stage(ce))) {
			show_ce(repo, dir, ce, fullname.buf,
				ce_stage(ce) ? tag_unmerged :
				(ce_skip_worktree(ce) ? tag_skip_worktree :
				 tag_cached));
			if (skip_duplicates)
				goto skip_to_next_name;
		}

		if (!show_deleted && !show_modified)
			continue;
		if (ce_skip_worktree(ce))
			continue;
		stat_err =3D lstat(fullname.buf, &st);
		if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR))
			error_errno("cannot lstat '%s'", fullname.buf);

		if (show_deleted) {
			show_ce(repo, dir, ce, fullname.buf, tag_removed);
			if (skip_duplicates)
				goto skip_to_next_name;
		}
		if (show_modified &&
		    (stat_err || ie_modified(repo->index, ce, &st, 0)))
			show_ce(repo, dir, ce, fullname.buf, tag_modified);
		continue;

	skip_to_next_name:
		{
			int j;
			const struct cache_entry **cache =3D repo->index->cache;
			for (j =3D i + 1; j < repo->index->cache_nr; j++)
				if (strcmp(ce->ce_name, cache[j]->ce_name))
					break;
			i =3D j - 1; /* compensate for outer for loop */
		}
	}
