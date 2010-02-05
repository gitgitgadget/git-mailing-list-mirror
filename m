From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: notes TODOs (was: Re: [PATCH 1/4] gitweb: notes feature)
Date: Fri, 5 Feb 2010 17:58:02 +0100
Message-ID: <cb7bb73a1002050858q3c13862ybe41fe3a9e14b705@mail.gmail.com>
References: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com> 
	<201002051546.19406.johan@herland.net> <201002051627.05182.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 17:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdRVp-0002pq-Mb
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 17:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab0BEQ6Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 11:58:25 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:44076 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415Ab0BEQ6X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 11:58:23 -0500
Received: by ewy28 with SMTP id 28so183106ewy.28
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nYoHGnyYal8Tu9tTNZVYC7aTpTtnPZRghHHsRBRMHUs=;
        b=eigS2rni+Gc5ZOjHZQq9kUZYi+jh10sGj5+Vv5QJCTrJKUB2avnkRj5n1ZjvvCWVbN
         DfhDQZl5bpiwRuaKxGIRJ/mxUPEc7+DKJ+64xDmxAt25l/IUVPdGN1vijvbb4X4+apwh
         9Yh8W9fqTjivpbLXrBAMfsWQ1R3SlT9onkFCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Twwz53aIz9G8ydoeSGN3/ih4n4lDkN72JiobjNM1x5nuX16l1q1IX7KquhP8ulwboG
         IYQHlX9of12/uRTXjeYTBYAzLcmx0yE2Hxel1F9r8knUjtwPG8rmxuodGJo+Whghz09h
         X3XYzliBmwt+xNIDSd9TI15ZZejQDX0N9V3GQ=
Received: by 10.213.109.217 with SMTP id k25mr2525486ebp.88.1265389102152; 
	Fri, 05 Feb 2010 08:58:22 -0800 (PST)
In-Reply-To: <201002051627.05182.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139060>

On Fri, Feb 5, 2010 at 4:27 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Fri, 5 Feb 2010, Johan Herland wrote:
>> On Friday 05 February 2010, Giuseppe Bilotta wrote:
>
>> > If I may be allowed to add a suggestion to put in the list, I woul=
d
>> > like to see notes attachable to named refs (branch heads in
>> > particular). From a cursory reading of your patches currently in p=
u
>> > it would seem that you explicitly prohibit this case currently.
>> > However, this has many possible uses, ranging from longer branch
>> > descriptions to tracking information to improve survival in case o=
f
>> > remote rebases.
>>
>> Nope. There is no explicit prohibition on anything. On a fundamental
>> level, Git-notes simply maps a given SHA1 (the annotated object) to
>> another SHA1 (the object holding the annotation itself). In principl=
e
>> you can annotate _any_ SHA1, it doesn't even have to exist as a git
>> object!
>
> I guess that it isn't currently possible to map _path_ (here: fully
> qualified name of ref, i.e. "refs/heads/master" in example) to SHA1
> rather than SHA1 to SHA1, as fan-outs assumes mapping of SHA1 (to
> object).
>
>>
>> In fact, something like the following abomination should solve
>> your "problem" quite easily:
>>
>> =A0 git notes add $(echo "refs/heads/master" | git hash-object --std=
in)
>>
>> (...washing my hands...)
>
> This actually annotates (existing or not) _blob_ object with
> "refs/heads/master" as contents (git-hash-object defaults to -t blob)=
=2E

Well, it still might work assuming the git tools know that they have
to look for these notes too when looking notes up. If we tolerate the
funky failure in the unlikely case of a file whose content matches a
ref name, it could be used to implement the feature without having to
remove the assumption that notes pretargets are SHA1. I do believe
that removing that assumption would be a smoother way to go, although
I have no idea how hard it would be to implement.

>> > And one last comment: how do notes behave wrt to cloning and remot=
e
>> > handling? Am I correct in my understanding that notes are
>> > (presently) local only? Would it make sense to have them cloned to
>> > something like the refs/notes/remotes/* namespace?
>>
>> They are no more local than any other ref, except that they are
>> outside the refspecs that are "usually" pushed/fetched (refs/heads/
>> and refs/tags/).
>>
>> =A0 =A0 =A0 git push <remote> refs/notes/<foo>
>> =A0 =A0 =A0 git fetch <remote> refs/notes/<foo>[:refs/notes/<foo>]
>> =A0 =A0 =A0 etc.
>>
>> should all work as expected.
>
> It would be nice, but I guess not possible, to have notes autofollowe=
d
> on fetch, like tags are autofollowed...

Tags have the idiosincracy of living in the same namespace regardless
of where they come from, and I believe there a little too high a risk
of conflicts to do this with notes too. It might make sense to add a
default fetch of +refs/notes/*:refs/notes/remotes/<remote>/*, but the
real question is what would pushing do, in case of conflicting notes.

--=20
Giuseppe "Oblomov" Bilotta
