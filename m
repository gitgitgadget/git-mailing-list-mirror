From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] for-each-ref: remove multiple xstrdup() in 
	get_short_ref()
Date: Tue, 7 Apr 2009 09:54:23 +0200
Message-ID: <36ca99e90904070054y3bbd21e0g44548162e71f3a13@mail.gmail.com>
References: <20090407070254.GA2870@coredump.intra.peff.net>
	 <1239089599-24760-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090407074435.GB7327@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:55:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6A0-0006P6-Dm
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbZDGHy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 03:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbZDGHy1
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:54:27 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:57241 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbZDGHy0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 03:54:26 -0400
Received: by bwz17 with SMTP id 17so2181005bwz.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zeygc2jHG0GCOg3i4dAyBhA7ZdVh/kMrNsQvZ5ow76U=;
        b=FGT4TdN0XpdxL0OX7g1/v5NZCIqMJVikZk2lXodMA20jNPwkzniKntC4rxSdiAT1+U
         dc/XgGEe4D/eMUgQaksVGmTGDcUR7+hAS1gT4Kvf+TblHRrQ7W/RpnBOxV8A6BLkLng5
         OvT7nXELCOt7+F/p+fvh/m/Vb9LPelVd/k83c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L4DvPyTU+EE7yYd764jKANJSel5Kah2fLyyIIUCWflXSfd06ezh1Nt84IBvTEu0R0q
         oLd6ncrtpi4Tr5of9rHPOAXgd7ChoLnLCvR5WiAJIJAC2aO3lQMDaiAXR29TR61b8U/H
         IB2M4d4NQ8emzNV65+pzbsa+bkCOFb6vxIsN0=
Received: by 10.204.76.129 with SMTP id c1mr2479929bkk.9.1239090863769; Tue, 
	07 Apr 2009 00:54:23 -0700 (PDT)
In-Reply-To: <20090407074435.GB7327@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115924>

On Tue, Apr 7, 2009 at 09:44, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 07, 2009 at 09:33:19AM +0200, Bert Wesarg wrote:
>
>> Now that get_short_ref() always return an malloced string, consolida=
te to
>> one xstrcpy() call.
>
> Makes sense to squash in on top of what I have. But I think it actual=
ly
> is pretty easy to always return a pointer into the existing string
> (patch based on current master):
Yes, thats probably a good idea. The caller can always do a
xstrdup(get_short_ref(ref)).

> @@ -637,12 +637,14 @@ static char *get_short_ref(struct refinfo *ref)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * short name =
is non-ambiguous if all previous rules
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * haven't res=
olved to a valid ref
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (j =3D=3D i)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return short_name;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (j =3D=3D i) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ref +=3D strlen(ref) - strlen(short_name);
we have strlen(short_name) in short_name_len already.

Bert
