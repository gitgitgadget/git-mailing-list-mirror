Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665B9C433E6
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 21:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1883320674
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 21:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pyNDZ7uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgGLVAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:00:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63982 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgGLVAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 17:00:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB18CE3548;
        Sun, 12 Jul 2020 17:00:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j3h2Ea0cQ9scyB9m6H7sFa2lVhM=; b=pyNDZ7
        uzTqeIA+Um7xgyM1Zdyjg0K2YP156z009lQEI54XYkFO10iM09/OEoaWGBXYKPge
        sbWKnHV6EEU/29xlp+OWcAc6QDQdqPjfNeCahSdTfLP2e/5on/XqQS1CtklkW0M4
        p/WxarK1p1gmSgrFrv8aNMwCumGevdLCGm+RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BVDjOm9DigNTALL3nQ7iShvbtRQcIa3G
        TXS1kZuQDzpgRa+Z1VXv/njRnkluR8IYhj3VxqfAA+KipnD2ST/kexoirD5iv5p2
        6W5akdyzVea2ZdB+P9uoWsmLNQSI9nGt+wNQq1++H1HvUHvvRYYbIY77sY6QjH0U
        0yo/Dte+7xM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3890E3547;
        Sun, 12 Jul 2020 17:00:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E58A8E3540;
        Sun, 12 Jul 2020 17:00:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tobias Girstmair <tobi@isticktoit.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gitweb: Replace <base> tag with full URLs (when using PATH_INFO)
References: <20200711203947.23520-1-tobi@isticktoit.net>
        <20200712183329.3358-1-tobi@isticktoit.net>
Date:   Sun, 12 Jul 2020 14:00:01 -0700
In-Reply-To: <20200712183329.3358-1-tobi@isticktoit.net> (Tobias Girstmair's
        message of "Sun, 12 Jul 2020 20:33:30 +0200")
Message-ID: <xmqqmu44phym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A91180BE-C482-11EA-AE46-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tobias Girstmair <tobi@isticktoit.net> writes:

> using a base tag has the side-effect of not just changing the few URLs
> of gitweb's static resources, but all other relative links (e.g. those
> in a README.html), too.

Sorry, but I am not sure the description is understandable to the
intended readers of this sentence.

Where does this README.html come from?  

Is it stored in the history of the repository as a blob, and sent to
the browser with a call to git_blob_plain() sub?  Wouldn't that
codepath send the untrusted end-user data as an attachment, in which
case relative links in the blob do not get resolved relative to the
base URL anyway, no?


