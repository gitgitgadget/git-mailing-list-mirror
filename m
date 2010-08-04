From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] tests: A new test prereq for testing chmod -w as root
Date: Wed, 4 Aug 2010 20:30:28 +0000
Message-ID: <AANLkTikgVF5JGi2Aacpsv=KE5uXGuzmyEVXgVPrTfkdh@mail.gmail.com>
References: <1280934026-25658-1-git-send-email-avarab@gmail.com>
	<7veieefaym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 22:30:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogkbk-0000FN-UJ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 22:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934744Ab0HDUac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 16:30:32 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58914 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934605Ab0HDUaa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 16:30:30 -0400
Received: by gxk23 with SMTP id 23so2156346gxk.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vqdcworioNLP2Mob3JWJ3cTZPF/qU619ALlTCvxNTVU=;
        b=rrJTBX1FLZ3M4ijgAeCkBnav8+j7vzSLNtpsWhrj0yQ4sgRDajFS9/UWc6GWpphqlD
         W+isbaAev6JLX4w2Gv4b1CxsM7HYw5RJhc+HS+v4ISZfDonP1UoDWrv+FwUyBfEeu36x
         aXOvjyq3ufag0ZeRD3bpNuoF41SgZbY4z+Ti4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=otZc8CH4kGtu6RPsRurJ8EpBCwi4LU2VAno+37ffXe/H6WFUQ1bUn+6R/h5aOqhgAW
         +O6jjN3NjxJ9z//0URhnpPZwwNStM0OLKLfhMXDzmrtw0q0gdkYyJ+fKE3FythNAoOcO
         dteX6eUe3EeebL9saCiD0iMSgVPfzvH3N4qMw=
Received: by 10.231.19.6 with SMTP id y6mr10645927iba.16.1280953829174; Wed, 
	04 Aug 2010 13:30:29 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 4 Aug 2010 13:30:28 -0700 (PDT)
In-Reply-To: <7veieefaym.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152601>

On Wed, Aug 4, 2010 at 19:13, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Some tests depend on not being able to read files after chmod -w. Th=
is
>> doesn't work when running the tests as root.
>
> Obviously you meant s/read/write/ or "chmod -r" ;-)

Yeah. I'll fix that in a future submission. Pending the question of
whether there's any interest.

> We discussed this prerequisite in the past as "SANITY", in the dual s=
ense
> that (1) nobody sane should be running tests as root and (2) for root=
 many
> normal assumptions programs make do not hold. =C2=A0If we throw out t=
he former
> by saying that it is safe to run tests under fakeroot, we would need
> something like this patch to cover the latter. =C2=A0The patch is a s=
tep in the
> right direction.

I sometimes run stuff like this as root, although obviously not often
enough to have bumped into this before with Git. But sometimes you
don't care about user seperation, e.g. inside a virtual machine.

When I bumped into this I was writing a script to run in cron that
would build and install pu daily in /usr/local if tests passed. Since
I needed root to install there I was running the whole script as root,
it was easier than giving the script permission to sudo or granularly
adjusting the permissions of /usr/local.

In any case, seemingly randomly breaking if the tests are run as root
is a bad thing which should be fixed.

> I wonder if we want to be so specific, as your patch does, to single =
out
> "you can write even to a-w file" aspect of rootness, or just want to =
cover
> the rootness more broadly so that other rooty conditions like "if you=
 can
> read even an a-r file, then the assumptions the test makes will not h=
old"
> and "if you can kill other's processes, ...ditto..." can also be cove=
red
> with a single prerequisite token.

Well, in practice it was the one and only thing that broke under
root. And it's something that can be compartmentalized easily and
tested for without cheating and checking if UID =3D=3D 0.

> Also I think there was a discussion and proposed patch to support mor=
e
> than one prerequisite tokens, concatenated with "," or something, lik=
e:
>
> =C2=A0 =C2=A0test_expect_success POSIXPERM,SANITY 'notice unwritable =
repo' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... test that depends on posixperm and not=
 running
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... as root comes here
> =C2=A0 =C2=A0'
>
> so that you don't have to invent permutations of prerequisite tokens.

I almost implemented something like that when rolling this series. Do
you happen to have the Message-ID of the thread or some pertinent
search keywords? Maybe I'll resurrect it. We're using that sort of
thing in a couple of places.

I didn't implement it because I was worried about handling the 'FOO &&
BAR' and 'FOO || BAR' cases, and combinations thereof. That's probably
overthinking it though, AND-ing them together seems to be good enough,
and simple to do.
