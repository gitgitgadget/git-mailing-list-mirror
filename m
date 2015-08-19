From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 7/7] submodule: implement `module_clone` as a builtin helper
Date: Wed, 19 Aug 2015 12:20:51 -0700
Message-ID: <CAGZ79kYHOb_PJFT3x=RrnfSRFGgizw=jxHG1FhSBBx3dTgZhiQ@mail.gmail.com>
References: <1439857323-21048-8-git-send-email-sbeller@google.com>
	<1439935980-30087-1-git-send-email-sbeller@google.com>
	<xmqqy4h785af.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:21:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS8v0-0007T0-KL
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 21:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbbHSTUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 15:20:53 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34767 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbbHSTUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 15:20:52 -0400
Received: by ykdt205 with SMTP id t205so15562518ykd.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2aBESCiU8MdBGg+c08xTz0k5b/nEo4e1YB6EDg0OMo8=;
        b=iADyfGuHg0cVOAl5lHNobWcTQnxkm1WJ26LwBvtWa2sBIKnbY+K/lyuuRAdZJLiNQk
         Sw+UG6HW0FYRwgfXpH6Ri4Z0+pry6sBAdhGm8TqYHMRcerTrB0YJl+5WFZG2QAF4Ej9Z
         kTNfqEVhvOxsA6gHXk4BZVU54GMmSbmNU9yeDfZEMGk2nlM/jZqGNU6ZouS7jiNRe/lH
         czRZbSQ4xYTbxX2YwYjONfjA/MeFZ7Itrk5Pd2j8TiJKgd3XQR9wymgBCl0FeNrX2OB+
         Re+Sk/BfZWPeehkrGuoLwTklVSMzsau/pnOO1WELJEpUvif0v4crFIvhLp1hjpliiUxJ
         fMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2aBESCiU8MdBGg+c08xTz0k5b/nEo4e1YB6EDg0OMo8=;
        b=mI6RVy46NUBOVD6zjK3lLGxYcTBx5/1xLoX0VDLB/q3WrnSpsWCPPlDI5HQXi/Y0IJ
         zUx+f5SvVGnbPSOZJRIM/YLS73ixwgLEDsPMZDEDGFjEgliEcti/JTuFDaSTg6B4sxNY
         F6+/nk0JIiLHFx9d+HZYKDs+seu1pEPKtNdAWkWsn0AKiDIpmrHW32Ta9FK3vTslOi2D
         GpMP6gJYmi4TZpoL+Lw6y5PtH6SmeoO5bEbiNRABRoNnXHRhAtVWarqp+dfPlXhCIZPe
         7pVqzzZCTzumDOjSvfmTPdja1HZix7k0/qVrcrx6w+eGcWkYPMoVa8XNf31PJen/j8FL
         8n1w==
X-Gm-Message-State: ALoCoQnt6lfwK5vSCu0GQXyDeXB7RDlUbnLa83V8KEvkrs934WDbWpRFzYwcN4eag6/fpgam5OG+
X-Received: by 10.170.112.194 with SMTP id e185mr15711526ykb.119.1440012051497;
 Wed, 19 Aug 2015 12:20:51 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Wed, 19 Aug 2015 12:20:51 -0700 (PDT)
In-Reply-To: <xmqqy4h785af.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276215>

On Wed, Aug 19, 2015 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> `module_clone` is part of the update command, which I want to convert
>> to C next.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> This is the only patch that broke by a last minute fix,
>> so this replaces the previous PATCH 7/7.
>
> ... which still breaks 7400.82, though.

because I messed up the resending. :(

Squashing in this fixes it:
---8<---
diff --git a/git-submodule.sh b/git-submodule.sh
index e50451b..e7d221e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -338,7 +338,7 @@ Use -f if you really want to add it." >&2
                                echo "$(eval_gettext "Reactivating
local git directory for submodule '\$sm_name'.")"
                        fi
                fi
-               git submodule--helper module_clone --prefix
"$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo"
--reference "$reference_path" --depth "$depth" || exit
+               git submodule--helper module_clone --prefix
"$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo"
"$reference_path" "$depth" || exit
                (
                        clear_local_git_env
                        cd "$sm_path" &&
@@ -634,7 +634,7 @@ cmd_update()
                        shift
                        ;;
                --depth=*)
-                       depth=$1
+                       depth="$1"
                        ;;
                --)
                        shift
---
because both depth and reference are either empty string or containing
both key and value
(i.e. $depth will be "--depth=5" and we should not pass --depth into
submodule--helper module_clone
twice)

I can resend the patch as a whole if you'd like. I'd send it together
 in the next series later today, which will demonstrate a possible
implementation of  `git submodule foreach-parallel`


>
> Output from running it with "-i -v" ends like this:
>
> expecting success:
>         mkdir super &&
>         pwd=$(pwd) &&
>         (
>                 cd super &&
>                 git init &&
>                 git submodule add --depth=1 file://"$pwd"/example2 submodule &&
>                 (
>                         cd submodule &&
>                         test 1 = $(git log --oneline | wc -l)
>                 )
>         )
>
> Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t7400-submodule-basic/super/.git/
> fatal: Clone of 'file:///home/gitster/w/git.git/t/trash directory.t7400-submodule-basic/example2' into submodule path 'submodule' failed
> not ok 82 - submodule add clone shallow submodule
> #
> #               mkdir super &&
> #               pwd=$(pwd) &&
> #               (
> #                       cd super &&
> #                       git init &&
> #                       git submodule add --depth=1 file://"$pwd"/example2 submodule &&
> #                       (
> #                               cd submodule &&
> #                               test 1 = $(git log --oneline | wc -l)
> #                       )
> #               )
> #
