From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/8] Making reflog modifications part of the transactions API
Date: Mon, 8 Dec 2014 12:05:26 -0800
Message-ID: <CAGZ79kb1yiSENO+uANdeOKtcSCZgZA3UXSdE2F5PBA49erh2Jw@mail.gmail.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 21:05:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy4Yl-0004mV-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 21:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbaLHUF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 15:05:28 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33185 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaLHUF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 15:05:27 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so5281434ier.28
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7j/nN2RzGdi7f8lGxFLLG4bz+DusRllKPDNKMkXia6k=;
        b=BiXqGHvCEPQ1yMj4AKJbDTyTzTdZD2P070SX5llh5LUuYBCIm2ThU8OrGeH7oR+qGR
         SAFICkkwdO6vNis3xY+rZrjA7fgHkszT865PjE9FT19dYjJ6J0k3JBT1mjhU55YUTUAR
         RGqtSRT6OFO8gHFKOuahfyGjXWY7RaQB0KDAh1qKiHqFLsgZxLeqYwer4N3lOpj3FRy9
         8QQoZbLKcCsmAhM5BhwkTtNknPZ1GlvgqQPeEo06iziePBklaTzFgBWtlsUFab0PUEYE
         2Y28oXrb1aX47hKcp2fXjfeSmWPIKhKsr4eVyKKocFRc+yaGOV8pEVwHcxJedoPSNBQL
         1/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7j/nN2RzGdi7f8lGxFLLG4bz+DusRllKPDNKMkXia6k=;
        b=LXXt3at2VBIykRBqE8XtmyXcAEWBHtF9HtgzDDQX4caJT8o2n508/1HGCLLTANap47
         r2Rq9REKqFrtJW6sXiDPNQpBM2R0G/iiHychUPuf7GKbH7PDHBidV7wVifwU0Twsnos6
         uPRInX4du22QQOt46r+LlpPm+1orxGi4g7qZ78etEasZFV4JML23BpkFpWbcQzFOnayK
         1ejksZdbuFRdgVVUtm8VVMte1JLUOAoD6rSjdXiuBel7NsB6mk2Ejd7R/KaU7QB3WfS0
         sAFUF1SL1eC3MXdfkYN9yEJwBwLi07SGiNk49fWiC0WxP83k7SX3vPFOwOIwRlyhbDS2
         NPPQ==
X-Gm-Message-State: ALoCoQlEzZolDgcS4yerYyp8mNU1Rpe41qG7OZgOTe54EFxCFKedwhUve1jTF1/jtl0P1LK1BgoE
X-Received: by 10.107.25.2 with SMTP id 2mr2873495ioz.70.1418069126874; Mon,
 08 Dec 2014 12:05:26 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Mon, 8 Dec 2014 12:05:26 -0800 (PST)
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261081>

So I reviewed and examined this series and run into some problems.

How do we view an empty reflog, i.e. an empty file at logs/refs/heads/master?
I was told this is not a valid state for a reflog. However even the
test suite sometimes
produces an empty reflog files.
Below there is a patch, which highlights the empty reflog when running
t1301.sh verbosely.


---
 t/t1301-shared-repo.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index de42d21..6a35fc0 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -113,7 +113,9 @@ done

 test_expect_success POSIXPERM 'git reflog expire honors
core.sharedRepository' '
  git config core.sharedRepository group &&
- git reflog expire --all &&
+ git reflog master &&
+ git reflog expire --all --verbose &&
+ git reflog master &&
  actual="$(ls -l .git/logs/refs/heads/master)" &&
  case "$actual" in
  -rw-rw-*)
-- 
2.2.0
