From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] git apply: option to ignore whitespace differences
Date: Tue, 4 Aug 2009 09:33:39 +0200
Message-ID: <cb7bb73a0908040033u418169bbtcddbe1524d8f70ae@mail.gmail.com>
References: <1249072858-21894-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7v8wi03usx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:34:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEXR-0007Ld-MZ
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 09:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbZHDHeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 03:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbZHDHeS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 03:34:18 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:54882 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbZHDHeR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 03:34:17 -0400
Received: by fxm17 with SMTP id 17so3104837fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=R4O4k6X5/lgLY0XnwJM7j3bMUPdq3FHkGLEmtQLzVsU=;
        b=bzV5Htl6GM27E5HEcjUes4AqGs9YAIrIsYjN5G8/o39ulbv+1oxkeMYatN3udSEZB2
         ZctSCaOZdmQGl9W5NhYP1co55wJzvgc5ztO6fRDWHD7dPqXzSO5dcCv+F0caD2s5wZ1p
         UVOTWce8WgXeOABScUZbz6582DmssJXUlyVzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DO/W7xzqhyfEgLd/fsBp1IKC7EmiuWltBe4F/S7QZgk7AIda9S5kOaH1NHHKb676Xi
         Q06v/dfUv4CubPZUnwJS21JvhDIRXL/31d3eLDPIFo1evhSdcJwZfATfxYiD1NhPjJFf
         YnwICzwlGUp73KKqY41gMK6tGuF1VxJNe9kXE=
Received: by 10.204.65.65 with SMTP id h1mr5960709bki.18.1249371255503; Tue, 
	04 Aug 2009 00:34:15 -0700 (PDT)
In-Reply-To: <7v8wi03usx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124768>

On Tue, Aug 4, 2009 at 9:25 AM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-igno=
re-whitespace.sh
>> new file mode 100755
>> index 0000000..8e3fce3
>> --- /dev/null
>> +++ b/t/t4107-apply-ignore-whitespace.sh
>> @@ -0,0 +1,149 @@
>> ...
>> +cat > patch3.patch <<\EOF
>> +diff --git a/main.c b/main.c
>> +--- a/main.c
>> ++++ b/main.c
>> +@@ -10,1 +10,1 @@
>> + =A0 =A0 =A0 =A0 =A0 =A0 print_int(func(i));
>> +EOF
>
> This part is triply troublesome in that:
>
> =A0(1) the payload ends with trailing whitespace which can be eaten b=
y MUAs
> =A0 =A0 (and I almost always use "git am" with --whitespace=3Dfix);

This is also a problem with some other parts of that patch. I'll apply
the suggestion you mention below to all of them.

> =A0(2) even if we apply your patch correctly, it is very unobvious th=
at you
> =A0 =A0 are testing the case where the line has an unwanted trailing
> =A0 =A0 whitespace; and

I'll add a comment for that that.

> =A0(3) a hunk without any added/deleted lines is an obviously artific=
ial
> =A0 =A0 test input that would not appear in real life, something one =
would
> =A0 =A0 never think of doing unless one knows how "git apply" interna=
lly
> =A0 =A0 works. =A0It makes the test too knowledgable about the implem=
entation.

Right. I'll make it do something else too.

> You can fix the first two issues by doing:
>
> =A0 =A0 =A0 =A0sed -e 's/Z/ /g' >patch3.patch <<\EOF
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0+Z =A0 =A0 =A0print_int(func(i));Z
> =A0 =A0 =A0 =A0EOF
>
> to make invisible SP stand out more for the benefit of people reading=
 the
> test script (I know you did not have leading SP before HT in yours, b=
ut
> the above illustrates the visibility issues). =A0For other tests with=
 test
> vector patches, visibility of whitespace is not much an issue, but th=
is
> script is _all about_ whitespace, so anything that clarifies what is =
going
> on better would help.

Indeed.

>> +test_expect_success "S =3D patch1" \
>> + =A0 =A0'git-apply patch1.patch'
>> +
>> +test_expect_failure "F =3D patch2" \
>> + =A0 =A0'git-apply patch2.patch'
>
> Please say
>
> =A0 =A0 =A0 =A0test_expect_success "whitespace corrupted patch does n=
ot apply" '
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0test_must_fail git apply patch2.patch
> =A0 =A0 =A0 =A0'
>
> instead.
>
> "test_expect_failure" is a declaration that the command being tested =
(in
> this case "git apply") is faulty. =A0It also is a request for somebod=
y
> interested to later fix it (again, in this case "git apply") to make =
this
> test pass.
>
> But you do _not_ want this to pass without an explicit ignore option,=
 so
> test_expect_failure is inappropriate here.

Ah, interesting. This was the first test I wrote (mostly copied from
the original patch) and I didn't have a clear idea of the difference
between the expected failures (although the comment about  'fixing'
that the test printed when some failing case didn't should have put me
on the right track).

I'll resend with a fixed test.

--=20
Giuseppe "Oblomov" Bilotta
