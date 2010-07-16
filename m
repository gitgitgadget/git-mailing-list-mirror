From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH resend] Only run aggregate-results over actual counts
Date: Fri, 16 Jul 2010 14:27:02 +0000
Message-ID: <AANLkTin1BQTWj7AiEuWibanhVKu6UBJmn1iKEF-DB-s9@mail.gmail.com>
References: <AANLkTil4HfoMPD4ds0uXRPruYrz4CtpAy-4TfEk0E_yT@mail.gmail.com>
	<3ce03e702e005a978d3229fa74860d6529296921.1279272868.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 16 16:27:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZlsh-0003PF-0B
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 16:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965725Ab0GPO1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 10:27:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52195 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965676Ab0GPO1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 10:27:05 -0400
Received: by iwn7 with SMTP id 7so2192811iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kU3AufgzjU2U5nl2lOgIMJNx02/w7uENoMC4y3LFEG0=;
        b=EYTzL18YUrcv1Er+vIcZZ+4BCTiQEuGjzj8kb/cETgXtN8/Z5MlXZGzvMibdEtoffR
         VnVS0hfoo/F9eaU+ZTkqevpxxnVx+wncDS4FNjDt0YgG9HeJObofFA6OMBduX1OXNCgj
         gZm/cRaWJ7j07fRhTPkw16u+eCuq9TpMp37ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bc3UljlP/bnlUTPuhD+dh+c9lVxTqnvcZJNglgHFHp8FJMNB5RbuyWqoUPrtKN6iYy
         pcJhheHnRaNIEdkyV6/6GllVxlHIaU/9viWLL+0mCX8Z+fvJr4qVg42L5/VYX1yTNg6X
         MCo9NsH3WQllts6Vt81Eo0IIrdsspW2a4DfBo=
Received: by 10.231.34.11 with SMTP id j11mr953434ibd.120.1279290422657; Fri, 
	16 Jul 2010 07:27:02 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 16 Jul 2010 07:27:02 -0700 (PDT)
In-Reply-To: <3ce03e702e005a978d3229fa74860d6529296921.1279272868.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151153>

On Fri, Jul 16, 2010 at 09:37, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> The current make target 'aggregate-results' scanned all files matchin=
g
> test-results/t*-*. =C2=A0Normally these are only the test counts (and=
 the
> exit values, which are ignored), but with --tee the suite also dumps
> all output. =C2=A0Furthermore, with --verbose t1450 contains several =
lines
> starting with "broken link from ..." which matches the criteria used
> by aggregate-results.sh.
>
> Rename the counts output files to *.counts, and only scan those.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -635,7 +635,7 @@ test_done () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_EXIT_OK=3Dt
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_results_dir=3D"$TEST_DIRECTORY/test-r=
esults"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir -p "$test_results_dir"
> - =C2=A0 =C2=A0 =C2=A0 test_results_path=3D"$test_results_dir/${0%.sh=
}-$$"
> + =C2=A0 =C2=A0 =C2=A0 test_results_path=3D"$test_results_dir/${0%.sh=
}-$$.counts"
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "total $test_count" >> $test_results_=
path
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "success $test_success" >> $test_resu=
lts_path

=46or Junio: FYI this bumps into my "test-lib: Don't write test-results
when HARNESS_ACTIVE" patch in flight. The fixup is trivial though.
