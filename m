From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v13 4/8] bisect: introduce support for --no-checkout option.
Date: Wed, 3 Aug 2011 00:42:14 +1000
Message-ID: <CAH3AnrrwXntCZrqDvTM2w2fkQ=G1UyTv1zhExFU-d_eMiR7fUQ@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<1312284545-2426-5-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD0kB+dS4cP=4MXKShhMw3-f_uKjtOmYKahNM0uQQkojsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 16:42:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoGAm-0003dJ-RE
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 16:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab1HBOmQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 10:42:16 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44783 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab1HBOmP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 10:42:15 -0400
Received: by vxh35 with SMTP id 35so5032776vxh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DHsTxIJ/WXzFfcZXgbWSY7yB1Wqu5CGZF/P190M6lyw=;
        b=lmKV9lXHFsz9aFuHFF86IEDrfOndyuz+X8Wi4YLgRg+vejCkTu1DWmSZeHVaNTCK+A
         AAnsXStpZdUSxUn4SSfoPSMO65MyQUgixNDGC99dnY7wfCeccdIy192019+sUX26md91
         g2J4LQeNCaD1mRCrHI62L1Y0d2OIMXJsxJ8hQ=
Received: by 10.52.22.19 with SMTP id z19mr5669826vde.499.1312296134876; Tue,
 02 Aug 2011 07:42:14 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Tue, 2 Aug 2011 07:42:14 -0700 (PDT)
In-Reply-To: <CAP8UFD0kB+dS4cP=4MXKShhMw3-f_uKjtOmYKahNM0uQQkojsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178471>

On Tue, Aug 2, 2011 at 10:16 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Aug 2, 2011 at 1:29 PM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
>> If --no-checkout is specified, then the bisection process uses:
>
> Yeah, but in this patch you are changing "git bisect--helper" by
> adding the [--bisect-mode=3Dcheckout|update-ref] option. So it is
> strange that you still talk about a --no-checkout option.
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git update-ref --no-deref HEAD <trial>
>>
>> at each trial instead of:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout <trial>
>
> [...]
>
>> =C2=A0int cmd_bisect__helper(int argc, const char **argv, const char=
 *prefix)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int next_all =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 int no_checkout =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 char *bisect_mode=3DNULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct option options[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN(0=
, "next-all", &next_all,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"perform 'git bisect next'"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_STRING(0, "bi=
sect-mode", &bisect_mode, "mode",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 "the bisection mode either checkout or update-=
ref. defaults to checkout."),
>
> Nit: I would say : "bisection mode: 'checkout' (default) or 'update-r=
ef'"
>

Thanks. Will address iboth comments s a future iteration.

jon.
