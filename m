From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 06/11] remote.h: add get_remote_capabilities, request_capabilities
Date: Fri, 29 May 2015 12:39:35 -0700
Message-ID: <CAGZ79kbm5FCjMH-vV+_ByNvAdOD2idVtd8-bizEJpZpdE9cGjQ@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-7-git-send-email-sbeller@google.com>
	<20150527064521.GD885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 29 21:39:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyQ85-0004eg-KK
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 21:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544AbbE2Tji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 15:39:38 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35447 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbbE2Tjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 15:39:36 -0400
Received: by qkhq76 with SMTP id q76so22194320qkh.2
        for <git@vger.kernel.org>; Fri, 29 May 2015 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TuIf0/rjgGr88+9vDDGgr6Wyb+VPQdr6/uMJfXAqmfA=;
        b=PBiMr5vokwHD4oTL6jXmNuReUxbqx46BBLqSKlfNg1XOoRR5f3iMOknV5yrBJ8LWBj
         nuZNPor1J8MlohKIXB5UEhdGAn5HO8uaM31kc6x6B30Ca/2zdB8H3TbiuCaAvNhezSSd
         JVyxnjZ0YlYfOHo6PBnRj3c6hFGGvQOrDM7Q5oB88Z6EmxHXtT4qifH6j7ySxklKLiXT
         s2xxNbmLuNNPm24YphadUpE0S49TMA/+aLW9aqpSgPUmcMukLn0hk2O4pvUpWhpuEZrX
         cjxlD1tZfJP1LNC9JekXBDcpSeuMgR4dEk50VSMCevHk0D1KW0xehUD+JJ8OkO2okPXZ
         Iukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TuIf0/rjgGr88+9vDDGgr6Wyb+VPQdr6/uMJfXAqmfA=;
        b=ajb1lOYkn3ZPnLHyfTslw5SqBzR2PamEvc2CeDjnecAaqYLy83JR/qfvC1+jImZkg3
         XqYkuBU8TdEhN5HkK/rO1badKgUAL+amByn5/HOl/ezjEx/bUeIdMypAy5AKj1Ntej5S
         lu8frTPWS+i4DiOmgPZMUyfuGZQNldkWmADY//NSusacJjjKgghdX4TtwZc75QH+EitG
         tTzISr9EfFwmkGKpjbithAV7taeSODmAM/J3SAzxSgaiXZWyElPpblucWBei7yFYA1nQ
         qsJVXQskCMaYp3w/K6DAo/9MmV6aprJ0MwJR6qEdu1/jlrbFd0GnsXaEV1EscFa4GukA
         Q7Yw==
X-Gm-Message-State: ALoCoQm42h1CokDbe3xkzoXCYFIg++nPQu5hkH/jjAANTNT2ARwTmrovGvlZnkw/IQHAL1grKOtK
X-Received: by 10.140.133.9 with SMTP id 9mr11876696qhf.5.1432928375353; Fri,
 29 May 2015 12:39:35 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 29 May 2015 12:39:35 -0700 (PDT)
In-Reply-To: <20150527064521.GD885@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270267>

On Tue, May 26, 2015 at 11:45 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 26, 2015 at 03:01:10PM -0700, Stefan Beller wrote:
>
>> +void get_remote_capabilities(int in, char *src_buf, size_t src_len)
>> +{
>> +     struct strbuf capabilities_string = STRBUF_INIT;
>> +     for (;;) {
>> +             int len;
>> +             char *line = packet_buffer;
>> +             const char *arg;
>> +
>> +             len = packet_read(in, &src_buf, &src_len,
>> +                               packet_buffer, sizeof(packet_buffer),
>> +                               PACKET_READ_GENTLE_ON_EOF |
>> +                               PACKET_READ_CHOMP_NEWLINE);
>> +             if (len < 0)
>> +                     die_initial_contact(0);
>> +
>> +             if (!len)
>> +                     break;
>> +
>> +             if (len > 4 && skip_prefix(line, "ERR ", &arg))
>> +                     die("remote error: %s", arg);
>> +
>> +             if (starts_with(line, "capability:")) {
>> +                     strbuf_addstr(&capabilities_string, line + strlen("capability:"));
>> +                     strbuf_addch(&capabilities_string, ' ');
>> +             }
>> +     }
>
> I think this is the reverse case of next_capabilities in the upload-pack
> side, so I'll make the reverse suggestion. :) Would it make things nicer
> if both v1 and v2 parsed the capabilities into a string_list?

Ok, I'll do that. Though this makes future enhancements a bit uneasy.
Say we want to transport a message by the server admins, this might be
the right place to do.

    if (starts_with("message"))
        fprintf(stderr, ....

Of course we can later add this in the future, but it would break older
clients (clients as of this patch series). That's why I like the idea of
adding a prefix here. Maybe just a "c:" as an abbreviation for capability.
But now making it short and concise makes it painful in the future when
we want to transport anything else apart from capabilities in this phase
of the protocol exchange. Of course we could have a capability "server-message"
indicating that after the capabilities we'll have a dedicated message to be
displayed to the user.

Yeah well that should do.

I'll just parse in a string_list for now.

>
>> +     free(server_capabilities);
>> +     server_capabilities = xmalloc(capabilities_string.len + 1);
>> +     server_capabilities = strbuf_detach(&capabilities_string, NULL);
>
> Is this xmalloc line left over? The strbuf_detach will write over it.

No, I wasn't reading the fine documentation and assuming things I
should not.

>
>> +     strbuf_release(&capabilities_string);
>
> No need to release if we just detached.
>
>> +int request_capabilities(int out)
>> +{
>> +     fprintf(stderr, "request_capabilities\n");
>
> Debug cruft, I presume.
>
>> +     // todo: send our capabilities
>> +     packet_write(out, "capability:foo");
>
> No C99 comments. But I think this is just a placeholder. :)
>
> -Peff
