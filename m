From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] test-lib: use subshell instead of cd $new && .. && cd $old
Date: Mon, 30 Aug 2010 16:01:43 +0000
Message-ID: <AANLkTi=z9uUB_YZ9Sb0O8JzaEjazKDzqB=ZVtqTTDf2K@mail.gmail.com>
References: <1283169642-21917-1-git-send-email-avarab@gmail.com>
	<20100830155723.GC3292@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Carl Worth <cworth@cworth.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 18:01:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq6nv-0006T9-42
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 18:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab0H3QBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 12:01:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42988 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824Ab0H3QBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 12:01:44 -0400
Received: by fxm13 with SMTP id 13so3344929fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GrZ8Kr5/KVyoVcC1vS8kZe0u1wdQIkSAFwZ/qZWJ5eA=;
        b=fOmQGx1V8TmZ+UpfFjHcj5rOBZ1g2seSBKRq67bmLJKuj3bYGJJL2YHdG8Ld1JbB6N
         ngaRcoR9MjD3tzRaHy2eVAHTl83j6pXVHgeGeXFiBaxelp//aNnxfiG9Rn3BUtDOYrPD
         q4cWbcsr1XNZmbExHTozTCA6YaAWxAeC4O7ms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QqMeo9Cewp9T0Qn6xQli2T2Lh0AieiJ/dAgOm4FZbhvSpruhop3fsBCyGGbba0PUyZ
         1VjIyJ8tpN1N54Lz3+KFarfAYAcPt/qaoeKCvPJCHKEDrzQQwt22/HTQVeJBk2mwvwFb
         kl5iVN2tyFmg7iID58vYPXaaBS+Q3ScaZw24U=
Received: by 10.223.126.68 with SMTP id b4mr4021374fas.96.1283184103144; Mon,
 30 Aug 2010 09:01:43 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 30 Aug 2010 09:01:43 -0700 (PDT)
In-Reply-To: <20100830155723.GC3292@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154825>

On Mon, Aug 30, 2010 at 15:57, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> +++ b/t/test-lib.sh
>> @@ -687,14 +687,12 @@ test_when_finished () {
>> =C2=A0test_create_repo () {
>> =C2=A0 =C2=A0 =C2=A0 test "$#" =3D 1 ||
>> =C2=A0 =C2=A0 =C2=A0 error "bug in the test script: not 1 parameter =
to test-create-repo"
>> - =C2=A0 =C2=A0 owd=3D`pwd`
>> =C2=A0 =C2=A0 =C2=A0 repo=3D"$1"
>> =C2=A0 =C2=A0 =C2=A0 mkdir -p "$repo"
>> - =C2=A0 =C2=A0 cd "$repo" || error "Cannot setup test environment"
>> + =C2=A0 =C2=A0 (cd "$repo" || error "Cannot setup test environment"
>> =C2=A0 =C2=A0 =C2=A0 "$GIT_EXEC_PATH/git-init" "--template=3D$GIT_BU=
ILD_DIR/templates/blt/" >&3 2>&4 ||
>> =C2=A0 =C2=A0 =C2=A0 error "cannot run git init -- have you built th=
ings yet?"
>> - =C2=A0 =C2=A0 mv .git/hooks .git/hooks-disabled
>> - =C2=A0 =C2=A0 cd "$owd"
>> + =C2=A0 =C2=A0 mv .git/hooks .git/hooks-disabled)
>
> Style: why not use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd "$repo" ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... .git/hooks=
-disabled
> =C2=A0 =C2=A0 =C2=A0 =C2=A0)
>

I've seen both used and I don't know which is preferred.
