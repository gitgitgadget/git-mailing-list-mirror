Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E016C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2551D206F1
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nkVlzOe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCMACK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:02:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59492 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMACK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 20:02:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FF85524B4;
        Thu, 12 Mar 2020 20:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oIIr7sHSQXNvUlCdzbO6REGARMA=; b=nkVlzO
        e0b4GkiGmDlxRjbQ3G4dE0iVeP3gqChI4MkLiCt5IgPx7vborBAskdknntRTntMu
        I6FYyZJJRUEtL3TnhUbJdkJ56Cc7RcqCy2c//cfYtPkWavQBrQ2vzBf3MVEE+UEO
        JmPbg53p49A3/2gSaC5uTFm2E1pjQbpVkPg9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c4r6pUtsTbu9ZNvywUNbOfMxcrGBfVKk
        YqP/EEM+VSe9bGxIJHmms20j3qj5ct6fys1f/thHs4HfxSQitGkqj9qUJnPGUWyT
        V3bQRo4mH5545H7YenNwuHujfIxq1EBwOPpOasrTofyQOce2uJJgzE4AEPohiDUE
        2yDlDF77Tt4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07308524B3;
        Thu, 12 Mar 2020 20:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89959524B2;
        Thu, 12 Mar 2020 20:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Regression in v2.26.0-rc0 and Magit
References: <3091652.KAqcNXvZJ4@cayenne> <20200312233504.GH120942@google.com>
Date:   Thu, 12 Mar 2020 17:02:06 -0700
In-Reply-To: <20200312233504.GH120942@google.com> (Jonathan Nieder's message
        of "Thu, 12 Mar 2020 16:35:04 -0700")
Message-ID: <xmqqk13pdsw1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E110D926-64BD-11EA-83A6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio, can you fast-track that fix to "master"?  Emily, can you add a
> test?

Thanks, indeed it has been waiting for tests.  We have a few more
business days before -rc2, so...

* es/outside-repo-errmsg-hints (2020-03-03) 1 commit
 - prefix_path: show gitdir if worktree unavailable

 An earlier update to show the location of working tree in the error
 message did not consider the possibility that a git command may be
 run in a bare repository, which has been corrected.

 May want a test or two.


