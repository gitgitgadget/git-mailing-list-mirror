From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/2] tests: move code to run completion tests under
 bash into a helper library
Date: Tue, 17 Apr 2012 10:37:18 +0300
Message-ID: <CAMP44s2isAvmEhaTJpg8qsT967ghkvjyU1OAnTLMZSb5MSsnXw@mail.gmail.com>
References: <20120416160124.GL5813@burratino>
	<1334614176-2963-1-git-send-email-szeder@ira.uka.de>
	<4F8D19B8.1040004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 09:37:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK2yb-0005b6-Cw
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 09:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab2DQHhV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 03:37:21 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48680 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab2DQHhU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 03:37:20 -0400
Received: by eaaq12 with SMTP id q12so1474270eaa.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=a2Sxnc82KYOt4kgWNGwBSFz3BvIOV9k/E37OgMa7eMs=;
        b=vYwkFzsAcdxCa2T0sJDpZGENpvZI4MhgfnuS19B4BMNDRs2Z4xI6gTTuSAGggKT1NQ
         2wcyeGE+PFQoki+F+1Zmq0t03PJ2ZOVG2/BaMOb9S7BNXijDrFU4PiNnNTfHbU/VsWcS
         Gjw17oc9ppIMtqifgp1xFnubHvJeizsYBO5AZO5oKVJLinwE5E7+D9Lhia4OEaPp4QHr
         XmLiSga7n7tBIWACuRhwhU/vUDKO2NZWeJSW1VDXTgagmg1xh131lE3fTzSQTualiaOP
         phuAFmpBZltk950ow2u07zxOMeC4so7Rivim6xokUgvRiVGAQtiip3bdH4KbasMdTqVy
         TyEA==
Received: by 10.213.32.2 with SMTP id a2mr990201ebd.39.1334648238980; Tue, 17
 Apr 2012 00:37:18 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Tue, 17 Apr 2012 00:37:18 -0700 (PDT)
In-Reply-To: <4F8D19B8.1040004@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195738>

2012/4/17 Johannes Sixt <j.sixt@viscovery.net>:
> Am 4/17/2012 0:09, schrieb SZEDER G=C3=A1bor:
>> diff --git a/t/lib-completion.sh b/t/lib-completion.sh
>> new file mode 100644
>> index 00000000..3d85feb2
>> --- /dev/null
>> +++ b/t/lib-completion.sh
>> @@ -0,0 +1,17 @@
>> +#!/bin/sh
>> +#
>> +# Ensures that tests of the completion script are run under Bash.
>> +
>> +if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
>> + =C2=A0 =C2=A0 # we are in full-on bash mode
>> + =C2=A0 =C2=A0 true
>> +elif type bash >/dev/null 2>&1; then
>> + =C2=A0 =C2=A0 # execute in full-on bash mode
>> + =C2=A0 =C2=A0 unset POSIXLY_CORRECT
>> + =C2=A0 =C2=A0 exec bash "$0" "$@"
>> +else
>> + =C2=A0 =C2=A0 echo '1..0 #SKIP skipping bash completion tests; bas=
h not available'
>> + =C2=A0 =C2=A0 exit 0
>> +fi
>
> I wonder what this 'echo...;exit' is about (I do so since I saw it th=
e
> first time when Felipe submitted his patch). Shouldn't it be more lik=
e:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0skip_all=3D'skipping bash completion tests=
; bash not available'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_done

It should, if the test library was loaded at that point, but it isn't.
BTW, I didn't write that code.

In any case, what the user sees is exactly the same, except without col=
or.

Cheers.

--=20
=46elipe Contreras
