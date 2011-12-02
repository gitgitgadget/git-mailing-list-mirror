From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git auto-repack is broken...
Date: Fri, 2 Dec 2011 08:56:34 -0800
Message-ID: <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 17:57:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWWQ3-0000EY-QP
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 17:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab1LBQ46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Dec 2011 11:56:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62575 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab1LBQ45 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2011 11:56:57 -0500
Received: by faaq16 with SMTP id q16so2241797faa.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 08:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6sCSV6ZSpXzPNSnyfcsuTNb5oSZM53BW62NOyx3CpDQ=;
        b=vsiH76g5ICZWKAUXw+CIJI+2Cd9lGwXsw0L7sHuwSiBpEImM3101xXOyHcMe4R7vzg
         rioPdY7vup5r8+wBMzAUpD041DS3jUYTufx1Fs1Ho7XGu66ihFAAr6yx+S0oA06JXzZj
         KvXWduBT/giV/cMm7bXEVBznHADwx1pFj13do=
Received: by 10.180.19.42 with SMTP id b10mr13972732wie.39.1322845016315; Fri,
 02 Dec 2011 08:56:56 -0800 (PST)
Received: by 10.216.58.140 with HTTP; Fri, 2 Dec 2011 08:56:34 -0800 (PST)
In-Reply-To: <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
X-Google-Sender-Auth: tGNbj3lT3UslUK2pXODr4EU-3DQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186228>

On Fri, Dec 2, 2011 at 8:27 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
>
>> Maybe we should make "git gc --auto" remove any unreachable objects?
>
> Wouldn't that mean that any loose commit objects you have lying aroun=
d
> would be removed by the automatic git gc?
>
> One feature of git that I personally rely on is that I can liberally
> move heads around / make commits on detached heads and not have those
> commits gc'd unless I explicitly ask for it for a while.

Well, with reflogs, you actually do have those objects reachable for
quite a while (90 days by default).

The "unreachable objects" tends to happen when you do fetches without
ever merging the result or actually remove branches (and/or expiring
the reflogs early etc). Not from the normal "use 'git reset' and
friends to move heads around".

That said, I do agree that removing loose objects is the much less
safe approach.

Of course, repacking the objects results in problems too: now you've
entirely lost the age information for that object, so now you cannot
prune it based on age any more.

But leaving the loose objects around and basically failing auto-gc
isn't good either.

                     Linus
