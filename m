From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git EOL Normalization
Date: Wed, 25 May 2011 21:58:33 +0400
Message-ID: <BANLkTik3iRKx4P_3nbzygadmLPEOr2vGhA@mail.gmail.com>
References: <20833035.39857.1306334468204.JavaMail.root@mail.hq.genarts.com>
	<29536877.39971.1306336806278.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed May 25 19:58:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPILw-0001rw-MM
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab1EYR6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 13:58:36 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63415 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab1EYR6f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 13:58:35 -0400
Received: by qyk7 with SMTP id 7so2257700qyk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sQbgSiBA2xFnqbKV0OH+/FiuocwOeUvm4GeDLvxgsec=;
        b=TcdrQl+4IgKDzMPAhCfnSQ9vRgNAaU/nxwZlvtk6EEn/W9vS/ptnoDFk+V52v72YkH
         jMc2TpOQlOm/Q6/zYoDsohJa73ZTj9zEn3/8g9jmxLu9YN4YDAboZVv+rRE/Zl8Ps2Iy
         ETU2qMr1JgwCVnB4AoGlszGKsI3bgQXw7zPPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D4D6R6l8nwZGH4pg+eLhG4N35X44WlXcBb6rRbvSb7+cgWGyiw3ykoux5z93X87iVr
         Iirw4PW6cf/Ys4kpEwAkhPnDbAmuH8pK4swdxEFZrfdokVahVIfdbAlUDf7F/CdYohyY
         cKUwbOSUKaFTqk8jJHez78NMcYXASjFb2dWf8=
Received: by 10.229.73.33 with SMTP id o33mr3968191qcj.294.1306346313737; Wed,
 25 May 2011 10:58:33 -0700 (PDT)
Received: by 10.229.77.226 with HTTP; Wed, 25 May 2011 10:58:33 -0700 (PDT)
In-Reply-To: <29536877.39971.1306336806278.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174439>

On Wed, May 25, 2011 at 7:20 PM, Stephen Bash <bash@genarts.com> wrote:
>
> The open questions for me are:
> =A01) what is the actual text file detection algorithm?
> =A02) what is the autocrlf LF/CRLF detection algorithm?
> =A03) how does autocrlf handle mixed line endings? (either in the wor=
king copy or repo)

Git looks at the text attribute of a file. If it is set or unset then i=
t
treats the file as text or binary accordingly. If the text attribute is
'auto', or it is unspecified but core.autocrlf is true, then git uses
heuristics to detect text files.

Currently, the following heuristics are used:

A file is considered as text if it does not have '\0' or a bare CR, and
the number of non-printable characters is less than 1 in 128.

Non-printable characters are DEL (127) and anything less than 32 except
CR, LF, BS, HT, ESC and FF.

Also, to avoid problems with autocrlf=3Dtrue when someone has already p=
ut
a text file with CRLF, CRLF->LF conversion happens only if the tracked
file in the index does not have any CR.


Dmitry
PS I wrote this mostly from my memory, so I could miss some detail.
