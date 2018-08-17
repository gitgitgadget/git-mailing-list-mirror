Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6761F954
	for <e@80x24.org>; Fri, 17 Aug 2018 16:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeHQTn5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 15:43:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35957 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeHQTnw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 15:43:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id m27-v6so1373230wrf.3
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kJWf5SlpnV16G8Af33dadBLW8eLejBqjl9BrgDB1dsc=;
        b=ojaeDjC5KpctuBt1UQseprJThcL0OCo1pBycReaw7VTWCQAII3xxlSAtOopaz9wpjt
         mMEAXAECjKcsXFG9HfIC258qMYYvfDR9hxEyms8qejOigB7aQ8z1OyWsptNapLVOenBp
         OqDvBkOc5jtLRTd/iqQQBmJrIdJsbsUEsqSbFFHHBxj4q4mSpbc3f5hPRxW47QQeXqaW
         M3WMjh5EJ9WHjgNT1DA5yD8qAEMdKNLjNckkzMnJRXraVAL7mKc9fGKI2Fu7+i+RXyer
         HWTLIGx+f+9Jde307hOULpAE049FI+jUD/gcfVfqqcO78nZXsJmkyf6YcSPbS+QH6F2d
         XrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=kJWf5SlpnV16G8Af33dadBLW8eLejBqjl9BrgDB1dsc=;
        b=dJHjk4RBu67EYaQU1+JgzWki2Q5XIQY3x0J8IOS7Lu/82cGhKCAz3aO32mvaHV0SJK
         3NjYGZ5Es258ED6VCDtNFyY8VeFNxqbkI1JLAhbAtNLzr6bT35cU4hoUp+tf/Y1YSaPi
         Z79OqWpZUS3FfhXnL+enHKqowkdARjedVV/VImrK5tIoCuUx4vnyqW/QH7NEw63LwB9g
         SPwNf2FtImq1IJbnAA7z8jtg7Q5PC7VT/Uh7RO8+NaUDfBbzjDbUdXWIReidtcCJ43ur
         tWWCvZG+nduMIGMrn9Yb7WBr7KpkOY2ZpRGk9IXl/FCKzflr02H7Qriz52fmPqsOKQsG
         UrTA==
X-Gm-Message-State: APzg51AwqSeOCxgnHLj5Vw+VbqlUIzXCNcoI1L84a+f5BX3lcyLW9mnv
        LcYY0tygagiYdRL4lJDbJOSF9Srb
X-Google-Smtp-Source: ANB0VdbNkwaFDTScBwTqXEhdR5iD6jEIpe/G/9N3VRcVkJdVGV7Z/Fz0NiqSdmEQoEKunXxfurseuw==
X-Received: by 2002:adf:a602:: with SMTP id k2-v6mr2872698wrc.181.1534523986740;
        Fri, 17 Aug 2018 09:39:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s1-v6sm2508572wrt.82.2018.08.17.09.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 09:39:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] gpg-interface.c: detect and reject multiple signatures on commits
References: <xmqqbmaa9t8k.fsf@gitster-ct.c.googlers.com>
        <20180814151142.13960-1-mgorny@gentoo.org>
        <20180815213108.GM181377@aiede.svl.corp.google.com>
Date:   Fri, 17 Aug 2018 09:39:45 -0700
In-Reply-To: <20180815213108.GM181377@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 15 Aug 2018 14:31:08 -0700")
Message-ID: <xmqq1saxc5gu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michał Górny wrote:
>
>> GnuPG supports creating signatures consisting of multiple signature
>> packets.  If such a signature is verified, it outputs all the status
>> messages for each signature separately.  However, git currently does not
>> account for such scenario and gets terribly confused over getting
>> multiple *SIG statuses.
>>
>> For example, if a malicious party alters a signed commit and appends
>> a new untrusted signature, git is going to ignore the original bad
>> signature and report untrusted commit instead.  However, %GK and %GS
>> format strings may still expand to the data corresponding
>> to the original signature, potentially tricking the scripts into
>> trusting the malicious commit.
>>
>> Given that the use of multiple signatures is quite rare, git does not
>> support creating them without jumping through a few hoops, and finally
>> supporting them properly would require extensive API improvement, it
>> seems reasonable to just reject them at the moment.
>> ---
>
> Thanks for the clear analysis and fix.
>
> May we have your sign-off?  See
> https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#sign-off
> (or the equivalent section of your local copy of
> Documentation/SubmittingPatches) for what this means.

I do not see the original message you are writing response to on
public-inbox archive.  As long as an update with sign-off will be
sent to the git@vger.kernel.org list, that is OK.

>>  gpg-interface.c | 38 ++++++++++++++++++++++++++++++--------
>>  1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> index 09ddfbc26..4e03aec15 100644
>> --- a/gpg-interface.c
>> +++ b/gpg-interface.c
>> @@ -24,21 +24,23 @@ void signature_check_clear(struct signature_check *sigc)
>>  static struct {
>>  	char result;
>>  	const char *check;
>> +	int is_status;
>>  } sigcheck_gpg_status[] = {
>> -	{ 'G', "\n[GNUPG:] GOODSIG " },
>> -	{ 'B', "\n[GNUPG:] BADSIG " },
>> -	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
>> -	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
>> -	{ 'E', "\n[GNUPG:] ERRSIG "},
>> -	{ 'X', "\n[GNUPG:] EXPSIG "},
>> -	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
>> -	{ 'R', "\n[GNUPG:] REVKEYSIG "},
>> +	{ 'G', "\n[GNUPG:] GOODSIG ", 1 },
>> +	{ 'B', "\n[GNUPG:] BADSIG ", 1 },
>> +	{ 'U', "\n[GNUPG:] TRUST_NEVER", 0 },
>> +	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED", 0 },
>> +	{ 'E', "\n[GNUPG:] ERRSIG ", 1},
>> +	{ 'X', "\n[GNUPG:] EXPSIG ", 1},
>> +	{ 'Y', "\n[GNUPG:] EXPKEYSIG ", 1},
>> +	{ 'R', "\n[GNUPG:] REVKEYSIG ", 1},
>>  };
>
> nit: I wonder if making is_status into a flag field (like 'option' in
> git.c's cmd_struct) and having an explicit SIGNATURE_STATUS value to
> put there would make this easier to read.
>
> It's not clear to me that the name is_status or SIGNATURE_STATUS
> captures what this field represents.  Aren't these all sigcheck
> statuses?  Can you describe briefly what distinguishes the cases where
> this should be 0 versus 1?

Good suggestion.

>>  static void parse_gpg_output(struct signature_check *sigc)
>>  {
>>  	const char *buf = sigc->gpg_status;
>>  	int i;
>> +	int had_status = 0;
>>  
>>  	/* Iterate over all search strings */
>>  	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>> @@ -50,6 +52,10 @@ static void parse_gpg_output(struct signature_check *sigc)
>>  				continue;
>>  			found += strlen(sigcheck_gpg_status[i].check);
>>  		}
>> +
>> +		if (sigcheck_gpg_status[i].is_status)
>> +			had_status++;
>> +
>>  		sigc->result = sigcheck_gpg_status[i].result;
>>  		/* The trust messages are not followed by key/signer information */
>>  		if (sigc->result != 'U') {
>> @@ -62,6 +68,22 @@ static void parse_gpg_output(struct signature_check *sigc)
>>  			}
>>  		}
>>  	}
>> +
>> +	/*
>> +	 * GOODSIG, BADSIG etc. can occur only once for each signature.
>> +	 * Therefore, if we had more than one then we're dealing with multiple
>> +	 * signatures.  We don't support them currently, and they're rather
>> +	 * hard to create, so something is likely fishy and we should reject
>> +	 * them altogether.
>> +	 */
>> +	if (had_status > 1) {
>> +		sigc->result = 'E';
>> +		/* Clear partial data to avoid confusion */
>> +		if (sigc->signer)
>> +			FREE_AND_NULL(sigc->signer);
>> +		if (sigc->key)
>> +			FREE_AND_NULL(sigc->key);
>> +	}
>
> Makes sense to me.

I was wondering if we have to revamp the loop altogether.  The
current code runs through the list of all the possible "status"
lines, and find the first occurrence for each type in the buffer
that has GPG output.  Second and subsequent occurrence of the same
type, if existed, will not be noticed by the original loop
structure, and this patch does not change it, even though the topic
of the patch is about rejecting the signature block with elements
taken from multiple signatures.  One way to fix it may be to keep
the current loop structure to go over the sigcheck_gpg_status[],
but make the logic inside the loop into an inner loop that finds all
occurrences of the same type, instead of stopping after finding the
first instance.  But once we go to that length, I suspect that it
may be cleaner to iterate over the lines in the buffer, checking
each line if it matches one of the recognized "[GNUPG:] FOOSIG"
lines and acting on it (while ignoring unrecognized lines).

>>  }
>>  
>>  int check_signature(const char *payload, size_t plen, const char *signature,
>> -- 
>> 2.18.0
>
> Can we have a test to make sure this behavior doesn't regress?  See
> t/README for an overview of the test framework and "git grep -e gpg t/"
> for some examples.
>
> The result looks good.  Thanks again for writing it.
>
> Sincerely,
> Jonathan
