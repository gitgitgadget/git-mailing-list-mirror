From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Tue, 22 Sep 2015 07:17:20 -0700
Message-ID: <xmqqlhby5yj3.fsf@gitster.mtv.corp.google.com>
References: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
	<xmqqeghraauu.fsf@gitster.mtv.corp.google.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D8@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 16:17:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeONu-0005Yr-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 16:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758074AbbIVORY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 10:17:24 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35827 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbbIVORW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 10:17:22 -0400
Received: by pacfv12 with SMTP id fv12so10773468pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=zl1AZfDVVFN+NXlQ6NTsKbt4lon7444yLFjPUQvQNU4=;
        b=PSaSa6YSAvaOUhrVi/kuVR8KW/geoh/PPdsbxtwFZjkugycJ4uInaDC6oXHZCxGwNF
         hpTEwJgu/nu3mjtIEMX6yIgFx96KsEbhapnWxVYD5mslGZmChVkUoOnu8lv1BYrA96xg
         g+f8hLU39mg7DbKqnD5M4hm6UN4xcVr6KDF6vysT+XCXxLH7HZt9DkzeEM/uv/6l3Ky9
         o27Xwz2Kb/orSo7M7G7cuwQmM6bb2dYvItWdqBEHXxWK5j66LPNgfKC+reGqrUAL0ZcH
         tqxMIjQikqOvrm1Ij8wbWK7qgDyH9hQbYpmCuZAqAFZBiUJOO9LZSIxtQItwJ909tA2g
         ISRQ==
X-Received: by 10.66.161.137 with SMTP id xs9mr32308351pab.117.1442931441643;
        Tue, 22 Sep 2015 07:17:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id of1sm2692251pbc.11.2015.09.22.07.17.20
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 07:17:21 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278392>

Victor Leschuk <vleschuk@accesssoftek.com> writes:

> We already do have some of these: 'no-metadata', 'no-checkout',
> no-auth-cache'. So I was just following the existing convention. Do
> you think we need to change it and stick with
> --catch-file-batch=1/--cat-file-batch=0 ?

Inventing a new --cat-file-batch=[0|1] is not a good idea, and
certainly not what I would suggest at all.

My suggestion was to accept --cat-file-batch to allow the --batch
processing, and to accept--no-cat-file-batch to trigger your new
codepath (and leave --cat-file-batch the default when neither is
given).  As these option descriptions are eventually passed to
Getopt::Long, I thought it should not be too hard to arrange.

Mimicking the existing handling of no-whatever is less bad than
accepting --cat-file-batch=[0|1], if you cannot tell the code to
take --[no-]cat-file-batch for whatever reason.  In the longer term
it would need to be cleaned up together with existing ones.  Your
patch would be adding another instance that needs to be cleaned up
to that existing pile, but as long as it follows the same pattern as
existing ones, it is easier to spot what needs to be fixed later.
Compared to that, accepting --cat-file-batch=[0|1] would be far
worse, as such a future clean-up effort can miss it due to its not
following the same pattern.
