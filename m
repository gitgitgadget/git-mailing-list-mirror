From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 15:56:11 -0400
Message-ID: <CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
	<7vzk849zxg.fsf@alter.siamese.dyndns.org>
	<20120615193724.GB26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 21:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfccz-000119-3W
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 21:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab2FOT4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 15:56:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55917 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab2FOT4M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2012 15:56:12 -0400
Received: by yhmm54 with SMTP id m54so2809287yhm.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=r5CpOlbK8v8r3j0enL8F82mY7X6lEYruQzZyjeF2/6U=;
        b=jgoX872EA8Ak8fQfT6Ztuojqe8IFIzFZsVYVdnwPimr4XdgGztMmFR8XFh1ao1DYQ/
         JkbeAjiOs2wUIstuM4DGRXCE4e6ntxMf/fImaRVJ3SnHGdHtigKEOStb2BCXkxzSjY+a
         w+oCu9ALZ9sfQmdwgVwVynNOuCgNdh2MEDrUKl5FZfTcsjAmRDk/x8BSAdnmVum6Ri//
         4Gg51fKwHoNzHz/D/CWjdvIVU8HKOTyRB0NiwvwPPWt8p+SduFlCnbfs6sRrSvFLTGvn
         mM8p7+regDN9uYE42FyLY0yLbbE8/ONh/5uArmuRHcVct0e+Fv0+DnFR/4dOiBW0Tawh
         ZX3A==
Received: by 10.50.94.133 with SMTP id dc5mr3199444igb.16.1339790171703; Fri,
 15 Jun 2012 12:56:11 -0700 (PDT)
Received: by 10.231.84.147 with HTTP; Fri, 15 Jun 2012 12:56:11 -0700 (PDT)
In-Reply-To: <20120615193724.GB26473@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200087>

On Fri, Jun 15, 2012 at 3:37 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 15, 2012 at 11:45:47AM -0700, Junio C Hamano wrote:
>
>> I think this breaks a normal case of comparing revisions and tracked
>> contents in a big way.

I didn't understand the ramifications of making the change where I
did.  I appreciate you and Jeff taking the time to point out the
problem (and suggest better solutions).


>> I think the following may be a lot closer to the correct fix; I
>> didn't test many combinations of options with it, though.
>>
>> =C2=A0diff-no-index.c | 5 +++--
>> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index f0b0010..ed74e27 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -172,7 +172,7 @@ void diff_no_index(struct rev_info *revs,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ar=
gc, const char **argv,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int no=
ngit, const char *prefix)
>> =C2=A0{
>> - =C2=A0 =C2=A0 int i;
>> + =C2=A0 =C2=A0 int i, result;
>> =C2=A0 =C2=A0 =C2=A0 int no_index =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 unsigned options =3D 0;
>>
>> @@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* The return code for --no-index imitates=
 diff(1):
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* 0 =3D no changes, 1 =3D changes, else e=
rror
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 exit(revs->diffopt.found_changes);
>> + =C2=A0 =C2=A0 result =3D !!diff_result_code(&revs->diffopt, 0);
>> + =C2=A0 =C2=A0 exit(result);

I assume the '!!' before 'diff_result_code' is a typo.  Reverting my
changes and putting this in solves the problem.

=2E..

> So the patch I posted elsewhere in the thread is not right; we do not
> need to do diff_flush_patch to actually compare, because the
> stat_unmatch code will have done everything we want (unless
> DIFF_FROM_CONTENTS really is set). And the bug is purely one of looki=
ng
> at the wrong output flag.

I will send v2 with the change to 'diff-no-index.c' suggested by
Junio.  I will also include the 'test_expect_code' improvement
suggested by Jeff.
