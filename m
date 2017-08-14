Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CA520899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbdHNRyB (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:54:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750989AbdHNRyA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:54:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7C5D8D170;
        Mon, 14 Aug 2017 13:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EYyOq7BV4wFJn0fhaZms/mi4sRo=; b=rixy0b
        kEXd1xMnx1pKTCQ5zuiS4SQvN9l8//pXkpFFWGbX+FKpTwl3YbugdLhG4+jnQOtK
        dgQrEvNtxtlJjjDYOBXrsY2NTzHIxe52ngoBFcWIiqce3+R55jx2CDcByayAXT9y
        vm6/AwZZFEwHkeNzNEclkOFzlO1fHmdeBbsx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O282/4C0nMCd2Whke9rzmOV6cZ1ONxUg
        fJPMLFxcoh0TY6v7Qg2GpqkDQLyBT359JN9/EkGpkw6ugckNJ7hDJHAz1cVoM6ZY
        lonqpRYgkhbxcpcwR6OxO2V7QTGiEuoqU2ujYG6yW8VpVH9epUo90YjrRY8SShEt
        YbU60MBnLYs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE5708D16F;
        Mon, 14 Aug 2017 13:53:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D76D8D16D;
        Mon, 14 Aug 2017 13:53:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify "config --bool" behaviour with empty values
References: <20170813094816.7754-1-asheiduk@gmail.com>
Date:   Mon, 14 Aug 2017 10:53:50 -0700
In-Reply-To: <20170813094816.7754-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Sun, 13 Aug 2017 11:48:16 +0200")
Message-ID: <xmqq60dqvxw1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8870980E-8119-11E7-B00B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> `git config --bool xxx.yyy` returns `true` for `[xxx]yyy` but
> `false` for `[xxx]yyy=` or `[xxx]yyy=""`.  This is tested in
> t1300-repo-config.sh since 09bc098c2.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/config.txt | 3 ++-
>  Documentation/git.txt    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d5c9c4cab..d3261006b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -221,7 +221,8 @@ boolean::
>  		is taken as true.
>  
>         false;; Boolean false can be spelled as `no`, `off`,
> -		`false`, or `0`.
> +		`false`, `0`, no value (but still with `=`) or the
> +		empty string.

Thanks for noticing that it was a problem not spelling out that an
empty string means false.  We do need to spell it out.

However, I think this "no value (but still with '=')" is making it
more confusing than necessary for two reasons.

(1) The notation

	[section] var =

    is a perfectly valid way to spell an empty string, and is *not*
    a way to say "section.var has no value".

(2) In fact there is no way to say "section.var has no value", which
    is an often lamented inconvenience, because sometimes people may
    have their own setting in ~/.gitconfig and want to override it
    in the repository specific .git/config but do the overriding not
    with a specific value but by saying "pretend as if there were no
    setting in lower precedence configuration files like
    ~/.gitconfig".  If we ever fix this and introduce some syntax to
    mean "the variable has no value", it will become necessary to
    update the above description, but I am sure nobody will remember
    it.

I notice that in this Values section (where the boolean:: is the
first entry) there is no mention on how to spell a string value.

Perhaps something like this?

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab6..7580088bec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -210,6 +210,14 @@ Values of many variables are treated as a simple string, but there
 are variables that take values of specific types and there are rules
 as to how to spell them.
 
+string::
+
+	A variable can take a string value, which can be quoted with
+	double quotes and backslashes as outlined in the Syntax
+	section above.  Note that it is sufficient to say 'name ='
+	without anything after the equal sign to spell an empty
+	string.
+
 boolean::
 
        When a variable is said to take a boolean value, many
@@ -221,7 +229,7 @@ boolean::
 		is taken as true.
 
        false;; Boolean false can be spelled as `no`, `off`,
-		`false`, or `0`.
+		`false`, or `0`.  An empty string can also be used.
 +
 When converting value to the canonical form using `--bool` type
 specifier; 'git config' will ensure that the output is "true" or
