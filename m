From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git-am and CRLF
Date: Wed, 13 Mar 2013 18:46:12 +0100
Message-ID: <CABPQNSYi2UnpEBu_-Mb=2XvCodeoseTGPKCiSo0+2MrnHt3rZQ@mail.gmail.com>
References: <CABPQNSb9euNgCY9g617opThHC8OUpZQvJ+peor8Yk39LZ+y+TQ@mail.gmail.com>
 <CA+sFfMfJp1-REXVjipUhsVrUKDSmhrBkV0yd_=sMwwmiw2aypQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 18:47:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFplt-0003Ns-W7
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934052Ab3CMRqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:46:54 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:44761 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932881Ab3CMRqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 13:46:53 -0400
Received: by mail-ia0-f182.google.com with SMTP id b35so1218701iac.27
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=GWZubQn6iYNCa+RNL5PvAMpJy24uM0Tp1G0qxJV9tG0=;
        b=hwO6pHBJDHtjtV26J6SJZQHV98DZI5/9bX+GH9Ke64sYDlbU03b3rxPjlBzR+OeN9h
         UhYCOzQPUCWvSeeBuOFzEJeqyDtJN9i2EOrifMz3J4hqw5jKOyUqfHlaD8SJdm7ja8lr
         ufuBBMqlCed7UlwZs3fkJaVuBr6Cu7jKFhd+MxeMgN1sSuCnakCQFgCiN996JCgLi1HR
         lyD3+2PHTONM5O9pKjJKFcAwtuTDbtm4oiFyU7aftqujPz17X0PEELf6E5D7YpNi05B4
         1FukEfY7KVAozOdy2M/kZws5n5vHUNjjoixClqAOZ6Huw9z47ewYulwsmib8sLU3fYVP
         +8gw==
X-Received: by 10.50.202.6 with SMTP id ke6mr17198513igc.30.1363196812698;
 Wed, 13 Mar 2013 10:46:52 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Wed, 13 Mar 2013 10:46:12 -0700 (PDT)
In-Reply-To: <CA+sFfMfJp1-REXVjipUhsVrUKDSmhrBkV0yd_=sMwwmiw2aypQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218076>

On Wed, Mar 13, 2013 at 6:42 PM, Brandon Casey <drafnel@gmail.com> wrote:
> On Wed, Mar 13, 2013 at 9:54 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> I recently tried to apply a patch-series to a repo that is
>> unfortunately full of CRLF files, and was a bit surprised that it
>> didn't work at all.
>>
>> So I made a small repro-case, and it seems CRLF new-lines is indeed
>> the problem. Any clue how to fix it? The way I see it, we should
>> simply be able top treat the CR as any other character, and succeed.
>> But that doesn't seem to happen...
>>
>> git init test &&
>> (
>>         cd test/ &&
>>         git config core.autocrlf false &&
>>         printf "%s\r\n%s\r\n" "foo" "bar" > test.txt &&
>>         git add test.txt &&
>>         git commit -m. &&
>>         printf "%s\r\n%s\r\n%s\r\n" "foo" "baz" "bar" > test.txt &&
>>         git commit -am. &&
>>         git format-patch -1 &&
>>         git reset --hard HEAD^ &&
>>         git am 0001-.patch
>> )
>
> Does 'git am --keep-cr' help?
>

It does, how silly of me not to try that before posting.

> Unfortunately the original information about line ending is lost once
> a patch is sent via email since RFC2822/822 dictates that the line
> ending in an email must be crlf.  So by default, mailsplit strips it.

Hmpf. I didn't transport my patches over e-mail, I simply used
git-format-patch/git-am to transfer the patches from one git-svn clone
to another. But since that's kind of an "abuse" of
git-format-patch/git-am, perhaps just using --keep-cr is the right
thing.

Thanks anyway :)
