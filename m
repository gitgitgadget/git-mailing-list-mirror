Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8053DC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 21:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjEPVSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 17:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEPVSq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 17:18:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FADF5FE1
        for <git@vger.kernel.org>; Tue, 16 May 2023 14:18:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C82C92006AF;
        Tue, 16 May 2023 17:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4hYX4LSGHZGjJsmCqQe8ITlL4ykqmoH08yMoAD
        Sb2pA=; b=ubAh6PyaVkgq4dgv0YfXO3tYn15A0dCmFUdWTCOcWcvwFMi/D6J86x
        pZ1Pz5FiElRl+pjRvhbG9hK2qBLCANtTt/lVS3NWj03H+22oeZWgi6HcBeXOEoA+
        GNQXHpl5eAj9Q2nSWuTtlFy04z0pSERNJ9RH0yBdU6/QChgyfeeXY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C15A52006AE;
        Tue, 16 May 2023 17:18:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F38E42006AC;
        Tue, 16 May 2023 17:18:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] strbuf.h: move declarations for strbuf.c functions
 from git-compat-util.h
References: <20230516170932.1358685-1-calvinwan@google.com>
        <20230516170932.1358685-2-calvinwan@google.com>
Date:   Tue, 16 May 2023 14:18:40 -0700
In-Reply-To: <20230516170932.1358685-2-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 16 May 2023 17:09:26 +0000")
Message-ID: <xmqq8rdot1ov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BAC56E0-F42F-11ED-8F63-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> While functions like starts_with() probably should not belong in the
> boundaries of the strbuf library, this commit focuses on first splitting
> out headers from git-compat-util.h.

Yeah, compat-util.h started out as a (surprise) "compatibility aid"
that isolates the knowledge of platform specific inclusion order,
what feature macros to define before including which system header
file, etc. but over the years, it accumulated some common niceties
that are too small to deserve their own header files.

starts_with() and skip_prefix() are two examples of such.  

It is hard to imagine skip_to_optional_arg_default() should belong
to strbuf API, but if you are booting it out of compat-util,
declaring it in strbuf.h may be the least bad choice, as the
implementation sits in strbuf.c (which is a strange place, but that
is not the fault of this series).
