Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DCE207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934101AbcI2VNE (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:13:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64828 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933484AbcI2VNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:13:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E290742B00;
        Thu, 29 Sep 2016 17:13:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XlqTtXG3ysGL0QukbrOdg9bQ1HQ=; b=Q0Xf4z
        4h0EeEvwXcSprMGnty65+yL6mdZak22zuVnnA8xSv59SNZw6eCvtP+0E4k0/B+GM
        DVf7DxFCQwRTGon2lTNIFRhFwFAYhkfOKtrw4wGym87kTSgxdMCA8wxde/gr0bZk
        eQOzIR6LKV3/VMKEqYL5DVfV0nCa2kDlhS0n4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QcvR/prE/+VvYPfvwnXsYs+xpJ/3MXL7
        dp62BdSE7PmBU9n8igxYRlx42HBOEzsXIu/64bHDLPqCKdPSiKiZBnRI5qzHsXgY
        j5W04kSZzLz1efmZJrIhligWPmITEtyvTslrVM0imW1qLU5HAzp+CI8ydrl7GCa4
        S0ZZLXtBgsY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBDC242AFF;
        Thu, 29 Sep 2016 17:13:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1124542AFB;
        Thu, 29 Sep 2016 17:12:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v8 00/11] Git filter protocol
References: <20160920190247.82189-1-larsxschneider@gmail.com>
        <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
        <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
        <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
        <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
        <DADB0C80-1EDF-4498-8DAC-A1B09E596518@gmail.com>
Date:   Thu, 29 Sep 2016 14:12:45 -0700
In-Reply-To: <DADB0C80-1EDF-4498-8DAC-A1B09E596518@gmail.com> (Lars
        Schneider's message of "Thu, 29 Sep 2016 22:50:46 +0200")
Message-ID: <xmqqk2due7g2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EF5E68E-8689-11E6-A7D0-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> A pragmatic approach:
>
> I could drop the "STOP" message that the filter writes to the log
> on exit and everything would work as is. We could argue that this 
> is OK because Git doesn't care anyways if the filter process has 
> stopped or not.

That would mean you can leave the process running while the test
framework tries to remove the trash directory when we are done,
creating the same bug J6t mentioned in the thread, no?

