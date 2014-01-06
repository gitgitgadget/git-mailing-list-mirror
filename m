From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [Bug report] 'git status' always says "Your branch is up-to-date
 with 'origin/master'"
Date: Mon, 6 Jan 2014 13:31:08 +0800
Message-ID: <CANYiYbG7Dh6npaMYajAeSMsR75SJM6kke9z7_4Q_z14nHY9KSg@mail.gmail.com>
References: <86886772.1529128.1388856329849.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 06 06:31:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W02mR-0002Ab-Md
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 06:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbaAFFbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 00:31:10 -0500
Received: from mail-we0-f181.google.com ([74.125.82.181]:56568 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaAFFbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 00:31:09 -0500
Received: by mail-we0-f181.google.com with SMTP id x55so15201410wes.40
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 21:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8BzP3K5qwI/pR8e07oN2bWWu7g9Iozol9iskPJlckIg=;
        b=aCd84PmE8w2RNKom9YYMdCnRZPRolQDkMeTYqKRRgF7khjk3eM0h5guPGTVSgX1yCu
         ToTf7Aaq3LGe/8eRTL6FIM30PjbNmPiH5qWBglormVe1lFyhiASNNvl+eM62gyAeEI9c
         +a80CN7VXbRskcAE5GMVk4F7XRMhkh7vDnqxurwib+XUETzJ3dXyBzWLfkOUIS+HGXUf
         OZUy+dITKYxcE//wHpIe1BVDPpn/C7iGPExo1m3ODalMO68uZ0o3bAuKU/Tjt7ohOxjv
         /YzfjgQLQXLs+EmWF7ftbmsue8Wc1yHIpyqlG4S5ZvFoTFK5/ivKMYXz156C2GB48O8C
         C1Cg==
X-Received: by 10.180.206.229 with SMTP id lr5mr10956600wic.13.1388986268390;
 Sun, 05 Jan 2014 21:31:08 -0800 (PST)
Received: by 10.216.213.207 with HTTP; Sun, 5 Jan 2014 21:31:08 -0800 (PST)
In-Reply-To: <86886772.1529128.1388856329849.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239987>

2014/1/5 Thomas Ackermann <th.acker@arcor.de>:
> Since f223459 "status: always show tracking branch even no change"
> 'git status' (and 'git checkout master' always says
> "Your branch is up-to-date with 'origin/master'"
> even if 'origin/master' is way ahead from local 'master'.

Hi, Thomas

Can you provide your operations so that I can reproduce this issue?

In the commit you mentioned above, there was a new test case named
'checkout (up-to-date with upstream)' added in 't6040'. I also add two
test-cases locally in order to reproduce the issue you report, and run
them in arbitrary orders, but they all look fine:

    ok 4 - checkout (behind upstream)
    ok 5 - checkout (ahead upstream)
    ok 6 - checkout (diverged from upstream)
    ok 7 - checkout with local tracked branch
    ok 8 - checkout (upstream is gone)
    ok 9 - checkout (up-to-date with upstream)
    ok 10 - checkout (upstream is gone)
    ok 11 - checkout with local tracked branch
    ok 12 - checkout (diverged from upstream)
    ok 13 - checkout (ahead upstream)
    ok 14 - checkout (behind upstream)
    ok 15 - checkout (diverged from upstream)
    ok 16 - checkout (upstream is gone)
    ok 17 - checkout (ahead upstream)
    ok 18 - checkout with local tracked branch
    ok 19 - checkout (behind upstream)


The two additional test cases I used locally are:

    checkout_test1() {
    test_expect_success 'checkout (behind upstream)' '
            (
                    cd test && git checkout b3
            ) >actual &&
            test_i18ngrep "is behind .* by 1 commit, and can be
fast-forwarded" actual
    '
    }

    checkout_test_2() {
    test_expect_success 'checkout (ahead upstream)' '
            (
                    cd test && git checkout b4
            ) >actual &&
            test_i18ngrep "is ahead of .* by 2 commits" actual
    '
    }

-- 
Jiang Xin
