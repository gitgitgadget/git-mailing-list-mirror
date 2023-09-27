Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58FE80A8A
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 13:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjI0NLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjI0NLL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 09:11:11 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA24F5
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 06:11:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-351435e9fd4so18094685ab.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695820268; x=1696425068; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=egF3nwdoHp0HrIBMrlNihKLcNBzmizYeTiW15mkj3TQ=;
        b=QkVdm7TVUQQmw6bdhXHholUOFLrfEuPq4SFOW+1GNDwnk4pNgnJuKLLSEjBnqpuzqr
         gjLnHJr8C3Upai6i+GzimhMsiUPwEl2F9id2eKJeXuBRyDiMq1QM2hKIFCXzOS1/LiL9
         yKNVjJqoW9sDPdFwyY5dESKY3r4AZ/5OjoysZyhSx/A2SYZT65VFiUJbtAIdGAhNwkR9
         ECwQKdtCC5k170ki9lYZRjKSQ0s4qdLnKVLIgkfgo4JjVKqiNiuvKMOlW5rCNxrbwOxT
         L+GIZRnwf4ufldC0fqAtdxcSUcMEnOgzAoyJRFxBI/3KevO+5Mi+IWvDLIuZAszTlWMO
         EDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820268; x=1696425068;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egF3nwdoHp0HrIBMrlNihKLcNBzmizYeTiW15mkj3TQ=;
        b=uL9bfgjQWWkUYZEnnykXYMtXaoMiMFTeaat6E88BLjG2U09dnvL9HW1iNlcVPq4sT+
         iTR4DdE9Ilr7AJrt9gNxoMiWaDB2nQgbT19bJ9IUQ74cNTMqN0Q9ljbO98hnA408zCyH
         39n5Y260F0hhH3+W83Z/GcNA71bhlz+AnscqA4GV9JH8LrWV/7OZh9bnvBbGTD6jEBPt
         xQUoqLjEaMnSdd5R1DBrcLPibhyoisp5e7xfJItOipvd2DZndZAbuQG33iDUu1ev/Zxw
         KUXYgAWDkyEN3YR+UWm0R+K4EQKKcVJBMwufaZpbR7ySqusr4mL5+CS1/rPP+E2F7hp0
         ZUkQ==
X-Gm-Message-State: AOJu0YwHC05l6hacbAwb9WzjNAGMq7lwnXqu0adiFxuVRfguCNddGuWX
        qLjebRB0pMyYVtPYp8QqKV+MP9WwbG8=
X-Google-Smtp-Source: AGHT+IEFRChoMe0ns3oJV+eS35IKONnJFHXsTfQfurKoa0zQeTy9uMSbQpXfMmXaQfR6AZ6FrcJQxw==
X-Received: by 2002:a92:c5ae:0:b0:34f:68fe:630 with SMTP id r14-20020a92c5ae000000b0034f68fe0630mr1918155ilt.25.1695820268276;
        Wed, 27 Sep 2023 06:11:08 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id c18-20020a056e020cd200b003515cdb8f23sm607860ilj.32.2023.09.27.06.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:11:07 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup: Only allow extenions.objectFormat to be
 specified once
References: <87h6ngapqb.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mkmx9b.fsf@gitster.g>
Date:   Wed, 27 Sep 2023 08:11:05 -0500
In-Reply-To: <xmqqr0mkmx9b.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        26 Sep 2023 14:37:36 -0700")
Message-ID: <87r0mjn4ly.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>
>> Today there is no sanity checking of what happens when
>> extensions.objectFormat is specified multiple times.  Catch confused git
>> configurations by only allowing this option to be specified once.
>
> Hmph.  I am not sure if this is worth doing, and especially only for
> "objectformat".  Do we intend to apply different rules other than
> "you can give it only once" to other extensions, and if so where
> will these rules be catalogued?  I do not see particular harm to let
> them follow the usual "last one wins".
>
> If the patch were about trying to make sure that extensions, which
> are inherentaly per-repository, appear only in $GIT_DIR/config and
> complain if the code gets confused and tried to read them from the
> system or global configuration files, I would understand, and
> strongly support such an effort, ithough.

Unless I misread something, the code only checks for [extensions]
in $GIT_DIR/config.

> The real sanity we want to enforce is that what is reported by
> running "git config extensions.objectformat" must match the object
> format that is used in refs and object database.

Agreed.  Allowing git config extensions.objectformat to change the
existing value is allowing the repository to be corrupted.

> Manually futzing
> the configuration file and adding an entry with a contradictory
> value certainly is one way to break that sanity, and this patch may
> catch such a breakage, but once we start worrying about manually
> futzing the configuration file, the check added here would easily
> miss if the futzing is done by replacing instead of adding, so I am
> not sure if this extra code is worth its bits.
>
> But perhaps I am missing something and not seeing why it is worth
> insisting on "last one is the first one" for this particular one.

I somewhat have blinders on.  There are 3 configuration options I am
concerned with:

extensions.objectFormat
extensions.compatObjectFormat
core.historicObjectFormat (or whatever name we settle on).

One key concern I heard expressed in earlier reviews is that however we
handle these options we handle them in such a way as to give ourselves
room to rise to challenges in the future.

Whatever we do with parsing we have the following logical
constraints:

For extensions.objectFormat: There can only be a single storage hash.

For extensions.compatObjectFormat: There can be no compatibility hash,
there can be a single compatibility hash, and depending how things go
between now and the next hash function transition we might want multiple
compatibility hashes.

For core.historicObjectFormat: There can be no historic hash function, there
can be a single historic hash function, there can be multiple historic
hash functions.


For the compatibility hash I think it is unlikely we will want to
support more than one compatibility hash in practice but I can imagine
a scenario where we just get into the transition from SHA-1 to SHA-256
and a serious break is discovered that requires switching to FutureHash
ASAP.

For historic object formats like SHA-1 will become post transition there
are references embedded in commit comments, email messages, bug
trackers.  All kinds of places that we can not update so there is
fundamentally a need to be able to find which current objects correspond
to the historic names.  For a project each hash function transition will
create more such objects.


When I looked I saw two ways within current git to specify a list of
values for a single configuration option.
- Give that option multiple times.
- Parse the option value in such a way as to generate a list.

It is my sense just specifying the compatObjectFormat multiple times to
specify multiple compatibility object formats makes the most sense.
Especially as all is needed today is to only allow a single value.

After I had implemented the only allow once logic for compatObjectFormat
I saw that objectFormat had nothing similar, and knowing it is a bug
for multiple objectFormat wrote a patch to enforce only appear once
for objectFormat as well.

For objectFormat I don't care very much.  For compatObjectFormat I truly
care, and for even more for the option that allows finding the current
object from a historic oid (even a truncated one) I care very much.

For me the fundamental question is if we allow multiples compatibility
hashes or historical hashes how do we specify them?  Have the option
appear more than once?  A comma separated list?

Whatever we decided I want to enforce that doesn't appear in current
configurations so we can support for multiples later.

Eric

>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  setup.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/setup.c b/setup.c
>> index 18927a847b86..ef9f79b8885e 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -580,6 +580,7 @@ static enum extension_result handle_extension(const char *var,
>>  	if (!strcmp(ext, "noop-v1")) {
>>  		return EXTENSION_OK;
>>  	} else if (!strcmp(ext, "objectformat")) {
>> +		struct string_list_item *item;
>>  		int format;
>>  
>>  		if (!value)
>> @@ -588,6 +589,13 @@ static enum extension_result handle_extension(const char *var,
>>  		if (format == GIT_HASH_UNKNOWN)
>>  			return error(_("invalid value for '%s': '%s'"),
>>  				     "extensions.objectformat", value);
>> +		/* Only support objectFormat being specified once. */
>> +		for_each_string_list_item(item, &data->v1_only_extensions) {
>> +			if (!strcmp(item->string, "objectformat"))
>> +				return error(_("'%s' already specified as '%s'"),
>> +					"extensions.objectformat",
>> +					hash_algos[data->hash_algo].name);
>> +		}
>>  		data->hash_algo = format;
>>  		return EXTENSION_OK;
>>  	}
