Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26804C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 06:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiFBGLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 02:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiFBGK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 02:10:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760111DA0B6
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 23:10:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AED2418B25B;
        Thu,  2 Jun 2022 02:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ht3P2+dVcMl1
        Hx3WEAMhf5c9acR6M8Up+7WA1X85BX0=; b=iaYiAI0sqk+/vIgCLTaR2WF61BYB
        4KaXNcJ107Gj7Tx+C34I5tftf4BMHPccM+6JxGEzNXeT9ipNxn41FnFtNSbjYZRc
        LDwOFlQ8KGPheuStowtUhGU3asgcDRPv5KiHX9iC8xz6wjX6CHDWsYuMnmxFzu/O
        USbjgZeSxs18IZE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4D3418B25A;
        Thu,  2 Jun 2022 02:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D41818B255;
        Thu,  2 Jun 2022 02:10:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] gitweb: switch to a modern DOCTYPE
References: <20220601012647.1439480-1-jason@jasonyundt.email>
        <YpgHUm93840oBtib@camp.crustytoothpaste.net>
Date:   Wed, 01 Jun 2022 23:10:53 -0700
In-Reply-To: <YpgHUm93840oBtib@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 2 Jun 2022 00:41:54 +0000")
Message-ID: <xmqqa6avppci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C2A6343E-E23A-11EC-8E7B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> While that DOCTYPE is still valid [2], it has several disadvantages:
>>=20
>> 1. It=E2=80=99s misleading. The DTD that browsers are supposed to use =
with that
>>    DOCTYPE has nothing to do with XHTML 1.0 and isn=E2=80=99t availabl=
e at the URL
>>    that is given [2].
>
> While the WHATWG may claim that, an XML parser is absolutely within its
> rights to refer to and use that DTD, and in fact should do so unless it=
s
> catalog directs it elsewhere.  It may be that some browsers use an
> internal catalog that refers to a different DTD, however.
>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 606b50104c..1835487ab2 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -4219,7 +4219,10 @@ sub git_header_html {
>>  	my $mod_perl_version =3D $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : ''=
;
>>  	print <<EOF;
>>  <?xml version=3D"1.0" encoding=3D"utf-8"?>
>> -<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.=
w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
>> +<!DOCTYPE html [
>> +	<!ENTITY nbsp "&#xA0;">
>> +	<!ENTITY sdot "&#x22C5;">
>> +]>
>
> I think this should be fine.  It defines the entities we need and
> appears to be valid XML.  I don't think there should be any problem
> upgrading to XHTML 5 here.

OK, so in short, the patch text looks OK and the proposed log
message needs a bit more work?

Thanks.


