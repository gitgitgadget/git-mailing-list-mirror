From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] Add infrastructure for translating Git with gettext
Date: Mon, 14 Jun 2010 20:26:02 +0000
Message-ID: <AANLkTikuSTKbPkTrRtw4fvNUxlh32uhTlbq0g-q35dng@mail.gmail.com>
References: <1275846453-3805-1-git-send-email-avarab@gmail.com>
	<1275846453-3805-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 22:26:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOGEX-0004ME-BP
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 22:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0FNU0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 16:26:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45299 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab0FNU0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 16:26:05 -0400
Received: by iwn9 with SMTP id 9so3691089iwn.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+ZQacXX9+7I39CZEANGaHMrU9Ydl5pBecijyPUsVXwU=;
        b=johYPN769QUxYg2YLrwC60I/nCwNFFpzp5foRMwjJnQBwtqFNize+6i8O2dLcLAPEn
         qL2x00ZtIAXdoeMKOGGHHRBq1AQ9LhrVAfeDK7K12QDTXb6K+w9tP6XYru7PzNWcOo3/
         OZ4RdhByoKPrhaYzH2Y6DeORQttQjx+41NpkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Uu1BbbtJLv53CI04yJSOM3DX8Lg5ojjs37UP1yfA/VdZyutVqLZpNIKCzeu+xFOMaY
         hSlGxIUPK5dmm1oGoLgEdZrqooKf9gsKQFkzU6hxr5v+KiK5C1RIzZnZAcHndUapa2q0
         uyvk+IvagvV99OvTs8mXf0uR7AWFrsiy6KMbQ=
Received: by 10.231.168.135 with SMTP id u7mr6512560iby.125.1276547163062; 
	Mon, 14 Jun 2010 13:26:03 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Mon, 14 Jun 2010 13:26:02 -0700 (PDT)
In-Reply-To: <1275846453-3805-2-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149135>

On Sun, Jun 6, 2010 at 17:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:

> +# Try to use libintl's gettext.sh, or fall back to English if we
> +# can't.
> +. gettext.sh
> +
> +if test $? -eq 0 && test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
> +then

It turns out that this doesn't actually work, and I can't find a
workaround. In Bash and Solaris's /bin/sh this executes until "dies
here". The problem is that I can't use the subshell trick, since the
gettext.sh inclusion has to be done in the current shell (I checked,
tests will fail).

    #!/bin/sh
    (. does-not-exist.sh)
    echo "A subshell made it! ret =3D $?"
    . does-not-exist.sh
  # dies here
    echo "A real shell made it! ret =3D $?"

Is there some clever shellscript trick that I'm missing, or will I
have to resort to modifying the file at `make' time for this to work
everywhere?
