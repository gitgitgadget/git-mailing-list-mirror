Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804071F404
	for <e@80x24.org>; Tue, 23 Jan 2018 20:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeAWU1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 15:27:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53160 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeAWU1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 15:27:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7D63C830E;
        Tue, 23 Jan 2018 15:27:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eiHvS3rKpZRXDi+D6iOzdBHk59M=; b=vCVHuz
        ZZd/fAoJyC6Rc0VBTh5Cwk5gJs8x9HhpHdjD71EjECLEwkxaG9LK0lg/crtxmyJX
        OU3ActmPwfYz/Xhp99kg2a6KzeTNvH8Zp4vryUBeBKTDlgdlsX4SjkG2G1fG/O3G
        ZJzf9fmf2MBx1AvjmbEFZBRiWjtPu4XtiJaDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IBL27Fq5a568RBylSoYmbC+NLYCp2mhl
        y2CP6EYKoWgsczpyOiN+REgOVjn5kuWPNEyUCZlsmzltGpUh0+Je4D6BAPDWueuJ
        /ws4H3ZWonCfJGDHf5FJ72foqso4LHESf8qDpZR1554869ISBLPe48B2evKs+OFz
        nEIaz+ugm1o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0933C830D;
        Tue, 23 Jan 2018 15:27:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67042C830C;
        Tue, 23 Jan 2018 15:27:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] sequencer: handle autosquash and post-rewrite for merge commands
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <219dbf95a8069190abe0986ca66b65a8ae3e670d.1516225925.git.johannes.schindelin@gmx.de>
        <CA+P7+xr0FpgTUa9SgkXM1U86i8f0cParNqGkP=KNPOR_EqNHYg@mail.gmail.com>
Date:   Tue, 23 Jan 2018 12:27:06 -0800
In-Reply-To: <CA+P7+xr0FpgTUa9SgkXM1U86i8f0cParNqGkP=KNPOR_EqNHYg@mail.gmail.com>
        (Jacob Keller's message of "Thu, 18 Jan 2018 08:43:49 -0800")
Message-ID: <xmqq1siggw2t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C82FCB7C-007B-11E8-9F1E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>>  static int is_per_worktree_ref(const char *refname)
>>  {
>>         return !strcmp(refname, "HEAD") ||
>> -               starts_with(refname, "refs/bisect/");
>> +               starts_with(refname, "refs/bisect/") ||
>> +               starts_with(refname, "refs/rewritten/");
>>  }
>
> Would this part make more sense to move into the commit that
> introduces writing these refs, or does it only matter once you start
> this step here?

Good spotting.  I too was wondering about multiple worktrees when I
saw the "label" thing introduced.  It probably makes sense to move
this to that step.
