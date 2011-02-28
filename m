From: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 12:45:35 +0200
Message-ID: <AANLkTim-vyWhgmFuewbd5e5iJiTC-EHz7g=efr2Sz-RH@mail.gmail.com>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
	<7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
	<4D6A6291.8050206@drmicha.warpmail.net>
	<7v7hclulz0.fsf@alter.siamese.dyndns.org>
	<7v39n9uldp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 11:45:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu0bl-000338-WB
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 11:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab1B1Kpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 05:45:36 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65056 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab1B1Kpg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 05:45:36 -0500
Received: by qwd7 with SMTP id 7so2702850qwd.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 02:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=ouPmDOlUt3eumduPcWOYyXUWTLCpqFwJrkpnk7vLro8=;
        b=riQ7r/3ozCwWdbHP2H79qK5uTKuA8UYkBKd1eCBVv5FuWCVm1DirUJWUqKtHaGwRjp
         pJWj1J22fZBdP6TONvszUbc9pwHt6sbUc6ts/zd4nA+ckrnva8dyzpDyGVlPJsJHEOIE
         9oEFrrLdOWmGt6mvDgMY2IBInjvCoaDeWOzew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=NCNvlUtootCvaNNMR4z0UJF8DrRwoUI/X7iz7DJqPTCIBzfcL3B46gr0KTASOKFe8L
         soDebQU5EVfWLcAzO+r0TBAuMdwAgIh3jDAakpnsVpPrKlXlTgOil+yF5M0s3EcAaNjX
         S+HZ4W5cd+T0EAYr7k4CzrkGuoSTvHEqmVEWM=
Received: by 10.224.73.130 with SMTP id q2mr4611265qaj.37.1298889935215; Mon,
 28 Feb 2011 02:45:35 -0800 (PST)
Received: by 10.229.192.14 with HTTP; Mon, 28 Feb 2011 02:45:35 -0800 (PST)
In-Reply-To: <7v39n9uldp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168097>

Why not just make it reversible then?

$ git diff -M
diff --git a/foo b/bar
similarity index 100%
rename from foo
rename to bar

is nonreversible without git already (i.e. does not work with plain
patch AFAIK).

Adding

$ git diff -D
diff --git a/foo b/foo
deleted file mode 100644
delete foo

would be neither less nor more reversible -- it would also only work
with git apply
(assuming that apply is amended accordingly).

Cognitive burdens aside, the "delete foo" output is both
more explicit and shorter anyway. Occam's razor FTW :)!

Junio, I won't push this further, so it's a final call -- if you give -=
1,
then let -D fall to the colourless abyss of oblivion :), if +1 or +0,
I'll see if I can come up with a patch.

Best regards,
MS

On Mon, Feb 28, 2011 at 1:07 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Wasn't the pager invented for sifting through output which has to b=
e
>>> several pages, but not not for that which could be more concise? ;)
>>>
>>> In fact, -D would be quite analogous to -M and -C in that respect.
>>
>> There is a big difference: -M and -C lets your recipient reproduce t=
he
>> state using the change you are trying to convey with the diff output=
 in
>> either direction (iow, "apply -R" works), but your "-D" would not ha=
ve
>> that property.
>
> Having said that we have always valued "reversibility" and a casual -=
D is
> not in line with that principle, I don't have a strong objection if t=
he
> new mode of operation is marked clearly as "nonusable if you are tryi=
ng to
> produce appliable diff (iow, don't send such a patch to mailing list-=
-it
> is for viewing purposes only)", treating it just like the --color-wor=
ds
> and the --stat options (there isn't even need to mark these as unusab=
le
> for that purpose, as people with common sense would be able to guess)=
=2E
>
> If we were to do this, it probably is a good idea to apply that for a
> typechange patch (the one that is produced when a symlink turns into =
a
> regular file and vice versa) as well. =A0It also might make sense to =
apply
> the similar principle to shorten the output with -B when a rewrite pa=
tch
> is expressed as a single hunk patch that removes everything old and t=
hen
> adds everthing new.
>
