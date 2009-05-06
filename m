From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] t4200: convert sed expression which operates on 
	non-text file to perl
Date: Thu, 7 May 2009 09:24:37 +1000
Message-ID: <fcaeb9bf0905061624s515d9b13i188b27f4c5472eba@mail.gmail.com>
References: <7vpreluckk.fsf@alter.siamese.dyndns.org> <Lle9L7vlL2vfnqjU75q2MR6WXGGP9aOKv8J97cnRHcQgyJeGbOMDDB2xJugZ0LoonfCRYmzXx9E@cipher.nrlssc.navy.mil> 
	<Lle9L7vlL2vfnqjU75q2MW9kwH-igiKVkmBrtmLzQmOXU0OyvCI2tl4UD8Kdhyg0x_gCHDJIHDM@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 07 01:25:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qUA-0007wd-KI
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZEFXZA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 19:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbZEFXZA
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:25:00 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:26039 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbZEFXY7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 19:24:59 -0400
Received: by an-out-0708.google.com with SMTP id d40so1104373and.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 16:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=extZnd/3D76OIgQ8ScVane5/pTouHSE3b3SptgcxHeE=;
        b=tMlDDBcC1CbiBaMRtcRf0A9JHZeuznz6diMFgttfRCeGkSozZEannTfIXyQjOm1xro
         7L8geSweGm7Gqe0LmrcYwIUvyu6sEezi0ff+39dWlA1IxRcqYWnd0+LUsnRUzWPD4jhE
         1QAwmVFkOlzObo/rlZFVsCovLrfQ87GkU7Ukw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=X9gRDBkcKajyXawr3lORmbtFitjOhTkDpOwCkC8zKfEzypvCkufGRgZaopgqrsKq5a
         gP9rgCgVY18dLuK0gJ6tkNUBy4cRJJkoTEaUt4eClBRi5s2IhjbfdY77itBE7UF4Tacu
         Mn2txumIq9YVygzgG5TPHHYeuMp9Foii93dZ0=
Received: by 10.100.132.4 with SMTP id f4mr3845548and.127.1241652297431; Wed, 
	06 May 2009 16:24:57 -0700 (PDT)
In-Reply-To: <Lle9L7vlL2vfnqjU75q2MW9kwH-igiKVkmBrtmLzQmOXU0OyvCI2tl4UD8Kdhyg0x_gCHDJIHDM@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118408>

On Thu, May 7, 2009 at 8:56 AM, Brandon Casey <casey@nrlssc.navy.mil> w=
rote:
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 504802c..5a1721d 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git merge first
> =C2=A0'
>
> -sha1=3D$(sed -e 's/ =C2=A0 =C2=A0 =C2=A0.*//' .git/MERGE_RR)
> +sha1=3D$(perl -pe 's/ =C2=A0 =C2=A0.*//' .git/MERGE_RR)

Can we have a wrapper for this please? This is correction solution.
But my work to make git work on windows without msys/cygwin also means
that I don't have perl. Maybe something like this? I know perl regex
and sed one is not completely compatible, but it should work for
simple regex used here and elsewhere.

sed_wrapper() {
  if test_have_prereq PERL; then
    perl -pe "$@"
  else
    sed -e "$@"
  fi
}
--=20
Duy
