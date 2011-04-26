From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: Folder Git
Date: Tue, 26 Apr 2011 17:03:44 +1000
Message-ID: <BANLkTin5JV3WSMDvA3E-oJUMCxsy8uByhw@mail.gmail.com>
References: <BANLkTim=xKxN9JovToVuOg=SQ2Mba1LvxQ@mail.gmail.com>
	<BANLkTimnyv_+NCc3yOSswJeqHo_zsGwCDA@mail.gmail.com>
	<BANLkTikkFgCQP9DA5VwMCMzDCiTnEENvOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEcJK-0001Jy-A6
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 09:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757488Ab1DZHDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 03:03:45 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50601 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab1DZHDp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 03:03:45 -0400
Received: by vxi39 with SMTP id 39so276551vxi.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Dqho3ilo1Pxhdv2bPBOy1UFjPtppJ//UQYmXi7BOR3s=;
        b=vvqct8uNjgCn7r4oVH9Hxzy1CiswGE0EvSozb0vE3qqp2dV+ga/1sa9S7DzUli3yT1
         Aa3mMHc6Z8U0CliQlrUnikmLegWKDY8LojkLLdLHxjGF2MHdPZ97V5hRtTGjedLYsGWK
         mQAVkA8Qpr68Z4H8siMpnua7kpVVnLLo6AQik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U4INWXPTC2qKm8cS4L/fMsJpWxXmmA+vW2sQze+bRjLIb3ot6GwGxqOh7yUwm/4xck
         DR4LtGNGRHrsWZfecUdxFyBRhQiN65CIbmhIXg11alcgAxzdNh4KiOsa0Utopbgr+9mG
         TJBzFisZpLMjtjNwMrhejC6F5Yqy7HiaJ26Vg=
Received: by 10.52.95.108 with SMTP id dj12mr660279vdb.39.1303801424454; Tue,
 26 Apr 2011 00:03:44 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Tue, 26 Apr 2011 00:03:44 -0700 (PDT)
In-Reply-To: <BANLkTikkFgCQP9DA5VwMCMzDCiTnEENvOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172071>

A concept I played with at one point was to have the idea of a working
set, which is a list repos.

You could then apply to the whole working set any command after
changing to the root directory of each repo, much like git submodules
does, but without any suggestion of any other relationship between the
repos.

The details working set were stored in the global git configuration.

In principle, you could have multiple working sets and switch which
one was active at a given time.

So, you'd do something like:

git working-set foreach {cmd} {args...}
git working-set activate working-set-name
git working-set add repo-url
git working-set remove repo-url

and so on...

jon.

On Tue, Apr 26, 2011 at 4:47 PM, Victor Engmark
<victor.engmark@gmail.com> wrote:
> On Mon, Apr 25, 2011 at 10:52 AM, Jon Seymour <jon.seymour@gmail.com>=
 wrote:
>> On Mon, Apr 25, 2011 at 6:32 PM, Victor Engmark
>> <victor.engmark@gmail.com> wrote:
>> continue to other repositories.
>>>
>>> Issues:
>>> * Don't know if anyone else has used it. Probably not, so there's
>>> bound to be issues (especially since it's been changed quite a bit =
the
>>> last couple days for this RFC).
>>>
>>
>> Victor,
>>
>> Certainly seems like a common need. I had a similar solution which I
>> used for a while.
>>
>> In the end, however, I found that creating a super-module in the top
>> directory that contains
>> the other git directories as git submodules allowed me to use a
>> standard feature of git to achieve the same effect.
>>
>> So:
>>
>> =C2=A0 =C2=A0git submodule foreach git gc --aggressive
>>
>> I know this won't suit every use case, but it does work in an
>> environment where the set of repos you are operating on have a degre=
e
>> of coherence and it makes sense to set up a submodule for them. =C2=A0=
In
>> this particular case this is the only reason why I use submodules - =
I
>> don't use them for configuration management, for example, simply as =
a
>> handy way to exploit git submodule foreach.
>>
>> Have you considered using git submodules in this way?
>
> I didn't know you could use them this way, and it's a nicely "Gitonic=
"
> way of doing it. I don't think this would fit my case, since the repo=
s
> are not much related and it's a more verbose solution which takes
> longer to set up than copying a single script. A compromise could be
> to set up a Git alias `sgit=3D"git submodule foreach git"`, if that'l=
l
> work as expected.
>
> --
> Victor Engmark
>
