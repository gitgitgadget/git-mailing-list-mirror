From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH -1/3] gitweb: Always call parse_date with timezone parameter
Date: Sat, 19 Mar 2011 15:56:04 -0700
Message-ID: <AANLkTimV7vvD0PTMejydiyW_CeUH0cuQ-2+PnRqjzob5@mail.gmail.com>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost>
	<201103192318.45925.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 23:56:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1548-0005L3-9m
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 23:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab1CSW4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 18:56:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62351 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab1CSW4G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 18:56:06 -0400
Received: by fxm17 with SMTP id 17so4621126fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JW+SnrwYGp4Zt2fygv+pxsF/OER0Urko5shYoPUjKeQ=;
        b=qSVzV8EnWOtMH30zjq5wHFXDjZmzl5157GrazQGxwkXfXZqQt1kTAyCNjtGeXHjFbN
         K+Hx56/xdw5qcvsWb5E90x1Oho4qVanqhD+DHjg+DLKtGZUMl+nW9JkrSCrribTVI+7O
         H4T5X3ZDCn/YjssPy8De+ci5D/+xDrHUrYm9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wZJ5kpq6EcBW/NbHVYkOjLW4mHdzo9PlkOS48ul1zhSauRLGhoEoOHzjH7pIoeXXR8
         oWCqtRnlQtpGBiWQy45P7kNyB345HlOozePGEDZnwe9wmYYc/ZlNQui7cCeZeFA56nr0
         sYF0QVgVHPqH8zYOkeuIyG5W7ung0PJcEZTP8=
Received: by 10.223.74.136 with SMTP id u8mr1160795faj.136.1300575364497; Sat,
 19 Mar 2011 15:56:04 -0700 (PDT)
Received: by 10.223.61.83 with HTTP; Sat, 19 Mar 2011 15:56:04 -0700 (PDT)
In-Reply-To: <201103192318.45925.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169475>

On Sat, Mar 19, 2011 at 3:18 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> @@ -4906,7 +4906,7 @@ sub git_log_body {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next if !%co;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my $commit =3D=
 $co{'id'};
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my $ref =3D fo=
rmat_ref_marker($refs, $commit);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my %ad =3D parse_d=
ate($co{'author_epoch'});
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my %ad =3D parse_d=
ate($co{'author_epoch'}, $co{'athor_tz'});

Should be 'author_tz'

Looking at the master branch, I don't see %ad actually getting used
anywhere?  Maybe it is safe to delete the line entirely, since
git_print_authorship() calls parse_date() itself.

> @@ -7064,7 +7064,7 @@ sub git_feed {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (defined($commitlist[0])) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%latest_commit=
 =3D %{$commitlist[0]};
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my $latest_epo=
ch =3D $latest_commit{'committer_epoch'};
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %latest_date =C2=A0=
 =3D parse_date($latest_epoch);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %latest_date =C2=A0=
 =3D parse_date($latest_epoch, $latest_commit{'comitter_tz'});

Should be 'committer_tz'

I would agree that it isn't such a good thing for
$latest_date{'rfc2822_local'} to be set to GMT in this case.  Although
the feeds don't need local times for anything, since RSS/Atom readers
seem to do their own timezone translations.

It probably makes sense to add this argument so that nobody gets bit
later when they try to use the rfc2822_local field.

Am I correct in interpreting "PATCH -1/3" as: "apply this before
Kevin's set of 3 patches?"
