From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v8 4/4] git-rebase: add keep_empty flag
Date: Tue, 17 Jul 2012 23:20:51 -0700
Message-ID: <CAOeW2eEchYzRYYUBySKg5xYY3vBDy8GVcAd=ay-HoAGDLZtORw@mail.gmail.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
	<1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
	<1334932577-31232-5-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 08:21:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrNdD-0005mi-DG
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 08:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab2GRGUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 02:20:54 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57557 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab2GRGUx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 02:20:53 -0400
Received: by lbbgm6 with SMTP id gm6so1652018lbb.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 23:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NE0sCqLCT9rODBXtisX3igCb9g3EX4ZZYRgZi9QEzsM=;
        b=tsR3ot/zDGm1w+OIBTBAy/QpGmoGDbIxnGDE0Pq79wLdJEXE3KX6ZAdIP08Vz++A73
         4W8uXShzGOFeOHYreeHD6q1i/rLdHOkZl/o3DEKshRxL0Wwc2pxPCasFYUumORdktUyy
         j65sbgCJ44AWVq+qw4vi3TYAg7MfwlqdTgcPkWK7erEuT6T1/+uVdEZLnTZf6GJvZBgo
         u53NZT+kmdDbK5QkIAlzcQY1HQnt6QIxPcdR+PwPtQNAEIwbxFDE5do1f91vmvrRIRwu
         KMbJMRcNppknYv+3QzF1VQklZxPZ0w6AsGOBh4kD5dm3R2JTxnFD8gRdJ+02+AXDqFY4
         jJGA==
Received: by 10.112.88.106 with SMTP id bf10mr1120773lbb.43.1342592451202;
 Tue, 17 Jul 2012 23:20:51 -0700 (PDT)
Received: by 10.112.39.169 with HTTP; Tue, 17 Jul 2012 23:20:51 -0700 (PDT)
In-Reply-To: <1334932577-31232-5-git-send-email-nhorman@tuxdriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201651>

On Fri, Apr 20, 2012 at 7:36 AM, Neil Horman <nhorman@tuxdriver.com> wrote:
>  pick_one () {
>         ff=--ff
> +
>         case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
>         case "$force_rebase" in '') ;; ?*) ff= ;; esac
>         output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
> +
> +       if is_empty_commit "$sha1"
> +       then
> +               empty_args="--allow-empty"
> +       fi
> +
>         test -d "$rewritten" &&
>                 pick_one_preserving_merges "$@" && return
> -       output git cherry-pick $ff "$@"
> +       output git cherry-pick $empty_args $ff "$@"

The is_empty_commit check seems to mean that if $sha1 is an "empty"
commit, we pass the --allow-empty option to cherry-pick. If it's not
empty, we don't. The word "allow" in "allow-empty" suggests that even
if the commit is not empty, cherry-pick would not mind. So, can we
always pass "allow-empty" to cherry-pick (i.e. even if the commit to
pick is not empty)?

Sorry I'm commenting so late; I didn't have time to look at your
patches when you sent them, but I'm currently working on the code
touched by this patch.
