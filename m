From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] WIP: Report intra-test progress with TAP subtests
Date: Wed, 11 Aug 2010 00:55:49 +0000
Message-ID: <AANLkTi=ygXFpRLR_Z7iEXX3THh+GT7P7X9o+NnaLajqs@mail.gmail.com>
References: <1281473829-2102-1-git-send-email-avarab@gmail.com>
	<20100811004425.GI2099@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 02:55:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oizbo-0004cF-OT
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 02:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab0HKAzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 20:55:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47881 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab0HKAzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 20:55:51 -0400
Received: by fxm13 with SMTP id 13so1079501fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u7U15L8LTt9ZI3VCC/Kp+aFU451tmttOxPMbvRk80wo=;
        b=pwJ7F//1XKWO9FPo3sb99YgdbsrdL7gqJVl5TQHZuWHSQvt2fwKs5YfJvdp2gqDS7P
         DBTI+wSnfrfKYJ+iy+fEG5tpJngTeQz7OV90OFeu3P+Wj4HwinWIslNqAeOebNwj40jj
         B6Mlr7xyAguJcounuwk4Ut62/UFu16jGWOu5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x60GD1qWJuqtHU5qowy8N0MkIyb2URUz7HwKkZzTs1tBIbSWu/Ou7zbLDhdGc6aFXN
         Hycu72MRT0j3OJONe+M/d7x/4iMO6vebXym36j49ub8rUVFn+6eisiy14QFti14WjDRd
         lPa/iseTJHTHmoQ+vzoNJobgN21C6xY2QpIO8=
Received: by 10.223.106.8 with SMTP id v8mr987944fao.104.1281488149441; Tue, 
	10 Aug 2010 17:55:49 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 10 Aug 2010 17:55:49 -0700 (PDT)
In-Reply-To: <20100811004425.GI2099@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153178>

On Wed, Aug 11, 2010 at 00:44, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi =C3=86var,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> =C2=A0 =C2=A0ok 1 - A git test
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ok 1 - doing test -f file
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ok 2 - git commit ...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ok 3 - test_tick...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A01..3
>> =C2=A0 =C2=A0ok 2 - A git test
>> =C2=A0 =C2=A01..2
>>
>> Here's an attempt at that, I've convented test_commit, test_merge an=
d
>> test_cmp to report intra-test progress.
>
> What if a test uses none of those commands?

Then it won't get any progress output.

> The ultimate conclusion of such an approach would be to use
> replacements for common commands like =E2=80=9Cgit=E2=80=9D and =E2=80=
=9Ccd=E2=80=9D, making tests a
> lot harder to read and write for the uninitiated.

Yes, but there's a middle ground here. We use a lot of utility
functions in the tests, adding tracing to these makes it easier to see
what's going on, especially in large tests.

> If we get peeks where the infrastructure has a chance to provide
> them, maybe it would be nice to allow explicitly inserting such
> checkpoints, too? =C2=A0Like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mv init init2 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0checkpoint &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config -f .gitmodules submodule.exampl=
e.url "$(pwd)/init2" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0checkpoint &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config --remove-section submodule.exam=
ple &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0checkpoint &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[...]
>
> while debugging.

Yeah. I was going to add something like that if I got this working.

> However, I would rather see those inserted automatically.
> Two ideas without code to back them up:
>
> 1. Script parsing.
>
> Yes, parsing shell command language is hard, but tests use only
> a subset of it. =C2=A0In particular the &&-chaining means it might
> be relatively easy to find where each command starts and ends.
>
> The hard bits: =E2=80=9Cif=E2=80=9D, =E2=80=9Cwhile=E2=80=9D, and =E2=
=80=9Cfor=E2=80=9D flow control constructs.
>
> The payoff of even partial progress in this would be very high,
> since it should make static analysis of &&-chaining possible.

Sounds like a good long term project, and shouldn't be so hard for the
simple case.

> 2. Letting the shell trace for us.
>
> When tests fail, I generally use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sh -x ./failing-test.sh -v -i
>
> and scroll back through the log to the important part.
>
> Maybe the test harness could automate that a little, by using
> set -x at the beginning and set +x at the end of each test.

The main use case for this for me is the smoke tester output, where
you won't get access to the original machine (without asking). Having
a few intra-test checkpoints helps you to see where things might have
gone wrong.
