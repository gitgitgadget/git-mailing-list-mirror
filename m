From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: Efficient cloning from svn (with multiple branches/tags subdirs)
Date: Thu, 15 Oct 2009 19:29:58 +0200
Message-ID: <28c656e20910151029s2e053f75q56e968f313d12b21@mail.gmail.com>
References: <hb2fvu$8qi$1@ger.gmane.org> <20091014060307.GA17178@dcvr.yhbt.net>
	 <32541b130910140928jdac0187x754423e8d5c64e53@mail.gmail.com>
	 <20091014180013.GA24741@dcvr.yhbt.net>
	 <32541b130910141126u4df7f439i3d2926c2e1db9497@mail.gmail.com>
	 <4AD75A93.9050106@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Thu Oct 15 19:37:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyUG0-0007by-DU
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 19:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935149AbZJORah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2009 13:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935138AbZJORah
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 13:30:37 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:41680 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933532AbZJORag convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Oct 2009 13:30:36 -0400
Received: by ewy4 with SMTP id 4so770265ewy.37
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z6KdVqLoGYNj2Ep04yrlB2iNU+0PPKsoRPQgXiDJSKE=;
        b=eQ9VRuc3JALVCvZlexKp5zcDQiVeAFoWOJGPZ+Y3ttA3WWG/GMoKX9qi+HA0vxPCFh
         YBTWBks2yHcoyzdGuE0UbLYaJyel4CVCJE12pY0zQvwEHocI8UVPU+cizYZMBBqxj0Wy
         F0q4Q4nwU4EHDpUiTrWeRHKEa37YSS2hjVt4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K/QCdNIpbvV0NE2AJco+25ZolXf8EhCGVNI+Eb6fHNCTLsJDCyr2EDhvPcFK7qK/60
         SDJJtqTJSAQjmjRhCbEZg7tfWpB0zC83ePpJ5zIodlj8k84b2G9cGLA9eTAiZTNyo3LU
         sOpNRH/mxHVZc84bmEWDLO1Ks50770zFLK/iU=
Received: by 10.211.157.11 with SMTP id j11mr9325353ebo.63.1255627799160; Thu, 
	15 Oct 2009 10:29:59 -0700 (PDT)
In-Reply-To: <4AD75A93.9050106@manchester.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130405>

On Thu, Oct 15, 2009 at 19:23, Bruno Harbulot
<Bruno.Harbulot@manchester.ac.uk> wrote:
> Hello,
>
> Avery Pennarun wrote:
>>
>> On Wed, Oct 14, 2009 at 2:00 PM, Eric Wong <normalperson@yhbt.net> w=
rote:
>>>
>>> Avery Pennarun <apenwarr@gmail.com> wrote:
>>>>
>>>> I've been thinking about this myself for some time. =C2=A0One opti=
on that
>>>> might be "interesting" would be to just grab the *entire* svn tree
>>>> (from the root), and then use git-subtree[1] to slice and dice it =
into
>>>> branches using your local copy of git (which is fast and uses no
>>>> bandwidth) instead of during the svn fetch (which is slow and uses
>>>> lots of bandwidth). =C2=A0I think it would also simplify the git-s=
vn code
>>>> quite a lot, at least for fetching, since there would always be a
>>>> global view of the tree and SVN things like "copy branch A to tag =
B"
>>>> would just be exactly that.
>>>
>>> This was actually the original use case of git svn back when I star=
ted.
>>>
>>> =C2=A0git svn clone SVNREPO_ROOT =C2=A0 (without --stdlayout)
>>>
>>> It's still an option if you have the disk space for the working cop=
ies,
>>> but I had to create the branches/tags support since the working cop=
ies
>>> would be become prohibitively large. =C2=A0If git-subtree could be
>>> taught to work on a bare repo (git svn has a --no-checkout option)
>>> it might be an option, too.
>
> Thank you for your suggestions. Unfortunately, I'm not really familia=
r with
> git-subtree and how it could work with git-svn, sorry.
>
> I've tried another workaround: using svnsync to pull the repository o=
nly
> once, and only then using git-svn fetch, locally, so as to avoid too =
much
> network traffic (I don't mind too much if it loops locally). I was ho=
ping to
> be able to change the URL of the repository to the original one after=
wards,
> but it doesn't seem to work so easily, because of the commit IDs. I'm
> assuming not having the same will cause problems for further fetches =
(this
> time directly from the original SVN repository) and for potential dco=
mmits.
>
> When I do this:
> =C2=A0git init
> =C2=A0git svn init -s --prefix=3Dsvn/ file:///path/to/local/restlet-s=
vnroot
> =C2=A0git svn fetch -r 1:2
>
> I get this ID, for example:
> =C2=A0r2 =3D c69a0b98d288a6e4e8779b50962b7fc65c4622e8
>
> If I do this using the original http://restlet.tigris.org/svn/restlet=
, I get
> this:
> =C2=A0r2 =3D ce3b82915e92fe1ccf6ddedacd9d74b30bd4de86
>
>
> I've even tried to install a Apache-based subversion server locally a=
nd make
> it believe it was restlet.tigris.org (by editing /etc/hosts and creat=
ing the
> appropriate VirtualHost), but this generates another SHA1 ID. (That's=
 of
> course not a solution that would be generalisable.)
>
> I've had a quick look at the git-svn code to see how this ID was gene=
rated,
> but couldn't find anything obvious.
> I realise this isn't the cleanest approach possible, but any suggesti=
on
> would be appreciated.

When I 'git svn clone' from a svnsync mirror I pass
--use-svnsync-props. Have you tried that?

// Ben
