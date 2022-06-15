Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72055C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbiFOK3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbiFOK3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:29:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB83F8B6
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:29:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn20so3034777edb.6
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=l1Zt6LZW75kWazM7qqys8G/6xttlyam5U4ITDe9uTMM=;
        b=RZ6zBc10CmnqfuXbBRgu8HmDlw/ZWbl5Cl85wA7Nldvfqtfhwm2R01CWZlU+WDFTVF
         tGesMihXVmjg1roUj8nHofHA4Y+gFb9pymDm5vXafHIv6zqdRX9d9mKpzsDMcPNyO7QB
         diem//yugZxF7C34XTrae93oEfnbs10TSbnySPv7B5pGGzwetMb0YvTupmtzRNbQJUQK
         Kad0q07/stuPAWA+bLPDYCxYcfbhWJNHauupeUwRLdHlz1j3O+p0KsfYZ/N4kiFVptV7
         ulu2/UP4jnKyb2NnE5j3JOBOLcLe/Q1wqdwioWZK4qQjSiqu/L0+7eysuve+lrgKaCS5
         mz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=l1Zt6LZW75kWazM7qqys8G/6xttlyam5U4ITDe9uTMM=;
        b=eYsrdwKxwOgFmlF96PG1QwJZCs0lrX2hrRKIH8TEr49sOCvEXV5Nq/ltCuZNyyrVv7
         cTFjyoJv7SRKgLbdwR+nKtA8y4JFa1rQpOLFoCfws3FhQih3GCZJHvsKDeA0p/puFJJQ
         nRkwb+nQIsJjUJfhHMRltyioNnlHy3XGZkuc/OqqMa3w5y2hsnOSrSWHwgWtnGBZLSsL
         phke23m5qbN/SJmGfZYu05PDYsorLZRHhlRm2RM5BeTzGRpyMN9SV5uJP+dAjQ19l4Aw
         dmJCdEnpPP9uCN0O0sTSaTAuK83HMuZQTZF/gO5I3DV+6YJB6ZKQXczA6rSCzbPZOJTX
         HyKQ==
X-Gm-Message-State: AOAM531upF9qDV0taVi6qI1AZKEuoKhknkxfPwZEwxZTJkNPWY8tQyDq
        KvumwgfELijaK+iZgvj4+TA=
X-Google-Smtp-Source: AGRyM1vvxR6PhGG34pLJjb47Ji7VQnWSVCfNgxpQTvDcDiXCMriLECczXbXYYH9cq2/R7R4rdBpvug==
X-Received: by 2002:a05:6402:4301:b0:42d:e8fb:66f7 with SMTP id m1-20020a056402430100b0042de8fb66f7mr11748400edc.229.1655288952048;
        Wed, 15 Jun 2022 03:29:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s29-20020a50ab1d000000b0042de29d8fc0sm9154663edc.94.2022.06.15.03.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:29:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1QGs-000nOG-Mr;
        Wed, 15 Jun 2022 12:29:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: Git Test Coverage Report for v2.37.0-rc0
Date:   Wed, 15 Jun 2022 12:16:53 +0200
References: <00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com>
 <3d1c6dfd-1df6-3393-df5e-692719375772@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3d1c6dfd-1df6-3393-df5e-692719375772@github.com>
Message-ID: <220615.86mteexls9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 14 2022, Derrick Stolee wrote:

Neat, thanks! Re git-test-coverage: Maybe it's covered somewhere, but is
there tooling to reproduce this somewhere? I.e. we have "make coverage"
in tree, but not this "do the diff and blame on lines" step, unless I've
missed it somewhere...

> On 6/14/2022 4:18 PM, Derrick Stolee wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason	338959da remote.c: remove braces =
from one-statement "for"-loops
>> remote.c
>> 338959da 149) for (i =3D 0; i < remote->url_nr; i++)
>> 338959da 153) for (i =3D 0; i < remote->pushurl_nr; i++)
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason	323822c7 remote.c: don't derefere=
nce NULL in freeing loop
>> remote.c
>> 323822c7 151) FREE_AND_NULL(remote->url);
>
> Just noting that these lines are inside remote_clear() which is called by
> remote_state_clear(), which is called by repo_clear(). Apparently we have
> no tests that clear a 'struct repository' that loaded remotes? This sounds
> likely since we don't close these unless they are not the_repository.

Yeah, it's also why we didn't segfault in practice on the landmine I
fixed in 323822c72be (remote.c: don't dereference NULL in freeing loop,
2022-06-07).

>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason	fd3aaf53 run-command: add an "ung=
roup" option to run_process_parallel()
>> run-command.c
>> fd3aaf53 1645) code =3D pp->start_failure(pp->ungroup ? NULL :
>> fd3aaf53 1646)  &pp->children[i].err,
>> fd3aaf53 1649) if (!pp->ungroup) {
>> fd3aaf53 1650) strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>> fd3aaf53 1651) strbuf_reset(&pp->children[i].err);
>
> This change seems sufficiently complicated that it would be good to look
> into the test coverage here. It's possible that it is covered by the
> GIT_TEST_* variables that I didn't use when generating my test coverage.

We should definitely have test coverage for these, but FWIW it's all
pre-existing-not-tested code.

I.e. this has presumably been untested as far back as c553c72eed6
(run-command: add an asynchronous parallel child processor,
2015-12-15). It's just:

	if (start_command(&pp->children[i].process))
        	/* this whole thing is untested, as no "start command" fails */

There's probably no easy way to automate this, but for significant bonus
points I think a script like this would be much more useful if once it
identifies given commit:line pairs it would check out $that_commit^, run
"make coverage" again, see how pre-image faired (presumably --word-diff
would associate them), and post that diff on top.=20

I see in this case it's as easy as tweaking t0061-run-command.sh to do:

    test-tool run-command run-command-parallel 5 this-command-does-not-exist

I.e. we just don't stress that failure path, but should.

I'm planning to submit a cleanup series for the "ungroup" feature,
i.e. the API is weird because we were trying to come up with a minimal
regression fix. I'll make sure to include tests for this scenario in
that series. Thanks!
