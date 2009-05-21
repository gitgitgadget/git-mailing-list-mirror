From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 2/3] t/t3400-rebase.sh: add more tests to help 
	migrating git-rebase.sh to C
Date: Thu, 21 May 2009 20:39:28 +1000
Message-ID: <fcaeb9bf0905210339t44e09c93r1b125dbded8be79@mail.gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> 
	<1242899229-27603-2-git-send-email-pclouds@gmail.com> <m3ab56kb7y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 12:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M75gr-0001nz-Gg
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 12:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbZEUKjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 06:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbZEUKjr
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 06:39:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:22478 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbZEUKjr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 06:39:47 -0400
Received: by yw-out-2324.google.com with SMTP id 5so619725ywb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VjpVIhldtkFTJTYFqnHZtTT/XlUnf0HnljmUsgCqFa8=;
        b=PcNqsdgZ3hej95vDNuwJ6x6oRI5M6khqTqCN8BN8LVYvXTfrGEYFbxPHdlAzm1Zq/X
         lmk+vQiNUuzY6gWIvNOoRzdsUN7gB4EVHwn/Bs1MWeEjjrzKzC6IfMl7fFrAOj1wgE8k
         aWuMSZftSI7EIw5NszSnPElIMeONPmDVHBRPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=N+AZFEmMvgNqGaOTGgt9HBR5VosHDf85gQb0xxDjo9f/HgJfDwhKAvHpI202d/GxYH
         qNfqwl+9HugLVLHr1+gaoNFg9khrgmktW27BM0gHE/cYCKX7JsOwbwFgZYFfIf3pDg0v
         FLbt0vKisBsbPA9GM/l9If7jojIJzYq6s0hus=
Received: by 10.100.132.4 with SMTP id f4mr4680086and.109.1242902388155; Thu, 
	21 May 2009 03:39:48 -0700 (PDT)
In-Reply-To: <m3ab56kb7y.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119671>

2009/5/21 Jakub Narebski <jnareb@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0 =C2=A0<pclouds@gmail=
=2Ecom> writes:
>
>> These new tests make sure I don't miss any check being performed bef=
ore
>> rebase is proceeded (which is well tested by other tests)
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0t/t3400-rebase.sh | =C2=A0 28 ++++++++++++++++++++++++++++
>> =C2=A01 files changed, 28 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 6e391a3..37f86ab 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -41,9 +41,37 @@ test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0 git tag topic
>> =C2=A0'
>>
>> +test_expect_success 'rebase on dirty worktree' '
>> + =C2=A0 =C2=A0 echo dirty >> A &&
>> + =C2=A0 =C2=A0 ! git rebase master'
>
> Shouldn't you use test_must_fail instead? From t/test-lib.sh
> (paraphrasing):
>
> =C2=A0Writing this as "! git rebase master" is wrong, because
> =C2=A0the failure could be due to a segv. =C2=A0We want a controlled =
failure.

Right. Shouldn't we have another patch to fix this once and for all? I
did "grep -F '! git'" and find a few places applicable too.

>> +
>> =C2=A0test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0'the rebase operation should not have destroyed =
author information' \
>> =C2=A0 =C2=A0 =C2=A0'! (git log | grep "Author:" | grep "<>")'
>
> Errrr... what? =C2=A0Why git-log and not git-cat-file? =C2=A0Why grep=
 twice?
> Additionally you do not check here that author is unchanged, only tha=
t
> is not destroyed.

Errr.. this is not from me. No idea why.
--=20
Duy
