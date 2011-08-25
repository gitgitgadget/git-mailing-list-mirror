From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: master-master server setup
Date: Thu, 25 Aug 2011 21:36:18 +0530
Message-ID: <CAMK1S_gKrOqY1xrsQi4hQLc85yAD0NW+wJxJ31HwRQMuY9A9sA@mail.gmail.com>
References: <loom.20110824T191218-282@post.gmane.org>
	<1314210406.14580.6.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>,
	Corey Mitchell <cmitchell@cctus.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 18:06:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwcRj-0003S7-Tq
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 18:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470Ab1HYQGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Aug 2011 12:06:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39111 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab1HYQGS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 12:06:18 -0400
Received: by vws1 with SMTP id 1so2111757vws.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/cOut/o9DvYgUpnxelX+g84nWji8CjHGdr/ISPwfToY=;
        b=I9cL08pV1s25IHq1ia7053Ry7Tz2MzU3mjeFUBjLMIUBYhw9OGKIztVJUdmBNjymcc
         cCs/wTYkwQ/of+ssErNZIga148jkAkksIx0gr+uUCfPfvtoJ82PypR7t11sskNKm9a+A
         vf8ndzoNCUAEoec80eFafYP9zXGCzJ3odfn+o=
Received: by 10.52.71.141 with SMTP id v13mr6809887vdu.338.1314288378042; Thu,
 25 Aug 2011 09:06:18 -0700 (PDT)
Received: by 10.52.6.131 with HTTP; Thu, 25 Aug 2011 09:06:18 -0700 (PDT)
In-Reply-To: <1314210406.14580.6.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180086>

[Thanks Drew!]

Corey,

On Wed, Aug 24, 2011 at 11:56 PM, Drew Northup <drew.northup@maine.edu>=
 wrote:
>
> On Wed, 2011-08-24 at 17:14 +0000, Corey Mitchell wrote:
>> Hello Git team,
>>
>> We have a distributed team (US and Japan). =C2=A0We are thinking abo=
ut migrating from
>> subversion to git because it better suits our distributed team. =C2=A0=
Due to network
>> latency, we want to setup 2 git servers hosting the same repository.=
 =C2=A0We want
>> developers to be able to download and publish branches to their loca=
l server and
>> then have those changes replicated to the other site. =C2=A0Is this =
possible? =C2=A0Can
>> someone please explain how this setup is done? =C2=A0If not, can som=
eone please
>> explain the closest alternative and how it is setup?
>
> Corey,
> If you choose to use gitolite, then you can just use Sitaram's
> instructions here:
> http://sitaramc.github.com/gitolite/doc/mirroring.html

The code for all this is in the "mirroring-revamp" branch, by the way,
although I hope to shortly bump it into pu (see below).

> If nothing else, you might find it inspirational.

Considering I spend more time on the docs than on the code, I sure
hope it's at least that ;-)

I'm currently at one of my $DAYJOB's other cities, setting up an
11-way mirrored gitolite setup for some colleagues in a different
business unit.  They have about 80 repos spread across 6 or 7 cities,
which different repos being "mastered" at different cities.

Some of them have 2 slaves, most have 1.  Of those that have 2 slaves,
only one needs the push *immediately* reflected.  All of them have to
send to a specific "backup" server sometime at night so that's like an
extra slave, though developers are not expected to hit it so it
doesn't need any authorisation information..

Some have enough developers that for convenience reasons they would
like to have the developer push to the (local) slave and have the
slave internally redirect the push to the real master, without the
developer having to know where the real master is and having to
configure his push-remote correctly.  For developers who're working on
multiple projects, with some of them mastered in one city and some in
another, this is great.  (I must warn that this feature is only useful
when all the servers trust each others authentication, because that
gets done at the slave site where the user hit, and authorisation is
done on the real master taking the push).

Note that this does no do exactly what you said, but probably comes
close enough in some sense.

So anyway it's been fun.  We're halfway there, and no problems so far.
 Once this is up and running for a few days I will merge it into pu.

regards

sitaram
