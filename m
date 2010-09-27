From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v1] stash show: fix breakage in 1.7.3
Date: Tue, 28 Sep 2010 01:38:51 +1000
Message-ID: <AANLkTinzx7Tj2dGp5UJw-uef-p7HVCYNa4p1a0b6Q6ri@mail.gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
	<1285385521-17012-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: robbat2@gentoo.org, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Mon Sep 27 17:38:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Fn9-00013b-An
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 17:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759694Ab0I0Piw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 11:38:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50679 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759685Ab0I0Piw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 11:38:52 -0400
Received: by yxp4 with SMTP id 4so1554420yxp.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7UG6KmW4RLtGgb5vnlmwu4L1iCYiK2qjv/YWB7VREt0=;
        b=x28+xGXVpQcsyoXODDprHkuzK3tX08a6V3yixHQzYTARWGRAS6vskUH59A1RkhtTVK
         6kUTlJ+pKcSg97PSbC56Yv//r56I1GOWcn8xjuAO6FkwTaed5O48iVQ80kKq3L28nTuf
         /aMmFT2sG4DaJEU66gRuDSRtnxK44BuWbeAI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kW1zWnDaqr0wS2eoDIigTkddzAwUi1ySlIWpmHR/fKqmXEkk7JOSGsVeSu8UIc9zh2
         N56tXDFJWTkdHu3/gx9ei3GAJiuaR7+XnIkea4WMckcTx4xsAXZWZKd7ZFy9kiviL/Ag
         yVV0Od29zI0N7swa9TpMqurCb07eMzJlRzCmE=
Received: by 10.229.231.4 with SMTP id jo4mr5775764qcb.22.1285601931594; Mon,
 27 Sep 2010 08:38:51 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Mon, 27 Sep 2010 08:38:51 -0700 (PDT)
In-Reply-To: <1285385521-17012-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157350>

This patch has been superceded by:

    [PATCH] stash: simplify parsing fixes

which applies on the Brian's fix that has been applied to maint.

On Sat, Sep 25, 2010 at 1:32 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> The detached-stash series regressed support for
> =C2=A0 git stash show stash@{0}
>
> due to a faulty assumption that:
> =C2=A0 git rev-parse --no-revs -- stash@{0}
>
> would treat stash@{0} as a revision reference and
> thus not output it.
>
> This patch restores the behaviour of git stash show
> so that git rev-parse is not used for parsing flags
> and only flag like options are assigned to
> the FLAGS variable.
>
> It has been tested with Brandon Casey's improved t3903 tests.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
> =C2=A0git-stash.sh | =C2=A0 =C2=A05 +----
> =C2=A01 files changed, 1 insertions(+), 4 deletions(-)
>
> This revision further simplifies the parsing code
> by removing use of git rev-parse for FLAGS parsing
> altogether.
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 7ce818b..8b18bb5 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -265,9 +265,6 @@ parse_flags_and_rev()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i_tree=3D
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0REV=3D$(git rev-parse --no-flags --symboli=
c "$@" 2>/dev/null)
> - =C2=A0 =C2=A0 =C2=A0 FLAGS=3D$(git rev-parse --no-revs -- "$@" 2>/d=
ev/null)
> -
> - =C2=A0 =C2=A0 =C2=A0 set -- $FLAGS
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0FLAGS=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while test $# -ne 0
> @@ -282,7 +279,7 @@ parse_flags_and_rev()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0--)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0;;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FLAGS=3D"${FLAGS}${FLAGS:+ }$=
1"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> --
> 1.7.2.14.g132f5.dirty
>
>
