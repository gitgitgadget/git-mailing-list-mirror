From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH/resent 0/9] Sparse checkout (first half)
Date: Wed, 1 Oct 2008 16:38:56 +0200
Message-ID: <adf1fd3d0810010738j21a6432foef3758fc7ed1cb1f@mail.gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
	 <adf1fd3d0810010320v340230f0jb443bafc1ef05d6f@mail.gmail.com>
	 <adf1fd3d0810010425r145396b0t52cf883576da8bbd@mail.gmail.com>
	 <fcaeb9bf0810010509m4d2045e4qcc2a887c180a787@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:41:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl2s4-0007iP-2n
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 16:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbYJAOi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 10:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbYJAOi6
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 10:38:58 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:54324 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYJAOi6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2008 10:38:58 -0400
Received: by gv-out-0910.google.com with SMTP id e6so109783gvc.37
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 07:38:56 -0700 (PDT)
Received: by 10.103.225.11 with SMTP id c11mr5911623mur.32.1222871936124;
        Wed, 01 Oct 2008 07:38:56 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Wed, 1 Oct 2008 07:38:56 -0700 (PDT)
In-Reply-To: <fcaeb9bf0810010509m4d2045e4qcc2a887c180a787@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97225>

On Wed, Oct 1, 2008 at 2:09 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On 10/1/08, Santi B=E9jar <santi@agolina.net> wrote:
>> On Wed, Oct 1, 2008 at 12:20 PM, Santi B=E9jar <santi@agolina.net> w=
rote:
>>  > Not in this half but I've seen that you added a --default-sparse =
flag
>>  > to "git clone". I think it is useless as mostly always the one gi=
ven
>>  > in -sparse-checkout should be used.
>>
>>
>> To be more precise, whenever you do "git clone --sparse-checkout" yo=
u
>>  will want it to be the default sparse pattern.
>
> Yes, if only the default pattern gets updated properly when you updat=
e
> your checkout area.

I don't parse this sentence, but I cannot see the connection between
the default sparse pattern for _clone_ and updating it or the working
area.

> If "git clone --sparse-checkout" makes the default
> pattern, then "git checkout --reset-sparse" should reset the default
> pattern as well.

Makes sense.

> The hard part is how to update default pattern with
> --include-sparse and --exclude-sparse.

Maybe you could let the core.defaultsparse be defined multiple times.

[core]
        defaultsparse =3D Documentation/*
        defaultsparse =3D t/*
        defaultsparse =3D !t/*svn*

equivalent to

[core]
        defaultsparse =3D Documentation/*:t/*:!t/*svn*

but it moves the complexity to the parsing of the config.

> Also, people can use "git
> update-index" to update checkout area, which should not touch default
> pattern at all.

I would prefer having a --not-update-sparse-pattern.

The most common workflow should be the most straightforward. The most
common use-case would be somebody working _only_ in some subdirectory
(say Documentation), then what s/he normally does is:

1) cloning and default sparse chechout:
  $ git clone --sparse-checkout=3DDocumentation/* ...
  or within an existing wd
  $ git checkout --reset-sparse=3DDocumentation/* ...
  (maybe just --sparse?)

2) Work normally inside the Documentation directory...

3) Abort a merge with conflicts outside the sparse area:
  $ git reset --hard ORIG_HEAD)
  <Now there are files outside the default sparse area>
  $ git checkout --reset-sparse # with --sparse to set the sparse patte=
rn

Including/excluding more paths in the default sparse checkout is not
something you would do normally, but I think it makes sense to add
them to the default pattern.

Please correct me if you think there are other use-cases, or more
things in my use-case.

> Maybe just throw a warning when default pattern no
> longer matches the checkout area, then let them decide.

Sure, and inform in the "git status" that you are in a sparse checkout.

Best regards,
Santi
