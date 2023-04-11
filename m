Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B21C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 16:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDKQ2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDKQ2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 12:28:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E349D0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 09:28:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n14so33487710plc.8
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681230509; x=1683822509;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TkR+ZIzP4trkrBw+iaF2nli7BuX/aJr6wEjqcDJaqI=;
        b=d68A6IoPngGHJVBaXIN6z7LmBZ5BHc+eRMo62y5Sqy/eoEKCMw3CxnombnIO9nOk0M
         /pjxO2qUs4oTICiCBsdJQB0ZYdy80w/Ujs1wkfFFCGPxKRLYInwbJ4vnDpdcuRC1iLDP
         rcDGpqOJn4OGJDVi272HZNzZyOm+U3f3OVLxfUxDWi5iRfHu92LFqg0rTOoefD66yH75
         XOabjgD48GTGxCbHOKjs/MCSMJl4aQpDIFtJQVZFsBU7NCfQ7c99Cgd5BeIHffpUvtuU
         aExHxvXrkBFNyih1wmkQC5idmqGzaFlBdALDA5WnQkTQFA7x2cCVA8fYEeRfwfEyjtAs
         2l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681230509; x=1683822509;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TkR+ZIzP4trkrBw+iaF2nli7BuX/aJr6wEjqcDJaqI=;
        b=oO8KK1AuqMcJ8d3eswT66wnAy44AtrjGRr2gsmMr/Rz6RjaOmEkgA2U6IF5J8pr4Ud
         cwLZEYQXiaUyunbVMdXGnioNphMpR/JXG+SMtmRbfdc5GmBlMblsSy1ir5D48XpOFxUF
         2sNBAiS9qFRsyUko2IjPoyNA+OEzau1yDTa32qTylkchNa7WQmMGRfKesiG9kXWSsnGO
         gfb/Fmz2uDRfY9VV6CXqNvwpe7EUHHZpjEx2tjUlxADHVj+JY4qxlsxeodAdEU0ouXRN
         YzurCtJ9YktPTiMcnnOtr0gbWW0JaNfFfjzMUgAgGh2/Tg+hNWD8LkbaF55bSsIrE2E9
         efaA==
X-Gm-Message-State: AAQBX9csdImfJyp5coqgDMLpnFuTLCLiQo4zdbEPzh8Cui0wtRmmzRo6
        dT5XK0W0tFHm9/gKGCYvTRE=
X-Google-Smtp-Source: AKy350YS/cD/+Ia8WSxQkWGITZCipdPJNFgqxhmDwwgm9ZSFSIO0Sspre5X+VRqnq65wC5ZqG1H7oA==
X-Received: by 2002:a05:6a20:4d91:b0:d5:58df:fb7a with SMTP id gj17-20020a056a204d9100b000d558dffb7amr17946205pzb.3.1681230509082;
        Tue, 11 Apr 2023 09:28:29 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79152000000b0062dbafd2980sm10035690pfi.65.2023.04.11.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:28:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Robin Jarry <robin@jarry.cc>, git@vger.kernel.org,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH] send-email: export patch counters in validate environment
References: <20230411114723.89029-1-robin@jarry.cc>
        <79a7c59f-6644-1dad-3b85-fe0ca8beb968@gmail.com>
Date:   Tue, 11 Apr 2023 09:28:27 -0700
In-Reply-To: <79a7c59f-6644-1dad-3b85-fe0ca8beb968@gmail.com> (Phillip Wood's
        message of "Tue, 11 Apr 2023 14:23:14 +0100")
Message-ID: <xmqqbkjubcyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Robin
>
> On 11/04/2023 12:47, Robin Jarry wrote:
>> When sending patch series (with a cover-letter or not)
>> sendemail-validate is called with every email/patch file independently
>> from the others. When one of the patches depends on a previous one, it
>> may not be possible to use this hook in a meaningful way. A hook that
>> wants to check some property of the whole series needs to know which
>> patch is the final one.
>> Expose the current and total number of patches to the hook via the
>> GIT_SENDEMAIL_PATCH_COUNTER and GIT_SENDEMAIL_PATCH_TOTAL environment
>> variables so that both incremental and global validation is possible.

The above mentions "cover letter" and naturally the readers would
wonder how it is treated.  When we have 5-patch series with a
separate cover letter, do we get TOTAL=6, COUNTER=1 for the cover,
COUNTER=2 for [PATCH 1/5], and so on, or do we see TOTAL=5,
COUNTER=0 for the cover, counter=1 for [PATCH 1/5], and so on?

The latter is certainly richer (with the former, the validator that
wants to act differently on the cover has to somehow figure out if
the invocation with COUNTER=1 is seeing the cover or the first
patch).  The usual and recommended workflow being "git format-patch
-o outdir --cover-letter <range>" followed by "edit outdir/*" to
proofread and edit the cover and the patches, followed by "git
send-email outdir/*.patch", git-send-email has to guess before
invoking the hook.

But it may be better than forcing the hook to guess, I dunno?

Whichever way we choose, we should

 * explain the choice in the proposed log message.  If we choose the
   "TOTAL is the number of patches and COUNTER=0 is used for the
   optional cover letter" interpretation, we should also explain
   that we cannot reliably do so and sometimes can guess wrong.  If
   we choose the "TOTAL is the number of input files and COUNTER
   just counts, regardless of the payload" interpretation, we should
   also explain that even though we hinted that a series with cover
   letter can be validated, it is a slight lie, because the hook has
   to guess if the series has cover and it can guess wrong.

 * document what TOTAL and COUNTER means.

>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index 62908602e7be..55f00e0f6f8c 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -600,6 +600,16 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
>>   non-zero status causes `git send-email` to abort before sending any
>>   e-mails.
>>   +The following environment variables are set when executing the
>> hook.
>> +
>> +`GIT_SENDEMAIL_PATCH_COUNTER`::
>> +	A 1-based counter incremented by one for every file.
>> +
>> +`GIT_SENDEMAIL_PATCH_TOTAL`::
>> +	The total number of files.
>> +
>> +These variables can be used to validate patch series.

This may be sufficient documentation to imply we are not treating
cover letter any differently, by not saying "patch" or "cover
letter" but just saying "file".  It may be more helpful to be a bit
more explicit, though (e.g. "files" -> "input files", perhaps).

>>   diff --git a/git-send-email.perl b/git-send-email.perl
>> index 07f2a0cbeaad..e962d5e15983 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -795,10 +795,17 @@ sub is_format_patch_arg {
>>   @files = handle_backup_files(@files);
>>     if ($validate) {
>> +	my $num = 1;
>> +	my $num_patches = @files;
>>   	foreach my $f (@files) {
>>   		unless (-p $f) {
>> +			$ENV{GIT_SENDEMAIL_PATCH_COUNTER} = "$num";
>> +			$ENV{GIT_SENDEMAIL_PATCH_TOTAL} = "$num_patches";
>
> We only need to set this once outside the loop

Indeed.

>>   			validate_patch($f, $target_xfer_encoding);
>> +			delete $ENV{GIT_SENDEMAIL_PATCH_COUNTER};
>> +			delete $ENV{GIT_SENDEMAIL_PATCH_TOTAL};
>
> Do we really need to clear these? Certainly not in each iteration of
> the loop I would think.

If we set TOTAL outside, we should clear it outside.  We have to set
COUNTER inside, and we could clear it outside, but it probably is
easier to see the correspondence of set/clear if it is done inside.

>>   		}
>> +		$num += 1;

When you have 3 files to send, and if the last one satisfies "-p",
the hook will be told "You are called for 1/3" and then "2/3", and
will never hear about "3/3", so in practice it will spool the first
two and finish without getting a chance to flush what has been
spooled.  When you have 3 files to send, and if the first one
satisfies "-p', the hook will be told "You are called for 2/3", but
it is understandable if anybody is tempted to write a hook this way:

	if COUNTER==1:
		initialize the spool area
		record TOTAL there
	else:
		read TOTAL recorded in the spool area
		make sure TOTAL matches

	process [PATCH COUNTER/TOTAL] individually
	if COUNTER==TOTAL:
		process the series as a whole

and for such an invocation of "git send-email", the hook will try to
process the second file without having its state fully initialzied
because it never saw the first.

Would these be problems?  I dunno.

Thanks for working on the patch, and thanks for a careful review.

