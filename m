From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Tue, 9 Feb 2010 12:55:37 -0500
Message-ID: <76718491002090955g66eca03ar7438e57811616267@mail.gmail.com>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
	 <4B71122F.3040809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeuJL-0002gH-Iq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab0BIRzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 12:55:39 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:62540 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab0BIRzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 12:55:38 -0500
Received: by iwn1 with SMTP id 1so3743827iwn.24
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 09:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wmAPGULDrnv3T8Iawv0EGywMvK9sD2xu4XiWxIfQbKo=;
        b=K4prlRvk5OwNtwk/zFnmz0iHlHCtt/qlTLuNczdHYvj2phXRmdbI1aIpvmUY7v2YWZ
         4oOgJltKgwlpCOxaFr4oiJciZkTJ/9PVbVss3rxqoWN8JqBpzDsAVtYamUh7x5Xuo9+/
         5rjxHwrVuQhEEpbHsb4j5f4tVSnZtgmAcXOs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qi8IELWJNd5UY4LuyNLBartLQsCGaf1zoPk+h6VPOIGca5HJVtMJ1oA/B7N8k2l9DE
         SFBXU05QpUDcDVA7MnllNtUh1agArBmgeM15gQck18TxFIUgK4JXi8dURZCKg2bORqvH
         tM2iBSmEZb+HTC2bJbwF8J+Cfm12tB2ox7AiM=
Received: by 10.231.148.16 with SMTP id n16mr1473228ibv.37.1265738137408; Tue, 
	09 Feb 2010 09:55:37 -0800 (PST)
In-Reply-To: <4B71122F.3040809@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139424>

On Tue, Feb 9, 2010 at 2:43 AM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Jay Soffian schrieb:
>> +test_expect_success 'blame -L with invalid start' '
>> + =C2=A0 =C2=A0 test_must_fail git blame -L5 tres 2>&1 | grep "has o=
nly 2 lines"
>
> Please write this as
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git blame -L5 tres >output =
2>&1 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep "has only 2 lines" output
>
>> +'
>> +
>> +test_expect_success 'blame -L with invalid end' '
>> + =C2=A0 =C2=A0 git blame -L1,5 tres 2>&1 | grep "has only 2 lines"
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git blame -L1,5 tres >outpu=
t 2>&1 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep "has only 2 lines" output
>
> because shells look only at the exit code of the last command in a pi=
peline.

Thanks, I knew that. I'd left in test_must_fail accidentally because
initially I wasn't bothering to grep the output. I then added the grep
and forgot to remove test_must_fail. Isn't this an adequate test:

  test_expect_success 'blame -L with invalid start' '
 =C2=A0 =C2=A0 git blame -L5 tres 2>&1 | grep "has only 2 lines"

As it seems unlikely git would crash and still output the message
correctly in this case.

?

j.
