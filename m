From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 12/12] t3070: disable two fnmatch tests that have
 different results on different libc
Date: Fri, 12 Oct 2012 16:49:05 +0700
Message-ID: <CACsJy8DkxT70M9EWGF4rFebQUcDguJqCHkrW3CL3pBi0cAegUQ@mail.gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <1349865651-31889-13-git-send-email-pclouds@gmail.com> <5077C52E.2050000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 11:49:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMbsL-0000jC-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 11:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890Ab2JLJth convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 05:49:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45295 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757855Ab2JLJtg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 05:49:36 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4477241iea.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vC644SAWUDKlpsgwtEwMewGEMago4V6owAj8bsah794=;
        b=NRgqnoxClp8f9R0sILBkjSU8VTGlxeV42Fwa1lQ/pVrCRP4Wrpl/1FsGL0+nl0PfKp
         X0WgKBYQ+6Kea5inPlTgHre1Eb/RFisPn5mDdvUUk1U/cfAf4ZJlBitW0k5+ssWf85rM
         3dSp2XZLFIsrDyYYMVxZo0QuWFMLyQ1cUwJ+7etPUNSiuApsrthEhTuX4+bL6a8m2+Hq
         kMcTTIzUs4RfJNXKMsCX3SkazmYwuInKPNeB2McDrw7/DUQ/6eVjw9c5iphvyxjRapel
         ahmFrE/BST/WzeYm/i3YJQpWMY1XqbZJRIYoT9+AYEtwrBvxSf1zjRAd5ne80jjZdQX4
         j+Mg==
Received: by 10.50.153.130 with SMTP id vg2mr1663218igb.26.1350035376111; Fri,
 12 Oct 2012 02:49:36 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Fri, 12 Oct 2012 02:49:05 -0700 (PDT)
In-Reply-To: <5077C52E.2050000@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207540>

On Fri, Oct 12, 2012 at 2:22 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 10/10/2012 12:40, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>> fnmatch on glibc-2.12.1 returns no match. glibc-2.15 returns ok.
>
> There are many more cases that fail with the fnmatch() that we ship i=
n
> compat/fnmatch. To test this on Linux, you have to remove the "#if de=
fined
> _LIBC || !defined __GNU_LIBRARY__" brackets from compat/fnmatch/fnmat=
ch.c
> and build with NO_FNMATCH.

Thanks. The point of checking against fnmatch is to make sure that
wildmatch does not divert in behavior from fnmatch. For some corner
cases that behavior is undefined, I think it is ok for different
fnmatch versions to behave differently.

But some of failed tests make me worry about fnmatch. compat/fnmatch
for example does not match '**/foo' with '/foo' (it does '*/foo' with
'/foo'). 'A' is matched with '[[:digit:][:space:][:upper:]]' but not
'[[:digit:][:upper:][:space:]]'. Perhaps we better off convert git to
use wildmatch only to keep matching behavior more reliable. wildmatch
does not support non-FNM_PATHNAME mode, but that should be easy to
fix. The only downside I see is fnmatch may support locale while
wildmatch does not.
--=20
Duy
