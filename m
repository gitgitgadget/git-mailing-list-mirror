From: Ciaran <ciaranj@gmail.com>
Subject: Re: [RFC PATCH] Pass empty file to p4merge where no base is suitable.
Date: Sun, 1 May 2011 23:08:24 +0100
Message-ID: <BANLkTikv0YmB-u74sOrQUQZGQvYJNmBx_w@mail.gmail.com>
References: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com>
	<7vwriq3p0t.fsf@alter.siamese.dyndns.org>
	<BANLkTimf1q8JM46J-X1BCwQ+GaeWAgv75Q@mail.gmail.com>
	<7v7haarsrd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 00:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGeoY-0005AJ-SS
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 00:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab1EAWIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2011 18:08:25 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65458 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab1EAWIZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2011 18:08:25 -0400
Received: by pzk9 with SMTP id 9so2817211pzk.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zkV/CB1e3DiuQ2sSXS8ukuRmCqyrUX0Jkesz2r+4z5Y=;
        b=Wg58Ij3igLiu6Wnzar6S5+d443fnAYQrumCwodwFuw7jLeYOj/O2OfJGtYs27bX0St
         bUvfmsziAHo9BgbTcatqwMhi6WmPiFo+stWYcvYLaDc1cDWhQF9R7SvBcTzhxqRG5AzS
         36iU0CRCkr835iSJHlmHDy9HYi+1C/B79VuqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xoY93+bbrogCpBVyOxifBWsLwZIAjDi09NYaeQnhr4baTdRduB7dChZuGkCvsMoxTK
         HHfwVzoIpoEjyHLRcac0rRLAlnnqUQ3DeIyefcs17C3VMeyQm82ywKRbbivCnkr/vSAM
         u4J/51aC2VWuSBV9H3+CDBWhHmgM3O31VFkK4=
Received: by 10.68.63.136 with SMTP id g8mr7811332pbs.121.1304287704653; Sun,
 01 May 2011 15:08:24 -0700 (PDT)
Received: by 10.68.62.6 with HTTP; Sun, 1 May 2011 15:08:24 -0700 (PDT)
In-Reply-To: <7v7haarsrd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172548>

On Sun, May 1, 2011 at 10:54 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ciaran <ciaranj@gmail.com> writes:
>
>>> I suspect that you may be able to simply use "$BASE" for that, no? =
=A0It
>>> will be cleaned up when cleanup_temp_files() is run anyway (warning=
: I do
>>> not use mergetool, and I am writing this only from my cursory looki=
ng of
>>> the script, so take this with a large grain of salt).
>> I don't think so, the BASE file isn't created at-all in this scenari=
o afaict.
>
> Hmm, just like $BASE, your .no-base is not created at all in this sce=
nario
> either, but you create it yourself in your patch, and because you pic=
ked a
> new filename for that temporary file, you also need to worry about
> cleaning it up.
>
> Why can't that temporary file be "$BASE"? =A0That is what I was askin=
g.
> Then you would still create an empty file (but see *1*), and can rely=
 on
> existing codepaths to clean it up.
>
> IOW, wouldn't it be far simpler to turn the part you are patching int=
o
> these three lines?
>
> =A0 =A0 =A0 =A0$base_present || >"$BASE"
> =A0 =A0 =A0 =A0"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED=
"
> =A0 =A0 =A0 =A0check_unchanged

Yes, that is a *much* better solution that solves my issue perfectly
;) Patch to follow.

<!-- Snip -->

> [Footnote]
>
> *1* It also may be worth considering to employ the "use either an emp=
ty
> =A0 =A0file or use the common parts of merged files, whichever makes =
the
> =A0 =A0merge simpler, as a phony base" technique found in git-merge-o=
ne-file.
>
I did consider your earlier post on this, but it seems that that
perforce's merge client is sufficiently smart enough to do this
alignment/matching itself, so the effort isn't required (imho) for
this client (which is the client that I'm experiencing 'pain' with atm
!

Thanks,
- Cj.
