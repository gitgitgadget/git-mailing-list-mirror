Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2444220323
	for <e@80x24.org>; Fri, 17 Mar 2017 05:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbdCQFqf (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:46:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750973AbdCQFqe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:46:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EB0A71AB4;
        Fri, 17 Mar 2017 01:45:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DlzoEEwnaPf061NGBm6KOIhoWUs=; b=u5d7xO
        2yT0uA7O1U5RoOlqFQDUuPJ4PS7botCEZxACSxnMCjCYhF1G8w0qoo/KaoOYdtx2
        VdQZcfelF9Dba/PtFPumAznUJHGaQpZ08MRFwIx6GgPvxe4LDt0f9fugzdArGVkR
        xAL+ZYoR8WPryWZ9fnDWPR4nOPGENOD6KZU1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GyvH7+JD8jtLNYNDhqHi+gfDjeK5LaUa
        8QNqHPBeHvHVGUnWVWzwm2m1ObyixaWua9rc/1BkQk3J+ei11+kBoXam2VMAuSEu
        oxAC93iCdWDkfI9UYNWZ6YfZQzW0Ux2Lz3uczFrXFbLkl7LFxf61V7VFeS68fQoz
        etv9GNPNH5Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9684871AB3;
        Fri, 17 Mar 2017 01:45:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AFB071AAF;
        Fri, 17 Mar 2017 01:45:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] name-rev: favor describing with tags and use committer date to tiebreak
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
        <20170315225045.15788-1-gitster@pobox.com>
        <20170315225045.15788-3-gitster@pobox.com>
        <9AE7ADCA-97F9-4857-AC55-76C4BD822C25@gmail.com>
Date:   Thu, 16 Mar 2017 22:45:28 -0700
In-Reply-To: <9AE7ADCA-97F9-4857-AC55-76C4BD822C25@gmail.com> (Lars
        Schneider's message of "Fri, 17 Mar 2017 12:07:06 +0800")
Message-ID: <xmqqy3w48nif.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE02629E-0AD4-11E7-A61E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> A quick bisect indicates that this patch might break 
> t9807-git-p4-submit.sh 8 and 13. I haven't looked into
> it further, yet.

As I do not do P4, help in diagnosing why it breaks is appreciated.
If the test script expects a commit, that can be described in two
more more ways, is named one way (e.g. named after a branch) and the
new "favor tags even if they are unannotated" behaviour breaks its
expectation, and the only thing the test _should_ care about is what
commit the result is, then clearly the test script needs to be fixed.
On the other hand, if git-p4 command internally uses name-rev and it
is not prepared to properly handle commits that can be named in more
than one way, the problem would be deeper, as it would mean it can
misbehave even without the change to name-rev when multiple branches
point at the same commit.

Thanks.

