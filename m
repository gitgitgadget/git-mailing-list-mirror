From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 1/4] completion: work around zsh option propagation bug
Date: Tue, 7 Feb 2012 01:57:01 +0200
Message-ID: <CAMP44s1urg0-1GZqLytg0h=qT77_zajwsKwNt9HnVfRZoOECqA@mail.gmail.com>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
	<1328214625-3576-2-git-send-email-felipe.contreras@gmail.com>
	<7v1uqbpsyh.fsf@alter.siamese.dyndns.org>
	<CAMP44s3SruBpM74BjWuTLfS=_66p7r6rkjJ+ObLr4bLq0nERNA@mail.gmail.com>
	<7vvcnj4kif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 00:57:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuYQo-00076W-VF
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 00:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab2BFX5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 18:57:05 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50873 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753694Ab2BFX5E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 18:57:04 -0500
Received: by lagu2 with SMTP id u2so3572154lag.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 15:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bkorkHspGA6/TSysHwfLJ4BH1kxFOjfDwey3QmqwjJI=;
        b=oqhnapi6cqou80d1aZIOjBNOfSgWnBiemuBChNHiKjdtsL14FkezWTIDaIzrzH/Dz1
         eaNE6jRlN0QbYjymhoMSHzu+FO6XAYOmVjDM7oyxxvAeHd6PrKO9sOlCNJXf53WXn8W9
         nUXEFY6Yn0TtIMPls9jDOGyUTBYZByehTdg6s=
Received: by 10.152.123.68 with SMTP id ly4mr5548833lab.13.1328572621381; Mon,
 06 Feb 2012 15:57:01 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Mon, 6 Feb 2012 15:57:01 -0800 (PST)
In-Reply-To: <7vvcnj4kif.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190123>

On Tue, Feb 7, 2012 at 1:20 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I find that what Jonathan gave you helps them much better:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fn () {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0var=3D'one t=
wo'
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s\n=
' $var
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0x=3D$(fn)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0: ${y=3D$(fn)}
>>>
>>> =C2=A0 =C2=A0printing "$x" results in two lines as expected, but pr=
inting "$y" results
>>> =C2=A0 =C2=A0in a single line because $var is expanded as a single =
word when evaluating
>>> =C2=A0 =C2=A0fn to compute y.
>>>
>>> =C2=A0 =C2=A0So avoid the construct, and use an explicit 'test -n "=
$foo" || foo=3D$(bar)'
>>> =C2=A0 =C2=A0instead.
>>>
>>> So I'll take the first two lines of the message (good bits), and si=
mplify
>>> the "This fixes a bug tht caused..." from the last paragraph (or pe=
rhaps
>>> even drop it).
>>
>> I'm not sure about it, because this relies on knowledge of how print=
f
>> works, and it's not used that often; an example with 'for' would be
>> much more clear IMO.
>
> Meaning, replace the fn() definition with something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fn () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0var=3D'one two=
'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for v in $var
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0echo "$v"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Yes.

> I can see that may make the issue easier to see; as you pointed out, =
it
> requires no implicit knowledge that printf "loops" over the arguments
> and applies the format string as manu times as needed to eat them.
> Let me update the log message before I merge it to 'next'.
>
> My main point was to illustrate the problematic pattern for people wh=
o
> write for bash, not for zsh, and that does not change with the above
> improvement, though ;-).

True, but I think that's an addendum. Most likely the people working
on this script will be thinking on bash terms, and would not notice if
they introduce code that is difficult for zsh, even if it's carefully
explained in this commit message; it would be zsh people that find the
bug, thus that's why I address the zsh side _first_.

So, IMO it should look like (looks like a fix has been submitted, so
I've updated accordingly):

---
completion: work around zsh option propagation bug

Right now when listing commands in zsh (git <TAB><TAB>), all of them
will show up, instead of only porcelain ones.

This is caused by a bug in zsh[1] that causes subshells to loose the
word splitting option (SH_WORD_SPLIT) since 4.3.0[2]. It will probably
be fixed in the next release (4.3.16).

Basically, in zsh, this:

 for i in $__git_all_commands

Should be:

 for i in ${=3D__git_all_commands}

Otherwise there's no word-splitting expansion (unless SH_WORD_SPLIT is
set). sh emulation should take care of that, but the subshell is
messing things up.

The visible result is that __git_list_porcelain_commands don't do any f=
iltering.

Specifically, the issue is with subshells in parmeter expansion
(e.g. '${var=3D$(func)'):

       fn () {
               var=3D'one two'
               for v in $var; do
                       echo "$v"
               done
       }

       x=3D$(fn)
       : ${y=3D$(fn)}

Printing "$x" results in two lines as expected, but printing "$y"
results in a single line because $var is expanded as a single word
(there's no word-splitting expansion).

So avoid the construct, and use an explicit '[ -n "$foo" ] ||
foo=3D$(bar)' instead.

[1] http://article.gmane.org/gmane.comp.shells.zsh.devel/24296
[2] http://article.gmane.org/gmane.comp.shells.zsh.devel/24338
---

Cheers.

--=20
=46elipe Contreras
