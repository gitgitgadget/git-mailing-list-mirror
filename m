From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: http-push: double free or corruption (!prev): 0x09fedb50
Date: Sat, 28 Feb 2009 18:46:41 +0200
Message-ID: <94a0d4530902280846mcfd30b1ka4bef4efbfc3240b@mail.gmail.com>
References: <94a0d4530902241545h6781aefbne275f8017d65c8ee@mail.gmail.com>
	 <alpine.DEB.1.10.0902250912470.28808@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Sat Feb 28 17:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdSMI-0007A5-7m
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 17:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbZB1Qqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 11:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbZB1Qqq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 11:46:46 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:48714 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZB1Qqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 11:46:45 -0500
Received: by fxm24 with SMTP id 24so1461834fxm.37
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 08:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7yLKrcFmZiBXQJta4GsjO2kRZQZxLjJ0p1eE36AI3ts=;
        b=LSAGqbvNjqruS+s+xriHOYTjNydFq3PVHUgwEzkdsTF2gyLgz6bVrCKdEMWHGiJq67
         h/59Ab6Ec4FC8HgyCY5WYbhV7B6ekRph8oz2dZaEnoTCxeDQkWLYb9hP9H3Eshwl0ru2
         hh5SLY7p8s06KCG72316D4H9WIXxcKdstIV8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YJhiELpYzJvz4O04OSKngZdEQlUvUh7/Kb7mUeQ/Go9BDZnP7xYCV6IFG2osJSBPJ5
         8ShNixYRY6H/raHaQahYQxOQww/haNofzWjxQbIr+iB9htipKNKKsRu960sbuR3D7S1u
         D+U3FCia4nt6G8YWIZRqvsmVpEJyvS+f4zAR0=
Received: by 10.86.82.6 with SMTP id f6mr4459290fgb.42.1235839601558; Sat, 28 
	Feb 2009 08:46:41 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0902250912470.28808@yvahk2.pbagnpgbe.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111774>

Hi,

Hmm, you didn't CC me so I didn't see your message until now. In
general it's a good idea to CC people in case they are not suscribed,
fortunately this is not the case.

On Wed, Feb 25, 2009 at 10:18 AM, Daniel Stenberg <daniel@haxx.se> wrot=
e:
> On Wed, 25 Feb 2009, Felipe Contreras wrote:
>
>> I'm trying to push over https and I keep getting a crash. "curl -net=
rc
>> https://server/repo/HEAD" seems to work fine.
>
>> I'm attaching the output of valgrind and this is the backtrace (not =
on
>> the same run):
>
>> #6 =C2=A00x064d5b37 in PR_Free (ptr=3D0x0) at
>> ../../../mozilla/nsprpub/pr/src/malloc/prmem.c:490
>> #7 =C2=A00x00df72f8 in nss_ZRealloc (pointer=3D0x9fedb58, newSize=3D=
4096) at
>> arena.c:1076
>> #8 =C2=A00x00de579b in pem_CreateObject (fwInstance=3D0x8109ba0,
>> fwSession=3D0x810bac8, mdToken=3D0x8109cf8, pTemplate=3D0xbfffd6e4,
>> ulAttributeCount=3D4, pError=3D0xbfffd608) at pobject.c:1080
>
> [...]
>
>> Any ideas?
>
> You didn't mention what libcurl version you use, but clearly this is =
built
> to use NSS for the SSL layer so I guess you're using a Fedora-provide=
d
> library.

Indeed, Fedora 10; libcurl 7.18.2.

> There's already at least one NSS-libcurl-git related bug report[*] fo=
r
> Fedora submitted and I think you'll have a reason to follow that to s=
ee if
> you can help them or they can help you. To me this looks like at leas=
t one
> NSS bug.
>
> In the mean time I suggest you attempt a work-around: build a new lib=
curl
> powered by another SSL library such as OpenSSL or GnuTLS. It's just a=
 matter
> of running libcurl's configure with the proper command line

Yes, actually I did that and it works fine. For the record, the new
libcurl with NSS still crashes.

> [*] =3D https://bugzilla.redhat.com/show_bug.cgi?id=3D483222

Thanks.

--=20
=46elipe Contreras
