Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D24C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 23:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD43610FA
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 23:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbhDNXWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 19:22:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55684 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhDNXWo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 19:22:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 187D2B8EA9;
        Wed, 14 Apr 2021 19:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6EDfcOMvJdwfcIUT7Ju66AE7Gqk=; b=knAVnM
        ViBNpDyz4bZlHdS2mrcrVCe61qhELonBDNezKYm2CqupJlQkS1cDmewQCc9tKBRM
        rV36eHgmWL5sUwH+/NYaRhFA67GqM1gmOKp7VDHdM11XB1cjtRmc+XYJYUmBrLpU
        2cPEo4NPOBpP0vhSQ/eMk70SKRL7GZBRv6RCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IHPwcwNUghheN4gzzM0t2rslEg5M8ej5
        g7IZ7vKHQP27FW/YKUqGNwEQP9fjCrdMhFBgIwfJ1y/mhs3zl6CMHhOFjUN54LzR
        jneLHciimt++FjCVj8MJuKKwJlfyfrWvGoQYh10BbljXnWdnZjy6uNM63eB3AmFa
        qsxRe1bp7io=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02454B8EA8;
        Wed, 14 Apr 2021 19:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63824B8EA7;
        Wed, 14 Apr 2021 19:22:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: What's cooking (draft for #4's issue this month)
References: <xmqqmtu1zn3o.fsf@gitster.g>
Date:   Wed, 14 Apr 2021 16:22:19 -0700
In-Reply-To: <xmqqmtu1zn3o.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        13 Apr 2021 18:11:39 -0700")
Message-ID: <xmqqim4owixg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 429FFAF2-9D78-11EB-8AE1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the (local) test status near the tip of 'seen', relative to
the integration result last night.

 * hn/reftable has a preparatory change to use oidread() instead of
   hashcpy() in places queued at its tip.  This is essentially a
   no-op in the codebase without bc/hash-transition-interop-part-1
   and would be a bugfix with that topic.  Please squash it into an
   appropriate step in the series when updating the topic in the
   future.

 * ab/unexpected-object-type topic has an assertion to catch
   semantic conflicts with topics in-flight queued at its tip.  It
   would probably be safe to carry it until the topioc is merged to
   'master' and then remove it after the dust settles.  Please
   squash it into an appropriate step in the series when updating
   the topic in the future.

 * The tip of 'seen' passes all the tests locally, except that t5540
   fails when compiled with CC=clang (http-push exits with signal
   11).  bc/hash-transition-interop-part-1, which is at the tip of
   'seen', seems to have this issue standalone.  FYI, here is what
   "clang --version" gives me:

    Debian clang version 11.0.1-2
    Target: x86_64-pc-linux-gnu
    Thread model: posix
    InstalledDir: /usr/bin

Credits for the corrections cited above goes to Patrick.

The attached is a summary of various topics.  Their status may be a
bit stale (I haven't re-reviewed them with respect to the latest
discussion on the list).

Thanks.

----- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 -----

Expecting a (hopefully final) reroll.
 - ag/merge-strategies-in-c                                     03-17         #15

Expecting a reroll.
 - sg/bugreport-fixes                                           04-08          #1
 - ds/maintenance-prefetch-fix                                  04-10          #3
 - ma/t0091-bugreport-fix                                       04-12          #1

On hold, waiting for the "protections" topic to stablize.
 + ds/sparse-index                                              03-30/04-07   #21

On hold.  Probably needs either a reroll or incremental refinements.
 + dl/complete-stash                                            03-24/03-24    #3

Stalled
 - es/config-hooks                                              03-10         #36
 - ab/describe-tests-fix                                        04-12          #5
 - ab/pickaxe-pcre2                                             04-12         #22
 - ab/unexpected-object-type                                    04-14         #11

Undecided
 - mt/add-rm-in-sparse-checkout                                 04-08          #7
 - jh/rfc-builtin-fsmonitor                                     04-08         #23
 - mt/parallel-checkout-part-2                                  04-08          #5
 - bc/hash-transition-interop-part-1                            04-10         #16
 - mr/bisect-in-c-4                                             04-11          #4
 - ps/rev-list-object-type-filter                               04-12          #8
 - ab/fsck-unexpected-type                                      04-13          #6
 - rs/repack-without-loosening-promised-objects                 04-14          #2
 - ds/sparse-index-protections                                  04-14         #26

Waiting for reroll.
 - ah/plugleaks                                                 04-10          #9

Waiting for reviews to conclude.
 - ab/doc-lint                                                  04-10          #7
 - ab/rebase-no-reschedule-failed-exec                          04-10          #2
 - hn/refs-trace-errno                                          04-12          #1

Waiting for reviews.
 - jt/push-negotiation                                          04-08          #6
 - tb/multi-pack-bitmaps                                        04-10         #23
 - ab/svn-tests-set-e-fix                                       04-12          #2
 - ab/test-lib-updates                                          04-12         #16
 - ao/p4-avoid-decoding                                         04-12          #2
 - zh/trailer-cmd                                               04-12          #2
 - hn/reftable                                                  04-14         #21

Will merge to 'master'.
 + en/ort-perf-batch-10                                         03-18/04-07    #8
 + en/ort-readiness                                             03-20/04-08   #13
 + jz/apply-run-3way-first                                      04-06/04-08    #1
 + ab/complete-cherry-pick-head                                 04-07/04-09    #1
 + jz/apply-3way-cached                                         04-07/04-09    #1
 + ab/userdiff-tests                                            04-08/04-13    #9
 + ar/userdiff-scheme                                           04-08/04-13    #1
 + ah/merge-ort-ubsan-fix                                       04-12/04-13    #1
 + hn/reftable-tables-doc-update                                04-12/04-13    #1
 + jk/pack-objects-bitmap-progress-fix                          04-12/04-13    #1

Will merge to 'next'.
 - jt/fetch-pack-request-fix                                    04-08          #1
 - ab/detox-gettext-tests                                       04-13          #1
 - ab/usage-error-docs                                          04-13          #3
 - jk/promisor-optim                                            04-13          #3
 - so/log-diff-merge                                            04-13          #5
 - ps/config-global-override                                    04-13          #3
