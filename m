From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] tag: support --sort=version
Date: Wed, 19 Feb 2014 21:19:24 +0700
Message-ID: <CACsJy8CL3rQx=QHf_eABCUqS+9kZXEmopUuCMiNCL+UPyvtbyw@mail.gmail.com>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com> <20140219140909.GA20128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 19 15:20:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG80H-0001R5-CG
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 15:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbaBSOT4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 09:19:56 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:35327 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaBSOTz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 09:19:55 -0500
Received: by mail-qa0-f41.google.com with SMTP id w8so457384qac.28
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 06:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kE2ALBpZmeOv3ZLyDwQ77W9fTHIzEvp49OMHwln5v0Q=;
        b=r+Id1kiKTOwKiM6Acn2RhbdF4GZOKMCeARwXewasp/2o+rIf+c1iBS/TSNsk0d8IgF
         +jScl4w+KdaRf/7TuY247FQIdwR/1tla0FedtM7qxb9vGjTS99Tjmd7+4yR1i4qjpyip
         iCet6SfsaZClTpO1R21bIbClW6iF5NEP40ynv3GZjDPukBV9fz4COZ0Bg/kEq1CMRXW6
         5VEsbknz+nr8TXJtBuR5RzYeMQpwIn2RTrGIbvJUQsQRMdLzf9chYYsIH7OSV3BNnVf9
         1uwFpY2mx7u3vooYtC69TM2Xl+zWUWri5xFUHlWdid0mtJXxb5OfEZI1JPf5/PdYwjWR
         mO8w==
X-Received: by 10.140.47.212 with SMTP id m78mr47454764qga.21.1392819595080;
 Wed, 19 Feb 2014 06:19:55 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 19 Feb 2014 06:19:24 -0800 (PST)
In-Reply-To: <20140219140909.GA20128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242394>

On Wed, Feb 19, 2014 at 9:09 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 19, 2014 at 08:39:27PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> --sort=3Dversion sorts tags as versions. GNU extension's strverscmp =
is
>> used and no real compat implementation is provided so this is Linux =
only.
>
> Sounds like a good goal.
>
> I wonder, if we were to merge the for-each-ref and tag
> implementations[1], how this would integrate with for-each-ref's
> sorting. It can sort on arbitrary fields like "--sort=3D-*authordate"=
=2E I
> think given the syntax you provide, this would fall out naturally as
> just another key (albeit a slightly magical one, as it is building on
> the %(refname:short) field but using a different comparator).
>
> Would we ever want to version-sort any other field? Perhaps
> %(content:subject) for a tag? I'm not sure what would be the most
> natural way to specify that. Maybe "--sort=3Dversion:content:subject"=
,
> with just "--version" as a synonym for "version:refname:short".

If f-e-r and tag share code and syntax then we could use another
letter for this sort type (like we use '-' to reverse sort order). I
think that would make the implementation easier as well. So we could
have --sort=3D.refname for version sorting refname, --sort=3D-.refname =
for
reversed version sort, and sort=3D-refname for reverse alphabetical
sort.

> We don't need to do any of that immediately.  This is mostly just me
> thinking aloud, to make sure we do not paint ourselves into a corner
> compatibility-wise.

Good thinking. If you plan to use the exact same sort syntax f-e-r
uses now, pick a letter (the dot I used above is probably not the
best), I'll rewrite this patch to use the same syntax.

>
> -Peff
>
> [1] I have patches which I really need to polish and send out that
>     combine the ref-selection code (so tag, branch, and for-each-ref =
all
>     know "--merged", "--contains", etc). I'd really like to combine t=
he
>     sorting and formatting code, too, so everybody can use "--sort" a=
nd
>     "--format" with all of the associated fields.
--=20
Duy
