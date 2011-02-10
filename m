From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 6/7] tag: support column output with --column
Date: Thu, 10 Feb 2011 09:35:38 +0700
Message-ID: <AANLkTinHyX+uiO+Oj3N3NAEjbZmE=vbKsA+C+tQ6B-Db@mail.gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <1297178541-31124-7-git-send-email-pclouds@gmail.com> <7vvd0sop15.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 03:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnMOc-0004co-Rx
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 03:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab1BJCgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 21:36:11 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54780 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab1BJCgJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 21:36:09 -0500
Received: by wwa36 with SMTP id 36so916956wwa.1
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 18:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=qKuYeVB0jTb34+GsoFCFIdVC1B5i2zkxyMYgdFMWFUg=;
        b=oQklIFAoGxAicBTylOQ+rLlUIQYKlm/DuB0BRoPwwdNVUKaoZUCcwcRb/02I8xRiJR
         Kcqm5Cz7qK3NL4qMoz8UKcJgLMpUI6R7oPtp4dJVOU16vxSFuA3CFIKj9MDssw5vd31T
         GMMAMVZIf46s6jXjnmVeouZFIveiDGJJt7gDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LjUZW39eX4CbLSxrFKq3Lq2z6g6EW3J69SagvCbjEEG2RlH9XuGly0tRQEpxZA9fQm
         priRXPY6B4e8acwYONRlB87+qEwBou6fYVZBe8sCIHmxNeKuKXxliNDrYxjFJlcbqtME
         hKz0vlbfy67z+7sQOgn66HeCl3QOiSNm0MGtI=
Received: by 10.216.163.69 with SMTP id z47mr17990479wek.43.1297305368208;
 Wed, 09 Feb 2011 18:36:08 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 9 Feb 2011 18:35:38 -0800 (PST)
In-Reply-To: <7vvd0sop15.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166468>

2011/2/10 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> @@ -52,7 +54,7 @@ static int show_reference(const char *refname, con=
st unsigned char *sha1,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!filter->lines)=
 {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 printf("%s\n", refname);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 string_list_append(&layout.items, refname);
>
> Hmm, is this robbing streaming output from people who do not care abo=
ut
> columnar output?

Yes, but tag list is short enough streaming does not really matter. I
can check if column mode is active there, if it's not, just printf.

> I tend to agree with others who suggested you to port column to platf=
orms
> that lack it.

The first version of this series created git-column and made a pipe to
git-column when column output is active. I'll resurrect the command
then. Original column does not understand ANSI escape codes for
coloring and mess up column output.
--=20
Duy
