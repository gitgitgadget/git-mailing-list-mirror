Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4A51F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 07:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfJZHe0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 03:34:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53370 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJZHe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 03:34:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0A3C2FECB;
        Sat, 26 Oct 2019 03:34:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wdqYZCtPPDgagdyX5SeOPNFX/SM=; b=tCwpx/
        9UUVDnBqPY4sJ08yQoDsEWCk2f2okoSO3akYqDEXncpqGTOiQVIc49uMIwL807SF
        jUHgcQEiquVz4A8FN4pVN8jZ3cVuta47wp/pktom1tQCPy3BFGTZleD0bbRN54aI
        Sy8dzh7JfLTV3jv5G8R/VItEqYC8XSkgTKMNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vv4hJjw2OFgAaEBx9V5F3Kf/VdwtzXP1
        RBuYe9/8FXveUpIJs+jPAB2K9lG8lUDhr9pfYNhjmPwzxWc0r9HcJEJiIVI4vCvn
        PxqQDZ2bjNgJFYEZLk46Z2xDSIfl2AZoLYRIZP72cH0Ja1viaX3OmwsQr/vgE3cj
        RUrnN1fQqok=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D71A72FECA;
        Sat, 26 Oct 2019 03:34:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B0C62FEC9;
        Sat, 26 Oct 2019 03:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Luke Dashjr <luke@dashjr.org>, git@vger.kernel.org
Subject: Re: GIT_COMMITTER_* and reflog
References: <201910252149.23787.luke@dashjr.org>
        <20191026022039.GE39574@google.com>
Date:   Sat, 26 Oct 2019 16:34:22 +0900
In-Reply-To: <20191026022039.GE39574@google.com> (Jonathan Nieder's message of
        "Fri, 25 Oct 2019 19:20:39 -0700")
Message-ID: <xmqqv9scark1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08402A8C-F7C3-11E9-8E41-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> If GIT_COMMITTER_{NAME,EMAIL} were used when writing reflogs but
> GIT_COMMITTER_DATE weren't, would that help with your workflow?

Thanks for a thoughtful response.

My knee-jerk reaction is that it probably was a design bug that came
out of laziness that we used the usual mechanism to obtain the
committer date when deciding the timestamp we leave in reflog
entries.  Given that we say master@{6.hours.ago} etc., we should
base the timestamp on something that is coherent with what the end
users would give us, e.g. "6.hours.ago".  IOW, we should be using
the wallclock time without paying attention to GIT_COMMITTER_DATE,
i.e. date.c::get_time().

