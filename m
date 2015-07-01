From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 01/31] wrapper: implement xopen()
Date: Wed, 1 Jul 2015 17:41:32 +0800
Message-ID: <CACRoPnRqnFESb4tom1FLWxpumLz-BxfBksG=gMePqSzV44=_CQ@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-2-git-send-email-pyokagan@gmail.com>
	<ed4f6565ed610a337244e06cc15b41bb@www.dscho.org>
	<CAGZ79kYtF+rHozVQhNz8uguLZvArPiB2UdkPTFn=Vc+YCsA=UQ@mail.gmail.com>
	<40fbc9dd1a066ba137647ff384aa6395@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 01 11:41:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAEWY-0006vH-7x
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 11:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbbGAJll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 05:41:41 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36491 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbbGAJle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2015 05:41:34 -0400
Received: by lbbpo10 with SMTP id po10so9302000lbb.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=T0hWRqybx1ayhVHEjyof8AHkivze9WfOGybrpmbcGhA=;
        b=oVAjR2Gi9ti6k8u9v/VVi+BWfEG0+J5M95Q6B2RP0XH9zs1LB/QjC7XTSq/82fHmwr
         KOAW6Pu7jJEFdqjFHUBHCFnjsQKMCb1hgZV3wOqzlwkMM1Hg9gCOqDGr0IZTpWiqjic+
         wsuDfx7Qr6d4mUyM77EPusYUztky5LofPo+WcNc0Uuki9g2xElWj6bOTvqI3mwQ/IMbf
         /+mR/M81k2FvFOu6rVNM2qXwow3sgT4+MOfv3lAvrWu32yVLe+xbrbtgsgWwZaz8PlS/
         1B/MWQbWtw6slMdxZSKgjBRVsldkj6pDy7aHSCX2FgTZlxmaCgDmlBIIzS5f/Os6qfph
         Cg3A==
X-Received: by 10.152.30.4 with SMTP id o4mr23547735lah.74.1435743692437; Wed,
 01 Jul 2015 02:41:32 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 1 Jul 2015 02:41:32 -0700 (PDT)
In-Reply-To: <40fbc9dd1a066ba137647ff384aa6395@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273146>

On Thu, Jun 25, 2015 at 2:39 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> IMO the varargs make the code more cumbersome to read (and even fragile, because you can easily call `xopen(path, O_WRITE | O_CREATE)` and would not even get so much as a compiler warning!)

I think that since xopen() is a wrapper around open(), it is best to
follow its interface (as defined by the POSIX spec) as much as
possible. It's important to note that the POSIX spec explicitly
defines that open() takes a variable number of arguments, and that the
`mode` argument is only used if O_CREAT is set. This means that if we
cement xopen() to take 3 arguments, and the third is a mode_t (or an
int), then we may not be able to keep up with changes in the POSIX
spec which e.g. in the future may specify that open() takes 4
arguments if certain flags are set.

> and the error message does carry value: it helps you resolve the issue (it is completely unnecessary to check write permissions of the directory when a file could not be opened for reading, for example, yet if the error message does not say that and you suspect that the file could not be opened for *writing* that is exactly what you would waste your time checking).

Good point, I agree with this. I'll look into putting the error messages back.

Thanks,
Paul
