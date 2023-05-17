Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7442C7EE22
	for <git@archiver.kernel.org>; Wed, 17 May 2023 20:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjEQUVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 16:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEQUVO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 16:21:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8341FF5
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:21:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae52ce3205so8472755ad.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684354872; x=1686946872;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQU437f2MJNUFeHqjXR5rhF4LFhk4D43pUr9b/zyPxo=;
        b=oE9Rk0DCA8dWvXxu3A/WT1j7JnXtVni0XYDjDdddxZTQoY2ffvm5AAY3kIdiwAebQD
         htcoymHhPMm+XS/XtLhtvptQAYthKeO7a6o7oOyAQOJgts8UyOVaGsb8jvl9OJvTQq7v
         fP7jYz8aA5EV1Apc5cvws8NDxDHuS5fp/in1AKR4BgAgM87+p53NUm/Of2kD0S7Bzen/
         tmz9SU6fmZhJbRbXuhwXmRrEV1yDL9AnbUkXMPQ0q8ntgGivEkLAPgzYFO11VZ5HXsHD
         rxDCf+Mp28p7A5cOeAl39xv+UBxXVr5BzYsSntKgiQeZXJ2O3+35qHoJkhi+7liSysOH
         3vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354872; x=1686946872;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQU437f2MJNUFeHqjXR5rhF4LFhk4D43pUr9b/zyPxo=;
        b=RMBIIkO6cf8BJUZYHH7VlFbgL37Fh4bsW5jAhmmdB6U+peNwXKSAWpctgJKxLnJSYt
         lwZgb71Y+db9/BB+ElEpmdPB4FYc7nLOPQQ3gVcfvhkcjmZ6utD7VHVmyoGPtUin4IPZ
         66G11SS4oRMQErgBQ4j/LkT90DrqYfqp9/ZWqAlL0Akvljdcogs5Ozgrqg2GnnXuzvVO
         dThouVw9urehMVxUawhiHi/VejebWyNlWLxSTNAs4CuIVA3cFSioBHHrGR3ekjnnu40R
         a1gIQiqoeRZbrbpcy7QvphoCQQ2wvLHfLIQ2qUxArZyJAnd2cgYO59KBFniTRgFIPDzd
         NQBw==
X-Gm-Message-State: AC+VfDy0rPn/TFKJqHNUttpMhZc0aZ4/Iu9qMaQh201ov5x6UCUd2ZWR
        wxYe3hXXOVURXXfJIUboFYM=
X-Google-Smtp-Source: ACHHUZ4+20LO+NAL/7eB54dl7sEMPBeikY2KxTad9mAqWqii2piwFkXT22AkWeLUyv9SizoE7Whphg==
X-Received: by 2002:a17:902:ecc6:b0:1ac:6ef0:a96e with SMTP id a6-20020a170902ecc600b001ac6ef0a96emr71307plh.31.1684354872475;
        Wed, 17 May 2023 13:21:12 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001ac896ff65fsm17959977pll.129.2023.05.17.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:21:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>, michael.strawbridge@amd.com
Subject: Re: bug report: cover letter is inheriting last patch's message ID
 with send-email
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
        <xmqqo7mipyt0.fsf@gitster.g> <xmqqjzx6pxuu.fsf@gitster.g>
        <CAD=FV=UkZBQ6SFB7xu8OD3vxtODp6RUq=K3xXzofpJjUZO18+w@mail.gmail.com>
Date:   Wed, 17 May 2023 13:21:11 -0700
In-Reply-To: <CAD=FV=UkZBQ6SFB7xu8OD3vxtODp6RUq=K3xXzofpJjUZO18+w@mail.gmail.com>
        (Doug Anderson's message of "Wed, 17 May 2023 13:14:55 -0700")
Message-ID: <xmqqbkiipv48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Wed, May 17, 2023 at 12:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> >> # With the attached patches, where all of the patches have a
>> >> # Message-Id but the cover letter doesn't.
>> >> git send-email *.patch
>>
>> I suspect this is a recent regression with the addition of the
>> pre_process_file step.  56adddaa (send-email: refactor header
>> generation functions, 2023-04-19) makes all messages parsed
>> before the first message is sent out, by calling a sub
>> "pre_process_file" before invoking the validate hook.  The same sub
>> is called again for each message when it is sent out, as the
>> processing in that step is shared between the time the message gets
>> vetted and the time the message gets sent.
>>
>> Unfortunately, $message_id variable is assigned to in that sub.  So
>> it is very much understandable why this happens.
>>
>> I wonder if it is just doing something silly like this?
>>
>> --- >8 ---
>> Subject: [PATCH] send-email: clear the $message_id after validation
>>
>> Recently git-send-email started parsing the same message twice, once
>> to validate _all_ the message before sending even the first one, and
>> then after the validation hook is happy and each message gets sent,
>> to read the contents to find out where to send to etc.
>>
>> Unfortunately, the effect of reading the messages for validation
>> lingered even after the validation is done.  Namely $message_id gets
>> assigned if exists in the input files but the variable is global,
>> and it is not cleared before pre_process_file runs.  This causes
>> reading a message without a message-id followed by reading a message
>> with a message-id to misbehave---the sub reports as if the message
>> had the same id as the previously written one.
>>
>> Clear the variable before starting to read the headers in
>> pre_process_file
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * I am not surprised at all if there are similar problems in this
>>    function around variables other than $message_id; this patch is
>>    merely reacting to the bug report and not systematically hunting
>>    and fixing the bugs coming from the same root cause.  If the
>>    original author of the pre_process_file change is still around,
>>    the second sets of eyes from them is very much appreciated.
>>
>>  git-send-email.perl | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git c/git-send-email.perl w/git-send-email.perl
>> index 89d8237e89..889ef388c8 100755
>> --- c/git-send-email.perl
>> +++ w/git-send-email.perl
>> @@ -1771,6 +1771,7 @@ sub send_message {
>>  sub pre_process_file {
>>         my ($t, $quiet) = @_;
>>
>> +       undef $message_id;
>>         open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
>>
>>         my $author = undef;
>
> I can confirm this fixes the regression for me. Thus:
>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Thanks.

Now I need to write (or trick somebody into writing) a test for this
;-)
