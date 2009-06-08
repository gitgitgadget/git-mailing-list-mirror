From: Marco Nelissen <marcone@xs4all.nl>
Subject: Re: [PATCH] fix handling of iconv configuration options
Date: Mon, 8 Jun 2009 16:51:18 -0700
Message-ID: <3a3d9e520906081651r33b485c2v745c4275a25c0f58@mail.gmail.com>
References: <3a3d9e520906071745k1fde4215xba310d945db37979@mail.gmail.com>
	 <7vhbyqwg2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 01:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDoch-0006K0-9J
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 01:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbZFHXvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 19:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZFHXvR
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 19:51:17 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:52127 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbZFHXvQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 19:51:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so6378738and.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=qsXmuu0ZP8VSXXrqDy4LX+vENGv5c/BYTGtFAbPTll8=;
        b=CjhL74IE+S3ZVX0s1GLiIPpJF4pm6FpLRlJQBsEROoQpJhuHKQmzExa5eJ4ue2zzhP
         rjKw0tzvwZ2DuC0HKyOR/0yBe5wuXorQ3TtPmZl/8arDoYPwzvXtD3YgE/PVoidaRh7e
         So0SXN9gWUM+m2q47s0KZ49xx1xUFdoc33uBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=aQzHbP4ICLfXgsqB9Uf4LqZQoUaRYCGSYTGDFQmfDDlRdsIbu/CKcE21XqgIAroLaz
         G6ZIUGX2r9DEmy2aQbuXZWdhMtwHl9DJ06SzwhNulSbDfMbH0SbLhdqWB0dTve5eby2o
         3ySl/wV2L6KnSt2CXEjYUV0A1qnM7UqULBTY4=
Received: by 10.100.96.12 with SMTP id t12mr884020anb.4.1244505078439; Mon, 08 
	Jun 2009 16:51:18 -0700 (PDT)
In-Reply-To: <7vhbyqwg2y.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 4c72ffb2079b75ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121132>

On Mon, Jun 8, 2009 at 2:50 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Marco Nelissen <marcone@xs4all.nl> writes:
>
>> diff --git a/configure.ac b/configure.ac
>> index 108a97f..3388036 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -385,6 +385,8 @@ AC_SUBST(NO_EXPAT)
>> =C2=A0# some Solaris installations).
>> =C2=A0# Define NO_ICONV if neither libc nor libiconv support iconv.
>>
>> +if test -z $NO_ICONV; then
>> +
>> =C2=A0GIT_STASH_FLAGS($ICONVDIR)
>>
>> =C2=A0AC_DEFUN([ICONVTEST_SRC], [
>> @@ -431,6 +433,12 @@ GIT_UNSTASH_FLAGS($ICONVDIR)
>> =C2=A0AC_SUBST(NEEDS_LIBICONV)
>> =C2=A0AC_SUBST(NO_ICONV)
>>
>> +if test -n $NO_ICONV; then
>> + =C2=A0 =C2=A0NEEDS_LIBICONV=3D
>> +fi
>> +
>> +fi
>> +
>
> Hmm, have you tested this with both NO_ICONV defined and undefined?
>
> Because ...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ test -z ; echo $?
> =C2=A0 =C2=A0 =C2=A0 =C2=A00
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ test -n ; echo $?
> =C2=A0 =C2=A0 =C2=A0 =C2=A00
>
> ... I would feel better if you had dq around $NO_ICONV in both tests.

Ah, you're right. I tested that it didn't incorrectly set
NEEDS_LIBICONV on a system that doesn't have/need it, but didn't test
that it doesn't unset it on a system that does need it (because I
don't have such a system).
