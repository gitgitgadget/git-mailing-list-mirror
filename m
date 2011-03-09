From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git fast-import : How to change parent during import?
Date: Wed, 9 Mar 2011 14:21:05 +0000
Message-ID: <AANLkTin-Zpk1mZ4hWy1HVL68a0qFjv=8Gne3FBNH8nio@mail.gmail.com>
References: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
 <20110308024427.GA21471@elie> <AANLkTini6NgeYxRdFtSDKe8GEEszDvXwRtLnuymiRNt4@mail.gmail.com>
 <20110308222328.GE26471@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 15:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxKGr-00076z-96
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 15:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739Ab1CIOVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 09:21:38 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48074 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab1CIOVh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 09:21:37 -0500
Received: by vws12 with SMTP id 12so480826vws.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=HaN7iq1odltzGwpd4I546qFUWEIzWInfbycyeFivsV4=;
        b=Qhv3cIq0x8y1HXuUwXPgXC2o4A5a54RTanZX1P/wYMhItM9aZSn6gisNfmbRfFteoi
         h4Iv48a65HZxLJB7K7+h4fxffDlUAQIn1oe1nlMrGfI6lL1/eilDTj5yr5Y0HDaxztnh
         VJS/JZutnmLP1k/frcIYcDA9TUqi8EIeUXAQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xySRa7mzwnUGp+yDbsEjvkwOsfJEUcYvQJZydV1kTck/YWv8g94NEp6b/gsJ5wotp1
         VieGCIK897C6glVknyWzZ3cjaVlj/cKKrUo/EO8yjXg8OcyLbOwM3xu0GGP8UjNWlb6M
         OMiET/0rExtOek6iXQgmEqmrBx9bA6ZUj8NR4=
Received: by 10.52.0.169 with SMTP id 9mr303989vdf.303.1299680496140; Wed, 09
 Mar 2011 06:21:36 -0800 (PST)
Received: by 10.220.178.130 with HTTP; Wed, 9 Mar 2011 06:21:05 -0800 (PST)
In-Reply-To: <20110308222328.GE26471@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168733>

Hi Jonathan,

On Tue, Mar 8, 2011 at 10:23 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> It's likely I misunderstood what you're trying to do. =A0If you have
> some work in progress, I'd be glad to look at it.
>
> Anyway, concerning tag fixup branches: git://repo.or.cz/cvs2svn.git
> has an example in cvs2svn_lib/git_output_option.py::process_tag_commi=
t.
> The idea is to make commits that don't belong to any branch on a
> separate TAG_FIXUP ref, using the "reset" command where appropriate;
> then the resulting commits can be inspected, merged, reset to, or use=
d
> in some other way later.
>
> The "tag fixup" idea is that in VCSes like CVS, tags do not
> necessarily match the content on any branch. =A0So the history looks
> somewhat like so (time flowing left to right):
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TAG
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> =A0o --- o --- o --- o --- o --- o ...
>
> instead of the perhaps more sensible
>
> =A0o --- o --- o --- TAG --- o --- o ...
>
> The side branch leading up to a tag does not correspond to any branch
> name; after it is in the correct state one can use the "tag" command
> to get it remembered in permanent history. =A0The same technique migh=
t
> be useful whenever you are creating history that is not meant to stay
> permanently on any branch.

I think I understood the idea behind TAG_FIXUP and I think it can be a
better solution for my problem. I could make the commit into
TAG_FIXUP, search for a better parent in the source branch and then
reset it to that parent or rebase it over any other commit. I'll try
to do this in the following days, so I will most likely come back with
more doubts :)

Thanks,
--=20
Vitor Antunes
