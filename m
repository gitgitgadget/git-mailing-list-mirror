Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08D42070F
	for <e@80x24.org>; Mon, 19 Sep 2016 16:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbcISQDK (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 12:03:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50622 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752112AbcISQDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 12:03:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C8DA3FB1F;
        Mon, 19 Sep 2016 12:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uktTD88Qju+eesFXTsILVAa9ZhM=; b=L5dlKn
        gSc/VFlXesP/Ad9Gs65ukiugLaw7oOal7l4TfIsSguSCJ8TJrZFVWPcGKZkXVDjU
        Vrfd1QdvIznFIotLYIjg85nOlSBNR2KjytlWQWbTa+5Aq41QYdWpV8MVUpZA6zRe
        p5ewdoP2sRFGv3T9spIoBEwc2VRrNil0EPYJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XKlS4M6i/IRvMClDmafqoGsH3KnTiC/m
        rTalIt47+Z5d5kwwCJ10wai0HQnWhBDEvoHAprCnxOckkB/mHdRJKLb5minNmd/k
        G7KrpqB16yEda7TXAa1q8TdkqijlJoNmBDclGxDCOL5JID3NqJjk0hMRXcpXgarE
        LXP7PAa5sgk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DC8C3FB1D;
        Mon, 19 Sep 2016 12:03:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 887FA3FB1A;
        Mon, 19 Sep 2016 12:03:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anatoly Borodin <anatoly.borodin@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Bug: pager.<cmd> doesn't work well with editors
References: <nrmbrl$hsk$1@blaine.gmane.org> <nrmd6u$imf$1@blaine.gmane.org>
Date:   Mon, 19 Sep 2016 09:03:05 -0700
In-Reply-To: <nrmd6u$imf$1@blaine.gmane.org> (Anatoly Borodin's message of
        "Sun, 18 Sep 2016 15:51:58 +0000 (UTC)")
Message-ID: <xmqqh99bho7a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E11D75E-7E82-11E6-AA2C-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anatoly Borodin <anatoly.borodin@gmail.com> writes:

>> I think, the pagination should be turned off when the editor is being
>> called.

This is a fun one.  IIRC, we decide to spawn a pager and run our
output via pipe thru it fairly early, even before we figure out
which subcommand is being run (especially if you do "git -p
subcommand"), which by definition is way before we know if that
subcommand wants to let the user edit things with the editor.
