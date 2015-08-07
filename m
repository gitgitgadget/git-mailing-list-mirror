From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 7 Aug 2015 14:21:52 -0700
Message-ID: <CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNp5i-0004QJ-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 23:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946138AbbHGVVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 17:21:54 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34857 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbbHGVVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 17:21:54 -0400
Received: by ykcq64 with SMTP id q64so93888798ykc.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=au8Yqip0LcrwUy65mudBe5ElwNt0hWDB52jgiHoH0Y8=;
        b=MuCGnc3FXHbTWSP8c1vStHdg8X7CiP2dFo0QTMp5wfH1f9jShRudxEiHcpfP7zTyYo
         w9+q2OBtWIKfj/n45Yizr6X3aMhBmq7um7GcnJNIQdsSkJRt+o7bR8O1C7CXwwxWYuQl
         EVeHRflzIZeTDwaHuGvGYN+50VXl99eiIBjfvlfca8UbrZJk0/XY3y2xVBSA1EEG0Hyp
         KZXO2slU2ZUp1/giTa3na+d7WFzPD5Pkbat3cJafW0DP0x9n7Yanuv/Qi8T985vukaiC
         045swg7uyBnuqIC1tKgsqr8OrJEWJ7OhNZO0FIpI1XCvg3yfaogi3cvZMdpU3KzpBRas
         gRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=au8Yqip0LcrwUy65mudBe5ElwNt0hWDB52jgiHoH0Y8=;
        b=UBxY7Ohzbfjalu5g6OSiuLsM1Q0M4YnJVLsambVxDieBMafy1hD2CeQmJi5qbA4l4n
         a6iOmqR+VtjcE3siqCXpqsjx0zXIwInOKoRfBZTWJgNIm09+1r8E40lTZhRHTCe7+f8z
         Xs2HY/XwuIieOMC5W5L69FHUUrJDWuqC8mguRd2H3QzOAitoxxRmaJMtF22LZDSCaRWy
         HZZSTOMncSnpFopN0e9ylWg70BXJHJVX/R5R3YdBIbUFopNhkV904gUlBFK2pFnsXo5H
         BMRb2qM9vVjC9HCkuxYzd1VaxZeIx8qZ5ZRvqJx5D2JG5Rmge22QwHFAjQuwFpP8J5nn
         r6cg==
X-Gm-Message-State: ALoCoQmPGzSqST8Wcq59s2KVHwCD4lDEaOv1flJizQxtejvX5gBjAR6nQU4H07SwyaXhs1vJAKxU
X-Received: by 10.170.85.2 with SMTP id c2mr10044456yka.56.1438982512856; Fri,
 07 Aug 2015 14:21:52 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Fri, 7 Aug 2015 14:21:52 -0700 (PDT)
In-Reply-To: <xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275491>

On Fri, Aug 7, 2015 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Aug 7, 2015 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>
>>> This change...
>>>
>>>>> @@ -723,10 +733,8 @@ int fetch_populated_submodules(const struct argv_array *options,
>>>>>              if (!S_ISGITLINK(ce->ce_mode))
>>>>>                      continue;
>>>>>
>>>>> -            name = ce->name;
>>>>> -            name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
>>>>> -            if (name_for_path)
>>>>> -                    name = name_for_path->util;
>>>>> +            name_for_path = submodule_name_for_path(ce->name);
>>>>> +            name =  name_for_path ? name_for_path : ce->name;
>>>
>>> ... interacts with Heiko's cached submodule config work that seems
>>> to have stalled.
>>
>> We can drop that hunk as it only uses the new method
>> `submodule_name_for_path` but doesn't change functionality.
>> So if you want to keep Heikos work, I'll just resend the patch
>> without that hunk.
>
> Does such a result even make sense?  Note that I wasn't talking
> about textual conflict.
>
> If we followed what you just said, that patch will try to directly
> read the data in config_name_for_path string list, which is removed
> by Heiko's series, if I am reading it right.
>
> In the new world order with Heiko's series, the way you grab
> submodule configuration data is to call submodule_from_path() or
> submodule_from_name() and they allow you to read from .gitmodules
> either in a commit (for historical state), the index, or from the
> working tree.  Which should be much cleaner and goes in the right
> direction in the longer term.
>
> And the best part of the story is that your module_name would be
> just calling submodule_from_path() and peeking into a field.
>
>> 2) Come up with a good thread pool abstraction
>>    (Started as "[RFC/PATCH 0/4] parallel fetch for submodules" )
>>    This abstraction (if done right) will allow us to use it in different places
>>    easily. I started it as part of "git fetch --recurse-submodules" because
>>    it is submodule related and reasonably sized
>
> I personally think this gives the most bang-for-buck.  Write that
> and expose it as "git submodule for-each-parallel", which takes the
> shell scriptlet that currently is the loop body of "while read mode
> sha1 stage sm_path" in update and clone.  You will have immediate
> and large payback.

You said that before. I feel like this is a bit to narrow. A "git submodule
for-each-parallel" would be a very specific tool which we would use to
make the different submodule operations parallel with ease. But it would
be very submodule specifc I guess?

That's why I want to be a bit more generic and have this thread pool API
done in C, such that "any for loop" in git can be easily replaced by using
the thread pool. I think of "git fetch --all" specially.

>
> And you do not even need module_list and module_name written in C in
> order to do so.  Not that these two are not trivial to implement, but
> the payoff from them is not as large as from for-each-parallel ;-)
>

I think I can do this for-each-parallel once I have the more generic thread
pooling done. All that is left now is a good handling of stdout/stderr, which
I am not yet convinced how to do it right. Maybe each task accumulates
messages in two string buffers and then the thread pool will output the
string buffer one a task is done.
