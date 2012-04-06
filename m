From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [GSoC] Designing a faster index format
Date: Fri, 6 Apr 2012 10:13:45 -0700
Message-ID: <CAJo=hJsfXd8J3ndLTMSUFRaH4FG+4YDXdnfFZ13bC+hoA3GE8g@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
 <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
 <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
 <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com> <87r4w1vofu.fsf@thomas.inf.ethz.ch>
 <CAJo=hJssfTvGqzQtaAj+Dk_R2oU5BwY=sQQuH3=SFTf+Zcp=3A@mail.gmail.com>
 <CACsJy8DaBxCtU7UQcc510J71zk95DMMsWdr9S3eYTupdRLjWBg@mail.gmail.com>
 <878vi8sx1x.fsf@thomas.inf.ethz.ch> <CACsJy8AkFiiaKnqqyLEZfa+DJsRyKd6dGEN71c3q=6j3fo8jww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Thomas Gummerer <italyhockeyfeed@gmail.com>, david@lang.hm,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 19:14:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGCjm-0004yh-B0
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 19:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939Ab2DFROI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 13:14:08 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:58239 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab2DFROH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 13:14:07 -0400
Received: by dake40 with SMTP id e40so2966145dak.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9SlWAO9UiMwX2o+RhLlG793FfUvrZCqWCHYmAva9UH8=;
        b=dxsMA4aN3wA/9mnXx1rTwvQivn4iXyJ+9n0u8X2L5TYc+eQZyDNFlqVvqLdBZUpMl6
         d52f3MaTESRgjeC/HBNWRDZc4uUReW48dSfN2SCHLSBbumyRdg19Lk2x21VjAjDNxdCN
         QAxHYKH4W5p/lIsKjd3P7qOapG8PEBFmoc5G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=9SlWAO9UiMwX2o+RhLlG793FfUvrZCqWCHYmAva9UH8=;
        b=Z0tzLGJ6rkVqEwhDfdCzQN7l183HP+rrc/SbPKYuvafz+ikCaXJQECDjJ82HixiT1J
         vHxdDtmfAPq65v3aHgHrc+vqeqJ2hEwsqRbGBg2QHsSL9AQZ1q/ScQyDLXMS+Ge7Y7Fm
         wdrADhu6Ks5es5viT2jXDG2Hb7XqS15MOczBGi7o85JD2IaxgA0+0fnd1QSWh+RbJJu5
         nYr2SqZMuJ8+i6q3JVvz/VqgouYFu2N46JI7eh2/ERVg7mM5Lim94zasYQBmv4uHWr7p
         vV/DaAyPlvOgcBDqk+jqjoeysF0wmLdbM65Dkk1WRK7DVeY/wffd2LrQ41+WDUP8vfXE
         w/+w==
Received: by 10.68.232.71 with SMTP id tm7mr260925pbc.86.1333732445712; Fri,
 06 Apr 2012 10:14:05 -0700 (PDT)
Received: by 10.68.55.68 with HTTP; Fri, 6 Apr 2012 10:13:45 -0700 (PDT)
In-Reply-To: <CACsJy8AkFiiaKnqqyLEZfa+DJsRyKd6dGEN71c3q=6j3fo8jww@mail.gmail.com>
X-Gm-Message-State: ALoCoQkCUc4krANyV4leX+Cr7MmvnQr32IwLpZ0o5F3oGaUyaf4714+j+PZiiNf0I43cbkk4I51a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194882>

On Fri, Apr 6, 2012 at 08:44, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> On Fri, Apr 6, 2012 at 10:24 PM, Thomas Rast <trast@student.ethz.ch> =
wrote:
>> But even so: do we make any promises that (say) git-add is atomic in=
 the
>> sense that a reader always gets the before-update results or the
>> after-update results? =A0Non-builtins (e.g. git add -p) may make sma=
ll
>> incremental updates to the index, so they wouldn't be atomic anyway.
>
> Take git-checkout. I'm ok with it writing to worktree all old entries=
,
> or all new ones, but please not a mix.

Why, what is the big deal? git-checkout has already written the file
to the local working tree. Its now just reflecting the updated stat
information in the index. If it does that after each file was touched,
and it aborts, you still have a partially updated working tree and the
index will show some updated files as stat clean, but staged relative
to HEAD. I don't think that is any better or worse than the current
situation where the working tree is shown as locally dirty but the
index has no staged files. Either way you have an aborted checkout to
recover from by retrying, or git reset --hard HEAD.

In the retry case, checkout actually has less to do because the files
it already cleanly updated match where its going, and thus it doesn't
have to touch them again.
