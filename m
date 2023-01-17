Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0095C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 07:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbjAQHdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 02:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjAQHdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 02:33:24 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DB92DE53
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 23:31:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id r21so582657plg.13
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 23:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLvQLo5s+NTgDVdB4ZtDIn8VKHX3jHWEQBDgneaRsPI=;
        b=L9uiOu3pHDSLz3ir+2ibROsKFYIcFYBS/argY6nhZLUisf88LxBKbpqGYQkM0kwbW3
         0IAXc7ev1xSlbAAIlbwv+osXFOyfpXjf3GQS9nKs2fCjxroH6bg8QC2VuxfZKnwHD5nq
         f2l6uUI3jj7l51f/Txbmfb9dGh7lBEmHO0Ho1r4JRa9ALEnjs6HLRpRBupBc9NJq43di
         5z7H96c78Pst5EqbpJfSzf53rpVUbeV5J9JZDBHu4JkXlxs39XuuIHYQMF6pEH8XTNFw
         avvq4xdp6Mpy5PhueuwbhSrkeeQRLhZ/2L4lPjbZB+XrZMwD88W0Vcu15oM7SyLg/nnY
         UJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rLvQLo5s+NTgDVdB4ZtDIn8VKHX3jHWEQBDgneaRsPI=;
        b=hAW0lhHVHGNHHJHnB1KHY/SXv8Hg0mkkv73DZilQVToQvAadeqAX4JOFRebER5arku
         9712Fmnm2TautXBx5oSFiphT+EnumoJrpGhT9wdK71BLtPJOjIyHlwF3IDWkRZOCkR0b
         nKkFei175bSvG1h8HomyqOarmHJt1iyRF18+EGk3OpGRI0AJDfbOsQ3CORH9IgqOvrR7
         Y5muiT+FCBogp2iaZ2nlDl479pEEJ+5uNsiQoxRaaGV51EuMbvPN9/taWS1P1qAmB8ZY
         LDqd6fIQa3wG6MN+6qa0orjrCKvy99naT6iT0rBUDfJlzJs6b9ObEtsdQqEPPt15EDTr
         I89A==
X-Gm-Message-State: AFqh2koF7TBUqqmfLdHTcm9fvAE+/GKvRkF9gXLqnpJHen5fz8pzT2Cr
        n/gL/9soBTQxzjQnKl+oOtFeEG1l8Dg=
X-Google-Smtp-Source: AMrXdXu/Lai+4DMFSv6CefXJ4GuXVWxuZM6SckyebxlSBCtB3t9G732BmaIOV7/fsYBF8Fed3pr5gw==
X-Received: by 2002:a05:6a21:3946:b0:9d:efbe:e607 with SMTP id ac6-20020a056a21394600b0009defbee607mr2114824pzc.35.1673940695475;
        Mon, 16 Jan 2023 23:31:35 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p13-20020a65490d000000b0048f8efc53a6sm16762297pgs.80.2023.01.16.23.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 23:31:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
        <20230117013932.47570-3-michael.strawbridge@amd.com>
        <3a2d4559-fce2-80f3-bafd-5eb8ac1a7eff@amd.com>
Date:   Mon, 16 Jan 2023 23:31:34 -0800
In-Reply-To: <3a2d4559-fce2-80f3-bafd-5eb8ac1a7eff@amd.com> (Luben Tuikov's
        message of "Tue, 17 Jan 2023 00:06:35 -0500")
Message-ID: <xmqqbkmxbort.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luben Tuikov <luben.tuikov@amd.com> writes:

>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>> +	if test -s "$2"
>> +	then
>> +		cat "$2" >actual
>> +		exit 1
>> +	fi
>> +	EOF

If "$2" is not given, or an empty "$2" is given, is that an error?
I am wondering if the lack of "else" clause (and the hook exits with
success when "$2" is an empty file) here is intentional.

>> +	cat actual | replace_variable_fields \
>> +	>actual-headers &&

Do not cat a single file into a pipe.  You can instead redirect out
of the file to whatever is reading from the pipe.  I.e.

	replace_variable_fields <actual >actual-headers &&

>> +	test_cmp expected-headers actual-headers
>> +'

OK.  We make sure the presence and the order of the fields in the
output just like all the other tests in this file do (which I think
may be a bit too much---there is no strong reason to insist that
"Subject:" comes before or after "Date:" or is spelled "Subject:"
and not "subject:" or "SUBJECT:"---but that is a problem shared with
many other existing tests in this file and this patch is not making
it much worse).

>>  for enc in 7bit 8bit quoted-printable base64
>>  do
>>  	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '
>
> As Junio and I discussed in the v5 2/2 patch review, here we may want to
> do something like this: Add a custom header to the SMTP envelope and then make
> sure that that is present when the hook checks $2.

Adding a custom header test is also fine, but I am OK with what we
see above, to verify the headers just the same way as existing
tests.
