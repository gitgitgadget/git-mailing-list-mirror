Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD311F45F
	for <e@80x24.org>; Tue,  7 May 2019 08:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfEGI4I (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 04:56:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59981 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGI4H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 04:56:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE8894FE79;
        Tue,  7 May 2019 04:56:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OwR06jhOZPqkSMOjz4gBrw9ESVw=; b=pQKsK9
        HAAAduQ5EZRZXxEt5i0xLTNDQ/CnIz9uX+9+3kAvCcE+39F/gmg16r8rgo+UKuqU
        0t7kXB744uyGxqVBYgQu9LDo1Z2q6UOXT5+Ez05Ms9IYCi5x2+6fbhmh+p3S5Yqd
        Kamg5SfptjORrfAUZt/VWCWoLwMIqjzE8BuMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cmr7qHP4WMZnITRX99kfMY35iV3Jk3b3
        Jo1poT4wVr+N0jdFewD4PRlTIz+x2r3DV0RrPjC/KxtGD8l0m13EZ9vdgjD20D/S
        yzmZ4mRhqqyInn4nkKKEF5chCzDJwt47gXZSOmy0iahF0Lx+9sLyuYDmbnSLWO3b
        Gh0y9b2+dLY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A72314FE78;
        Tue,  7 May 2019 04:56:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D60E94FE73;
        Tue,  7 May 2019 04:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] teach branch-specific options for format-patch
References: <cover.1557072929.git.liu.denton@gmail.com>
Date:   Tue, 07 May 2019 17:56:00 +0900
In-Reply-To: <cover.1557072929.git.liu.denton@gmail.com> (Denton Liu's message
        of "Sun, 5 May 2019 12:24:26 -0400")
Message-ID: <xmqq4l66myn3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1213278-70A5-11E9-8982-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Currently, format-patch only accepts branch.<name>.description as a
> branch-specific configuration variable. However, there are many other
> options which would be useful to have on a branch-by-branch basis,
> namely cover letter subject and To: and Cc: headers.
>
> Teach format-patch to recognise these branch-specific configuration
> options.
>
> Note that this patchset[1] was created using these new configuration
> options:
>
> 	[branch "submitted/fix-revisions-txt"]
> 		coverSubject = "cleanup revisions.txt"
> 		cc = "Andreas Heiduk <asheiduk@gmail.com>"
> 		cc = "Duy Nguyen <pclouds@gmail.com>"
> 		cc = "Junio C Hamano <gitster@pobox.com>"

Do we have format.<something> configuration for these things?

What I am trying to get at is if these are better structured similar
to http options where http.<something> supplies the overall default
for <something>, while http.<destination>.<something> gives a more
destination site specific override of that default.  I.e. format.cc
is used as fallback, while format.<branch>.cc is used to override.

In any case, it smells to me that branch.<branch>.cc does not hint
strongly enough that they are meant to affect format-patch.


