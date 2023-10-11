Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA70CDB481
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjJKTKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJKTK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:10:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C78F
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:10:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E63391CC8B9;
        Wed, 11 Oct 2023 15:10:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JFCHN0UALKwn
        EtINqhEJ3uu4+IwhOgwXJXJPcgoU/5o=; b=qP9xJuGK8ScrasQkKIsPou0/RUV7
        PoRb1ubFfluMPH974gU4pz3rntBmR3W8VXVNffzlHtf9TisayJgetnZCSkSM4uJO
        +nBfM/vrAhdKX/BiqJtQeX8JIryy5MMj5o1dyVgAmeJ6NGtEn0zp2NV7hxv3QE3Y
        Cg/hHTIm7ikWB0s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB7C41CC8B8;
        Wed, 11 Oct 2023 15:10:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52F061CC8B6;
        Wed, 11 Oct 2023 15:10:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Isoken June Ibizugbe <isokenjune@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] branch.c: ammend error messages for die()
In-Reply-To: <06bc7b39-ed70-460f-b6f1-47a0c94c0538@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Wed, 11 Oct 2023 20:04:37 +0200")
References: <20231011152424.6957-1-isokenjune@gmail.com>
        <20231011152424.6957-2-isokenjune@gmail.com>
        <06bc7b39-ed70-460f-b6f1-47a0c94c0538@gmail.com>
Date:   Wed, 11 Oct 2023 12:10:21 -0700
Message-ID: <xmqqttqxkmaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3748AFC-6869-11EE-B8C7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> @@ -640,16 +640,16 @@ static void copy_or_rename_branch(const char *ol=
dname, const char *newname, int
>>  	if (!copy && (oldref_usage & IS_HEAD) &&
>>  	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.=
buf,
>>  					      logmsg.buf))
>> -		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
>> +		die(_("branch renamed to %s, but HEAD is not updated!"), newname);
>
> IMO we can go further here and also remove that final "!".  But it's OK
> the way you have done it.

Thanks for good eyes.  I do not think '!' is adding any value in
this case, so removing it is probably a good idea, even if it is
done outside the scope of this patch.

>>  		else if ((argc =3D=3D 1) && filter.detached)
>> -			die(copy? _("cannot copy the current branch while not on any.")
>> +			die(copy? _("cannot copy the current branch while not on any")
>>  				: _("cannot rename the current branch while not on any."));
>
> OK.  But I think you want to modify also the second message, to remove
> its full stop as well.

Nice spotting.

>> @@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>>  		const char *start_name =3D argc =3D=3D 2 ? argv[1] : head;
>> =20
>>  		if (filter.kind !=3D FILTER_REFS_BRANCHES)
>> -			die(_("The -a, and -r, options to 'git branch' do not take a branc=
h name.\n"
>> +			die(_("the -a, and -r, options to 'git branch' do not take a branc=
h name\n"
>>  				  "Did you mean to use: -a|-r --list <pattern>?"));
>
> Good; the full stop removed and here that question mark is valuable.  A=
nd ...

This one is not a single sentence, so retaining the full stop at the
end of the first sentence would actually be good, in addition to the
capitalization of the second sentence.

In a modern world, I would suspect that we would use die_message()
interface to emit the first sentence, show the "Did you mean..."
with advice_if_enabled(), and then exit with the status returned by
die_message(), similar to how branch.c::setup_tracking() does.  When
it happens, the die() message will be only the first sentence, and
what this patch did can be retained.  The second message will have
to be reworked to make it more appropriate as an advice message.

Thanks for a prompt review.
