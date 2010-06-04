From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [RFC/PATCH 4/4] t/t8006: test textconv support for blame
Date: Fri, 4 Jun 2010 10:55:34 +0200
Message-ID: <AANLkTil7Y6PPkbmzuID4vY_fhEwvP4qa2UG5jC1qLtTG@mail.gmail.com>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<1275562038-7468-5-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<201006031744.07569.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 04 10:56:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKSh7-0006pa-Pe
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 10:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab0FDIzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 04:55:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43790 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab0FDIzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 04:55:51 -0400
Received: by fxm8 with SMTP id 8so616828fxm.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=LsZf2otMOD1n42MpjzhKNEgD+OM4pC7yLALBnhYop3Y=;
        b=UY13tyYJcMK9XfgC38D5RGPQWsJUcokOx5k0o2+aprwwlmRBpSCMxdlcZomBfLLbf3
         Tpaxtkf78A1Y7n9AmLmro1xbxW2PKl1awkC3rvj/o4wn0DZfhILTAPsTwAv60oCN55LF
         xSPHSPU91mQhvu5F5kAdlWHiqIh30wl3lZVtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=HpCrCKVFnhPsm/cawp+JLiR6tJV7+L7SWhBvLB940TiCyQC5vdVZdDCVAmKxfOAnkE
         4bAiwF9bxYphJELlIB4nYjg7BVQY9kc9zYF9a3hiWo8LDCH7ukKjyNyiCqgT69UALm6U
         08pmg7lw3/k8sHxIoVEg2AsgfJvoOinbgd0js=
Received: by 10.239.166.84 with SMTP id a20mr73823hbe.85.1275641749214; Fri, 
	04 Jun 2010 01:55:49 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Fri, 4 Jun 2010 01:55:34 -0700 (PDT)
In-Reply-To: <201006031744.07569.j6t@kdbg.org>
X-Google-Sender-Auth: AQ9dKkn7s4T2bBcwlbJ7IAm8JKE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148388>

Le 3 juin 2010 17:44, Johannes Sixt <j6t@kdbg.org> a =E9crit :
> On Donnerstag, 3. Juni 2010, Axel Bonnet wrote:
>> +cat >helper <<'EOF'
>> +#!/bin/sh
>> +sed 's/^/converted: /' "$@" >helper.out
>> +cat helper.out
>> +EOF
>
> You don't need an intermediate file here, do you? Without it, this te=
xtconv
> script is a one-liner; now, isn't it possible to configure a shell co=
mmand as
> textconv command, i.e., without this helper script?
>

Ok. We don't use the intermediate file anymore. Actually, we used what
has been done for textconv test for diff.
I didn't find a way to directly specify the sed command as textconv
command without using ./helper though.

cat >helper <<'EOF'
#!/bin/sh
sed 's/^/converted: /' "$@"
EOF
chmod +x helper

>> +test_expect_success 'setup ' '
>> + =A0 =A0 echo test 1 >one.bin &&
>> + =A0 =A0 echo test number 2 >two.bin &&
>> + =A0 =A0 ln one.bin link.bin &&
>
> Do you need a hard link? Can't you just copy the file at the right ti=
me?
>

At first, we wanted to test how links handle textconv but it behaves
as regular file so the test is not really relevant. It will be
deleted.

>> +test_expect_success 'blame with --no-textconv' '
>> + =A0 =A0 git blame --no-textconv one.bin | grep Number2 >blame
>> + =A0 =A0 find_blame <blame >result
>
> It would be nice if you could write this like, e.g.,
>
> =A0 =A0 =A0 =A0git blame --no-textconv one.bin >blame &&
> =A0 =A0 =A0 =A0find_blame Number2 <blame >result
>
> so that the git command is not part of a pipeline (otherwise, unexpec=
ted exit
> codes would go undetected).
>
> Please look for missing '&&', you forgot it in many places.
>

We did the appropriate changes.
Thanks a lot for your comments!

Diane

> -- Hannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
