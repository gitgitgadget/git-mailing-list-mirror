Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59BFC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E3E61181
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhHXUjD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 24 Aug 2021 16:39:03 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19917 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbhHXUjC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 16:39:02 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17OKcEDV087567
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Aug 2021 16:38:14 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     <git@vger.kernel.org>
References: <20210819033450.3382652-1-emilyshaffer@google.com> <20210819033450.3382652-7-emilyshaffer@google.com> <87ilzueh1g.fsf@evledraar.gmail.com>
In-Reply-To: <87ilzueh1g.fsf@evledraar.gmail.com>
Subject: RE: [PATCH v3 6/6] hook: allow out-of-repo 'git hook' invocations
Date:   Tue, 24 Aug 2021 16:38:08 -0400
Message-ID: <033201d79927$f5bfa1f0$e13ee5d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKRHTr7ax/yJxm30yaE/o/bmTBHdwHJeRAYAUpxx7up93TrUA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 24, 2021 4:12 PM, Ævar Arnfjörð Bjarmason wrote:
>On Wed, Aug 18 2021, Emily Shaffer wrote:
>
>> Since hooks can now be supplied via the config, and a config can be
>> present without a gitdir via the global and system configs, we can
>> start to allow 'git hook run' to occur without a gitdir. This enables
>> us to do things like run sendemail-validate hooks when running 'git send-email'
>> from a nongit directory.
>
>Sensible goal. Perhaps we should note in an earlier commit when config-based hooks are introduced something like:

To clarify the requirements here, if running without a gitdir (and thus without a repository?) how will front-ends know what to supply? Will this just be "some shell script" that runs?
>
>    Even though we've added config-based hooks, they currently only work
>    if we can find a .git directory, even though certain commands such
>    as "git send-email" (or only that command?) can be run outside of a
>    git directory. A subsequent commit will address that edge-case.

So we cannot assume anything about the repository, correct? Similar to running git version but not git status?

>> [...]
>> Notes:
>>     For hookdir hooks, do we want to run them in nongit dir when core.hooksPath
>>     is set? For example, if someone set core.hooksPath in their global config and
>>     then ran 'git hook run sendemail-validate' in a nongit dir?

So this is complete consent to run outside of git? I wonder whether there needs to be an attribute associated with the hook that enables this edge capability. That way we can validate whether the hook should be run or not (from front-end scripts).

