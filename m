From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Wed, 29 Jul 2009 08:33:18 +0200
Message-ID: <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vljm84htf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 08:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW2jT-0006fY-BO
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 08:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbZG2Gdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 02:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbZG2Gdj
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 02:33:39 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:42122 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbZG2Gdj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 02:33:39 -0400
Received: by bwz21 with SMTP id 21so491064bwz.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 23:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CCSLXGQmlQaKfFY9lXjXfDU2dlnHemh0UqpIXTkTohg=;
        b=ESofjNHG4EDw2PWaJ0i62n06ekF0U7Mt4u4Ow6h5RVVSunbLzusa98n06EslhLUsrr
         CP6ukDq0M1VLLxLZRl71CSo/81pSWc22m5LwV8RM4FlYE1fGjw+iu7JFUpEbiz9P52QN
         KnysQ84S0rjhbPJldXCNo4Gtzo7ma/M63LeLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Te4bvNobqKzKVbqT7SoTCVWLOTCx2W1qykLjIkPy82Z68deP7ugp0afzdI3FHg3NiU
         hM5bt8CojlPYKWwTdQnLuQBCbOF+aq9qfa8fS7ewbo1apC4o5wHT44luikTi3qRV6hvZ
         ljRmbiPmAjHpAyJtVoIiZxYbRPvsVqD0ZPM24=
Received: by 10.204.119.129 with SMTP id z1mr5224083bkq.67.1248849218122; Tue, 
	28 Jul 2009 23:33:38 -0700 (PDT)
In-Reply-To: <7vljm84htf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124308>

On Tue, Jul 28, 2009 at 11:29 PM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> @@ -205,6 +209,9 @@ running `git apply --directory=3Dmodules/git-gui=
`.
>> =A0Configuration
>> =A0-------------
>>
>> +apply.ignore-whitespace::
>> + =A0 =A0 Set this boolean configuration flag if you want to ignore =
whitespace
>> + =A0 =A0 differences to be ignored by default.
>
> That's a strange sentence.
>
> =A0 =A0 =A0 =A0When set to true, changes in amount of whitespace are =
ignored.

Indeed, my sentene was horrible.

> I am not happy with the name --ignore-whitespace.
>
> Perhaps --ignore-space-change, to be consistent with a "git diff" opt=
ion,
> would be more appropriate. =A0Doing so has an added benefit of leavin=
g the
> door open to add --ignore-all-space option to the patch application s=
ide
> later.

On the other hand, --ignore-whitespace matches the option name (and
behavior) of the 'patch' command (just like "git diff"'s matches the
'diff' option name and behavior). Principle of least surprise says
that someone coming to git from raw diff/patch setups would expect
--ignore-whitespace on the patch side.

A possible future expansion to allow ignoring all whitespace
completely would be to allow --ignore-whitespace=3Dall

> If I am reading the patch correctly, use of this option always disabl=
es
> checks and corrections of whitespace errors.

Not exactly. Whitespace correction is not attempted to try matching
context lines, but the whitespace correction on the new lines is still
applied.

>=A0I personally feel that
> somebody who is willing to accept a patch that has whitespace breakag=
es
> that needs this option would not care

Indeed, my first patch fell through to the whitespace correction, I
changed it per your suggestion.

> but the documentation should warn
> about it at the minimum.

The code comments does mention that context line whitespace correction
that will be skipped. I'll add a note about it in the man page.

> Needless to say, a lot better option is not to disable the checks and
> corrections at all. =A0After all, this "ignore space change" option i=
s about
> matching the common context lines and replaced/removed contents befor=
e the
> change, and checks and corrections are about added/replaced contents =
after
> the change. =A0They should be orthogonal.

They are, for new lines.

Actually, one thing that I've been thinking about doing is to adjust
the new lines to match the kind of whitespace change the context line
underwent. Example: if all the context lines had the change 4 spaces
-> tab, it would be nice to have the new lines undergo the same
change. However, this is going to be rather hard to implement.

--=20
Giuseppe "Oblomov" Bilotta
