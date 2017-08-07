Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14EBD2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 22:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbdHGWIl (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 18:08:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62606 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751662AbdHGWIk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 18:08:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC06CA12E8;
        Mon,  7 Aug 2017 18:08:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2vR39eTydvoSbNjVa+4USWev1yk=; b=dayXgg
        KgQGZCbPkGng8NWNVghgezCqC9RUF/911pj0K/URRyKsFqiEUiP6YfLsADX6ucBJ
        qjPINFYDARXNcMgsDn+X9geg+zDYi6FhloAlibp56eU7Jyzbytvpe98GTtczb2RL
        iJvpriFc1pSjrnJtyyjtqeyunRiGyNHUdJenA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jzSo/ri7POHXW8vmw1JD+kVCbcbUoCJi
        oL7nENXYq+YwLoH/5gQT1cpOgiv0zims9acVSzWe7jKWjto6duyJHtt95QiBWqwn
        bInMvEiyS9/wbwcNDVxkwl9fGk9j1VlhUR26B4F4yK7G+9q0JiKBpYEYZFhwCFqH
        JlTfm/t7+s8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C45FCA12E7;
        Mon,  7 Aug 2017 18:08:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 337C9A12E4;
        Mon,  7 Aug 2017 18:08:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Urs Thuermann <urs@isnogud.escape.de>
Subject: Re: [PATCH] git svn fetch: Create correct commit timestamp when using --localtime
References: <ygf8tiyx480.fsf@tehran.isnogud.escape.de>
Date:   Mon, 07 Aug 2017 15:08:30 -0700
In-Reply-To: <ygf8tiyx480.fsf@tehran.isnogud.escape.de> (Urs Thuermann's
        message of "05 Aug 2017 02:12:15 +0200")
Message-ID: <xmqqlgmvni8x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3313F84-7BBC-11E7-9B51-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Urs Thuermann <urs@isnogud.escape.de> writes:

> In parse_svn_date() prepend the correct UTC offset to the timestamp
> returned.  This is the offset in effect at the commit time instead of
> the offset in effect at calling time.
>
> Signed-off-by: Urs Thuermann <urs@isnogud.escape.de>
> ---
>  perl/Git/SVN.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks; sounds sensible.  

Eric?

>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 98518f4..bc4eed3 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1416,7 +1416,7 @@ sub parse_svn_date {
>  			delete $ENV{TZ};
>  		}
>  
> -		my $our_TZ = get_tz_offset();
> +		my $our_TZ = get_tz_offset($epoch_in_UTC);
>  
>  		# This converts $epoch_in_UTC into our local timezone.
>  		my ($sec, $min, $hour, $mday, $mon, $year,
