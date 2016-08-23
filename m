Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5946D1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbcHWQM5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:12:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52994 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752958AbcHWQM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:12:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 292A9354C1;
        Tue, 23 Aug 2016 12:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P9PTQ0uwcrx6r1a6cb9H6Ju2HqY=; b=smsXVN
        j/HMWxh6wbQL0CeW9VZ/g2mfVmVnYiw+XULEyYobTzkC6xKjk0exAfMxxu5XPbCN
        6nBwiygVQtfKhwXY4ogn0fwaND/6CO15ucgZVdzE0yDgJtnzwc6ihbuzkKtDOqVK
        pSFH9vRiTZDv0qGHawSdfN1HE5ufpA4dQb2lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DgEE26e6z3zXVWkADubw6Be9EBeroaYv
        IEKyApdPxr+G2+2mCc1ZD3Ef1jCKpsCfwQxS0cYKVp9wDFPHqIC3M0z2ybn7L4QR
        pS6bqd6+rNEcpNlusFC3wwowkDwcLcsE7YQn9LwZpJTkZUbxC1UFXc2JSZBmHJoS
        Frf6/spfCcg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2171E354BF;
        Tue, 23 Aug 2016 12:12:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A9F7354BD;
        Tue, 23 Aug 2016 12:12:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv8 8/8] clone: recursive and reference option triggers submodule alternates
References: <20160817224535.5551-1-sbeller@google.com>
        <xmqqziob6ibv.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbRNG-BCs2vZAq5CWBNc2EYyaL7Ft-eTt2=H6GmP+aNfQ@mail.gmail.com>
Date:   Tue, 23 Aug 2016 09:12:52 -0700
In-Reply-To: <CAGZ79kbRNG-BCs2vZAq5CWBNc2EYyaL7Ft-eTt2=H6GmP+aNfQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 18 Aug 2016 10:18:08 -0700")
Message-ID: <xmqqfupvxy4b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72D6427C-694C-11E6-832A-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Aug 17, 2016 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>  and now with error handling of invalid options.
>>
>> Thanks.
>
> Well this was not the end of the story. I sent that version out,
> before doing a final test run, because changing a few lines is trivial right? :(
>
> I'll resend with:

Heh, my integration test caught it before pushing it out ;-).

>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a1da3ea..a366757 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -562,7 +562,7 @@ static void prepare_possible_alternates(const char *sm_name,
>
>         if (!strcmp(sm_alternate, "superproject"))
>                 foreach_alt_odb(add_possible_reference_from_superproject, &sas);
> -       else if (!strcmp(sm_alternate, "no")
> +       else if (!strcmp(sm_alternate, "no"))
>                 ; /* do nothing */
>         else
>                 die(_("Value '%s' for submodule.alternateLocation is
> not recognized"), sm_alternate);
