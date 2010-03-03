From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Tue, 2 Mar 2010 23:26:36 -0500
Message-ID: <ca433831003022026pbc172d6ocb5ff2aefe29f462@mail.gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> 
	<1267246670-19118-5-git-send-email-lodatom@gmail.com> <4B890572.5040604@lsrfire.ath.cx> 
	<ca433831002281214q14e6e62bj54cf7227cd32873b@mail.gmail.com> 
	<b4087cc51002281426m126a0c07l9f4a38088d0146b1@mail.gmail.com> 
	<ca433831003011749h43293f80kd4ec18bd796dea7c@mail.gmail.com> 
	<4b8cb38b.870fcc0a.7ebc.1a83@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 05:27:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmgAu-00067C-4B
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 05:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab0CCE06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 23:26:58 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41201 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab0CCE05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 23:26:57 -0500
Received: by gwb15 with SMTP id 15so535802gwb.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 20:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=m2hjoJ9v4b/uIf2tYc9ovU047KJxhiF63s+w/AlxV+c=;
        b=aszpZ1LfiKg0gClwDT5cY27t0emBKHt1l23+gnEV9RxvF1jiHeHukEknDnmiGEdh+B
         HtkHCIBilxUjYEjMb69I8wd6/RiRPojByzpq5jgSq83AYp2/eDBuu2tqxCPCxAI4nC7+
         pqAjjMAq34MPFdRBNSA31FNj93PC3ILBhOsGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FtInGAzobot+4bg4JzO2/DLhZ9sgZA3YKi25twKJESNifPQKXekk3lZxtPr/rmkHDf
         Rw2LOHJdDrROITXhq6P13UjPpEKOJ94crXBFtMUJaaBjhVtYsXMPWMAKLTq/a3F8eGSc
         YdK7zHutcYWS6lh+Bv/7wAq03sT9ZPDfHEGso=
Received: by 10.91.137.19 with SMTP id p19mr6258431agn.57.1267590416231; Tue, 
	02 Mar 2010 20:26:56 -0800 (PST)
In-Reply-To: <4b8cb38b.870fcc0a.7ebc.1a83@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141435>

On Tue, Mar 2, 2010 at 1:43 AM, Michael Witten <mfwitten@gmail.com> wro=
te:
>> By the way, the default should be 'always', not
>> 'auto', to be consistent with GNU tools, and to be backwards
>> compatible with the old --color behavior.
>
> Well, I've got:
>
> =C2=A0 =C2=A0GNU grep 2.5.4
>
> and the default for a plain `--color' seems to be `auto', whereby
> colorization is turned on when stdout is attached to a tty capable
> of color, but turned off otherwise:

Sorry, that was my mistake about GNU grep.  However, GNU ls (coreutils
7.4) defaults to 'always'.  So, GNU tools are not consistent in this
regard.  Furthermore, the current behavior of all git tools is to make
--color turn on color always, so I imagine you would have to make an
extremely compelling argument to break backwards compatibility.  I'll
add that this behavior makes the most sense, since most folks who use
color have done `git config color.ui auto'.  This is why no one have
created this patch until now.  The [=3D<when>] part is nice, but the gi=
t
config infrastructure usually obviates the need for --color=3Dauto.

> Firstly, note that GNU understands a wide set of option arguments:
>
> =C2=A0 =C2=A01: always , yes , force
> =C2=A0 =C2=A00: never =C2=A0, no =C2=A0, none
> =C2=A0 =C2=A02: auto =C2=A0 , tty , if-tty

I guess this is okay, but I don't see a need for it.  If we allow
these other synonyms, then we'll have to support them forever.  I say
just stick with always/never/auto for now, and we could add the others
later if there's a big demand.

> In my opinion, Git grep should follow GNU grep's conventions, not
> only to be consistent, but also because they are better.

It is more important to be consistent with the other git tools, so
that is why --color is a synonym for --color=3Dalways.
