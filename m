From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 15:46:54 -0500
Message-ID: <76718490902261246k1c5026f9m6ff18701a7a61fba@mail.gmail.com>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
	 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
	 <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcn9b-0001KU-Nt
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 21:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbZBZUq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 15:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbZBZUq4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 15:46:56 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:61925 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbZBZUq4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 15:46:56 -0500
Received: by rv-out-0506.google.com with SMTP id g37so699721rvb.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hJ4RsFofmjdiCzjndHCPKFtzRr/Ow9XnImV5K/v5ZqM=;
        b=AgiW3bxIwtwjUdMJFtagsZCB/WkWU3/Z/rqK7eEfkbL2Q/gb32ULzfy/XzaAiqqIYv
         ycPC15vENSv0LwPhTT2RBBiEWJXCwOIIZP+QYcafezrVizbqC1SrGj+K8cD5lJQO8Cbk
         axtEv0KAdvXPCDIrB29ZZrAWLSQa0xJCkF388=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FqbxLWHd7kt81e9AyNUxpitD9m/YGfNmfsz8PqKRS7kvPmaONt6miZCP/MtquvQvhn
         e72SpGJASqG3Kqzfs9qRylbXoLfwS4SW+bdnGnu3qTfMlc9h4ZG5X5hGqAL9RnL2vNcm
         5rRfD6kUoDjNZgjkxvRvdDqeITXzI9o4as8kc=
Received: by 10.141.4.20 with SMTP id g20mr805960rvi.221.1235681214188; Thu, 
	26 Feb 2009 12:46:54 -0800 (PST)
In-Reply-To: <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111598>

On Thu, Feb 26, 2009 at 3:43 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> Originally I had switched to perl. Would you prefer:
>
> diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
> index 11b3432..a53fe0d 100755
> --- a/t/t5540-http-push.sh
> +++ b/t/t5540-http-push.sh
> @@ -96,8 +96,8 @@ test_expect_success 'MKCOL sends directory names
> with trailing slashes' '
>
> =C2=A0test_expect_success 'PUT and MOVE sends object to URLs with SHA=
-1
> hash suffix' '
>
> - =C2=A0 =C2=A0 =C2=A0 grep -P "\"(?:PUT|MOVE)
> .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 < "$HTTPD_ROOT_PAT=
H"/access.log
> + =C2=A0 =C2=A0 =C2=A0 test $(perl -ne "print if m{\"(?:PUT|MOVE)
> .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d}" =
\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 < "$HTTPD_ROOT_PAT=
H"/access.log | wc -l) -gt 0
>
> =C2=A0'

gmail mangled the lines. Sorry about that.

BTW, I was not aiming for "portable" to the extent that git is
portable, I was aiming for "portable enough" to the extent that the
test suite is portable. :-)

Let me know if the perl above is okay, or if you'd prefer a basic RE
and I'll send a new patch.

j.
