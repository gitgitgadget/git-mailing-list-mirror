Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11175C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 22:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40AF206C0
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 22:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LpTAf5XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgCPWii (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:38:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58730 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732739AbgCPWii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 18:38:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 257D7C11A1;
        Mon, 16 Mar 2020 18:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+EbTF6b+qhnhOL920k8tcLgAWYw=; b=LpTAf5
        XDUFnNHd3YA2nis0Ij0TzcikpK5WMRSs8sEKuZsEMB+X5Yx5CJ7F44Hv5w2fhz+q
        dPesWkHL0dAYzWpDkcBq065m00fIFUJ0yPPFyzIkbKBHqDFVrx/VwBAz4CpuKt6F
        JXiyxuC2eggik2l3PJebdz82TUod87dcSFivU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ELcq0mLNQ5XXKd381BFiN7VlT6mOaL8G
        yY+8ljV79O4f6LU23pDGs3xBmRiYA4YspdW6YFBOy7gdNKj/AnKeqbYYiqGTWlLi
        PaWGc+hgCmQdOCq2DC8JVuOBm7VnDclg0k7cOGd6xeFlQo+WuM3Moz3gi4Tth5bn
        AooU/h5FN60=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 122C8C119F;
        Mon, 16 Mar 2020 18:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4B5CDC119C;
        Mon, 16 Mar 2020 18:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] log: give --[no-]use-mailmap a more sensible synonym --[no-]mailmap
References: <20200316212857.259093-1-gitster@pobox.com>
        <20200316212857.259093-4-gitster@pobox.com>
        <CAPig+cRj5c-AEOySWkfM=PX-CUFO-R-cN8pgyTm0kD32xyhihA@mail.gmail.com>
Date:   Mon, 16 Mar 2020 15:38:31 -0700
In-Reply-To: <CAPig+cRj5c-AEOySWkfM=PX-CUFO-R-cN8pgyTm0kD32xyhihA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 16 Mar 2020 17:39:50 -0400")
Message-ID: <xmqqk13khqmw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDFD131E-67D6-11EA-88A5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 16, 2020 at 5:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>> The option name "--use-mailmap" looks OK, but it becomes awkward
>> when you have to negate it, i.e. "--no-use-mailmap".  I, perhaps
>> with many other users, always try "--no-mailmap" and become unhappy
>> to see it fail.
>>
>> Add an alias "--[no-]mailmap" to remedy this.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> @@ -49,6 +49,7 @@ OPTIONS
>> +--[no-]mailmap::
>>  --[no-]use-mailmap::
>>         Use mailmap file to map author and committer names and email
>>         addresses to canonical real names and email addresses. See
>
> Here, the documentation seems to promote --mailmap over --use-mailmap.
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> @@ -173,6 +173,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>>                 OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
>> +               OPT_ALIAS(0, "mailmap", "use-mailmap"),
>
> So, along the lines of patch 2/3, I wonder if this should instead make
> --mailmap the "real" option and --use-mailmap the alias; namely, use
> OPT_ALIAS for --use-mailmap and place it after --mailmap. (Genuine but
> very minor question; should not hold up acceptance of patch.)

Actually, I do not think "--use-mailmap" is too bad.  It is just
"--no-use-mailmap" felt horrible.  If the enable-disable interface
for this feature were "--(no|use)-mailmap", I would not have written
this series.

There are two subcommands other than "log" that has "use-something"
that needs "--no-use-something" to countermand:

    "git fast-export" has "--use-done-feature"
    "git pack-objects" has "--use-bitmap-index"

So an alternative approach which might be better is to teach
parse-options interface to handle "--no-something" by doing the
following:

 - first find "--something" in the option[] array, and if there is,
   use it just like we do today;

 - if there is no option "--something" in the option[] array,
   instead of erroring out, see if "--use-something" is there, and
   pretend as if the user said "--no-use-something".

I guess that is very similar to the way we avoid "--no-no-frotz" for
option[] entries whose long name already begins with "--no-".


[Footnote]

Optionally, when the command line option says "--something", and
there is no such entry in the option[] array, we could check it with
the "use-" prefix, and pretend that "--use-something" was what the
user asked if there is such an entry.  But if we were to go that
route, it is not all that different to have an alias, as there are
only three subcommands (counting "log") that has the "use-something"
(and one of them, i.e. "pack-objects", is not even an end-user
facing command).
