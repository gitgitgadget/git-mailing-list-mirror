From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] check_aliased_update: strcpy() instead of strcat() to 
	copy
Date: Thu, 10 Jun 2010 15:26:16 -0400
Message-ID: <AANLkTikNyyIk2952ei2kXsQJcznunmDJ30Ze2Sjb8V2M@mail.gmail.com>
References: <AANLkTimPCMbprIKQ__SfMej3oST5agPZ06hM2dkyiUfj@mail.gmail.com>
	<f99f845d5d0aa77b0a95c35f9289f1b031897d43.1276195180.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erick Mattos <erick.mattos@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 10 21:26:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMnOT-0001jt-GM
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 21:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759470Ab0FJT0S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 15:26:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42373 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759128Ab0FJT0R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 15:26:17 -0400
Received: by iwn37 with SMTP id 37so265577iwn.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aME71qPCIObUbYj/XyFCt0xpNsUHHQNCUuctLLq7iFw=;
        b=NVcGWXTfrKLeZ1wCX7dSErOzThfRtdwBLKDgOBiI01Gfc4uRGm793WULSxOLny959+
         J4xwhFhnT8uAWredMWT/1Sar+jtfPkpxcPNrWgV8n/shgm2RHqcd1a0t4vKa9dFqDdoh
         p0UxCvYNAVnObfbHuut+/xfuyMka4gQJ6wCjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jIYwGV/FHmPK5K5osQ7EaKab+mUsyjW226Z6zBcOUYX7Oe/3i8vvOtuF8ZVxHoDxYK
         +3G9Mw9les3B/mNAHCrrwOE9rp1jRD8xJilIsP124qTLRwzoKeOf8ZsNWOeq/tklC5+I
         v3X80/1CPh3zJitWGG+Tsmi0tMvmQf84emcVA=
Received: by 10.231.168.200 with SMTP id v8mr628909iby.33.1276197976806; Thu, 
	10 Jun 2010 12:26:16 -0700 (PDT)
Received: by 10.231.16.134 with HTTP; Thu, 10 Jun 2010 12:26:16 -0700 (PDT)
In-Reply-To: <f99f845d5d0aa77b0a95c35f9289f1b031897d43.1276195180.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148913>

On Thu, Jun 10, 2010 at 2:43 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> da3efdb (receive-pack: detect aliased updates which can occur with
> symrefs, 2010-04-19) introduced two strcat() into uninitialized
> strings. =C2=A0The intent was clearly make a copy of the static buffe=
r used
> by find_unique_abbrev(), so use strcpy() instead.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
>> Actually I think my test failure is related to da3efdb17b, see the
>> "[PATCH v2 2/2] receive-pack: detect aliased updates which can occur
>> with symrefs" thread.
>
> Indeed, there's another bug in this one. =C2=A0(And valgrind catches =
it
> too... =C2=A0if only I had the patience to let it churn through t5516=
!)
>
> Unlike the other bug, this one is already in master.
>
> =C2=A0builtin/receive-pack.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index bb34757..7e4129d 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -515,9 +515,9 @@ static void check_aliased_update(struct command *=
cmd, struct string_list *list)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_cmd->skip_update =3D 1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(cmd_oldh, find_unique_abbrev(cmd->o=
ld_sha1, DEFAULT_ABBREV));
> - =C2=A0 =C2=A0 =C2=A0 strcat(cmd_newh, find_unique_abbrev(cmd->new_s=
ha1, DEFAULT_ABBREV));
> + =C2=A0 =C2=A0 =C2=A0 strcpy(cmd_newh, find_unique_abbrev(cmd->new_s=
ha1, DEFAULT_ABBREV));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(dst_oldh, find_unique_abbrev(dst_cm=
d->old_sha1, DEFAULT_ABBREV));
> - =C2=A0 =C2=A0 =C2=A0 strcat(dst_newh, find_unique_abbrev(dst_cmd->n=
ew_sha1, DEFAULT_ABBREV));
> + =C2=A0 =C2=A0 =C2=A0 strcpy(dst_newh, find_unique_abbrev(dst_cmd->n=
ew_sha1, DEFAULT_ABBREV));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rp_error("refusing inconsistent update bet=
ween symref '%s' (%s..%s) and"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " its target =
'%s' (%s..%s)",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->ref_name=
, cmd_oldh, cmd_newh,

Thanks. I cannot imagine what I was thinking. Maybe a cut-and-paste
error from somewhere else. I am sad this made it all the way to
master.

j.
