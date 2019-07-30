Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1536F1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 22:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfG3WNy (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 18:13:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53677 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfG3WNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 18:13:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 986B0166E2A;
        Tue, 30 Jul 2019 18:13:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Cgt22sWc0BCa
        1pT2IiVy8c3UO/U=; b=B3vc5AuVvZSEcC//QbFXqr22Zeqx2ABORFTiOrzc5K0w
        cpvWU99zyVsHye+WrAridz9PGWmoaZP6ahSv/RKTMKRdKPhuGPl6xYZ+eJcAAhYJ
        gm47N+QCpfvvtcP1rXUbwbmM2HLydW3rnO2/dKziD9or9iurNE4nSX6urStTXdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EiNxrM
        HvRLJxjJzJhmiK7SdeqX3vtrKTv3Rtd4b9M3CjNw4gqrWsAjxrzl7XxqbLgNNlC9
        F8VyaCsaC6lll/Mfgp86ZJY3gBHNebXyqsZY/1A04kNZpOA5vWLG4qcubLKBaR69
        ECqnZpyYdVpp/SKAjmG06TQq7soTY0GBV40us=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FC6E166E29;
        Tue, 30 Jul 2019 18:13:52 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E53B3166E28;
        Tue, 30 Jul 2019 18:13:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCHv3] send-email: Ask if a patch should be sent twice
References: <20190730203327.30958-1-dima@arista.com>
Date:   Tue, 30 Jul 2019 15:13:50 -0700
In-Reply-To: <20190730203327.30958-1-dima@arista.com> (Dmitry Safonov's
        message of "Tue, 30 Jul 2019 21:33:27 +0100")
Message-ID: <xmqq5znjrx0h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5003C52C-B317-11E9-AB42-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dmitry Safonov <dima@arista.com> writes:

> I was almost certain that git won't let me send the same patch twice,

Why?  And more importantly, does it matter to readers of this
message what you thought?

> but today I've managed to double-send a directory by a mistake:
> 	git send-email --to linux-kernel@vger.kernel.org /tmp/timens/
> 	    --cc 'Dmitry Safonov <0x7f454c46@gmail.com>' /tmp/timens/`
>
> [I haven't noticed that I put the directory twice ^^]
>
> Prevent this shipwreck from happening again by asking if a patch
> is sent multiple times on purpose.
>
> link: https://lkml.kernel.org/r/4d53ebc7-d5b2-346e-c383-606401d19d3a@gm=
ail.com

What does "link:" mean?

> Cc: Andrei Vagin <avagin@openvz.org>

What's the significance for this project to record that this patch
was CCed to Andrei?

> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

I think "Helped-by:" is a lot more appropriate, viewing the exchange
on v2 from the sideline.

> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
> index d93e5d0f58f0..0441bb1b5d3b 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -421,6 +421,8 @@ have been specified, in which case default to 'comp=
ose'.
>  			('auto', 'base64', or 'quoted-printable') is used;
>  			this is due to SMTP limits as described by
>  			http://www.ietf.org/rfc/rfc5322.txt.
> +		*	Ask confirmation before sending patches multiple times
> +			if the supplied patches set overlaps.
>  --
>  +
>  Default is the value of `sendemail.validate`; if this is not set,
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5f92c89c1c1b..c1638d06f81d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -688,6 +688,9 @@ sub is_format_patch_arg {
>  @files =3D handle_backup_files(@files);
> =20
>  if ($validate) {
> +	my %seen;
> +	my @dupes =3D grep { $seen{$_}++ } @files;
> +
>  	foreach my $f (@files) {
>  		unless (-p $f) {
>  			my $error =3D validate_patch($f, $target_xfer_encoding);
> @@ -695,6 +698,17 @@ sub is_format_patch_arg {
>  						  $f, $error);
>  		}

This is not a fault of your patch at all, but the two hunks are
curious.  If "git format-patch" chose to coalesce these two hunks
into one, the second hunk header can be replaced by

		$error and die sprintf(__("fatal: ..."),

The end result would be that we will spend the same number of lines
and we will see more useful information.

>  	}
> +	if (@dupes) {
> +		printf(__("Patches specified several times: \n"));
> +		printf(__("%s \n" x @dupes), @dupes);
> +		$_ =3D ask(__("Do you want to send those patches several times? Y/n =
"),
> +			default =3D> "y",
> +			valid_re =3D> qr/^(?:yes|y|no|n)/i);
> +		if (/^n/i) {
> +			cleanup_compose_files();
> +			exit(0);
> +		}
> +	}

Perhaps this should be inserted _before_ the "let's examine each
patchfile and complain" loop.  Otherwise, you'd see this warning
only after seeing the same "the file has too long a line" error
on the same patch.

While you are counting with %seen how many times the contents of
@files appear, perhaps you can also create a list of unique files,
so that you do not have to call validate_patch() more than once
for each of them.  It would also allow you to offer another choice
in the above question "do you want to send them more than once?",
which may be much more useful than yes/no: "drop duplicates".  If
you did so, you do not need to swap the order of the checks.  You
would first count the occurences of each element in @files, then
call validate_patch() on each of them just once, and after you are
done, check if the user wants to send duplicates, abort, or dedup.

Perhaps like this:

 if ($validate) {
+	my (@dupes, %seen, @uniq);
+
	foreach my $f (@files) {
+		if ($seen{$f}) {
+			if ($seen{$f} =3D=3D 1) { push @dupes, $f; }
+			next;
+		}
+		$seen{$f}++;
+		push @uniq, $f;
+	}
+	foreach my $f (@uniq) {=09
		unless (-p $f) {
			my $error =3D validate_patch(...);
		... the existing loop ...
	}
+
+	if (@dupes) {
+		... the new code in your patch ...

