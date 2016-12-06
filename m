Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169F01FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 23:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbcLFXzA (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 18:55:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64617 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751266AbcLFXzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 18:55:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 442A3561AF;
        Tue,  6 Dec 2016 18:54:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qLyiMWU+xeDgII0N3bY04rxSEHs=; b=REmzac
        xko90p+teB0dPFj4LGSInKVPZWPJHQrnOJHCzGUAV4t+ZwIRtaqrtbpJIclEQtsA
        Mr3bb0eXr3Vb4wfhhE4HG9npUC3tJDzkaL7BK+FryFE6VdeU1qcvK40u6Oq0uFEc
        8sH1zP4DHxBoJm9bUriLt5C1AzW/K2Cw/j96I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dnIVwBSV8xK56yxngGU+M9ohR4CQnYMa
        JkfhmXuUosuzqX8rrSTc2Ch0lUjBDigXi3K212w71nYaYdP+TwrqVmrJk2XGBi9T
        HNZQdbauGD7orOXGwx+JjpMJLJX6BQfIDaHlE+6p61aDaJQ2iVxAgWBsZy/jDbPq
        zY6K+aqgZSo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B7C7561AE;
        Tue,  6 Dec 2016 18:54:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF251561AC;
        Tue,  6 Dec 2016 18:54:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Merging .gitmodules files
References: <8d266034ae5940efbec3eef372a6ce43@exmbdft7.ad.twosigma.com>
Date:   Tue, 06 Dec 2016 15:54:57 -0800
In-Reply-To: <8d266034ae5940efbec3eef372a6ce43@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Tue, 6 Dec 2016 23:48:27 +0000")
Message-ID: <xmqqlgvsy5ny.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 650DDAAE-BC0F-11E6-B042-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

> I could set my .gitattributes for the .gitmodules file to use a
> custom merge driver. But: (a) I don't see an off-the-shelf one
> that does what I want ("union" happens to work in the add/add
> case, but not in the add/remove case or other cases) and (b) I
> would have to rewrite my whole history in order to have the
> .gitmodules file exist at every commit (or find a way to get
> .git/info/attributes into each of my users' clones) and (c) this
> should work correctly without customization; Git already treats
> the .gitmodules file as special for commands like "status";
> there's no reason it shouldn't do so for merge and rebase.
> ... if I did have time, do others agree that it would be
> reasonable to special-case this file?  (Naturally, before doing
> the merge, we would check that the file was in fact parseable as a
> git config file; merging two changed gitmodules files of which
> either is unparseable would fall back to merging as text).

I do not see a fundamental reason why Git shouldn't know what
.gitmodules file is and how it should merge.

Our philosophy has always been "give users enough flexibility so
that they can experiment and come up with a solution that is general
enough (i.e. you can do it with custom merge driver), and then fold
it back into the core if it is an issue that is general enough and
it makes sense for the core to care about (i.e. my "why not?"
above).  If you already have a custom merge driver, then you have
already cleared the first step ;-)

