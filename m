Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D671F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 00:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeK0Lrm (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 06:47:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64659 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeK0Lrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 06:47:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A923C25B0B;
        Mon, 26 Nov 2018 19:51:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ivLnKr9HWoRXOy1DSHPofHXa33A=; b=WZHJu1
        RUxevUioKB8S77IO+H1u+qBpVNLO25oj9bFVKZIw10FXlhL3psXqGpBOxY3zypUX
        RY9ds0LlioQwPr9QhM+S01EN9WOqxM/hfWteXxBnTPM2gY9FIWagpAlHIXUyAYwJ
        X36bhIlH43iHVecmWWOYeJ45TH69J4xf+fa3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v1XWa919CTpww6AqjqmAtufqiodWXxGN
        wSjsccsgaDhwLNd0emheS5H8SefR72/WQVhHc2oWNCNnTpKlojuJyEMUfLPDq1qC
        hc6RDeB1fHcpCO7aSq9FcuquQFLTC7c+J4ZOkE3HRfRuUZgwudFLYbMQl1SmItdN
        4E8V5Oi6FF0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A12B225B09;
        Mon, 26 Nov 2018 19:51:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 703D625B06;
        Mon, 26 Nov 2018 19:51:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
        <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
        <CAGZ79kaaLeaffMnkyd7Z1gF5yxq=GDH_Fy_PG1=FfcL=9b9nRQ@mail.gmail.com>
Date:   Tue, 27 Nov 2018 09:51:34 +0900
In-Reply-To: <CAGZ79kaaLeaffMnkyd7Z1gF5yxq=GDH_Fy_PG1=FfcL=9b9nRQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 26 Nov 2018 12:19:01 -0800")
Message-ID: <xmqq4lc3uyuh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97AFFE22-F1DE-11E8-A3BA-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Nov 21, 2018 at 1:08 PM Thomas Braun
> <thomas.braun@virtuell-zuhause.de> wrote:
>>
>> The -G <regex> option of log looks for the differences whose patch text
>> contains added/removed lines that match regex.
>>
>> The concept of differences only makes sense for text files, therefore
>> we need to ignore binary files when searching with -G <regex> as well.
>
> What about partial text/partial binary files?

Good point. You'd use "-a" (or "--text") to tell the diff machinery
to treat the contents as text, and the new logic must pay attention
to that command line option.
