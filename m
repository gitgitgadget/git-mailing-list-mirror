From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 13:45:30 -0400
Message-ID: <CABURp0r46C84pPptecDmLBHuO2Z+vXAm26JRA+HVcF9KvT_NyA@mail.gmail.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
 <xmqqa9k6moif.fsf@gitster.dls.corp.google.com> <20130825042314.GE2882@elie.Belkin>
 <xmqqk3jal4t7.fsf@gitster.dls.corp.google.com> <xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
 <CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
 <xmqqr4dgifp5.fsf@gitster.dls.corp.google.com> <CABURp0odEGgZO1yWFgXS+akPb4wJHiTLoQcmqBd00oYnPZ77vA@mail.gmail.com>
 <xmqqbo4kicsm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0rT-0002YB-7j
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab3HZRpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:45:51 -0400
Received: from mail-vb0-f53.google.com ([209.85.212.53]:35883 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab3HZRpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:45:50 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so2179696vbh.26
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=huXtYb2niwkWWduOjVI+hxNOZOJ0xTj1Tu9djElaQAU=;
        b=Wi4riSjb4B8K9kxKeFENlq0HksoMZef5nz8ju2h10uUOdsNjyqEnaLOgHB1JmR7uOQ
         RilKcXHou4uXhSRY80PgnfRz2DllnlF0/e0c4qQIE/AGriRZurEN7A0PDaD6j39Bts/B
         /55nZ7NQzqgpyZzTF9AMeKGQOsFvRIWQmofSjb0B13PixUFLR1a6U8IY88Io3gDaBAfY
         2hNlU+N106X7pAQorRCAf5x2WDkyS9vZbbtNFZ64A/XReK2CB9fCrrCtJb0qw4trTGYP
         xtOh7CTGocRSoGp0fvHgG3Bkmsnbv/WuuNkMJPYMm8KkVKSos69GwHxsRVAOD2/yLOm8
         3MLQ==
X-Received: by 10.221.64.17 with SMTP id xg17mr15861154vcb.5.1377539150156;
 Mon, 26 Aug 2013 10:45:50 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Mon, 26 Aug 2013 10:45:30 -0700 (PDT)
In-Reply-To: <xmqqbo4kicsm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233013>

On Mon, Aug 26, 2013 at 1:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>>> If your justification were "above says 'there may be a readon why
>>> the user wanted to ask it in that way', i.e. 'find in this tree
>>> object HEAD:some/path and report where hits appear', but the reason
>>> can only be from laziness and/or broken script and the user always
>>> wants the answer from within the top-level tree-ish", then that
>>> argument may make some sense. You need to justify why it is OK to
>>> lose information in the answer by rewriting the colon that separates
>>> the question ("in this tree object") and the answer ("at this path
>>> relative to the tree object given").
>>>
>>> Whether you rewrite the input or the output is not important; you
>>> are trying to give an answer to a different question, which is what
>>> I find questionable.
>>
>> Ok, so if I can summarize what I am inferring from your objection:
>>
>>  1. The (tree-path, found-path) pair is useful information to get back
>> from git-grep.
>
> At least that was the intent. I can be persuaded that your change
> will not break anybody if you successfully argue that it is not a
> useful information, though.

Anyone who is interested in the matched trees from the original
command-line only needs to compare the matched paths' prefixes with
the original args to see which one is responsible for each hit.  But
this is not convincing to me because they may not know the original
args to the grep command.

I do not know if this a good reason to keep supporting this mode,
though.  I can just as easily see some script being confused by four
colons in

    origin/master:some/:path/file.c:1:int main()

instead of only three that he is used to because someone passed in a
longer tree-path than expected.

I don't know if I can make that argument.

I think I _can_ argue that the colon separator here is historically
just a part of the filename because it is not affected by "--null".

>>  2. A colon is used to delimit these pieces of information, just as a
>> colon is used to delimit the filename from the matched-line results.
>>
>>  3. The fact that the colon is also the separator used in object refs
>> is mere coincidence; the colon was _not_ chosen because it
>> conveniently turns the results list into valid object references.  A
>> comma could have been instead, or even a \t.
>
> Not necessarily.  If the user is asking the question in a more
> natural way (I want to see where in 'next' branch's tip commit hits
> appear, by the way, I know I am only interested in builtin/ so I'd
> give pathspec as well when I am asking this question), the output
> does give <commit> <colon> <path>, so it is more than coincidence.
>
> I do not think it is worth doing only for this particular use case,
> but it might be a good change to allow A:B:C to be parsed as a
> proper extended SHA-1 expression and make it yield
>
>         git rev-parse $(git rev-parse $(git rev-parse A):B):C
>
> Right now, "B:C" is used as a path inside tree-ish "A", but I think
> we can safely fall back, when path B:C does not appear in tree-ish
> A, to see if path B appears in it and is a tree, and then turn it
> into a look-up of path C in that tree A:B.

That would also solve this problem, usually.  But I don't like it
nearly as much as my patch, and I agree it seems extreme for this one
corner-case.

Phil
