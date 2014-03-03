From: Faiz Kothari <faiz.off93@gmail.com>
Subject: Fwd: [PATCH] implemented strbuf_write_or_die()
Date: Tue, 4 Mar 2014 00:18:29 +0530
Message-ID: <CAFbjVck=yfRfhFtmLedD9A+ddeo7VcJ-km=6NBgmYXtmSfBRmQ@mail.gmail.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
	<CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
	<xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
	<CAFbjVckhU7NHzLjqPo5WkoBwVLrOLg=CS6mHSKkQstUxB31_eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 19:48:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXul-0006rQ-FM
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbaCCSsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:48:31 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:59808 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbaCCSsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:48:30 -0500
Received: by mail-la0-f52.google.com with SMTP id ec20so4095166lab.39
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 10:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=fNPGunZ58OUgyaEaRqt+Fmne/uWE2hK2P5NIaBnzCwM=;
        b=IBKeS8cV/uhqsmQ8Al8yjaH9cdfgxo9z9NFkQZt3VOSMWiyUMCKQE/hPRusvFAni7I
         ynW4bLxg7f+B6VZHZq1jJx/j4FRX45ZeFIqGlE4KmtR1zvQOgIxdEDyLsJFhLjTiFn8T
         v7sCpaCcFf+XWtwaLfAYP9mh4UEP5I3HlFMLwe7+l7lEs+HzFDQ5UzS5PvF0FCVvhdc/
         9Ku16KBPcZBCMhj9a5GgwYbBWFj/ai6gJPBLI+HiUL7UfNg13Y2NEHi6+bp5/kY7zKbW
         RN6NguUdno+Qn/gbe8WNYM5Jl6SpO4gaZNs2h4TiqjQitQXMp51Bao+R3Igdm3oHfSwC
         KjsA==
X-Received: by 10.112.13.133 with SMTP id h5mr2292575lbc.67.1393872509384;
 Mon, 03 Mar 2014 10:48:29 -0800 (PST)
Received: by 10.114.186.35 with HTTP; Mon, 3 Mar 2014 10:48:29 -0800 (PST)
In-Reply-To: <CAFbjVckhU7NHzLjqPo5WkoBwVLrOLg=CS6mHSKkQstUxB31_eA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243252>

On Tue, Mar 4, 2014 at 12:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Sat, Mar 1, 2014 at 7:51 AM, He Sun <sunheehnus@gmail.com> wrote:
>>> 2014-03-01 19:21 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
>>>> diff --git a/remote-curl.c b/remote-curl.c
>>>> index 10cb011..dee8716 100644
>>>> --- a/remote-curl.c
>>>> +++ b/remote-curl.c
>>>> @@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>>>>         if (start_command(&client))
>>>>                 exit(1);
>>>>         if (preamble)
>>>> -               write_or_die(client.in, preamble->buf, preamble->len);
>>>> +               strbuf_write_or_die(client.in, preamble);
>>>>         if (heads)
>>>>                 write_or_die(client.in, heads->buf, heads->len);
>>>
>>> This should be changed. May be you can use Ctrl-F to search write_or_die().
>>> Or if you are using vim, use "/ and n" to find all.
>>
>> It's not obvious from the patch fragment, but 'heads' is not a strbuf,
>> so Faiz correctly left this invocation alone.
>
> That is a very good sign why this change is merely a code-churn and
> not an improvement, isn't it?  We know (and any strbuf user should
> know) that ->buf and ->len are the ways to learn the pointer and the
> length the strbuf holds.  Why anybody thinks it is benefitial to
> introduce another function that is _only_ for writing out strbuf and
> cannot be used to write out a plain buffer is simply beyond me.
>
Hi,
Thanks for the feedback. Yes, I do realize, its kind of a code churn.
I didn't realize it until I looked at the sign you pointed out.
But it was a good exercise to go through the code as this is one of
the GSoC microprojects.
Sorry, it didn't turn out to be a beneficial one. My bad.

Thanks a lot again for the suggestions and feedback.

-Faiz
