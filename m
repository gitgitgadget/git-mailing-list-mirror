From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Thu, 25 Sep 2014 12:04:48 +0200
Message-ID: <CAP8UFD0kfSBhSwu5Mb46XEHqYCE0SEsZd_3c0Sm4WzEc-NNc7w@mail.gmail.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
	<xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
	<xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
	<xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
	<20140618030903.GA19593@redhat.com>
	<CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
	<xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
	<20140922140144.GA9769@redhat.com>
	<CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
	<xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 12:04:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XX5uw-0002EW-Cg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 12:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbaIYKEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 06:04:50 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:43942 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbaIYKEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 06:04:49 -0400
Received: by mail-ig0-f172.google.com with SMTP id a13so8161980igq.11
        for <git@vger.kernel.org>; Thu, 25 Sep 2014 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HUojDS1/Wj1BGkBXFXg6kp3gIPajeMvdZrSIH52FuJE=;
        b=ubWqF7wJzPcayZXMUH8+BC0pU/dLxbQcoj+53ZDXWxYjPu86D+hUPLKtGwnDgJDeCW
         kKcNRw80HCtj2ZeO9GFr5GX75GRSPdkxWJwxOeJ2alsRBYceMxSJkTHwi0XqWMDudTVv
         ialc5MFADRDS3kq8CqyLRlbpDKzTKG8sBhyrKWEsO88XCKHbQHRiK1HHzkX99DtFJaDd
         5hvFSRPPIuds+Fm0y/kClJFdRU+yRYTHCC02eiPCzdxEAfxtI/wwO4wHhWyHIxssB7dI
         NppH55aak1GOZCzd5QziJs/VA+ngjlGN8iTJGlYEugJpAA5H3BgOrrRWJaz7HCBzxnhf
         BHxg==
X-Received: by 10.42.60.7 with SMTP id o7mr17594180ich.28.1411639488707; Thu,
 25 Sep 2014 03:04:48 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Thu, 25 Sep 2014 03:04:48 -0700 (PDT)
In-Reply-To: <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257474>

On Tue, Sep 23, 2014 at 7:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>
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
>
> If I understand it correctly, Michael is envisioning to implement
> his "git am -s art" (I would recommend against reusing -s for this,
> though.  "git am --trailer art" is fine) and doing so by using
> interpret-trailers as an internal implementation detail, so I would
> say the above is a perfectly fine way to do so.  An equivalent of
> that command line is synthesized and run internally in his version
> of "git am" when his "git am" sees "--trailer art" option using
> those am.{"a","r","t"}.trailer configuration variables.

Yeah, that's the idea, except that I think "--trailer art" should mean
a trailer like:

art: <default value>

(if there is no trailer.art.key config variable defined).

Having am.{"a","r","t"}.trailer configuration variables to define full
trailers seems too specific and quite confusing regarding how git
interpret-trailers work without those variables.

>> Also by using something like:
>>
>> $ git config trailer.a.key Acked-by
>> $ git config trailer.r.key Reviewed-by
>> $ git config trailer.t.key Tested-by
>>
>> the first command could be simplified to:
>
> So I think this mechanism buys Michael's use case very little, if
> any.  It might be useful in other contexts, though.
>
> What would be more interesting is if the primitives you have,
> e.g. "replace", "append", etc. are sufficient to express his use
> case and similar ones.  For example, when working on multiple
> trailers (e.g. "am --trailer art" would muck with three kinds), how
> should "do this if exists at the end and do that otherwise" work?

The way the "trailer.<foo>.ifexists" and "trailer.<foo>.where" work is
quite orthogonal to the way we decide what the content of the trailer
is.
If we make "--trailer art" mean "--trailer Acked-by: Michael --trailer
Reviewed-by: Michael --trailer Tested-by: Michael", then it should
work as if we had passed the latter to the command line.

> To an existing message ends with Michael's Signed-off-by:, if his
> "git am --trailer arts" is called to add these three and then a
> Signed-off-by: from him, should it add an extra S-o-b (because his
> existing S-o-b will no longer be the last one after adding Acked and
> others), or should it refrain from doing so?  Can you express both
> preferences?

The default for "trailer.where" is "end", and for "trailer.ifexists"
it is "addIfDifferentNeighbor".
That means that by default it will add the four new trailers at the end.

If either "trailer.ifexists" or "trailer.S-o-b.ifexists" is set to
"addIfDifferent", then only the first 3 new trailers will be added at
the end. So yes you can express both preferences.

> Another thing that got me wondered this morning while I was thinking
> about this topic was if "replace" is flexible enough.  We may want
> to have "if an entry exists (not necessarily at the end), remove it
> and then append a new one with this value at the end" to implement
> "Last-tested-by: me@my.domain", for example.

That's what "replace" does already. That's why I changed the previous
name for this option from "overwrite" to "replace". You have an
"overwrite behavior" with where = after and ifexist = replace, and you
have a "remove old one and append new one behavior" with where = end
and ifexist = replace.

Thanks,
Christian.
