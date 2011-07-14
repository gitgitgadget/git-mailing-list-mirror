From: John Szakmeister <john@szakmeister.net>
Subject: Re: Nesting a submodule inside of another...
Date: Thu, 14 Jul 2011 05:36:46 -0400
Message-ID: <CAEBDL5VUPE9YCX1C4pqkjb+EODkAWo9h774B=Jv5eUNbocMuZQ@mail.gmail.com>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
	<4E1C9F21.6070300@web.de>
	<CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com>
	<4E1E0C27.60903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 14 11:37:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhIMD-0007zI-O2
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 11:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab1GNJgs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 05:36:48 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:60711 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab1GNJgr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 05:36:47 -0400
Received: by fxd18 with SMTP id 18so862239fxd.11
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rmi/0wZX/s3ucw8riTJwksF9/N6PIEkRaGVsa9hQ/N0=;
        b=cdGSPGSFRND2140uA4vlrE4ube0xW7yZFR0Vyf7rNVjJsnA69TNJIdm1D7xV56p4E+
         CQ3Kc2ebFoIqDJFdci8ym0jxn8Qn7eifQLnuxQ37tmG4KVpBLjx6LS+cNsI4ShxoIBgg
         8uJGq60+ppIj9fzyyl8S+iCqBc+uSuU3vzqHE=
Received: by 10.223.50.131 with SMTP id z3mr3235291faf.127.1310636206543; Thu,
 14 Jul 2011 02:36:46 -0700 (PDT)
Received: by 10.223.30.68 with HTTP; Thu, 14 Jul 2011 02:36:46 -0700 (PDT)
In-Reply-To: <4E1E0C27.60903@web.de>
X-Google-Sender-Auth: ys3qqiz45JWLiXHkXX06FJ0gAjI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177106>

On Wed, Jul 13, 2011 at 5:20 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 13.07.2011 03:21, schrieb John Szakmeister:
[snip]
>> I guess I still don't see how that's a problem. =C2=A0It seems to me=
 that
>> for the superproject the ignore rule needs to be:
>> =C2=A0 ignore framework1, except framework1/module
>
> But that would mean the superproject would have to scan framework1's
> work tree for changes too, which is conflicting with the idea that ea=
ch
> submodule is a repo of it's own, so that won't fly.

I guess I just don't see that.  Even though the path is inside of a
submodules, it would be part of the superproject's work tree.  But, I
can see how it's a violation of a submodule being a repo of it's own.
And I certainly understand the desire to maintain that quality.

>> And then it could check its status. =C2=A0Of course, framework1 woul=
d
>> somehow need to know to ignore it... and I'm not sure how that can b=
e
>> communicated.
>
> It can't be communicated, as submodules are unaware of their superpro=
ject.
> And adding module manually to framework1's .gitignore is just a probl=
em
> waiting to happen. Having a file or submodule in the work tree of one
> git repository being referenced by another is just asking for trouble=
 ...

Again, I don't see how the submodule needs to be aware of the
superproject.  In this case, it'd be the responsibility of the
superproject to setup whatever is necessary at 'git submodule
init/add'.  I don't see how the submodule *must* know about the
superproject for it to succeed.  I see the opposite, the superproject
needs to communicate some information down to the submodule, but I
don't see the reverse.

What I'm hearing is that while it may be possible, the idea of
violating the concept that the "subrepo is standalone" is
unacceptable.  Which means, unfortunately, git isn't a solution for us
in this case.

[snip]
>> I'm using 1.7.6rc3. =C2=A0I updated to the latest trunk and still ge=
t the same error:
>>
>> :: git submodule add $PWD/../c b/c
>> The following path is ignored by one of your .gitignore files:
>> b/c
>> Use -f if you really want to add it.
>
> You're right, the error message of "git submodule add" should be bett=
er
> here.

I'll write a patch for this.  Thanks.

And thanks for the input.  I was just looking to see if there were any
technical/morale reasons that submodules weren't allowed in this way.
I appreciate you all taking the time to answer.

-John
