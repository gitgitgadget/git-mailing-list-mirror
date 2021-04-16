Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AC1C43462
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C286137D
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbhDPSrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 14:47:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61051 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244992AbhDPSrj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 14:47:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27C05C82FB;
        Fri, 16 Apr 2021 14:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3dAoNgyK2lutYX6VFVDTt7/24Y4=; b=nv8Gnz
        AlMFg8IvzJmGt2E1YYJBJbeMPJMQnGj8Oxi174VpwZFJOo4OPzapdjB5YGBNR5Z0
        GmfORP58v3YB35+9SXk4IXIqndDoi98d1+IUvliWxITZZBohTWZCYrfcH9Da9JNC
        ACOqSuRXYa735O8sQuJE3vxpFFIz0OmFqqubo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y7kixUXuWGb2FFClee+gX2toUSCaLND+
        8jZykzHWDlDjlxSXs8j/lZQwvJlR84LcOP/L5eDeTT578KobtUohXZAZNMqmputY
        62hPyKb/yieI8wxpXX5NmqAGPCNjWkB13VjOozG3vtkV5Cx9lrmrKboK8KaxNlq1
        cJzP8Jq9gRA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E98FC82FA;
        Fri, 16 Apr 2021 14:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B823C82F9;
        Fri, 16 Apr 2021 14:47:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v6 18/20] Reftable support for git-core
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <2dc73bf2ec96acae12a17c719083d11401775bc3.1618255553.git.gitgitgadget@gmail.com>
        <87im4qejpk.fsf@evledraar.gmail.com>
        <CAFQ2z_OSbeciLQnoognG+Hh5S1tZTHO6WUviC9h5YMer766k6g@mail.gmail.com>
Date:   Fri, 16 Apr 2021 11:47:12 -0700
In-Reply-To: <CAFQ2z_OSbeciLQnoognG+Hh5S1tZTHO6WUviC9h5YMer766k6g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 14 Apr 2021 18:44:54 +0200")
Message-ID: <xmqqo8eem5hr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28A55576-9EE4-11EB-9C92-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> I would think that a better approach here would be to start with some
>> (per-se unrelated) series to teach update-ref some mode like
>> hash-object's --literally, i.e. "YOLO this ref update".
>
> I disagree.  I think this would be a job better suited to a
> test-helper. Then we don't put tools into users' hands that
> potentially corrupt the repository. I don't understand why hash-object
> --literally is not a test helper either.

As the person who invented the "--literally" option, I'd have to
agree with this assessment.  It does make life a little bit easier
for those who hack on Git codebase and reimplementations of it, but
little practical value for those who use Git every day [*].

If it were a tool to _dump_ the contents of a possibly corrupt
object that the "--literally" option would have produced to make it
easier to see by humans, I might be pursuaded to say that such a
feature may be better in end-user accessible subcommands.  But the
reason why we invented "--literally" was specifically to create
corrupt objects in test repository to see end-user accessible tools
behave, and in hindsight, such a use case shouldn't have been a good
justification to add the option.

I wasn't following the discussion of this particular patch closely,
so I do not know what is being discussed is a tool on the diagnosis
side (for which I may say it is OK to give to end-usres) or on the
currupting side (for which I would regret to add to end-user tools),
but hopefully the above would help guiding the decision between the
two.

Thanks.


[Footnote]

* ... for any purpose other than creating a corrupt repository,
  asking somebody who is or claims to be a Git expert to figure out
  what is wrong in his or her repository, and either waste expert's
  time or have fun by watching the expert fail and gets embarrased,
  that is ;-)
