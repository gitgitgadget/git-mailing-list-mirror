Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18FF71F406
	for <e@80x24.org>; Mon, 14 May 2018 05:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeENFhZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 01:37:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41687 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeENFhY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 01:37:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id g21-v6so10804773wrb.8
        for <git@vger.kernel.org>; Sun, 13 May 2018 22:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=a0IhIOcUby7OpB61NKq13NRBZ0ovxNxd8hw6CuC72ZU=;
        b=U5a0gQ8Hr5Cf8ETN5l9KbTT+tCFURT1V3Y9rUQD0WE5xXYMbCtpjGOjQszsel8oSAw
         GSVkmbYo+vKIis9Kfmygq+G4OQ+vFZAXUaIS0YIyVtWKwqKz4qhNjS3fuWgQXfAD3RXg
         qX90cWjQES7LVuixMSHmWNESZPoNrdNMbx57xYzv/+oBWDvsQ57giis607MISTm3LEXN
         jiISIaaCK/9h6ad3pgTyzpJXpVHl0dHp4+rqkG4h9Tzey7OZeFT7cdWvDy0apXZGXuGP
         csZcmaHl22ug12JqqIkAwEBGXqAp0ulKSA1vHuB0/INz3n/TaUIK2UEpsfg9368uxKgL
         i+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=a0IhIOcUby7OpB61NKq13NRBZ0ovxNxd8hw6CuC72ZU=;
        b=HfHxMIZy6ZiJmtsHeVb7JUdMZ/ZqsqKFJcXbOgxeVqD1N3gOwUs5/X2Y1hKTb5ZsqE
         qjhZ8wx2Ru0kZi8DxkcP3gnmqKIy1FTcm/i9wu2E3djwV2TwmQ1OAWdESHsPCjYHAIQ+
         vk5jTnFdp3dGQxmTyXcc4Q3rClsdfFYASIOvlwFGANCGb4d/e/wmPI5Y6I9CaiRDBZbp
         PqSD1vUOB6Yve7GmbpJ9pUpfzqkGGbEtwRYK82h8ZW8Yb8t6J9mA8TnSL7uMpx88NCeQ
         gVIpDL+CpiIcIjxxqOZewddY6EvA8Q8xOmhmSCX/XCEc6PmpUpVDHiUvq0bfJEK5fUxZ
         b99w==
X-Gm-Message-State: ALKqPwcS65f187bGzLLBJhhjlM/bW8HBRbs0BmUR9WdX+cB53dAyz97I
        x3nHy8g4BrcjDvFV3JNZXWM=
X-Google-Smtp-Source: AB8JxZoj+HQKfCiJH1XQuxSNIXIclQz7MOBmAW5ayBztURfNPN1nbGMUa/mI6Da+mySARA/F3j7mXA==
X-Received: by 2002:adf:b083:: with SMTP id i3-v6mr5485789wra.52.1526276243466;
        Sun, 13 May 2018 22:37:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h12-v6sm7086197wmc.7.2018.05.13.22.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 22:37:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/14] revision.c: use commit-slab for show_source
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-9-pclouds@gmail.com>
        <xmqqfu2uddqg.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 14 May 2018 14:37:21 +0900
In-Reply-To: <xmqqfu2uddqg.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 14 May 2018 14:10:15 +0900")
Message-ID: <xmqqbmdidcha.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> -	refname = commit->util;
>> +	refname = *revision_sources_peek(&revision_sources, commit);
>
> At first glance, I thought that the reason why this uses _peek() is
> because the "sources" is expected to only sparsely be populated,
> perhaps because get_tags_and_duplicates() annotates only the tips
> mentioned on the command line via rev_cmdline mechanism and this
> code does not want to auto-vivify the slot, only to read NULL from
> it.
>
> But the code that follows this point liberally uses refname without
> checking if it is NULL, so I am not quite sure what is going on.

Ah, of course, this is about the code that propagates the "source"
(i.e. from which tip given on the command line did we start the
traversal to reach this commit?), so that is what ensures there is
something in commit->util and revision_sources not just has an entry
for the commit but the entry should have a non-NULL string.

So shouldn't *slab_peek() here be *slab_at() instead?

> In
> any case, wouldn't *slab_peek() an anti-pattern?  You use _peek()
> because you expect that a slot is not yet allocated for a commit,
> you desire not to vivify all the slots for all the commits, and
> instead you are prepared to see a NULL returned from the call.  But
> I do not think that is what is happening here, so shouldn't it be
> using _at() instead of _peek()?
>
>>  	if (anonymize) {
>>  		refname = anonymize_refname(refname);
>
>>  		anonymize_ident_line(&committer, &committer_end);
>> @@ -862,10 +864,11 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
>>  		 * This ref will not be updated through a commit, lets make
>>  		 * sure it gets properly updated eventually.
>>  		 */
>> -		if (commit->util || commit->object.flags & SHOWN)
>> +		if (*revision_sources_at(&revision_sources, commit) ||
>> +		    commit->object.flags & SHOWN)
>
> Here it uses *slab_at() which makes more sense.
