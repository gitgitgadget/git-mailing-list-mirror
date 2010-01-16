From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 05/14] mingw: support waitpid with pid > 0 and WNOHANG
Date: Sat, 16 Jan 2010 22:57:19 +0100
Message-ID: <40aa078e1001161357m1799478bk35c35077f8836e9e@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-6-git-send-email-kusmabite@gmail.com>
	 <201001152328.28260.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 22:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWGeA-00065F-R4
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 22:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab0APV5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555Ab0APV5Z
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 16:57:25 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34649 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab0APV5Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 16:57:24 -0500
Received: by ewy19 with SMTP id 19so2045051ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XNL/fB131H8gFrbdovNzbNbscumV9vxvEX2k35YYY4s=;
        b=HS1KIfBLunrbf2B12N1T9gL7uy+jxZLs4hjpGhSArnziZ1yqgXUAfSEs3i4tIsHFJM
         oOKLJIhpaBGfORoE8Yg1DGs96ieKArg1acJKHJhEW+2axQVvxB4ViDbinlI49DX3pXmV
         Cm2Lqw2RtxypyV+cAjkgvX4XG296T/xegfuiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=N3V+K6WBR7tpoTtxHfB+rpe5qGVpKYryEiannETkmXvjMYx9AAscj82T71P7KCxqzh
         +ifpwNUutNeaHgc4C+99Fxo0TV4ZKy6wTkT8h2ZaoXpxbXDKZE6PoQOSTpiYGNXl9wXa
         qUe3D9EzmYBYsCCJFNABZj6sKB4FF1KJQ3MTI=
Received: by 10.216.88.75 with SMTP id z53mr287738wee.46.1263679040021; Sat, 
	16 Jan 2010 13:57:20 -0800 (PST)
In-Reply-To: <201001152328.28260.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137265>

On Fri, Jan 15, 2010 at 11:28 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> =A0static inline int waitpid(pid_t pid, int *status, unsigned option=
s)
>> =A0{
>> + =A0 =A0 if (pid > 0 && options & WNOHANG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleObject=
((HANDLE)pid, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 options &=3D ~WNOHANG;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (options =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _cwait(status, pid, 0);
>> =A0 =A0 =A0 errno =3D EINVAL;
>
> With this change, and in particular the one in the next patch, this f=
unction
> grows too large to be 'static inline'.
>
> -- Hannes
>

=46ixed locally.

--=20
Erik "kusma" Faye-Lund
