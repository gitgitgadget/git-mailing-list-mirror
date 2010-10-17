From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Fix checkout of large files to network shares under
 Windows XP
Date: Sun, 17 Oct 2010 14:54:40 +0400
Message-ID: <AANLkTinpwpckOn3BEHWn=4Tq_kRyOYYmYF5UQQ0qSpmS@mail.gmail.com>
References: <4BCC5083.30801@gmail.com>
	<4BCCC05E.4030206@lsrfire.ath.cx>
	<t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com>
	<4BCE134C.8090802@lsrfire.ath.cx>
	<4BD9E58E.8020406@lsrfire.ath.cx>
	<290b11b5-5dd5-4b83-a6f5-217797ebd5af@t8g2000yqk.googlegroups.com>
	<4CB9DF7E.1020203@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chad Warner <chad.warner@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysgit@googlegroups.com, Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	dvornik+git@gmail.com
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Oct 17 12:54:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Qt7-000833-7a
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 12:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333Ab0JQKym convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 06:54:42 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54492 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0JQKyl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 06:54:41 -0400
Received: by qwa26 with SMTP id 26so1100260qwa.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c8TVIqrzpN3KlCVJqFHWJt5gBTu9KrSD30DQP111KBE=;
        b=VbVK7ny/TN5xxb0iPsugII+YiGpuvh3xZM8N8jbBf6Z04OH4SfP5zprRKbkOdt24jb
         ASeTky5eVFOwPFUzdw9DYTpDpB+L7LtdPoU4AF2G7aQgFABR2NEBzhT4NA4eN5Lw3fe5
         A4WrYO8Ml9Lz6iZweymoEUHv1G0cFmdbQ/wOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o3MDJHiESN4+vvowo8q9qb+PhLXQA7rOhYPD5t8NtHGBOzTLuvvT7RfBlIOBAqGh2t
         ameYEdutxnTYDxiAj6rAVaDOVhKw8QPa1RuYEPgkfaXXw+/AVbxajiB32UsvJ9qWQPuO
         D62BqM4D+IK+7NC0ruULHBF+JX1pUdBlj11sw=
Received: by 10.229.223.210 with SMTP id il18mr2676677qcb.133.1287312880490;
 Sun, 17 Oct 2010 03:54:40 -0700 (PDT)
Received: by 10.229.222.147 with HTTP; Sun, 17 Oct 2010 03:54:40 -0700 (PDT)
In-Reply-To: <4CB9DF7E.1020203@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159204>

On Sat, Oct 16, 2010 at 9:23 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
>
> Also, 27KB is an odd number. =A0I take it that 28KB won't fix the iss=
ue
> for you?

I guess the beginning of the written buffer is not page aligned, and th=
e
system locks pages. Thus depending on the buffer alignment, the written
maximum can vary up to the size of one page.

>
> I wonder about the cause of this threshold. =A0Wild guess: network dr=
iver
> bug or other network issue?

Memory pressure? Git may consume large amount of virtual memory
during some operations, but I am not sure how it is translated in the
number of physical memory consumed by the process as well as what
quotas could be on that system. It would be interesting to see what
GetProcessMemoryInfo() returns when write() fails.


Dmitry
