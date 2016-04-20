From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v1 2/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 17:40:26 +0200
Message-ID: <CAHGBnuOAsKNDc7UBN=1r867KxpRSr_RG+EPFhCL+gJbbQo9rdg@mail.gmail.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
	<1461096530-82448-3-git-send-email-larsxschneider@gmail.com>
	<xmqqtwixz6i4.fsf@gitster.mtv.corp.google.com>
	<A6FD8E93-63E8-49EE-838D-2AF3FD3910D4@gmail.com>
	<xmqqh9exz4xq.fsf@gitster.mtv.corp.google.com>
	<CAHGBnuOuFYvf=CSyCLbhn7pyq4jsqH+p+xV9rxAtU1y3r+qjzw@mail.gmail.com>
	<xmqqy488wb4p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:40:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuEz-0001pH-2S
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbcDTPk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 11:40:28 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34076 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbcDTPk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:40:27 -0400
Received: by mail-vk0-f65.google.com with SMTP id a6so7087908vkh.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=SCLK48Zl3xumS44rMmk9cCfKQgM/9A6QC1L8Cytda7E=;
        b=XGXoZN6H+48crPG1D/UjIeTbShod6B7TuHN4ucdnm2yZ+bq2BPBFc7U3E5bu4Oji0I
         8ZKUNg4xAPFl9fufd+JCeKISK5qr3L80hAnFYFoL4hXyf+ZDc22hQTcif0fT3bhr7JP/
         6Hh3AjDlK1KFXbAL5ZyX5ySuiKCLJJAPzHqf6NDPMGNjdsJyCvZ4fCIWaVr93vR77mXA
         MpmC7c2rOBXvYlq2KhaJuLA03uHKY+9CNwG2vhnXO4NuEqxYUeqDbDYSDR6yXaf3IWuw
         f6m2JtJVnFu0CWvlvKntTDkbpSOrKHrB8ygK0/OT4JzcGsQy51+VMIsLlYPkn/bsruLR
         AT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=SCLK48Zl3xumS44rMmk9cCfKQgM/9A6QC1L8Cytda7E=;
        b=jo8gw5w7krGGwu8ip4xZH4g+yv7vkEqj0GkB3oeMDO3eT7d4EjvI8hnYinWK7vAYoH
         9JZNFK1mavJb6gduQiDJsUunWYd91lTBLui9kXOp5wfhHZbRVAYDbLXbHnX/TxYVR1DK
         fZaKQ131C1Xg8gtQ2ps6Lw/3bvE5d7iphXJ767+73VbdgcwaJfh6Das+tCjF8ay55m+7
         g6x1PkQ4wWQcdqs4Ict8R9vrHK8xDNy06jyyBOHKYH13APjgFm74VTkil7XTMoKyXKFu
         0GU92iQu4T/N1zeTXOXHpIzyZ9z4eQDxO3nsUiTqaMVqxXqsJafEarF1JLfv8x5ACHLI
         5NDw==
X-Gm-Message-State: AOPr4FWlhM7eWAISWJdzQT/u6zLkUCwrymOeTYeB2RtwHq4L9ustwaXCGf2LH1PIuTDNka4XXRZO7DIJwl3QDQ==
X-Received: by 10.31.146.5 with SMTP id u5mr4351931vkd.19.1461166826572; Wed,
 20 Apr 2016 08:40:26 -0700 (PDT)
Received: by 10.176.5.2 with HTTP; Wed, 20 Apr 2016 08:40:26 -0700 (PDT)
In-Reply-To: <xmqqy488wb4p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292031>

On Wed, Apr 20, 2016 at 5:30 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> If clients rely on output targeted at human consumption it's not
>> surprising that these clients need to be adjusted from time to time.
>> What's troubling is not the change to git-lfs, but the very un-generic
>> way git-p4 is implemented.
>
> Sounds like the subcommand they are using is not meant for
> scripting?  What is the kosher way to get at the information they
> can use that is a supported interface for scripters?

The "pointer" subcommand indeed is listed under "Low level commands"
by "git lfs" (without any arguments), and as such it probably can be
considered for scripting use. However, before my fix in [1] the
subcommand was printing both output targeted at humans and output
targeted at scripts to stdout. After my fix, only output targeted at
script goes to stdout, and output targeted at humans goes to stderr.

[1] https://github.com/github/git-lfs/pull/1105

-- 
Sebastian Schuberth
