From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Alt. PATCH v5] gc: save log from daemonized gc --auto and print it next time
Date: Mon, 21 Sep 2015 09:19:23 -0700
Message-ID: <xmqqy4fzbv90.fsf@gitster.mtv.corp.google.com>
References: <1442108202-25746-1-git-send-email-pclouds@gmail.com>
	<1442639665-25692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 18:19:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze3oR-0000oH-HW
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 18:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057AbbIUQT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 12:19:27 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33047 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbIUQT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 12:19:26 -0400
Received: by pacex6 with SMTP id ex6so120666540pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=I/rlbieEjr6ZWSlqQgCyNC0CdgMadiivmRymvSrwG5c=;
        b=f02rnIHpKabKYAV8D+bJrxPmxWhVhFDevqcXNw/j54JGMBqifDIhDC+3RmhzzsdaFk
         kYzW4UGGoSzuGBKIMGgPLnysqWGV3sZg6hQs/pGj/KwbHssw6Z8DPEKJCpsNA53syoOq
         8BNpnji4YqZCnZgelcI1hw6JDtvdtXQo3OVgFVHt4gzPzijDmm4/7127T46uBKnxW9rV
         v7Eq5OcYk8Z45z/XvOlDMlCo8cEQTwus8mpz+NUVg6PFzAdISxRYgxqVRvdN6sG8BbzQ
         4CKlBkmBB2s2PR5cxhh8X9hUJON0GrmOP7WUDIDFwvko2t7w+6nAnpyexHEvl5AI+i1O
         indg==
X-Received: by 10.66.141.238 with SMTP id rr14mr988418pab.15.1442852366132;
        Mon, 21 Sep 2015 09:19:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id zc4sm24755524pbb.24.2015.09.21.09.19.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 09:19:25 -0700 (PDT)
In-Reply-To: <1442639665-25692-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 19
 Sep 2015 12:14:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278306>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  The lock-based version has an advantage that the following gc runs
>  will never see partial gc.log. But it requires some more hook at
>  atexit() and maybe signal handler.
> =20
>  This version avoids that, and gc.log can be kept even if gc is
>  SIGKILL'd (unlikely because gc itself does not do anything that can
>  upset the kernel), but then it's racy.

Given that you are only interested in an non-empty output, and also
you want to avoid running an auto-gc when another one is already
running, I wonder if that "never see partial" property really
matters.

In any case, "an alternative could be to avoid lockfile and not
bothering to remove an empty one" was idea from Michael, so let's CC
him back in the loop.

>  I think I perfer the lock-based version.

It certainly does look more familiar to me, too ;-)
