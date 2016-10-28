Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64B42035F
	for <e@80x24.org>; Fri, 28 Oct 2016 21:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761932AbcJ1VG4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 17:06:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58102 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1761913AbcJ1VGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 17:06:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF2C84A08B;
        Fri, 28 Oct 2016 17:06:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h+YzIXO3SogD5z0KvJ88WhOaVgc=; b=DPWJkW
        LpFzWJp6GC5bMxvYyhU4zrm2FGDDiG2+mB8g2ifqmxUjH/CLAGCaXwBz/KHXZoeX
        QMyIfBbUmlOH+L88zboWUTn1TA2VnrqXz1Nc5iQ/9YLpkqQUGcoJnvTf0WHkEXxF
        fgm8PeKwlOrYwodFdiQDKOLzeCczd5xm+TZCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DPvYLSMhoiom2o5KJZjEyldo8aQ40IQo
        S18B+T4l3D7yZ7Z8i+ABldJhKSq5/mI6E2fWQMI4jzf6KBUC3qYvDt+feuL2qdXi
        D6E7ohHKL1gBrwqcRR8EKhqGj/JoP2EnzwX7AEHaSH5JkeBJCF/gmfelFYGWTxKJ
        5aHyB5MH5iU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C63FE4A08A;
        Fri, 28 Oct 2016 17:06:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 558BE4A088;
        Fri, 28 Oct 2016 17:06:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Scott R. Chamberlain" <srchamberlain@impromed.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can't get git to stop outputting to StdErr
References: <c09d32d8ab97418d98ddf356e20a6ff5@ES4.impromed.com>
Date:   Fri, 28 Oct 2016 14:06:51 -0700
In-Reply-To: <c09d32d8ab97418d98ddf356e20a6ff5@ES4.impromed.com> (Scott
        R. Chamberlain's message of "Fri, 28 Oct 2016 20:31:02 +0000")
Message-ID: <xmqq7f8syyhg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73989CA2-9D52-11E6-9C49-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Scott R. Chamberlain" <srchamberlain@impromed.com> writes:

> The line I do is:
>
>     git push -q binaryRepo HEAD:"$Env:BUILD_SOURCEBRANCH"

This would 

 (1) squelch the output from the sending side (i.e. local), and

 (2) ask "quiet" to the receiving side (i.e. remote), if they know
     how to be quiet.

> But I get the following in my log after the build
>
>     2016-10-28T20:05:32.3179442Z ##[error]remote: 
>     remote: Analyzing objects... (3/3) (657 ms)        
>     remote: Storing packfile... done (40 ms)        
>     remote: Storing index... done (42 ms)        

These three lines prefixed with "remote:" are coming from the
software that runs on the remote machine that accepts your push, but
the way it says these three things do not look familiar to me.  Is
it possible that the remote machine is running a Git server that is
not ours, which lacks the support for "quiet" capability?  If that
is the case, the symptom is understandable.

A quick archive search tells me that you are seeing the same issue
as this one:

https://public-inbox.org/git/20160516133731.GA6903@sigill.intra.peff.net/

where the concluding remark, to which I agree, is:

    The server side here is clearly not stock git, from the content
    of those progress messages (some googling shows it looks like
    whatever visualstudio.com is running, but I don't know what that
    is). So either the server implementation doesn't support the
    "quiet" protocol extension, or it is ignoring it. It might be
    worth filing a bug with them.


