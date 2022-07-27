Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A300BC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 06:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiG0Gbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 02:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0Gbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 02:31:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E527B11
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 23:31:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AA98141CF1;
        Wed, 27 Jul 2022 02:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uTHGCWFthrix
        bSuHNvn8yfVeUKPfArb6pSYZq3PAHxo=; b=WZMDa6+vc2NwsWvoVXXKTMyDXHgp
        X4oWnlZhAmFjvmxGVEzp8GmUvl9mCFkL7idPb24vVNNj7iO3NyC5znmAMoR+EuNl
        lic/pwL9JdvbAEzfjDjl7JmTqGCKDWBrBZ0t7w3Lq5clZ6nIkM58PevO4fEDGHXd
        2Un+Glrb2MgPFZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90DC9141CF0;
        Wed, 27 Jul 2022 02:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEDA4141CEF;
        Wed, 27 Jul 2022 02:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julien Rouhaud <rjuju123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: improve title shortening heuristics
References: <20220724061231.jddhqns7bqx5c2xm@jrouhaud>
        <xmqqfsiq6ksb.fsf@gitster.g>
        <20220725020534.x33hso22ab2dwyo7@jrouhaud>
        <220725.86czdtrayy.gmgdl@evledraar.gmail.com>
        <20220726135911.ycvgwbkixb3ei6w3@jrouhaud>
Date:   Tue, 26 Jul 2022 23:31:32 -0700
In-Reply-To: <20220726135911.ycvgwbkixb3ei6w3@jrouhaud> (Julien Rouhaud's
        message of "Tue, 26 Jul 2022 21:59:11 +0800")
Message-ID: <xmqq4jz3vzgb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C2441734-0D75-11ED-A899-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien Rouhaud <rjuju123@gmail.com> writes:

> Hi,
>
> On Mon, Jul 25, 2022 at 07:54:34AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>
>> Please "inline" your patches, see "Sending your patches" in
>> Documentation/SubmittingPatches (I.e. send it with git-send-email, or
>> similar). I see this as:
>>
>> > [2. text/plain; v2-0001-gitweb-Remove-title_short-shortening-heurist=
ics.patch]...
>
> Ah I'm sorry about that.  For the archives sake (and to make sure that =
I
> correctly configured my MUA), I'm reattaching the v2 inline.

Thanks.  It is not for the archives' sake; I do not take (or notice
in the first place) patches in attachments, simply because rarely
anybody reviews attachments.

>> This looks good to me, The one thing I'd add is that we're just runnin=
g:
>>
>> 	 git rev-list --parents --header  --max-count=3D1 HEAD
>>
>> And parsing that, but if we're truncating things perhaps we should jus=
t
>> run "git log" or "git show" with the "%<(<N>[,trunc|ltrunc|mtrunc])"
>> syntax or similar.
>>
>> That's obviously a follow-up, but if anyone's interested in deleting
>> even more code here...
>
> Note that I didn't try to do anything about that.  I have the feeling t=
hat
> gitweb isn't wildly used nowadays, especially for bigger projects, so i=
t didn't
> seems worth spending too much efforts.
>
> From ea4f31c0a2276f042322a11e258e55223863cd35 Mon Sep 17 00:00:00 2001

When you are sending the patch in for real, after making a non-patch
discussion (all of the above), you can write a "scissors" line

----- >8 -----

right here, immediately before your "From:" and "Subject:".  What it
does is to tell "git am" on the receiving end to ignore everything
it saw up to that point and pretend the message starts there.

You do not want to include "From <object name>" line that is used as
an internal separator in the mailbox format.  You do not want to
include the "Date:" in-body header, either.  "From:" and "Subject:"
are used often because they are frequently different from the e-mail
(e.g. in the message I am responding to, the sender is rjuju123@gmail,
not julien.rouhaud@free.fr, and we want the latter on the From: line
because that is what appears on the Signed-off-by: line).

> From: Julien Rouhaud <julien.rouhaud@free.fr>
> Subject: [PATCH v2] gitweb: Remove title_short shortening heuristics
>
> Those heuristics are way outdated and too general to be useful outside =
of
> kernel.org.  Since kernel.org doesn't use gitweb anymore and at least o=
ne
> project complained about incorrect behavior, entirely remove them.
>
> Signed-off-by: Julien Rouhaud <julien.rouhaud@free.fr>
> ---
>
> Notes:
>     Patch re-submitted inline rather than in attachment, sorry about th=
e
>     previous attachments.

Thanks.  Will queue.


>  gitweb/gitweb.perl | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1835487ab2..e66eb3d9ba 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3560,23 +3560,6 @@ sub parse_commit_text {
>  		$title =3D~ s/^    //;
>  		if ($title ne "") {
>  			$co{'title'} =3D chop_str($title, 80, 5);
> -			# remove leading stuff of merges to make the interesting part visib=
le
> -			if (length($title) > 50) {
> -				$title =3D~ s/^Automatic //;
> -				$title =3D~ s/^merge (of|with) /Merge ... /i;
> -				if (length($title) > 50) {
> -					$title =3D~ s/(http|rsync):\/\///;
> -				}
> -				if (length($title) > 50) {
> -					$title =3D~ s/(master|www|rsync)\.//;
> -				}
> -				if (length($title) > 50) {
> -					$title =3D~ s/kernel.org:?//;
> -				}
> -				if (length($title) > 50) {
> -					$title =3D~ s/\/pub\/scm//;
> -				}
> -			}
>  			$co{'title_short'} =3D chop_str($title, 50, 5);
>  			last;
>  		}
> --
> 2.37.0
