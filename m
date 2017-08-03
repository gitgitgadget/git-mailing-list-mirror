Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4968F1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbdHCURN (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:17:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50805 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751600AbdHCURK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:17:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E92E28AD66;
        Thu,  3 Aug 2017 16:17:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xrPDun/cJIB5PNc8Pf3euvz/gvw=; b=ZPOW+J
        3shtS/c2tH615vfYjvUyJFLP1dj5qZG7LERnDzhribSpGkqcw1RRmhVkzg0nWH0J
        JlJYQkKiQHKR7thRrEhRwDLmRHFC57UYp74TMcGxpAtwoB1F9vVxtIs1D7WcFCiU
        XHu5B8pzUIYIu3Szt6mhsadm2wGdKcuFzNh4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YaEhsX35QghaqEdw9QZc8OR5mKiRLs0V
        kmc93BsNHECjHNsrk+j6IrBGGV4LiLnkLwZUpDBt+kNvtXYyquERtOVYbxNUbGOc
        Pu3FwxrKd6V3r15kYoQxyVCJ9uhLmHnIsyvp8Bbxjimm+PQ3qqXbp0v+TWYHXBa9
        WYmQvne3CDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E03EA8AD65;
        Thu,  3 Aug 2017 16:17:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49BB48AD61;
        Thu,  3 Aug 2017 16:17:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de
Subject: Re: [PATCH v2 02/15] submodule: don't use submodule_from_name
References: <20170725213928.125998-1-bmwill@google.com>
        <20170803182000.179328-1-bmwill@google.com>
        <20170803182000.179328-3-bmwill@google.com>
Date:   Thu, 03 Aug 2017 13:17:00 -0700
In-Reply-To: <20170803182000.179328-3-bmwill@google.com> (Brandon Williams's
        message of "Thu, 3 Aug 2017 11:19:47 -0700")
Message-ID: <xmqqtw1owgn7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B60B4B22-7888-11E7-8759-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> The function 'submodule_from_name()' is being used incorrectly here as a
> submodule path is being used instead of a submodule name.  Since the
> correct function to use with a path to a submodule is already being used
> ('submodule_from_path()') let's remove the call to
> 'submodule_from_name()'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  submodule.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 5139b9256..19bd13bb2 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1177,8 +1177,6 @@ static int get_next_submodule(struct child_process *cp,
>  			continue;
>  
>  		submodule = submodule_from_path(&null_oid, ce->name);
> -		if (!submodule)
> -			submodule = submodule_from_name(&null_oid, ce->name);
>  
>  		default_argv = "yes";
>  		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {

It appears to me that the scope of the variable "submodule" in this
function can be narrowed to be limited to the block inside this "if"
statement we see in the post-context of this hunk.  That would make
it even easier to see why leaving submodule to NULL is a safe thing
to do.

This comment applies to the state of this function before or after
this patch.  It can be left outside the scope of this immediate
series, and instead be done as a follow-up (or preparatory) cleanup.

Thanks.
