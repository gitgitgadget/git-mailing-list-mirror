From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Rebase performance
Date: Thu, 25 Feb 2016 07:50:03 +0700
Message-ID: <CACsJy8DZOv2Z2hiUmRKHr_GCjsyVz9kQEE8a1F=h6Ku0Dr9g_w@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:50:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYk8e-0006bM-DU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758447AbcBYAug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:50:36 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33650 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757325AbcBYAuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:50:35 -0500
Received: by mail-lb0-f170.google.com with SMTP id x4so20452647lbm.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 16:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NDUtjLkf3mIB9Od5DRM/zxB9HS+5XcI6SNStUP0mcvU=;
        b=s2P0bpfaRCCxOBxV1NCd85fY1q3FAVK+ELhJgcQOBM89XefQQpMKqbmrEM2lqWJKDj
         5uWOtn0dn9QeqGxTCq/vBHmV1hj8MD1gcNt/TxVZTY+QAstFrvPE3wqPlCoBCGla7AkA
         NVxR/K4wA0o4fqp5U1JTc/AYIdjNBCrNJzDWlHU6KiMmaAsZgALvun5p+2fWvVvMzKUg
         Ui7Dddf3J1idQj+xvE5ru+a3rwjyrTqzmkzprZinEmKSDYHImAtO6C4dxLWlrlAST0Ca
         qgSebV9CCqGK3nY+bep0ZiUqEsn6Slm/l/ppM86IvozhzkBzDkBWYoUIEJK5UWWMdAPq
         Y6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NDUtjLkf3mIB9Od5DRM/zxB9HS+5XcI6SNStUP0mcvU=;
        b=CZ3xZ0igz4lXz4RjQiRO0aGtYv8rghfT0wpYOnGVyS9Z4rB1jBH2btz0FMcPvE4d7U
         vI3H/ztfRQ5i9e2heodPh841cEfPEFitQAML9B4emI28iDiGwexR6AJ/eWMBmxKTJkWy
         mp4376SFMzlnxSjtxbuZcAdZMdsz9HEUBKCxgylUGUrWLBfnrnK+HcynE9U5sv3bNvMK
         Z/CzNcDSa4iRO+RJInmocJ7O6vdVNtFJmqertbmvxIfbCkKI15+CsiLSMHHegK73y2xk
         cKxM7aWFT0e8OcTgIWMlxiF1i3HC/JkcJNUYdtTQGFMa1RjlrWzB5RLHGjIjwF+sRL0c
         coEQ==
X-Gm-Message-State: AG10YOSdsWeDk59E2bghIAgUuMIjuXL8siEgai2/ZkYtocajnvaLvvRSsNPIdpQDiseCphk2uLyUpciuePw9cg==
X-Received: by 10.112.150.133 with SMTP id ui5mr15415207lbb.12.1456361433298;
 Wed, 24 Feb 2016 16:50:33 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 24 Feb 2016 16:50:03 -0800 (PST)
In-Reply-To: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287297>

On Thu, Feb 25, 2016 at 5:09 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Another possibility would be to libify the "git apply" functionality
> and then to use the libified "git apply" in run_apply() instead of
> launching a separate "git apply" process. One benefit from this is
> that we could probably get rid of the read_cache_from() call at the
> end of run_apply() and this would likely further speed up things. Also
> avoiding to launch separate processes might be a win especially on
> Windows.

The amount of global variables in apply.c is just scary. Libification
will need some cleanup first (i'm not against it though). Out of
curiosity, how long does it take to do "git update-index <one modified
path>" on this repo? That would cover read_cache_from() and
write_cache(). While you're measuring, maybe sprinkle some
trace_performance() in apply.c:apply_patch() to get an idea where time
is most spent in? This is a big guess, but if we spend more time
parsing/validating the patch than applying, then that part could be
parallelized, we only need to apply patches in sequence.
-- 
Duy
