From: Johan Herland <johan@herland.net>
Subject: Re: Storing refs in the odb
Date: Mon, 20 May 2013 20:44:35 +0200
Message-ID: <CALKQrgeq5xs0ob7=gyYp4nzV3EftOePOPXD4gz6uZBHgmDzD7w@mail.gmail.com>
References: <CALKQrgcBkdoJdJGam=VkE=nXHQ8WB5judY3C3nNQBJCns-_f+A@mail.gmail.com>
	<7vbo85wos9.fsf@alter.siamese.dyndns.org>
	<CALKQrgdWx5mw3NCd4JOr3x9M34c2rNjm_tz_C7fm7g7g-LUJZQ@mail.gmail.com>
	<7va9npv730.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 20 20:44:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeV4f-0000Wz-4c
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 20:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662Ab3ETSol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 14:44:41 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:59320 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab3ETSok (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 14:44:40 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeV4Y-000EOm-Ro
	for git@vger.kernel.org; Mon, 20 May 2013 20:44:38 +0200
Received: from mail-ob0-f170.google.com ([209.85.214.170])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeSWY-000HcJ-To
	for git@vger.kernel.org; Mon, 20 May 2013 18:01:23 +0200
Received: by mail-ob0-f170.google.com with SMTP id er7so7466008obc.1
        for <git@vger.kernel.org>; Mon, 20 May 2013 11:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=b2vb+O22it/01ow407OsD0Pw2l+NT1ymHpYWulEQvb0=;
        b=FDgPzqbBrpLW1RrJU2y8MebXmDWBcNPTPoy1uY7Y2zzosppJKOOUdPWyLnDSAW4v1W
         he23y+kuPuKwmPBdY1JAgxjKqL6Z/kpMgujvAFvrP9kBs7i/nT3ZH0Z/GwjYcH/DiSH8
         WzOcCeXXsqe9J0W+4BymIvD5h2/u8KKmxzHKMZLu+tFa6uWQ6rcj3cSZeXOJ/cBfv+Dr
         ISRJ0q3J3b4ZHsb9/tBgnQ3cECVvph4cMW0EKCB5jxJNcOugogvulR77WL1BFrAY81Ek
         y0hpxqMCF1nyXrj8IGSdfG/UP/bPXRUVwDoQfUiwWeGt48RzQZzFJPvR2E2qx7zg5Jj9
         FVYQ==
X-Received: by 10.60.37.133 with SMTP id y5mr18607533oej.123.1369075475197;
 Mon, 20 May 2013 11:44:35 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Mon, 20 May 2013 11:44:35 -0700 (PDT)
In-Reply-To: <7va9npv730.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224973>

On Mon, May 20, 2013 at 8:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> I wasn't considering disallowing _anything_, rather open up to the
>> idea that a tree object might refer to tag objects as well as
>> commits/trees/blobs. E.g. in my suggested-but-pretty-much-retracted
>> scheme, I was considering whether the tree entry at the "virtual" path
>> "refs/tags/v1.0" should look like this:
>>
>>   100644 blob 123456... v1.0
>>
>> where the blob at 123456... contains the object id of the v1.0 tag
>> object, or whether we should allow the crazyness that is:
>>
>>   ?????? tag 987654... v1.0
>>
>> Just a thought experiment...
>
> I was reacting to this part of your earlier message:
>
>>>> Of course in either case we couldn't use a tree object directly, because
>>>> these new "reference tree" objects would refer not only to blobs and
>>>> other trees but also to commits and tags.
>>>
>>> Indeed. I don't know if the best solution would be to actually _allow_
>>> that (which would complicate the object parsing code somewhat; a tree
>
> You cannot disambiguate, with the thought-experiment in your message
> I am responding to, between these two:
>
>     ?????? tree 987654... v2.6.11-tree
>     ?????? tree 987654... sub
>
> where the former is a light-weight tag for that tree, while the
> latter is merely a subhierarchy in refs/sub/hier/archy, but if you
> disallow v2.6.11-tree, and if you know this kind of tree is only to
> express the ref hierarchy, then everything is unambiguous (a commit
> is not a submodule but is a ref that points at a commit, a blob is a
> ref that points at a blob like refs/tags/junio-gpg-pub, and tag is a
> ref that points at the tag).
>
> So it was "workable" alternative implementation of refs (I am not
> saying it is an "improvement", with the atomicity and performance
> implications we already discussed), if we did not have to worry
> about a light-weight tag that directly point at a tree.

True, unless we were to abuse the mode bits to differentiate between
regular-subtree and ref-to-tree cases...

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
