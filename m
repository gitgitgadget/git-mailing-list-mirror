From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2] t4018: introduce test cases for the internal hunk
 header patterns
Date: Tue, 20 Dec 2011 09:58:37 -0600
Message-ID: <CA+sFfMd95-T9K2CztByo7d9Yn-RN58oYfAz0ZA1Gp+84oBBs2g@mail.gmail.com>
References: <7vmxaokv6k.fsf@alter.siamese.dyndns.org>
	<1324348939-27115-1-git-send-email-drafnel@gmail.com>
	<m3pqfjfy42.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	j6t@kdbg.org, jrnieder@gmail.com, trast@student.ethz.ch
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 16:58:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd25T-0001r2-7R
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 16:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab1LTP6j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 10:58:39 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37600 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751516Ab1LTP6i convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 10:58:38 -0500
Received: by obcwo16 with SMTP id wo16so2505629obc.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 07:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PsY4GeHS+MxxTk7+RWuFZJ4Ou05Yux8YNzCyoMQJ4ug=;
        b=mQ9RHBb3ikf1eDOiWHuUY8atSu3o8oEjLc05aKP+VLXCYwHAq+3gE4o3JfsS29/cjf
         SoWpmn2u4/C9sHyaLQidNt8qxgp+kPY0j4w3kGTrzt/48P6HevIAAI+HdkBlL2gXR9I9
         vMPqHA2r6k8wFgeIPs3LMDkI6eFUjZ2GeH0Ss=
Received: by 10.182.13.42 with SMTP id e10mr2210679obc.18.1324396717571; Tue,
 20 Dec 2011 07:58:37 -0800 (PST)
Received: by 10.182.37.170 with HTTP; Tue, 20 Dec 2011 07:58:37 -0800 (PST)
In-Reply-To: <m3pqfjfy42.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187514>

On Tue, Dec 20, 2011 at 2:25 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> diff --git a/t/t4018/ignore_global.cpp b/t/t4018/ignore_global.cpp
>> new file mode 100644
>> index 0000000..95e23bc
>> --- /dev/null
>> +++ b/t/t4018/ignore_global.cpp
>> @@ -0,0 +1,19 @@
>> +int WRONG_function_hunk_header_preceding_the_right_one (void)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +int RIGHT_function_hunk_header (void)
>> +{
>> + =C2=A0 =C2=A0 printf("Hello, world\n");
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +int WRONG_global_variable;
>> +
>> +int ChangeMe;
>> +
>> +int WRONG_function_hunk_header_following_the_right_one (void)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> Shouldn't ChangeMe be inside function?

No, this one is placed here after the WRONG_global_variable to make
sure that a global variable is not chosen for the hunk header.  It
should chose the most recently encountered function name for the hunk
header, which is RIGHT_function_hunk_header.

>> diff --git a/t/t4018/simple.cpp b/t/t4018/simple.cpp
>> new file mode 100644
>> index 0000000..c96ad87
>> --- /dev/null
>> +++ b/t/t4018/simple.cpp
>> @@ -0,0 +1,32 @@
>> +/*
>> + * =C2=A0Test file for testing the internal hunk header patterns
>> + *
>> + * =C2=A0The "RIGHT" hunk header function, the one that should appe=
ar on the
>> + * =C2=A0hunk header line, should be named "RIGHT_function_hunk_hea=
der" and
>> + * =C2=A0the body of this function should have an assignment that l=
ooks like
>> + *
>> + * =C2=A0 =C2=A0 answer =3D 0
>
> Shouldn't it be ChangeMe?

Whoops, I forgot about that text.  Thanks for noticing.  Yes this is
incorrect now.  I think I'll break that out into a README file.

v3 forthcoming.

-Brandon
