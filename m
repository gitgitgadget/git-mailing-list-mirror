From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of 
	commit header(s) in $GIT_EDITOR
Date: Mon, 12 Jul 2010 21:39:00 -0400
Message-ID: <AANLkTik7KDM8Vp_nc1NYRZ89cd1IdyfBffq5vUitbrzj@mail.gmail.com>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
	<7v7hl1fd0n.fsf@alter.siamese.dyndns.org>
	<AANLkTin03Ea2fIBQiSDpIqRYLYjWRe9U62nZpfczbfST@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 03:39:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYUSl-0000hY-O1
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 03:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab0GMBjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 21:39:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41662 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab0GMBjD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 21:39:03 -0400
Received: by iwn7 with SMTP id 7so5279900iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 18:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zHOISB0Y/z1PxQ22qWhDY4VaPHhNtm76fMXJu5ITyVE=;
        b=PIMHzXw0VKn4JI1rrdcNG9sPaNebvPlKyME41Fy4TJIWLNY06z+D/InzTwCauseuf8
         cuWJpXMj0XPkJoOOIJAW2neBlT9UkEkbCewIPDKlIB6VvKGtolyRmL9QLQfyMJ24cEVE
         Ov4q/7F0IXxAFBlvGKsmM2NslDzuEild8bEDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ccqFTd+InwxJi2YkjCNu66XbcLfFhPl68SIbr3ufh+uSJtOMudpYcKanmZ1tW7Ncuw
         itmXVDLXBtdDjB0h5ZlKXvuMWSmOEb3S6O0/tQcxVcEAr4tVx8EoN3wAK/GFcp3cVLkZ
         rAmCqZ9Jt4YlkBMKTKvrRuySuwUUknY+pyAFQ=
Received: by 10.231.36.72 with SMTP id s8mr15853658ibd.49.1278985140961; Mon, 
	12 Jul 2010 18:39:00 -0700 (PDT)
Received: by 10.231.178.152 with HTTP; Mon, 12 Jul 2010 18:39:00 -0700 (PDT)
In-Reply-To: <AANLkTin03Ea2fIBQiSDpIqRYLYjWRe9U62nZpfczbfST@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150866>

On Mon, Jul 12, 2010 at 8:36 PM, Nazri Ramliy <ayiehere@gmail.com> wrot=
e:
> If I were to use a single "sed" invocation here's how it's going to l=
ook like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "s/^pick [0-9a-f]\+//" < "$1" > com=
mit_headers.$$
>
> But doing so reminds me of this:
>
> On Sat, Jul 10, 2010 at 6:30 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nazri Ramliy <ayiehere@gmail.com> writes:
>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sed -i "s/^\([a-z]\+\) [0-9a-f]\+ /\1 $REPLACE_COMMIT_ID /" \
>>
>> This is not portable. Escaping an ERE element with a backslash does =
not
>> make it suitable for use in BRE that sed uses.
>
> Aren't we back to square one? Or am I missing something?

sed 's/^pick [0-9a-f]\{1,\} //'

is a valid posix BRE. Alternately + can be expressed as:

sed 's/^pick [0-9a-f][0-9a-f]* //'


>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff "$EXPECT_HEADER" c=
ommit_headers.$$ > /dev/null
>>
>> Is "test_cmp" inappropriate here for some reason?
>
> It seems appropriate, but this will require a ". ./test-lib.sh" from =
inside
> lib-rebase.sh, which fails because at that point we are already in th=
e trash
> directory for the test, the solution is to do a ". $TEST_DIRECTORY/te=
st-lib.sh"
> instead but that gives more errors due to test-lib.sh assumes that it=
 is always
> being "sourced" when $CWD is $TEST_DIRECTORY, i think.

Don't the scripts that source lib-rebase.sh all source test-lib.sh
ahead of it? lib-rebase.sh shouldn't need to re-source test-lib.sh.
No?

j.
