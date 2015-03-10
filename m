From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] builtin/help.c: fix memory leak
Date: Tue, 10 Mar 2015 16:50:33 -0700
Message-ID: <CAGZ79kYSBsfbR_gH1Ur12vMpcK5S0K6wrOpMhNVvgffAb683Bw@mail.gmail.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
	<1425920304-22360-3-git-send-email-sbeller@google.com>
	<xmqqwq2oxyli.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVU0S-0004yo-Ah
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbbCJX4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:56:05 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34295 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbCJX4C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:56:02 -0400
Received: by iecsl2 with SMTP id sl2so877975iec.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=esojwWa5qQEukwWRIvPzfcgQW/F1EPMY+7cO1gPNYVk=;
        b=mKYn05pZGmMPLey9BOPET05daFUTFte2zQapoSpuPtnrTfqIN8Ak16q2SHyR2Uem5S
         gestZ0rxqrlcoganhY/XJPOYtUOAmicM0WmxwodIS9ITsuY0Xfb702MqHWnwEgpB2fjx
         Pi/AfgDuZBnw5h7MZuTWvJOganh6VfbTtLtAl8+av8jUIX2jTQubmHgtmkxtRZa4VJqN
         zDM991xluMt1bRggWZ0kQ3NcM4W3aMshPvhlkwKT4JK48WVRCNMUEkOqtZPt70vSyPyw
         aYj+9iRXm1xz48neao4gEI5y8qaBTTDlgFgv8BG31VDbJrfr8USarBHQ5Re7FtUhAkUH
         6/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=esojwWa5qQEukwWRIvPzfcgQW/F1EPMY+7cO1gPNYVk=;
        b=VxE58qm56RmA5qAO1W+hVrp86EaBnKbwTyv716YFMPZIkm5mTLFYwQSvb3rDwg/+91
         0BQWZzq/e3xaOB5GQC6IAne45+UzSQnq3rBxPxlK7bOdwZ/mJnFm450mYXGwicMc8wRk
         IXejeFGlIbnfQhX07yVC8WBuwHLboGa0EmpO9EkY7ZVtuvyfdpbTyEP6WESdp9TLXu9f
         3WuPTFL064k0VrrTmmKNwZFuHoLjACunqEvEmjiZgzPksihjix+Yphqxw5pRGweO9/pX
         Zr6sGpGCH2m4qyKhk+WSeVqLfC2ifhxtXnUKDj+h5ris2Mmx5orXKtO5hWrFszm9+Di2
         i2hw==
X-Gm-Message-State: ALoCoQkMU9hCW08PPjHxj6rgij2mLqtYAV1r8wauADeB4glncHWElW5yiB2tPleI9pK74FNMqMNh
X-Received: by 10.42.92.16 with SMTP id r16mr37670843icm.95.1426031433562;
 Tue, 10 Mar 2015 16:50:33 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Tue, 10 Mar 2015 16:50:33 -0700 (PDT)
In-Reply-To: <xmqqwq2oxyli.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265286>

On Tue, Mar 10, 2015 at 3:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/help.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/help.c b/builtin/help.c
>> index 6133fe4..a1f5a0a 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -456,7 +456,7 @@ static void list_common_guides_help(void)
>>  int cmd_help(int argc, const char **argv, const char *prefix)
>>  {
>>       int nongit;
>> -     const char *alias;
>> +     char *alias;
>>       enum help_format parsed_help_format;
>>
>>       argc = parse_options(argc, argv, prefix, builtin_help_options,
>> @@ -499,6 +499,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>>       alias = alias_lookup(argv[0]);
>>       if (alias && !is_git_command(argv[0])) {
>>               printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
>> +             free(alias);
>
> Hmph, does this memory belong to us, or are we peeking into the
> cached data in the config cache layer?

So  alias_lookup(..) is a wrapper around git_config_string essentially
(some more git_config_functions are involved, but we eventually reach
git_config_string), where we have

    *dest = xstrdup(value);

so I think we need to free that memory, as the config cache layer doesn't
care any more.
