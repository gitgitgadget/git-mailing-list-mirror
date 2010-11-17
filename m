From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/4] builtin: use builtin.h for all builtin commands
Date: Wed, 17 Nov 2010 21:08:29 +0100
Message-ID: <AANLkTikw0+FGJmj7C0B9J_3ZVXrbqCw+UzyP3sqfyVdm@mail.gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
	<1289745857-16704-5-git-send-email-avarab@gmail.com>
	<7vzkt7enfn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 21:08:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIoJ2-0005wk-7N
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 21:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935435Ab0KQUIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 15:08:31 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48988 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933888Ab0KQUIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 15:08:30 -0500
Received: by fxm6 with SMTP id 6so918536fxm.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WkPQw5gkFQJ+8EX/RVq3f2Kw7TWZF57lggn/Igm55qs=;
        b=XgLB5WSjpcbhlTLpAgdjqyisbpi6s5SeWb78tOKhxugi7zorksjQlMBVpigCmgpF2b
         YigPRdgjBZkFkxvM84kcACuv5Le5MqocWfbIBgjivNV80aARL3SwBIav6t3UUdi/K9/N
         lGwIHt9r/hDSiqJNDRYf/mo2qiVso3XEiJZ6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GWdgBED9qdH/CQOUQUUyPDUyotWeMS5LSzS3+LtBEV1DmJ1d9BR1qkXsvExyTjqcmH
         RF3E7GlYmlwzMWhFUhr1djqT8l13ZtjcCBx+qpL6KLmPKCfXWt2JXu8N6z85zBa1C4Yn
         kmGrUkOgth6WXF83CeFFSWqSt+r4ZAEn5Jun4=
Received: by 10.223.108.147 with SMTP id f19mr7373490fap.68.1290024509181;
 Wed, 17 Nov 2010 12:08:29 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Wed, 17 Nov 2010 12:08:29 -0800 (PST)
In-Reply-To: <7vzkt7enfn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161633>

On Wed, Nov 17, 2010 at 20:54, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Change the builtin/*.c files and wt-status.c files which weren't usi=
ng
>> builtin.h to use it, also remove any git-compat-util.h, strbuf.h and
>> cache.h from those files. We can trust on builtin.h including them.
>
> As I already said, buitlin/*.c is fine, but wt-status.c is very dubio=
us.

So I should resend this patch with `#include "gettext.h"` in
wt-status.c and the rest unchanged, along with a new commit message?

>> This impeded my efforts to gettextize git, since I'd otherwise have =
to
>> add gettext.h to all of these. Using builtin.h is a good idea in any
>> case, since it's defining the prototypes for the cmd_* functions tha=
t
>> these files define.
>
> What about non-builtin commands? =C2=A0Don't they need to include get=
text.h
> anyway?

In my patch to add gettext infrastructure I add gettext.h to
imap-send.c and friends which have their own main.

> I would have expected that gettext.h would be included from cache.h, =
so
> that all gitty commands, whether they are builtin or standalone, have
> access to the symbols defined in it.

I can do that too. I just got the impression previously that we wanted
to only include things in headers that made sense according to their
name. Gettext has nothing to do with the cache, and cache.h itself
doesn't need it.

But if we want to stick it in there that's fine by me, I just care
about the ends, not the means. So just say which way you want it and I
can cook up a patch.
