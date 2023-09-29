Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5BDE71D4A
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 15:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjI2PMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjI2PMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 11:12:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B88DE
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 08:12:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF2BA1B9CED;
        Fri, 29 Sep 2023 11:12:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=fhsdlUbAyn4SR4/sE3HLi7dktsrHg+BXXDT8IU
        PpMwM=; b=HeLgQN8liw70+hf+gJApdzVXwwG1Uo35mG90QAjSDIRFSxxvdIXerE
        DK/VB2TRRlF18UlMHin/1M7KLSaTuOjE4YIt1RocAXLWAobxNkRok1DxjFqynPD+
        aPwizUdEBUmtBFUHw7U6wNRUQyrEGcQoXvmuLPDJAH/I2v3HL/aAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7A411B9CEC;
        Fri, 29 Sep 2023 11:12:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5435E1B9CEB;
        Fri, 29 Sep 2023 11:12:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     liangxiong zhu <lxzhu@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git log bug
In-Reply-To: <LV2PR19MB5767BB3F887CDB46F571656DAFC0A@LV2PR19MB5767.namprd19.prod.outlook.com>
        (liangxiong zhu's message of "Fri, 29 Sep 2023 09:35:33 +0000")
References: <LV2PR19MB5767BB3F887CDB46F571656DAFC0A@LV2PR19MB5767.namprd19.prod.outlook.com>
Date:   Fri, 29 Sep 2023 08:12:44 -0700
Message-ID: <xmqqil7thv2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4AAADA2-5EDA-11EE-AD40-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

liangxiong zhu <lxzhu@outlook.com> writes:

> git clone $repo_url $repo_name
> cd $repo_name
> mkdir dir01
> mkdir dir02
> touch dir01/file01.txt
> git add .
> git commit -m 'Add file01.txt'
> git push
>
> touch dir02/file02.txt
> git add .
> git commit -m 'Add file02.txt'
> git push
>
> git log -1 -- dir01
>
> What did you expect to happen? (Expected behavior)
> print out commit with message 'Add file01.txt'
>
> What happened instead? (Actual behavior)
> print out commit with message 'Add file02.txt'

Thanks, but it does not reproduce with the above procedure.
Following the above (with $repo_name set to "trash" that is not a
name of any existing directory in the current directory, and
$repo_url set to a local repository that exists but without any
history), I got the "Add file01.txt" from the last step.

I got

    No refs in common and none specified; doing nothing.
    Perhaps you should specify a branch.
    fatal: the remote end hung up unexpectedly
    error: failed to push some refs to '/var/tmp/x/./empty.git'

after both of "git push", but becuase "git log" that does not say
where to start cares only about HEAD, in the above reproduction
precipe "git push" should be irrelevant (i.e., if your copy of Git
is broken to exhibit the above reported bug, it should show the same
symptom without these steps to run "git push").

If there are some hooks that modifies the history after your "git
push", it would be a different story, but otherwise I am not sure
how any version of Git would exhibit such a symptom.

Puzzled.
