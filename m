Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C4FC25B08
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 22:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbiHDWWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbiHDWWS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 18:22:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE89D71BDF
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 15:21:02 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10ec41637b3so1109489fac.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MVLzxqfk7YnFDRAOqdt/1ZY1eZVoz/AcfA3PE6HMF0E=;
        b=U4Qh6vlpd1/lUyVCQoEtYfxD0Fbf2ypglsKEe/cK/h4VTH9uzNwXOVFtoXKJn4k/xD
         5d9ubRc73Qq234vxKwPZuUKM9ZTlu8thpoovN1eqLpKSUKNHjHDp9IezY+5qbZTcP8hM
         6i0wJTvK3rpjrJ1Hbk+ecP97wi845LDTguCkrDvUZrZuD8WK3kCuTXHUCAYR75SGGXPf
         A85LHcNx74b6flbSHPXhaTtSgrCqZUtYY0YSUXclewyrMSNbx+YvwY3rfzmQ7Svg3HOR
         dEmVMnYSz0zHLxfQV0yhZJ2A7/CtbuRITUYkdAbh/lU2ZylCFMV7vLTznJwt+YNik9t0
         3cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MVLzxqfk7YnFDRAOqdt/1ZY1eZVoz/AcfA3PE6HMF0E=;
        b=EKNrb3UWx8cEznMdvQmTgyrrj3x+8U4cZ+gcEzi/oQlUGdlzu7cjDv4jD+RmHRzAgc
         AX1xgfkYqHPjrtbNzI0Ok58Qjz5my8hH+rmj5AX6hj+gsBGS3cDbsbXwDLxb+bU+Ph4r
         Hufr++d8jVWDIwTCekRzKGq0LEqDBQLI/xu9SQTBo6UB7xKkMSUHxCmDGIhAmoDj9fP4
         7brn6BcMcIcZ2GIId9MUXmIbyZWMPoEl5I/HLjWiMhTELEVBYg/AzhadEqgwHM/thCNL
         NSn3ipFkBc1b/j4lOU0oOPxBxc50I5Bjep1MTz8GSgm/UFH5swHRFVPkZ7tebdFHkaCS
         OGEQ==
X-Gm-Message-State: ACgBeo3Ur3beJTxOE8glda63z2shcxIrIU6cQrrS6L/EiXhK7CdIy1qp
        5PCo6XLItCDlGBuiBM19K4p+sxtrAAs9AiXB5q+vbQ==
X-Google-Smtp-Source: AA6agR5I819DOcti6UUs7D2piJRtPoYlXdPJhlLONTMfSOfUV1sORJrfsWKCBrMCrk2B8w/IARy43DnRo1Txqs/F2K8=
X-Received: by 2002:a05:6870:2191:b0:10e:75b6:fc3a with SMTP id
 l17-20020a056870219100b0010e75b6fc3amr1844609oae.236.1659651661991; Thu, 04
 Aug 2022 15:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-6-calvinwan@google.com> <b33ec478-8858-faa7-2678-f02559426539@gmail.com>
In-Reply-To: <b33ec478-8858-faa7-2678-f02559426539@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 4 Aug 2022 15:20:50 -0700
Message-ID: <CAFySSZDvgwbbHCHfyuaqX3tKsr-GjJ9iihygg6rNNe46Ys7_EA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] transport: add client support for object-info
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > The client currently supports requesting a list of object ids with
> > features 'size' and 'type' from a v2 server. If a server does not
> > advertise either of the requested features, then the client falls back
> > to making the request through 'fetch'.
>
> I'm confused by the 'type' support, I might have missed something as I'm
> not familiar with this code but I couldn't see where we parse the type
> returned by the server.

I should clarify that the server does not support 'type', only the client.
Since the client falls back to 'fetch' to grab the object info if the server
doesn't support a requested option (e.g. type), I have 'type' included
as part of the supported client options.

> > +     for (i = 0; i < args.object_info_options->nr; i++) {
> > +             if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
> > +                     check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
>
> This is one of a number of lines in this series that are way over the 80
> column limit.

ack

> > +             if (unsorted_string_list_has_string(args.object_info_options, reader.line)) {
> > +                     if (!strcmp(reader.line, "size"))
> > +                             size_index = i;
>
> Should we be checking for "type" as well? Also does protocol-v2.txt need
> updating as it only mentions "size" as an attribute.

I gave context above -- the server does not accept 'type' so protocol-v2.txt
does not need to be updated.

> To avoid a possible out-of-bounds access we need to check that
> size_index + 1 < object_info_value.nr in case the server response is
> malformed

ack

> > +                     if (!strcmp(object_info_values.items[1 + size_index].string, ""))
> > +                             die("object-info: not our ref %s",
>
> I'm a bit confused by this message is it trying to say "object %s is
> missing on the server"?

Correct. You'll find the same error message in upload-pack.c

> > +                                     object_info_values.items[0].string);
> > +                     *(*object_info_data)[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
>
> As Junio pointed out in his comments in v4 there is no error checking
> here - we should check the server has actually returned a number. Note
> that strtoul() will happily parse negative numbers so we probably want
> to do something like
>
> const char *endp
> errno = 0
> if (!isdigit(*object_info_values.items[1 + size_index].string))
>    die("...")
> *(*object_info_data)[i].sizep = strtoul(object_info_values.items[1 +
> size_index].string, &endp, 10);
> if (errno || *endp)
>    die("...")



> Should be we checking the object id matches what we asked for? (I'm not
> sure if protocol-v2.txt mentions the order in which the objects are
> returned)

Hmmmm I think I either check for an object id match or update
protocol-v2.txt to mention order is consistent.

> Should we be parsing the object type here as well?

When the server starts supporting it.

> > +             for (i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
> > +                     struct ref *temp_ref = xcalloc(1, sizeof (struct ref));
>
> Using CALLOC_ARRAY() or p = xcalloc(1, sizeof(*p)) would be safer here
> (and everywhere else where you have used xcalloc()) as it ensures we
> allocate the correct size.

ack

> > +     /*
> > +      * Transport will attempt to pull only object-info. Fallbacks
> > +      * to pulling entire object if object-info is not supported
> > +      */
>
> Is it definitely true that we fallback to pulling the entire object? -
> there is at least one place above where we do

Yes, fetch_refs_via_pack() is where fetch_object_info() is called,
making it easy to fallback if fetch_object_info() fails.

>> +     while (packet_reader_read(&reader) == PACKET_READ_NORMAL && i < args.oids->nr) {
>> +             struct string_list object_info_values = STRING_LIST_INIT_DUP;
>
> I forget to say earlier that this is leaked

ack

Thank you for the review!
