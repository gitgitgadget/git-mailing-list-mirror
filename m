Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B5320323
	for <e@80x24.org>; Thu, 16 Mar 2017 18:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbdCPS0R (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 14:26:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64150 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753159AbdCPS0P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 14:26:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D173A851C4;
        Thu, 16 Mar 2017 14:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XrTkjp4cgBt33DRwmsxx+GW/JRo=; b=BhuomF
        bYNXPW2Z+iRAuA+hpZz2F9CuVIepNG3BZ8s8Dqd6s4wCZ/3l2Jo+5p7q/hHs+Tin
        j+8WKSTLNVxzMjlPUKmhhF47ebXSNi2ZzI+n1dOr5QvFLdR4OKAyoaXty0K1nh2e
        PfWwzlr7OwZKeVXBchW1AD7dT92bvEw5g4tSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pS5kVlkBFQgxHxGTJkI7Hyeqt4OVIj8W
        9q+AB5JEKPijvfOq3NwafT6z3JEWfWNBaB28DaM265/rdhkzMhIcKhNJihGW+brS
        PYvw8XdIKF8Gg2hM7UDy2fjZwcigrnPSgGslsSqhDRea1NIqg1jEHFZZyfsNsEDw
        wD3wyrvFHmE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7E76851C3;
        Thu, 16 Mar 2017 14:26:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44158851C2;
        Thu, 16 Mar 2017 14:26:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4 2/4] dir: add directory_exists
References: <20170314003246.71586-4-lehmacdj@gmail.com>
        <20170316051827.97198-1-lehmacdj@gmail.com>
        <20170316051827.97198-3-lehmacdj@gmail.com>
        <xmqqlgs5cify.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 16 Mar 2017 11:26:07 -0700
In-Reply-To: <xmqqlgs5cify.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 16 Mar 2017 09:09:05 -0700")
Message-ID: <xmqqziglaxj4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 061A92E8-0A76-11E7-9B0F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Devin Lehmacher <lehmacdj@gmail.com> writes:
>
>> +int directory_exists(const char *path)
>> +{
>> +	struct stat sb;
>> +	int ret = lstat(path, &sb);
>> +	return ret == 0 && S_ISDIR(sb.st_mode);
>> +}
>
> I am not a great fan of using file_exists() [*1*] on anything other
> than paths in the working tree (i.e. in preparation for checking
> things out of or into the index), as ...
> ...
> [Footnote]
>
> *1* ... and friends, like safe_create_leading_directories().

I actually got things mixed up.  safe-create-leading-directories is
to be used only for paths inside .git/ (i.e. not for working tree
files, but for things like ".git/refs/heads/foo" when creating a
branch called foo/bar).

