From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Wed, 24 Sep 2014 12:00:40 +0200
Message-ID: <CAP8UFD2FV2pvR4+N0fDLtentA_oWwYGRZ6rPtshi=TOAvXaRLA@mail.gmail.com>
References: <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
	<xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
	<xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
	<20140618030903.GA19593@redhat.com>
	<CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
	<xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
	<20140922140144.GA9769@redhat.com>
	<CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
	<20140923080700.GA16527@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 12:00:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWjNS-0005DI-2l
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 12:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbaIXKAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 06:00:45 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:64769 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbaIXKAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 06:00:41 -0400
Received: by mail-ie0-f173.google.com with SMTP id tr6so11390957ieb.32
        for <git@vger.kernel.org>; Wed, 24 Sep 2014 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kGJRQLiKnjBQmB+PJsPijwspJwxw5lrwQoZbF34pSLY=;
        b=nJ0IeUYLg7j8B3Y+NkTPg9lu2jYJHy5H+VZgIhCoXV07oDsjKsCYTVBGn6rrcJYclE
         fAnAEOUEF7hi7qGkEqtv9pwTL0F0fPSbwvXtZQ1RX0FKrLtmhbXBrDe+3W53TB1AzM9u
         t//8zw6jVJH63BHfoBoZ7qXIv3XUXV2L6lt4Gq/EDgsMZiZHKb0OVkL0Frvjvgw9H05d
         rce/HiTrkQG5P8yCHBV5HY5FBjKtkLo7IbqLpgJE22FOd8ohiAOmyrnu3e9iYkoNM0S+
         vxvTlkfawuwD2GjGdJ6m6OySuKQLyeOzuGeMTGIuYSJ2A509dDR8dlDyrDLV3SoT4mIc
         T9Xg==
X-Received: by 10.42.205.19 with SMTP id fo19mr9658186icb.52.1411552840743;
 Wed, 24 Sep 2014 03:00:40 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Wed, 24 Sep 2014 03:00:40 -0700 (PDT)
In-Reply-To: <20140923080700.GA16527@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257455>

On Tue, Sep 23, 2014 at 10:07 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Sep 23, 2014 at 09:45:50AM +0200, Christian Couder wrote:
>> This is probably not as simple as you would like but it works with
>> something like:
>>
>> $ git interpret-trailers --trailer "Acked-by: Michael S. Tsirkin
>> <mst@redhat.com>" --trailer "Reviewed-by: Michael S. Tsirkin
>> <mst@redhat.com>"  --trailer "Tested-by: Michael S. Tsirkin
>> <mst@redhat.com>" 0001-foo.patch >to_apply/0001-foo.patch
>>
>> and then:
>>
>> $ git am to_apply/*.patch
>>
>> Also by using something like:
>>
>> $ git config trailer.a.key Acked-by
>> $ git config trailer.r.key Reviewed-by
>> $ git config trailer.t.key Tested-by
>
> I would like multiple keys to match a specific
> letter, e.g. as a maintainer I need
> both reviewed by and signed off by when I
> apply a patch, I like applying them with
> a single "-s m".

That's different from what you implemented in your patch.
And franckly I think that for this kind of specific use cases, you
could create your own aliases, either Git aliases or just shell
aliases.

For example if we implement default values and make git am call git
interpret-trailers, a shell alias could simply be:

alias gamsm='git am --trailer r --trailer s'

I use "git log --oneline --decorate --graph" very often, so I made my
own alias for it, and I suppose a lot of other people have done so.

The number of people who will use trailers will probably be much
smaller than the number of people using git log, so if we don't make
shortcuts for "git log --oneline --decorate --graph", I see no ground
to ask for a specific shortcut that adds both a reviewed by and a
signed off by.

>> the first command could be simplified to:
>>
>> $ git interpret-trailers --trailer "a: Michael S. Tsirkin
>> <mst@redhat.com>" --trailer "r: Michael S. Tsirkin <mst@redhat.com>"
>> --trailer "t: Michael S. Tsirkin <mst@redhat.com>" 0001-foo.patch
>> >to_apply/0001-foo.patch
>>
>> And if you use an env variable:
>>
>> $ ME="Michael S. Tsirkin <mst@redhat.com>"
>> $ git interpret-trailers --trailer "a: $ME" --trailer "r: $ME"
>> --trailer "t: $ME" 0001-foo.patch >to_apply/0001-foo.patch
>>
>> Maybe later we will integrate git interpret-trailers with git commit,
>> git am and other commands, so that you can do directly:
>>
>> git am --trailer "a: $ME" --trailer "r: $ME"  --trailer "t: $ME" 0001-foo.patch
>>
>> Maybe we wil also assign a one letter shortcut to --trailer, for
>> example "z", so that could be:
>>
>> git am -z "a: $ME" -z "r: $ME"  -z "t: $ME" 0001-foo.patch
>
> -s could apply here, right?

I don't know what we will do with -s. Maybe if we use -z, we don't need -s.

> It doesn't have a parameter at the moment.

We will have to discuss that kind of thing when we make it possible
for git commit, git am and maybe other commands to accept trailers
arguments and pass them to git interpret-trailers.

In his email Junio seems to say that we don't need a shortcut like -z,
we could only have --trailer.
And I think that it is indeed sound to at least wait a little before
using up one shortcut like -z in many commands.

>> We could also allow many separators in the same -z argument as long as
>> they are separated by say "~",
>
> I think -z a -z r -z t is enough.

Great! I think you will likely have at least "--trailer a --trailer r
--trailer t", but I don't think it is too bad as you can use aliases
to make it shorter to type.

>> so you could have:
>>
>> git am -z "a: $ME~r: $ME~t: $ME" 0001-foo.patch
>>
>> And then we could also allow people to define default values for
>> trailers with something like:
>>
>> $ git config trailer.a.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
>> $ git config trailer.r.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
>> $ git config trailer.t.defaultvalue "Michael S. Tsirkin <mst@redhat.com>"
>
> I'm kind of confused by the key/value concept.

A "defaultvalue" would be the value used when no value is passed.
The "key" is just what we will use in the first part of the trailer
(the part before the separator).

For example with the above "defaultvalue" and "key", "--trailer a:
Junio <gitster@pobox.com>" would add:

Acked-by: Junio <gitster@pobox.com>

while "--trailer a" would add:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Can't I define the whole 'Acked-by: Michael S. Tsirkin <mst@redhat.com>'
> string as the key?

The whole 'Acked-by: Michael S. Tsirkin <mst@redhat.com>' is a full
trailer, not a "key".

And it is not possible right now to define a full trailer. Maybe we
could find a way to make it possible, but a default value and a way to
have a small nickname for the token (like "a" for "Acked-by") should
get people quite far. And then for very specific use cases, it may be
better to use aliases anyway.

>> So that in the end you could have:
>>
>> git am -z a~r~t 0001-foo.patch
>>
>> which is very close to "git am -s art".
>
> If I figure out the defaultvalue thing, I might
> find the time to work on git am integration.

That would be great!

Thanks,
Christian.
