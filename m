From: Subho Banerjee <subs.zero@gmail.com>
Subject: Re: [PATCH][GIT.PM 2/3] Getting rid of throwing Error::Simple objects
 in favour of simple Perl scalars which can be caught in eval{} blocks
Date: Wed, 23 May 2012 16:32:00 +0530
Message-ID: <CAB3zAY3nVDiBH6kJKK9YTXKsaFZZnUz7AAFh5z+J0VhXHjYiMQ@mail.gmail.com>
References: <7vobpulhbk.fsf@alter.siamese.dyndns.org> <1337411317-14931-1-git-send-email-subs.zero@gmail.com>
 <1337411317-14931-2-git-send-email-subs.zero@gmail.com> <4FB76A21.7000801@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed May 23 13:02:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SX9Ks-0006sS-A9
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 13:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab2EWLCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 07:02:24 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64506 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab2EWLCX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 07:02:23 -0400
Received: by vbbff1 with SMTP id ff1so4459040vbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 04:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qHeaoGjB1wXWDT5YTCHE0NurQBeRxh8BtXrnhNvLVK4=;
        b=KTq92ioWKzfvHWaMke5ipC474K5ETGc8UmrmJNy+w1N6vNz1CVcg81XvbTyNeBMrE0
         2z2MBQmpNjr2maC0HmFAoCF2ko5q6ogsbsEwyQmusMnSLKxDfL1mUDoJzQ8rR6aug/hX
         Ie1vLEhTx0NDcHyDjry6a/VuZtfRZaU0jcAyk5Gli6+Goguqu9EhGVTTURCTRSp4o0F/
         jW57KpsY3CKcwnZFDI2ucCnh8/gGCi1aRHuBYEpqsUEeI4mrS+DyUiyuFTTY+VDnbvIz
         MVw46Mcq4QN9mDo6sidF6P6cnnlYhlBlIP0cJAFsSeYk5fgMIfY2xNyy9YCxShQ0J85h
         ez+A==
Received: by 10.52.89.102 with SMTP id bn6mr12099070vdb.46.1337770942138; Wed,
 23 May 2012 04:02:22 -0700 (PDT)
Received: by 10.220.48.20 with HTTP; Wed, 23 May 2012 04:02:00 -0700 (PDT)
In-Reply-To: <4FB76A21.7000801@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198278>

Hi,
The semantic
> =A0 =A0 =A0 =A0<fail> unless <noun>
works well when the <fail> part of the code is a singular statement.
But it is of ungainly when there are a couple of statements to be
executed as a block. In this case, I believe that a the conjunctive
,,or''/,,and'' statement makes more sense. In the sense -
                 <verb1> or <die_gracefully1> and <die_gracefully2>
I believe this is easier to read compared to -
                 <die_gracefully1> and <die_gracefully2> unless <noun>
especially if you have a larger block of commands to execute in case
of the failure. I believe the easiest to read would be a classical C
styled if() block, but that would make the code more "verbose" :-)

But I am open to the change of the ,,or''s to ,,unless"s. They are
just cosmetic changes. I can submit patches to that effect if that's
what you guys want.

Cheers,
Subho.

On Sat, May 19, 2012 at 3:08 PM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:
> I'll limit myself to a style review here - other people can say bette=
r
> than me about the deeper issues.
>
> On 19/05/12 08:08, Subho Sankar Banerjee wrote:
> <snip>
>> @@ -160,7 +160,7 @@ sub repository {
>> =A0 =A0 =A0 if (defined $args[0]) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($#args % 2 !=3D 1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # Not a hash.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $#args =3D=3D 0 or throw E=
rror::Simple("bad usage");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $#args =3D=3D 0 or die "ba=
d usage";
>
> This is valid and no worse than before, but I find this use of the "o=
r"
> operator slightly confusing. =A0I find it easier to read either:
>
> =A0 =A0 =A0 =A0<verb> or <fail>
> =A0 =A0 =A0 =A0OR:
> =A0 =A0 =A0 =A0<fail> unless <noun>
>
> For example:
>
> =A0 =A0 =A0 =A0do_something($foo) or die "couldn't do_something with =
'$foo'";
> =A0 =A0 =A0 =A0OR:
> =A0 =A0 =A0 =A0die "'$foo' is not a something" unless is_something($f=
oo);
>
> <snip>
>> @@ -1041,7 +1041,7 @@ sub _temp_cache {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ($$temp_fd, $fname) =3D File::Temp->temp=
file(
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 'Git_XXXXXX', UNLINK =3D=
> 1, DIR =3D> $tmpdir,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ) or throw Error::Simple("=
couldn't open new temp file");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ) or die "couldn't open ne=
w temp file";
>
> This is a good example of where I think "or" is appropriate.
>
> Think of it in terms of an English sentence. =A0Which of these would =
you
> find easier to read:
>
> =A0 =A0 =A0 =A0It is raining or go out and play
> =A0 =A0 =A0 =A0OR:
> =A0 =A0 =A0 =A0Go out and play unless it is raining
>
> =A0 =A0 =A0 =A0Find your umbrella or cancel the trip
> =A0 =A0 =A0 =A0OR:
> =A0 =A0 =A0 =A0Cancel the trip unless find your umbrella
>
>
> A bit of background for people who aren't (primarily) Perl programmer=
s:
>
> As an expressive language that promotes "more than one way to do it",
> Perl has a long tradition of supporting many redundant ways of spelli=
ng
> "if (...) { ... }". =A0Common examples include:
>
> =A0 =A0 =A0 =A0if ( $x ) { do_something() }
> =A0 =A0 =A0 =A0do_something() if $x;
>
> =A0 =A0 =A0 =A0unless ( $x ) { do_something() }
> =A0 =A0 =A0 =A0do_something() unless $x;
>
> =A0 =A0 =A0 =A0$x && do_something();
> =A0 =A0 =A0 =A0$x || do_something();
>
> =A0 =A0 =A0 =A0$x and do_something();
> =A0 =A0 =A0 =A0$x or do_something();
>
> Sometimes people find very practical reasons why these aren't good
> programming practice, but the rest of the time everyone just argues
> about whether they're good grammar.
>
> The "&&" and "||" operators are an example of bad programming practic=
e -
> these operators have relatively high precedence, so tend to behave
> unintuitively when used in (often regrettably) complex ways. =A0The "=
and"
> and "or" operators behave just like "&&" and "||", but with a precede=
nce
> low enough to avoid weirdness. =A0See [1] for an example.
>
> Some people consider anything but a traditional prefix-if() statement=
 to
> be bad grammar (I believe "Perl Best Practices" makes the argument,
> which is definitive for many people). =A0Other people say anything in=
 the
> language is by definition fair game. =A0The rest of us spend a lot of=
 time
> making arguments like the above, and frankly I think we gain more fro=
m
> the debate than the conclusion.
>
> =A0 =A0 =A0 =A0- Andrew
>
> [1] http://perldoc.perl.org/perlop.html#C-style-Logical-Defined-Or
