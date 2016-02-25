From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv17 05/11] run_processes_parallel: treat output of children
 as byte array
Date: Thu, 25 Feb 2016 12:35:04 -0800
Message-ID: <CAGZ79kaQHk+1k48Yrn_2p9SwB8aJO96jUtL-cA-Gr1PASMkUkQ@mail.gmail.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
	<1456369618-18127-6-git-send-email-sbeller@google.com>
	<xmqqsi0godtp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:35:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2dB-0000RZ-1w
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbcBYUfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:35:09 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34745 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbcBYUfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:35:05 -0500
Received: by mail-io0-f178.google.com with SMTP id 9so95982093iom.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wWI9kjFpJUzf5bLq2TeIu4+RmcDS15xBLj9XTzLjXkA=;
        b=Fo5Xxx9yh0m9hxFyPqFJsZ4sC4hfPefT12qzEkoDBT3q+YKxEnCYevS0rOWa+bHAyO
         Q0SX38tfTmqs0Fd1K4TiYb4RlUlTmxFIphrirkd0z5z13b506UPPfe4kuc4G/iEhP/w+
         kDHrVRTX1iJvHr8++MVFpK1wFH3u6KFCEOqFyGx7FJ5NwEH+qJi934pCnJNG1j5ERXgc
         sL7q3QYE48gRzBrGOT5m9NagQCyn3wlyT0KC5MPWNueKwLBsrOlcw2Fbt2DYgkXFHivi
         39Wu+qlmNvNNEEkz9ZaV3V+jU9CQ5UiQm19jTRdCnD9Z+EpyIAkAYJ0Dmn2OD00kghOo
         u28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wWI9kjFpJUzf5bLq2TeIu4+RmcDS15xBLj9XTzLjXkA=;
        b=FrpJLGj4M3pDb4EP3O7HShmH3Jbrg1TPkpF7vGtlGaz/BUsCaiaoOxzbjajAvXKkZz
         UfXedtLf4Tghw7lDG2wZ/D9NZuPos+sq+UDN6CeiE0GGkkzIHW91Dlr0CtVtbqr3KEK+
         8A7bffF/tLsFQI256QAzT6L5YF6d/LVeGkvgVG4nsYyHuCjUyMkbBJrCuABdOG8RciCI
         A94yYh7MVuiDbH7eHoTfkEtB8+4rzosxh6Q5pPs8Ix5KJx8QzaA8oaAohdbUYvL6j0kS
         0nUR83Y1nLrADmw/YLQucIqmXEMpH/2e97UmMPWi/e873K5xsdyHFSaRwy0qyuNvs5E6
         Lyig==
X-Gm-Message-State: AG10YOTtPublqFRYldd44poKRtO8fk3oNOkVrbQWpcnFFr61n1YMoc7hCu2odGmPgFl+q7kAWd03deOnz+pvl32b
X-Received: by 10.107.168.149 with SMTP id e21mr4869284ioj.96.1456432505071;
 Thu, 25 Feb 2016 12:35:05 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Thu, 25 Feb 2016 12:35:04 -0800 (PST)
In-Reply-To: <xmqqsi0godtp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287437>

On Thu, Feb 25, 2016 at 10:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -1135,11 +1135,11 @@ static int pp_collect_finished(struct parallel_processes *pp)
>>                       strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>>                       strbuf_reset(&pp->children[i].err);
>>               } else {
>> -                     fputs(pp->children[i].err.buf, stderr);
>> +                     strbuf_write(&pp->children[i].err, stderr);
>>                       strbuf_reset(&pp->children[i].err);
>>
>>                       /* Output all other finished child processes */
>> -                     fputs(pp->buffered_output.buf, stderr);
>> +                     strbuf_write(&pp->buffered_output, stderr);
>>                       strbuf_reset(&pp->buffered_output);
>>
>>                       /*
>> diff --git a/strbuf.c b/strbuf.c
>> index 38686ff..71345cd 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -395,6 +395,12 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
>>       return cnt;
>>  }
>>
>> +ssize_t strbuf_write(struct strbuf *sb, FILE *f)
>> +{
>> +     return fwrite(sb->buf, 1, sb->len, f);
>> +}
>
> Whenever I see a call to a function that takes size and nmemb
> separately, I get worried about the case where nmemb is zero.
> Hopefully everybody implements such a fwrite() as a no-op?
>
> This may not matter in this patch as no caller checks the return
> value from this function, but shouldn't the callers be a bit more
> careful checking errors in the first place?

If there is no other comment on the series, I plan on sending a patch
to fix this up afterwards to not further collide with the refs backend series.
