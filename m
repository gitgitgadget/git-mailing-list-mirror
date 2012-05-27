From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v6 8/9] submodule: fix handling of denormalized
 superproject origin URLs
Date: Mon, 28 May 2012 00:38:17 +1000
Message-ID: <CAH3Anro5nLmP_e3AGj42FoDr9Xt+ADd4KUF9sb+AzKsh7V-5Aw@mail.gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
	<1338126210-11517-9-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens.Lehmann@web.de, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 27 16:38:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYebx-0003q9-8u
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 16:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab2E0OiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 10:38:20 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60808 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab2E0OiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 10:38:19 -0400
Received: by weyu7 with SMTP id u7so1475009wey.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1synbD8mulTl4t1r4VcAcBWx/d6Sl3MTEa0xI5pxFVk=;
        b=rZWvVot/M2rql+phvvRW2iMUepohsrzv01Hdm1GngZWelRvo47TI+zrj/vgv4RW/UN
         nZDAiBY3gpV4xTf2SikPcVaOJKWQ8/7UybBS1WkEpiKFjtKUigThPMkx9XsmBp7kaSz5
         qX4vjKHSTc6XAjqu2/aDNXKDlNTwA59Q2T0pPRoP2sYPyC65JQIHMWHeHHGGshi7J5QM
         9Wrp67pfUfr1CoJcVTLXmkdej6wgEfC0IeDlrPw8m2YhU8YRfva6LBPmQfHEk25eaD0j
         nAyX84syl6fOhR9e3VZSYfNpEmKfgrVvJN/RF3Can+s0G10iUXdnZMxosS9x8OKgnCVM
         OB8Q==
Received: by 10.180.98.39 with SMTP id ef7mr9252846wib.21.1338129497844; Sun,
 27 May 2012 07:38:17 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sun, 27 May 2012 07:38:17 -0700 (PDT)
In-Reply-To: <1338126210-11517-9-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198603>

On Sun, May 27, 2012 at 11:43 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> This change also fixes a subtle error in the setup of t7403 which was
> masked by the denormalization issue. Previous behaviour was
> relying on submodule add to clone trash/submodule into super/submodule,
> however from the perspective of super's origin (i.e. trash), the origin
> submodule is actually located at ./submodule not ../submodule. However,
> because the origin URL of super was denormalized (it had a trailing /.)
> the incorrect handling of denormalized super URLs actually produced
> the correct result - a case of two errors cancelling out each other's
> effects.
>

Forgot to check the other test scripts for a similar issue. This
change breaks the following tests:

   t7406-submodule-update.sh
   t7407-submodule-foreach.sh
   t7506-status-submodule.sh

possibly because of the same issue mentioned in regard to t7403.

In any case, better not to apply this to pu until I have had a chance
to re-roll a v7

jon.
