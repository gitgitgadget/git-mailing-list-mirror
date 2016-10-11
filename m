Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A25E1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbcJKRKS (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:10:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56604 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754042AbcJKRKR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A139540B37;
        Tue, 11 Oct 2016 12:58:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DAWsZraC1K/5fylViBQ8xXLJDLc=; b=KeIi+l
        t3lJW/X7yFuZo3nHi/+BVF7+kyTNZKF+QM5YW0Mzrt6mqECDUSODdGSCDbM5qynF
        Mi07iDH9flOlinnN0GgEG/3nbThgi5eP6JpgOxRV+EwFn9ZpWLJGK4x6ipATnfel
        QzB/+Gb6HNavvfHP2YkevYbrFHeKN4obJYOYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CDFj42A+8s/PjCGORGP8Ju5ZoyddKuyJ
        W0WLFuWd3uysGUabmXIjI+ezNn3m8FeWWTyeadk2fyL6oW/n/TCS3S4fq+q674ol
        KUWgAWrn+S4B1CLLyxnSUKjrmvVWTyr9DKBl1V5E7GXBQZGc0zWgwdwsFBbWoZxT
        GJjxJ7ERAYA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9815240B36;
        Tue, 11 Oct 2016 12:58:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B82140B34;
        Tue, 11 Oct 2016 12:58:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script parsing
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
        <xmqqlgxvdf90.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610111212090.35196@virtualbox>
        <alpine.DEB.2.20.1610111221530.35196@virtualbox>
        <alpine.DEB.2.20.1610111238470.35196@virtualbox>
Date:   Tue, 11 Oct 2016 09:58:01 -0700
In-Reply-To: <alpine.DEB.2.20.1610111238470.35196@virtualbox> (Johannes
        Schindelin's message of "Tue, 11 Oct 2016 12:55:14 +0200 (CEST)")
Message-ID: <xmqqvawyakme.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF7566BC-8FD3-11E6-9511-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In the end, I decided to actually *not* use strbuf_add_unique_abbrev()
> here because it really makes the code very much too ugly after the
> introduction of short_commit_name():

It's perfectly fine not to use that function when it does not make
sense; we shouldn't use it (or anything for that matter) just for
the sake of using it.
