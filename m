Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD08E20966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934210AbdC3S2z (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:28:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54408 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934028AbdC3S2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:28:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75A526D529;
        Thu, 30 Mar 2017 14:28:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gbyq584PgwwE52Z9hka/UMtUeHU=; b=P410lK
        VmlGXKPa3Nmkn7hHZzw5MKT6fQ+6jhXMi+i04YAo06BfPeJ6sq3u9G3+tyunXK25
        FCXHoju/y0a2YDnYNUPWzPhrmAoVdncsIn2mYv3f+fyBs0Q1KKmcyHhChjTWQJr/
        ZVhbqYOmO91MokyAvwVw8BOD22f32o38smVO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BPrLAKQbSFJWcsTqHG9kje9x3d/V05JR
        UY3dtdLxfyyNQqYfH5rXvJfRw551TVcf9AqVXT1lVpWOirz5cTdSLx0tUBhQVzD1
        Ln8PSF9Y73ir53Oi/T3xybuG0FwMbwTX7Awksf/UeygJUKlMqDSsDLbiQcz7KBH6
        U7uhmZ1mF9s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EA596D528;
        Thu, 30 Mar 2017 14:28:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D87266D526;
        Thu, 30 Mar 2017 14:28:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule.c: correctly handle nested submodules in is_submodule_modified
References: <20170328230938.9887-1-sbeller@google.com>
        <20170329222616.11077-1-sbeller@google.com>
        <20170329222616.11077-3-sbeller@google.com>
        <20170329231308.GZ31294@aiede.mtv.corp.google.com>
Date:   Thu, 30 Mar 2017 11:28:50 -0700
In-Reply-To: <20170329231308.GZ31294@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 29 Mar 2017 16:13:09 -0700")
Message-ID: <xmqqmvc24o0t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9678D28-1576-11E7-B453-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> This bug fix also affects the default output (non-short, non-porcelain)
>> of git-status, which is not tested here.
>
> Do you have an example?  (In just the commit message would be fine, in
> tests would be even better.)
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/git-status.txt |  2 ++
>>  submodule.c                  | 21 +++++++++++++++++++--
>>  t/t3600-rm.sh                |  2 +-
>>  t/t7506-status-submodule.sh  |  4 ++--
>>  4 files changed, 24 insertions(+), 5 deletions(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> but I would be a lot more comfortable after looking at the change to
> "git status" output.  (E.g. a test demonstrating it can happen in a
> followup change if that's simpler.)
>
> Thanks for your patient work on this.

Thank you both.  I re-read the whole thing and it feels to me that
the topic is now ready for 'next'.
