From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/34] mailinfo: move global "line" into mailinfo() function
Date: Mon, 19 Oct 2015 22:19:29 -0700
Message-ID: <xmqq7fmi9kwu.fsf@gitster.mtv.corp.google.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-11-git-send-email-gitster@pobox.com>
	<CAPig+cQ5bcaTEsGMP7_LZKD4ze8vQAaqcw7kbhU7rZQXGdDRUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 07:19:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoPKn-0000sN-9j
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 07:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbbJTFTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 01:19:31 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36821 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbJTFTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 01:19:31 -0400
Received: by pacfv9 with SMTP id fv9so9856790pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 22:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hf3TR6stfKtOG9pgNwkqrIg1DC3DCy4amR6ks9Y9cxM=;
        b=tdRGXegqRxY4f47e2ezFPFIpMoBLFC4WkBAuixyXLS83HeXEh22/V68lfT390lIyoO
         afzhGS7BKfw1xFDPx50A3DqrQjhoauQgns1bfIuvcyDgmD+CmWuFJgaPwzMNL45bB+aL
         PyTjPloOc+NXQCjE8nC+4rQDu5GcyArm0P3wE+SVFyQQI6rLSMx8eAwKMzF5wQSn5h3j
         W+rTTqbLLRMglTlqJCfL8gquVCrNOdrnKJtD2m7sx7XQ4ESi2d03A24/IOORNFP7mnCk
         dBZWqTUcvLG1g/s1v8Fof428jzUyJWij83uMbzCBVxUb6tRgWzJuwgAbUN9d7Tn2aBvl
         NSKw==
X-Received: by 10.66.220.164 with SMTP id px4mr1678963pac.15.1445318370701;
        Mon, 19 Oct 2015 22:19:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id mk5sm1177205pab.44.2015.10.19.22.19.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Oct 2015 22:19:30 -0700 (PDT)
In-Reply-To: <CAPig+cQ5bcaTEsGMP7_LZKD4ze8vQAaqcw7kbhU7rZQXGdDRUQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 19 Oct 2015 18:57:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279902>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Oct 19, 2015 at 3:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> With the previous steps, it becomes clear that the mailinfo()
>> function is the only one that wants the "line" to be directly
>> touchable.  Move it to the function scope of this function.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
>> index 12d1eda..c8dc73f 100644
>> --- a/builtin/mailinfo.c
>> +++ b/builtin/mailinfo.c
>> @@ -12,7 +12,6 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
>>  static int keep_subject;
>>  static int keep_non_patch_brackets_in_subject;
>>  static const char *metainfo_charset;
>> -static struct strbuf line = STRBUF_INIT;
>>  static struct strbuf name = STRBUF_INIT;
>>  static struct strbuf email = STRBUF_INIT;
>>  static char *message_id;
>> @@ -966,6 +965,8 @@ static void handle_info(void)
>>  static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
>>  {
>>         int peek;
>> +       struct strbuf line = STRBUF_INIT;
>
> Does there need to be a corresponding strbuf_release(&line) at the end
> of the function?

Indeed.
Thanks.
