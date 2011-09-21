From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] bisect: fix exiting when checkout failed in bisect_start()
Date: Wed, 21 Sep 2011 16:42:23 +1000
Message-ID: <CAH3Anrpvz5mv+B2Y95rPytTUynELo63nZOdCc9CvYVhkvxvPgg@mail.gmail.com>
References: <20110921051725.5255.6756.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Joel Kaasinen <joel@zenrobotics.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 08:42:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6GVp-0007uR-IN
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 08:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab1IUGmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 02:42:25 -0400
Received: from mail-gw0-f52.google.com ([74.125.83.52]:35939 "EHLO
	mail-gw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab1IUGmY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 02:42:24 -0400
Received: by gwb1 with SMTP id 1so1371165gwb.11
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cS4TcPSsYlureEamWiMlWVEDqqo0Pe2v4Fvm8ld0Vkk=;
        b=Tq6cJPbM4HKm2rvFN8sVfSh8FC5XxORj2uB2lI4eQxFEUElfOFYx40g6CSPkPXyO/Z
         ktkeAwCg6saKiGhumbULKXi3rYaBzU/3e0lmDt1aTh6YnpqFWJOWZslTEAmerYJp9oDT
         0lfv9f1MNGmGgqbnVoIYe9iwiaD027xRvAzzM=
Received: by 10.68.42.167 with SMTP id p7mr108639pbl.334.1316587343325; Tue,
 20 Sep 2011 23:42:23 -0700 (PDT)
Received: by 10.142.116.15 with HTTP; Tue, 20 Sep 2011 23:42:23 -0700 (PDT)
In-Reply-To: <20110921051725.5255.6756.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181818>

On Wed, Sep 21, 2011 at 3:17 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Commit 4796e823 ("bisect: introduce --no-checkout support into porcel=
ain." Aug 4 2011)
> made checking out the branch where we started depends on the "checkou=
t" mode. But
> unfortunately it lost the "|| exit" part after the checkout command.
>
> As it makes no sense to continue if the checkout failed and as people=
 have already
> complained that the error message given when we just exit in this cas=
e is not clear, see:
>
> http://thread.gmane.org/gmane.comp.version-control.git/180733/
>
> this patch adds a "|| die <hopefully clear message>" part after the c=
heckout command.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> =C2=A0git-bisect.sh | =C2=A0 =C2=A03 ++-
> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index e0ca3fb..5fb4291 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -129,7 +129,8 @@ bisect_start() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_head=3D$=
(cat "$GIT_DIR/BISECT_START")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "z$mod=
e" !=3D "z--no-checkout"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git checkout "$start_head" --
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git checkout "$start_head" -- ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die "$(eval_gettext "Checking out '\$start_head' failed. Try 'g=
it bisect reset <validbranch>'.")"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Get rev from=
 where we start.
> --
> 1.7.7.rc0.72.g4b5ea.dirty
>
>

Thanks. Looks good to me.

Acked-by: Jon Seymour <jon.seymour@gmal.com>
