From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/11] commit: add tests of commit races
Date: Mon, 9 Feb 2015 10:31:59 -0800
Message-ID: <CAGZ79kYmgeXt1k22h3fbDR04BTHOQRxryNVSJDOL2DC5yLLHpw@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:32:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKt7v-0001MI-6u
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758987AbbBIScB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:32:01 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32912 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbbBIScA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:32:00 -0500
Received: by iecrl12 with SMTP id rl12so18653040iec.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CROZGeCN1j9mSRyMLJSIgxJY7AqpgzRCNjqUYx8VhIo=;
        b=Wg5vbKpd/B7FfogRsN9Xa0SMHdXjMIGTbaaIyb2yW5AyppzY/EaHKOuL3yHvnW7/oo
         nhto0vc/dbeG7VDbOMJXDX1SU1izCkvf6daVnZ8SutjkiazzNz54pTVRR/f/K++ueHU8
         PbNgFSONqSejyeSxocjN4QBLJqPILoLsjWifZhvKCFYyGBOfO2OswXMgmYs2MAbBgI7O
         m0GPqUkCUd79wup0bCdozKGT7xeDy4n9UAW3WdRv9ZX03PSlTI5OnQsFyKBiY88xN1Rf
         uvzLpImRelcJASxCIxO+aYzn1LyywE0WaRp7Y/kP3SRkStFdgOan8njA+AK/39Wnq5Ue
         W0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CROZGeCN1j9mSRyMLJSIgxJY7AqpgzRCNjqUYx8VhIo=;
        b=g6H7twQbRdUT9WAwMayx0WUl+HSHJGHLYP0GoY7hQ6JRCXU5w4lAruVa0ny8eyonbR
         gmeRuZCI0Vw+TDwxVNDev7mF7JXVdQALpUIwjWx8Qcr/dVP3f/Abh7TWfaUyQ5El2us0
         5sp4Kz9ZA6hdsuCXu0jyXL3w1RuYdFE5VRD1GByxt649JBdUVXzz3z5cBHSvciPDfltT
         FFuJCmzxR2+L/E1k1ZJ8UE1RlHhTxsglKbHiD+0J3TZgx4pUH/l+klQvyEc6WnUdtV1h
         gJoj45CdMQiPUF8tKfoZHKy5sUSXpvBl0lWcyoGA9pDHFAc9vNXE42nCs32xiCdVlB93
         olFQ==
X-Gm-Message-State: ALoCoQkMf3MPx0u6PfbcnlM4Gi19W+/jK75ZME7Hi160HeBzUOJLKNZGgnygNVHx7QB6LL8Oo0I5
X-Received: by 10.42.71.194 with SMTP id l2mr26198609icj.71.1423506719664;
 Mon, 09 Feb 2015 10:31:59 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:31:59 -0800 (PST)
In-Reply-To: <1423412045-15616-7-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263574>

On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
> new file mode 100755
> index 0000000..5efa351
> --- /dev/null
> +++ b/t/t7516-commit-races.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Michael Haggerty <mhagger@alum.mit.edu>

What is the projects stance on copyright lines?
I've seen files (most of them from the beginning) having some copyright lines,
other files (often introduced way later) not having them, "because
we're git and have
history, so we know who did it".

The tests themselves look fine.

Is there a reason you did not append the tests in 7509 ?


>
