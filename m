From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] Use reflog in 'pull --rebase . foo'
Date: Sat, 13 Nov 2010 12:52:06 -0500
Message-ID: <AANLkTineaFVawXbJKHKv39bwPco7JHcmpUwXtZhscaFs@mail.gmail.com>
References: <1289590708-11064-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<m2pqu98urp.fsf@whitebox.home>
	<AANLkTiniwpk7ao=M4=5vuahczk6FscQYJE1rZx=wuBk_@mail.gmail.com>
	<AANLkTikmJVj9BM=K2oSYJvPV27Uzn_9SQhsLc9EQm8zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	gitster@pobox.com
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Nov 13 18:52:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHKH9-0001eL-WB
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 18:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861Ab0KMRwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Nov 2010 12:52:10 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34593 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab0KMRwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Nov 2010 12:52:07 -0500
Received: by qyk12 with SMTP id 12so2254810qyk.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 09:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FejHMDuZ49ad04kJal6Cn6I/ySxRxjS4KuWvu+Qmntc=;
        b=jFcyIYmNRFiD/ZnlS03p2yjrwgKCJ7naWhj4TL6xAOaHw3veHhfjkDFCGRkP+KatAQ
         oJuPTx54BoF+FxDoBh3A/uoVYYylFIdNYkTqnStPsqwaV4082DF82/RshIjPG3dLPrwa
         s2DiQQItaIelYCHJhDaSKDJ/m3ACC11HAgwKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S2ffZ02lSN1NsA5jW08I0UPrhRblNXEUhKhAl6OijU0QrtefVJdHRqV9aMJKBgi/Pc
         KmEPWmInUhUPmopr8/GPC/so7CV8tC1j3nBXEBry/RGai92cnoOFYxy+mzK95uO7oUqa
         fG6F7BaDOdVU38kGMgoNzbVX/pv99/kyXMKXw=
Received: by 10.224.38.26 with SMTP id z26mr3643969qad.375.1289670726696; Sat,
 13 Nov 2010 09:52:06 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Sat, 13 Nov 2010 09:52:06 -0800 (PST)
In-Reply-To: <AANLkTikmJVj9BM=K2oSYJvPV27Uzn_9SQhsLc9EQm8zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161393>

On Sat, Nov 13, 2010 at 12:20 PM, Santi B=C3=A9jar <santi@agolina.net> =
wrote:
> On Sat, Nov 13, 2010 at 1:09 PM, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
>> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
>> index 5f47b18..2e1661d 100644
>> --- a/git-parse-remote.sh
>> +++ b/git-parse-remote.sh
>> @@ -63,11 +63,8 @@ get_default_remote () {
>> =C2=A0get_remote_merge_branch () {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$#" in
>> =C2=A0 =C2=A0 =C2=A0 =C2=A00|1)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 origin=3D"$1"
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D$(get_default_remote)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test -z "$origin" && origin=3D$=
default
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curr_branch=3D$(git symboli=
c-ref -q HEAD)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ "$origin" =3D "$default" ] &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test -z "$1" || test "$1" =3D $=
(get_default_remote) &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $(git for-each-ref --f=
ormat=3D'%(upstream)' $curr_branch)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*)
>
> They are not equivalent, the last line (echo $(git for-each-ref...))
> is always executed, not only when ask for the default remote. When
> $origin !=3D $default the last line does not return the correct answe=
r.
> It should return nothing, it is not well defined. Or maybe it should
> return the branch pointed by $origin/HEAD (I cannot test right now
> what 'git pull $remote-not-the-default' merges).
>
> And it has nothing to do with letting 'pull --rebase . for" work.

You are right, of course. I think I was modifying the code to try to
understand how it behaved and it should not have been part of the patch=
=2E
Sorry about that.

Junio, will you just exclude that hunk?
