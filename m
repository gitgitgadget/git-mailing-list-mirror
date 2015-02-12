From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 06/12] commit: add tests of commit races
Date: Thu, 12 Feb 2015 10:13:51 -0800
Message-ID: <CAGZ79kbz5+CNO3fgy+UyY1z45a+cTkhtroRbHSNdmUWdQdKeqQ@mail.gmail.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
	<1423739543-1025-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 19:14:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLyH1-0003ws-Pw
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 19:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbbBLSNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 13:13:55 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:40938 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbBLSNy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 13:13:54 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so5499828igb.2
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q8NLjtCSCoaAasHxODM6YnpUCBs0L+tdKQl8jZSx5r0=;
        b=RsO/s6mhJHmSCZWTybkXyjnRzFkwA4k2kR099rpdTq9z3V8RxQOQx7aIfFrptXJ8tv
         UCw+Rf/f2cDO/9mB1iAMZShZ2fdkNlU1w6MTj5JCCLkhE3NhY/+/kYXubO549CegMePB
         gZVuy4zwkoq1U3yQDGXIFrhA5Ke0UMh97eBDEe+EC6F/mEFggOdXK2YCqp0iQoL2cenr
         vo1nv6yn2xgPFmxsjZqkgH8ExZ16uy08tF+5LixlERRfaB0zdg4aIKPKDyRZGk26e7av
         WXBiiRlxQfrnbI80Glu1auerGPTJQr5bkUhKRG99Ef1AzlVNmD4C+iO7uMhPo/W1aOB2
         1sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q8NLjtCSCoaAasHxODM6YnpUCBs0L+tdKQl8jZSx5r0=;
        b=cyk9Y4yubpa1Qy/3XMGSk/qPI1N2lM3SlPVDd4o/0cUoQqXrfBsvW8Ae1g2dfzF6Ev
         RKsTC2ySgqrLnWfUMlZ+HjNuJMd4WMIZv8srWtp22GvK3L9Xb0brfgwmh3UTDcEJ62+I
         tLtayqMylm/X+F3a6DhkC78N1G1zPLXugPoWZ4BqWGcD9QR8ql+UDZIicq2LaTTCqyQP
         p0zq2YRcmyTz4z2kbWQHQEzoyf4igvHBnS45Zf/pYPNz/uC3rY5Pro0dJrSX9hGmC9uA
         VzQq+6Mlov8Q2w/bBuoxELsBrDH56IJJpe7kMo8NbJYk9W6suaevjzJUxEogvP+bYQGV
         VPMQ==
X-Gm-Message-State: ALoCoQmCr+R7M818PqpnD4sJKCJx4rk+yz025lQH0ORxvP6nC4+8Yn5r3HSdiL5KAU3NqE2sQJP7
X-Received: by 10.50.85.44 with SMTP id e12mr5561035igz.48.1423764831761; Thu,
 12 Feb 2015 10:13:51 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 12 Feb 2015 10:13:51 -0800 (PST)
In-Reply-To: <1423739543-1025-7-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263748>

On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Committing involves the following steps:
>
> 1. Determine the current value of HEAD (if any).
> 2. Create the new commit object.
> 3. Update HEAD.
>
> Please note that step 2 can take arbitrarily long, because it might
> involve the user editing a commit message.
>
> If a second process sneaks in a commit during step 2, then the first
> commit process should fail. This is usually done correctly, because
> step 3 verifies that HEAD still points at the same commit that it
> pointed to during step 1.
>
> However, if there is a race when creating an *orphan* commit, then the
> test in step 3 is skipped.
>
> Add tests for proper handling of such races. One of the new tests
> fails. It will be fixed in a moment.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t7516-commit-races.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100755 t/t7516-commit-races.sh
>
> diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
> new file mode 100755
> index 0000000..08e6a6c
> --- /dev/null
> +++ b/t/t7516-commit-races.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description='git commit races'
> +. ./test-lib.sh
> +
> +test_tick

So I am wondering why we need to have a test_tick here.
In case we need to pass simulation time after loading the
test-lib, we should rather have it inside the test-lib.

If we need to pass time specifically for this test (I just don't
understand why at this point of execution), then we should
move it more to the relevant place inside the &&-chain as all
other tests have test_tick inside a test chained up with &&.


> +
> +test_expect_success 'set up editor' '
> +       write_script editor <<-\EOF
> +       git commit --allow-empty -m hare
> +       echo tortoise >"$1"
> +       EOF
> +'
> +
> +test_expect_failure 'race to create orphan commit' '
> +       test_must_fail env EDITOR=./editor git commit --allow-empty &&
> +       git show -s --pretty=format:%s >subject &&
> +       grep -q hare subject &&
> +       test -z "$(git show -s --pretty=format:%P)"
> +'
> +
> +test_expect_success 'race to create non-orphan commit' '
> +       git checkout --orphan branch &&
> +       git commit --allow-empty -m base &&
> +       git rev-parse HEAD >base &&
> +       test_must_fail env EDITOR=./editor git commit --allow-empty &&
> +       git show -s --pretty=format:%s >subject &&
> +       grep -q hare subject &&
> +       git rev-parse HEAD^ >parent &&
> +       test_cmp base parent
> +'
> +
> +test_done
> --
> 2.1.4
>
