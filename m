From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Using kdiff3 to compare two different revisions of a folder
Date: Wed, 13 Feb 2008 22:37:18 -0200
Message-ID: <b8bf37780802131637t1b7ec2e6he57919fdb7760050@mail.gmail.com>
References: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com>
	 <20080213174428.GN27535@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brian Downing" <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 01:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPS6t-0007Sy-Lc
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 01:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763771AbYBNAhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 19:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764707AbYBNAhV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 19:37:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:51608 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763762AbYBNAhT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 19:37:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so899510ugc.16
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 16:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DLrxHYzc2tSxxsUwxUUA9eKjoXixew3Ok3NtTfGDHMY=;
        b=XMtmQBBMgl3p5RvSNCNztTWoSFPEqw9+1VgpsX151zU9f0cKbu12Gpq/gmbE7mS9kxYuvMeHc396h3ed6vqZzRIF20RDGr3tIRnR8BoGG1EOkdbPQViJsLYeLBO3UONJ46OWrL+7LqmzaFsekV0Afx6OTXLufd2GC42qnHAv65c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dvXiX6tpqfREqdrpNEakPAPChVThd+qkaQJefyPe+G7z6WA3gl1E4hjWvA/p+GcQu13/7FiI8vqiqLRfB2dqd0OUIf6HQPDRrV4Xci4P48mCB+Lw6WyQjGowHzQbkYFqNMRiRzo8+K1AJJKXJXRPvUQw49I87gfrFe0Txw6u8MA=
Received: by 10.78.172.20 with SMTP id u20mr1307314hue.13.1202949438167;
        Wed, 13 Feb 2008 16:37:18 -0800 (PST)
Received: by 10.78.100.15 with HTTP; Wed, 13 Feb 2008 16:37:18 -0800 (PST)
In-Reply-To: <20080213174428.GN27535@lavos.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73833>

On Feb 13, 2008 3:44 PM, Brian Downing <bdowning@lavos.net> wrote:
>
> On Tue, Feb 12, 2008 at 11:44:07PM -0200, Andr=E9 Goddard Rosa wrote:
> >     I would like to use kdiff3 to compare some folder like "include=
"
> > between two different revisions.
> >     It would be something like "git diff v2.5:makefile HEAD:makefil=
e",
> > but for an entire folder.
> >
> >     Kdiff3 give me a quick glance of its nice graphical output of t=
he
> > differences, without have to resort to looking/parsing 'git log'
> > output.
> >     For now, easiest way for me is to keep my tree replicated in tw=
o
> > different folders pointing to different revisions then use it.
> >
> >     Is there a better way to do this kind of comparison?
>
> Maybe you want something like this?  This uses kdiff3 to compare two
> full commits, by extracting the changed files into a temporary locati=
on.
> Modifying it so it can work with path limiters and/or take arguments
> exactly like 'git diff' is left as an excercise for the reader.
>
> -bcd
>
> #!/bin/sh -e
>
> # usage: git-kdiff3 commit1 commit2
>
> SUBDIRECTORY_OK=3D1
> . git-sh-setup
> cd_to_toplevel
>
> O=3D".git-kdiff3-tmp-$$"
> list=3D"$O/list"
> trap "rm -rf $O" 0
> mkdir $O
>
> git diff --name-only -z $1 $2 > $list
>
> cat $list | xargs -0 git archive --prefix=3Da/ $1 | tar xf - -C $O
> cat $list | xargs -0 git archive --prefix=3Db/ $2 | tar xf - -C $O
>
> kdiff3 $O/a $O/b
>

Thanks a lot, it works like a charm! :)

--=20
[]s,
Andr=E9 Goddard
