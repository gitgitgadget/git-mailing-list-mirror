From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/3] test-lib: Add support for multiple test prerequisites
Date: Sun, 8 Aug 2010 13:29:22 +0000
Message-ID: <AANLkTikFUH38mzuPo8D-MwJQZdUPEaBUVKgrrfYX=5=p@mail.gmail.com>
References: <1281129565-26124-1-git-send-email-avarab@gmail.com>
	<1281129565-26124-2-git-send-email-avarab@gmail.com>
	<20100808015729.GA9284@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 15:29:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi5wZ-0000h1-87
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 15:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0HHN3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 09:29:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60804 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab0HHN3X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 09:29:23 -0400
Received: by iwn33 with SMTP id 33so2908344iwn.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=diB+SIQ/oopl66eOke4ybOEFFqnclyCXAl/sszC6GFU=;
        b=i6Qq8bxw7tzN5XOZEg0RUF6d/7z4ofJ/L/W5oltWHGBvEtL8iD7VcVVx5wX/5cf553
         EhT7RiCLhfsEv2+wexA4dQBjBEaUCjv3Q0VhncY91Lpp2RvB2N0pOZGfq5pAnVMxkXZZ
         EIaa6ClrS3D7tukTn/nEAVdDrLkA+Eh6kk0F4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bzS9Yg3ZgYvgAOHZm4UR2to0Gvsw6WV/M5JRgK5F5DGWLfrIip5ZeJKivJQL3YDOJO
         rihYRSyF7MHHq2ijyMJJs87QQDH1ZBZp7nwMbNHnbw41BGrWF032qHPiWPrOyWVxqOm3
         zYVKgWqtN/kuYZoWcs6oTnudUBISRMHodw25w=
Received: by 10.231.178.103 with SMTP id bl39mr16802363ibb.138.1281274162921; 
	Sun, 08 Aug 2010 06:29:22 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 8 Aug 2010 06:29:22 -0700 (PDT)
In-Reply-To: <20100808015729.GA9284@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152908>

On Sun, Aug 8, 2010 at 01:57, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Change the test_have_prereq function in test-lib.sh to support a
>> comma-separated list of prerequisites. This is useful for tests that
>> need e.g. both POSIXPERM and SANITY.
>>
>> The implementation was stolen from Junio C Hamano and Johannes Sixt,
>> the tests and documentation were not.
>
> I think you can sell it better. :)

As Johannes points out the patch is different enough that I changed
the authorship. Actually I wouldn't modify any patch under someone
else's name without getting them to sign off on it.

>> +++ b/t/t0000-basic.sh
>> @@ -73,6 +73,23 @@ then
>> =C2=A0 =C2=A0 =C2=A0 exit 1
>> =C2=A0fi
>>
>> +test_set_prereq HAVETHIS
>> +haveit=3Dno
>> +test_expect_success HAVETHIS,HAVEIT 'test runs if prerequisites are=
 satisfied' '
>> + =C2=A0 =C2=A0test_have_prereq HAVEIT &&
>> + =C2=A0 =C2=A0test_have_prereq HAVETHIS &&
>
> I think the similar code above was just a way to sneak in a sanity
> check for test_have_prereq(). =C2=A0I=E2=80=99d leave it out.

It's a sanity test. If that wasn't there the test might succeed
e.g. if the implementation was broken and only did a OR on the comma
delimited list, not a AND.

>> + =C2=A0 =C2=A0haveit=3Dyes
>> +'
>> +donthaveit=3Dyes
>> +test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes t=
est to be skipped' '
>> + =C2=A0 =C2=A0donthaveit=3Dno
>> +'
>> +if test $haveit$donthaveit !=3D yesyes
>> +then
>> + =C2=A0 =C2=A0 say "bug in test framework: multiple prerequisite ta=
gs do not work reliably"
>> + =C2=A0 =C2=A0 exit 1
>> +fi
>
> Maybe it would be simpler to squash this in with the other similar ch=
ecks.

I think that's too much complexity for one test, especially in the
sanity file. I didn't squash it with the existing "yesyes" test
because we're testing basic functionality first (one prereq) then the
fancy stuff (multiple).

>> +++ b/t/test-lib.sh
>> @@ -327,12 +327,20 @@ test_set_prereq () {
>> =C2=A0satisfied=3D" "
>>
>> =C2=A0test_have_prereq () {
>> - =C2=A0 =C2=A0 case $satisfied in
>> - =C2=A0 =C2=A0 *" $1 "*)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : yes, have it ;;
>> - =C2=A0 =C2=A0 *)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! : nope ;;
>> - =C2=A0 =C2=A0 esac
>> + =C2=A0 =C2=A0 # prerequisites can be concatenated with ','
>> + =C2=A0 =C2=A0 save_IFS=3D$IFS
>> + =C2=A0 =C2=A0 IFS=3D,
>> + =C2=A0 =C2=A0 set -- $*
>> + =C2=A0 =C2=A0 IFS=3D$save_IFS
>> + =C2=A0 =C2=A0 for prerequisite
>> + =C2=A0 =C2=A0 do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case $satisfied in
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *" $prerequisite "*)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 : yes, have it ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ! : nope ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
>> + =C2=A0 =C2=A0 done
>
> Does that work?

It passes all the tests :)

> Except as noted above,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.

Likewise.
