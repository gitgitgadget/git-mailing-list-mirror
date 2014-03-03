From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Mon, 3 Mar 2014 14:46:12 -0500
Message-ID: <CAPig+cTmejtWXRzr6qk-kd+P8j4b6xMJSUVnNnqObqNXc-S9UA@mail.gmail.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
	<CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
	<xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: He Sun <sunheehnus@gmail.com>, Faiz Kothari <faiz.off93@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYoh-0004FD-Co
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbaCCTqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:46:14 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:44991 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbaCCTqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:46:12 -0500
Received: by mail-yh0-f51.google.com with SMTP id f10so3534054yha.38
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IZzKoSlntgWXepvebogSlLdDzoVB3KoZgBo3HI3RlgY=;
        b=xt1Yywci5QxnkHm9xKhMsQJNZbO6KRVwmN5dSgsamMfhpxVxapXhKVnJ82oiarRuCm
         ZweJG/vdzmEG7eE/O8j2wiq16551/UGHpRYEKstjuMmiHXIZd7mXtku0J4UmGzsn1dbM
         i0mpD9H2DT4k/VeNgJ3bQoSkyo8ExkiBjllK7zunea7129xt5w9fwlNM+f4fwun1fPUF
         1uFmE8jJnjQJ+RlfA37hUy2cqzM+wZYxAoWKnb/+XbMRcQ+A++bqMD4wzVVBBJDx2uKq
         LsvsBXNI7yrxiineH1W3sKiGQN7pVPEXmVaoE+d0HcP1pRTxMnVq9KEbhmC2NGLnmb7u
         cxDw==
X-Received: by 10.236.231.234 with SMTP id l100mr1316095yhq.135.1393875972100;
 Mon, 03 Mar 2014 11:46:12 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 11:46:12 -0800 (PST)
In-Reply-To: <xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: Joz9jS7SfSUMDl4Ia8ufVaon7x4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243260>

On Mon, Mar 3, 2014 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
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

As a potential GSoC student and newcomer to the project, Faiz would
not have known that this would be considered unwanted churn when he
chose the task from the GSoC microproject page [1]. Perhaps it would
be a good idea to retire this item from the list?

On the other hand, it did expose Faiz to the iterative code review
process on this project and gave him a taste of what would be expected
of him as a GSoC student, so the microproject achieved that important
goal, and thus wasn't an utter failure.

[1]: https://github.com/git/git.github.io/blob/master/SoC-2014-Microprojects.md
