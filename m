From: Phil Lawrence <prlawrence@gmail.com>
Subject: How can I tell if anything was fetched?
Date: Thu, 11 Oct 2012 09:25:23 -0700
Message-ID: <CAFRB3XkueafikCvwzBb+WOAG_1mEkVg1Yt6=teOuVwYd2zWVOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 18:25:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMLZp-000847-KX
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 18:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab2JKQZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 12:25:25 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39668 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab2JKQZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 12:25:24 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1622548wgb.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gf6sMcEJfMeH3YuQ2KcbAWQAUKiatR99tbk9ObKR1RU=;
        b=U3rirS3qYGJnxW4kzpqyqa0QMdiShxZz9ux0cLToKLfmWcLwoetK45dBm3wmuTfvoo
         cIxFtLu0A7FaiwSzevSq1sH316Wxw6NWTGwu1i7wWw54zHZ3d/zcIfiBbVGKaiAXmMPZ
         0+UVakEyviOF+FP92pUL2+MRrRfk0N+uIJQDr8d3iSN2JIa5upAf96ztf/NMEQ4sUrKP
         9eqxyZ/jDOj/yCAY7EcpqDeH3NVxdzi07QYVhvWKtv/UO+C2+OMtryZUhqL2uABtFEoW
         3cbQfr2NP7KR0g64qxlr8sWSrhkS6f9sgbCMWWxl9i+5QW2tFXUAE9IJWab1Dt3jh/f1
         kF8A==
Received: by 10.216.134.96 with SMTP id r74mr752197wei.219.1349972723435; Thu,
 11 Oct 2012 09:25:23 -0700 (PDT)
Received: by 10.216.148.138 with HTTP; Thu, 11 Oct 2012 09:25:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207484>

I have a cron job that regularly fetches into a bare repo.  Currently,
the job then pushes the repo to another remote, regardless of whether
or not anything was actually fetched.  That's a waste.

What is the best way to know whether or not anything was received
during the fetch?  I don't want to be stuck trying to parse the answer
out of STDOUT and STDERR...

One approach might be to first generate a state-of-the-repo SHA1:
    # http://stackoverflow.com/a/7350019/834039
    # http://git-scm.com/book/ch9-2.html
    {
        git rev-list --objects --all
        git rev-list --objects -g --no-walk --all
        git rev-list --objects --no-walk \
            $(git fsck --unreachable |
              grep '^unreachable commit' |
              cut -d' ' -f3)
    } | sort | uniq | git hash-object -w --stdin

I could then do the git fetch, generate another state-of-the-repo SHA1
and compare...

Thoughts?

--
Phil Lawrence
