Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47317C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C28E206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 16:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VrIHpkd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFKQoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:44:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52990 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKQoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 12:44:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5025E5F3D5;
        Thu, 11 Jun 2020 12:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3fkIxO+AgE80yo2dTUfkihxMyfI=; b=VrIHpk
        d3PAO6kMYhXPqb49M99+2Wd/pc+17FagDoHJlmXEQO2Wu+btxtLPZlu0DbAfn4AF
        35pB1UOQNEPeFTcvrSDyEiWDn0/LDdVYvYrorb3ct8M+vgyw9twvCzQWJ4SVNRvp
        9RY52oXATF82NqlbWndzdRYpanM0w7VyHEoSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u2Be8GdiwVFsVdxurUyyE23Pd+K6hHC1
        +jZF9G3c6VGtL4UXXUJR16UAtAtEB1rZcLoLVnXq22l5VUwh6l5fxqI3S0PJbO2K
        rbymbliBBKc1oiZEzl46IXafnM57tWW8xTWkev0J82c0D3xg6z/ylfcv+iUCccsn
        RLzeR0A+SdY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46A145F3D3;
        Thu, 11 Jun 2020 12:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C10285F3D2;
        Thu, 11 Jun 2020 12:44:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
Date:   Thu, 11 Jun 2020 09:44:20 -0700
In-Reply-To: <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 11 Jun 2020 08:05:38 -0700")
Message-ID: <xmqqtuzha6xn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC71527A-AC02-11EA-9DFE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But because the old solution would not work in the new world order
> this topic created, a new solution needs to be found when you move
> the world to the new order.
>
> An easy solution would be to reserve "ref0" for the primary branch
> in the repository and anonymize other refs "ref1", "ref2", ...
>
> That can be done as a preparatory step regardless of the "'master'
> may not be in the name of the primary branch in this repository"
> topic.
> ...
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 85868162ee..a306a60d25 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -497,7 +497,7 @@ static void *anonymize_ref_component(const void *old, size_t *len)
>  {
>  	static int counter;
>  	struct strbuf out = STRBUF_INIT;
> -	strbuf_addf(&out, "ref%d", counter++);
> +	strbuf_addf(&out, "ref%d", ++counter);
>  	return strbuf_detach(&out, len);
>  }
>  
> @@ -522,7 +522,7 @@ static const char *anonymize_refname(const char *refname)
>  	 * anything interesting.
>  	 */
>  	if (!strcmp(refname, "refs/heads/master"))
> -		return refname;
> +		return "ref0";

This is obviously wrong.  It should return "refs/heads/ref0".

But another thing we could do, which is probably more backward
compatible, is to return "refs/heads/master" from here.  That way,
consumers of "fast-export" stream that expect 'master' to be the
primary branch would not get upset when the data source runs a newer
version of Git that allows the primary branch name to be customized.

Which means that, before such a change to allow the primary branch
name to be customized happens, there is no need for such a
preparatory patch, because the status quo is just fine.  So, I'm OK
with retracting the above.  "ref0" is not special, so there is no
need to have the first hunk above, either.

However, when the customization being discussed is implemented via
the "get_default_branch_name()" and "get_primary_branch_name()"
functions, we should update these lines like so:

-	if (!strcmp(refname, "refs/heads/master"))
-		return "refs/heads/master";
+	if (!strcmp(refname, get_primary_branch_name(DO_NOT_ABBREV)))
+		return get_default_branch_name(DO_NOT_ABBREV);

That is, the name of the "primary" branch used at the data source is
replaced by the more generic "this is the default" branch name used
in a random "git init" repository.

Imagine that there is a project that has an integration branch per
each device type, named after the confidential device name, owned by
a company.  An employee of the company works on one device type in
his own clone of the repository, and the primary branch in the
repository is set to that confidential device's name.

The employee can create an anonymized output, replacing the
confidential name with a generic "default" name that is not
confidential, like 'main' in the new world order or 'master' in the
backward compatible world order, with such an updated code.

After having thought about it a bit longer, I actually do prefer to
use the "ref0" approach, as it is possible for the employee in the
above example to have the "default" branch name tied to the primary
branch for the hardware type the emploee works on in the ~/.gitconfig
so the "alternative" I suggested in this message will reveal the
confidential name.

So, I guess we should just fix the patch I am responding to to
return "refs/heads/ref0" instead of "ref0", and queue it as one of
the preparatory steps.

