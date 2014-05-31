From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Reset by checkout?
Date: Sat, 31 May 2014 14:46:12 +0900
Message-ID: <20140531144610.754B.B013761@chejz.com>
Reply-To: Atsushi Nakagawa <atnak@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 07:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wqc7W-0000O9-NP
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 07:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbaEaFqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 01:46:14 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36487 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbaEaFqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 01:46:14 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so2437871pad.9
        for <git@vger.kernel.org>; Fri, 30 May 2014 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chejz.com; s=google;
        h=date:from:to:subject:reply-to:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=eq/i/AlxDz3HCKiTSzfcfr90THKm41FJVg+iM4ZSlOY=;
        b=AYfnWpEVNbjnhBMxJ7CBhgMK4DSHZQ1haYEDs+7wH0vt2DYxzMcMTZza7TZrSTp3as
         w+kZoy5t5e4BmZv0E7PSwUGf7P9BkqsNWPIL29ghJvErH41JEdvT/F6QxeZkoJkigQGv
         b5XuCNmcXcGOFIPxTttekV5s3jcPStDlsMLUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:reply-to:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=eq/i/AlxDz3HCKiTSzfcfr90THKm41FJVg+iM4ZSlOY=;
        b=L8MoPhUgZHyqYobRbGT/EEjHFTzjykVZVVfhsO4hglWTfU7nQmgwFAWJ0oWTQ9ozB4
         nFG+xRgELPUleFX9LmRdkyxDSKn9uDVz+G9tdAKdgnsScoLF2s6zyQQehX4knd62EXis
         keY3NXnO4Ic9mvUJBEJ10eJdUEsjmmLlNEbLpiAWtP+Dh0IFOZvw3tahfcGezQGVzQQF
         BKC7t/AbCv9BbPOjp/VhpI/9u64vLkx65N1/1hckxay5wrXuV2EvBnrUUzwON5sAx9Cp
         GI8dRoHkWjqTsxgkl2Z5anMxW2u3+aGmSdzR2aroAKvMOUghtDH9jcJVRzVVRprqvpFm
         3CTg==
X-Gm-Message-State: ALoCoQmeEHff7DN3eFRfskYWqNEs1Mfr56Zdr90ua5M/1OHPESGD6zz8gY2g5U8iTs/TQzVYGhY4
X-Received: by 10.66.139.201 with SMTP id ra9mr24564268pab.84.1401515173559;
        Fri, 30 May 2014 22:46:13 -0700 (PDT)
Received: from [127.0.0.1] (KD106168138162.ppp-bb.dion.ne.jp. [106.168.138.162])
        by mx.google.com with ESMTPSA id xz7sm28855020pac.3.2014.05.30.22.46.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 May 2014 22:46:12 -0700 (PDT)
X-Mailer: Becky! ver. 2.65.07 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250500>

Hi all,

One of the more underrepresented command I use in git use on a regular
basis is this "reset by checkout".  It's what's currently achieved by
this convoluted expression:

  `git checkout -B <current-branch-name> <tree-ish>`

This is such an useful notion that I can fathom why there isn't a better,
first-tier, alternative.  i.e.  How come there's no 'git reset
--checkout'?  The command above even prints "Reset branch
'<current-branch-name>'".

The problem with 'checkout -B' is it's so easy to mistype!  If I had a
yen for every time I accidentally left off the '<current-branch-name>'
part and created a branch named "<tree-ish>" at HEAD...

So, I defined alias.become '!git checkout -B "$(git symbolic-ref --short
HEAD)"' and was happy for a while.  Now, the lack is glaring every time
I'm explaining workflows to people who don't have the the alias.

Ok, the typical use case is: I'm on 'master' and I make a few test
commits.  Afterwards, I want to discard the commits and move back to
'origin/master'.  I could type 'reset --hard origin/master' and risk
blowing away dirty files if I'm not careful.  Or, I could use "reset by
checkout" and be carefree.

Any ideas?  Am I doing something wrong or unconventional?

Cheers,


-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
