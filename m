Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6DFC388F9
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AB420757
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wyUDwxjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgKCSeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:34:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58807 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgKCSeO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 13:34:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2100E3BB0;
        Tue,  3 Nov 2020 13:34:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VJ2viFHNt06r
        TEJcEQNV+XgZ60A=; b=wyUDwxjNpIDHba4+FtQan5jEY+okFX6rg804jcZcRYQd
        eiNsvyB0x3gg5NKHvxzxyD3XG7OYJ35ORw17Hf9rEHAqvcZ0PNCFfnnxmjOlyK8+
        AoMU0ZMUToGQhQJslnVmLO4c+l6mgUslDjkdTBnVpFRyveuEz9E7Mm/t/AkkYtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Fc1AN6
        nIMiXDcyDTJl15RjCiDmM8BunKAvVb1FhDNdhTb+9JnXxFb5lqOcqZnwCgIHmQ4D
        hvpwVGwCd14PqhZ+kF+o8UfJq97hxsSBQnn4Ks2xiVSrNUzLZ5trPYeHBK73Q9Ms
        00nrq9rFMIw1sotL+5cqhlFNNy/7hHYjYz/e4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CAE54E3BAF;
        Tue,  3 Nov 2020 13:34:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 223FFE3BAE;
        Tue,  3 Nov 2020 13:34:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
        <20201102144321.GA3962443@coredump.intra.peff.net>
        <20201103101553.GH24813@szeder.dev>
        <20201103182102.GA459792@coredump.intra.peff.net>
Date:   Tue, 03 Nov 2020 10:34:09 -0800
In-Reply-To: <20201103182102.GA459792@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 3 Nov 2020 13:21:02 -0500")
Message-ID: <xmqq361qs31a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A7DB13E-1E03-11EB-B5A0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 03, 2020 at 11:15:53AM +0100, SZEDER G=C3=A1bor wrote:
>
>> > > Now, use git log to show commit logs using command
>> > >=20
>> > >         git log  --follow -L 1,1:hello.log -- hello.log
>>=20
>> While Git should never segfault, no matter what, this is a bogus git
>> invocation to begin with: the second sentence in the description of
>> 'git log -L' clearly states that "You may not give any pathspec
>> limiters", so this command should have errored out from early days,
>> but, unfortunately, it was never enforced.  This also means that '-L'
>> and '--follow' are incompatible, because while the former forbids any
>> pathspecs, the latter requires exactly one; and line-level
>> log does its own rename following anyway.
>
> Thanks for confirming. My "I am not clear how these should interact" wa=
s
> really "this does not make any sense to me" in my head, but I was afrai=
d
> that I was missing something. The fact that we document explicitly that
> -L should not be combined with pathspecs makes that much more obvious.
>
>> VS Code should be fixed to call 'git log -L 1,1:hello.log' instead,
>> without '--follow' and without pathspec.
>
> Agreed.
>
> On our side, I don't think it would be _wrong_ to catch and disallow th=
e
> combination. But it may be nicer to them if we continue to quietly
> ignore --follow and the pathspec in that case, for working with older
> versions. (OTOH, if I understand correctly they're segfaulting every
> time VS Code is used with v2.29 now, so they may have to accept it as a=
n
> urgent fix anyway).

So something like this won't harm VS Code more than we currently do,
while telling users what is wrong with their command line?

We may still want the "silently disable follow" at low-level
protection, but that does not give feedback why the end-user option
is silently ignored, so...

 builtin/log.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git c/builtin/log.c w/builtin/log.c
index 9f939e6cdf..8811084f02 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -206,6 +206,13 @@ static void cmd_log_init_finish(int argc, const char=
 **argv, const char *prefix,
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
=20
+	if (rev->line_level_traverse) {
+		if (rev->diffopt.filter)
+			die(_("-L<range>:<file> cannot be used with pathspec"));
+		if (rev->diffopt.flags.follow_renames)
+			die(_("-L<range>:<file> cannot be used with --follow"));
+	}
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
=20
