Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C689C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 22:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7247620678
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 22:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Amhabqt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgFBWJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:09:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50874 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBWJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 18:09:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1625BCF645;
        Tue,  2 Jun 2020 18:09:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hQ8r5yzULzZovNJF8zBOZi3W3ng=; b=Amhabq
        t6KgK+63WacrKFn9PjPVvisi8vbJfMuEkWNWTBmwGBL6QQAvwZ4Re06otsTA8mxO
        kPFsQKG0Om2PHsh1U4IehMazWGzxXkUScA19SEe6jbvnFOg4z71u/pLXofCakkdj
        Mho2zsK8IQUc/7elskOOTysbBk2mImbY9XBHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NReqtE6XwCiDexIM0VjCc3x8p5efpECE
        Vm8SBxYydCaDsRpWMuHDqMKvteHtv9au/wHU8XSblNIByigUmYCZCYbF2C+ZUkhR
        AQBRAB/aPTVlpF/f4OBWP474h7YrU+886gmzm+h3twSyNGToaA6l0tuRb7QGFRig
        neN9YlT01ig=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B9B2CF644;
        Tue,  2 Jun 2020 18:09:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 210E6CF640;
        Tue,  2 Jun 2020 18:09:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Laurent Arnoud <laurent@spkdev.net>
Subject: Re: [PATCH] format-patch: generate valid patch with diff.noprefix config
References: <20200602204924.GA1853335@spk-laptop>
        <xmqqpnahrx2y.fsf@gitster.c.googlers.com>
Date:   Tue, 02 Jun 2020 15:09:36 -0700
In-Reply-To: <xmqqpnahrx2y.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 02 Jun 2020 14:12:37 -0700")
Message-ID: <xmqqeeqxrufz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFF745F4-A51D-11EA-A493-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Laurent Arnoud <laurent@spkdev.net> writes:
>
>> With diff.noprefix enabled the patch generated with format-patch does not
>> include prefix a/ and b/ so not applicable with `git am`.
>
> Some projects (not this one) do not want to see a/ and b/ prefix in
> their patches, and noprefix is an option for those who needs to give
> patches to such projects.  As "am" can be told with -p<num> to accept
> such a patch just fine, I do not think this change is appropriate.
>
>> Solution is to force a_prefix and b_prefix on diffopt.
>
> Sorry, I do not think there is any problem to be solved here ;-)

Having said all that, we seem to be letting more configurations for
the diff.* family to affect the format-patch command.  The latest
addition was "diff.relative"---together with the "diff.noprefix"
that triggered this thread, some users may feel that it is a bug to
allow these configuration variables to affect the output from the
"log -p", "show", and "format-patch" commands.  

It *might* make sense to introduce log.diff.* configuration
variables so that when they are set, they are used by
log/show/format-patch instead of diff.* counterparts, or something
along those lines.  I dunno.

