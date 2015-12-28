From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Mon, 28 Dec 2015 11:30:22 +0100
Message-ID: <cover.1451298323.git.mostynb@opera.com>
Cc: Mostyn Bramley-Moore <mostynb@opera.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 11:30:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDV4s-0000UJ-5b
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 11:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbbL1Kau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 05:30:50 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37131 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbbL1Kas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 05:30:48 -0500
Received: by mail-wm0-f54.google.com with SMTP id f206so2974403wmf.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 02:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zgQp1eTrLQ5Obh0LWzgGw36YoIvnNwzhGuIjsZDOTj4=;
        b=Fhj/wsfhc+ZF4pY2UbFv0O3KxcNbAaCdzeT6vXcv7HTEIIxcFp2TZU0AyWuwHOFPsp
         UpU6nbp6VbKwENuYSxcRte/JiG2+HAyjWGnJQlH7r/4M5TKzbJuAyqNd9rL43Q7l5g1l
         aDNkqopwfDYFhu0Ej87tk9u6lO1njG8SJKriqbP4iqJWgFBpXlPlgNDB/UWMgQFWicFq
         fdUm74x5XFnBS/UcQe6wSDBJyrsDUXDSlx+1BG956cmwA8AVfm9gA76Y0ZACVZHdrvnA
         pVBP6Tw+WFpzqGpyNbp2Z9KfCxfGNk0xmXJcr1wyBF9HAidMQeLQXaTOUr+lhXe7eYJY
         CHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zgQp1eTrLQ5Obh0LWzgGw36YoIvnNwzhGuIjsZDOTj4=;
        b=JZSDf27g0ECsbAoHoq5x/tEpnQ1ElOsyQKNfcdWGcuxXYUJ/G2EPilHPKZIeePobmb
         qV8FQrQ2+AmffzglfAgdLPPqULS3uzFG7JX2xURbccceLnZo3csEnqU/YKy4b9ZqBgEd
         lxjLvO/C4EkShRHIXX56MRDXBI0ZHMw5hTWIEuPs/KkEw1njG0Tkw0+pDpoy5mtBcx3F
         TtQQ3leo9THTrwO+6yAgTeTYfKr+dAEDV7AkLf8MZnDxgC44VWp0FvuNqUBlLK+xAiW2
         RAYGZANEf8hYD4DjX7yQRFAKQGMlmIMNS1CX7wibp8HRfKdWaaJKcGisvID+bKZ27DvK
         jaJg==
X-Gm-Message-State: ALoCoQn4K2N3tfpq42N9AwK/lnZqwWTQga3x1tbpcwMS5b25wjSx7TGJ8GrAQZXBZk7IzbvtcCSfWsS5ygnvank0agkrIZCIPg==
X-Received: by 10.28.158.194 with SMTP id h185mr53406567wme.48.1451298647577;
        Mon, 28 Dec 2015 02:30:47 -0800 (PST)
Received: from teardrop.oslo.osa (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id uw6sm56248541wjc.42.2015.12.28.02.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 02:30:46 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283033>

git describe currently only supports glob matching with the --matches flag.
It would be useful to support regular expressions.

For consistency, this uses the same regex flags as those used by git-grep.

Some old discussion of this as a candidate feature is here, though nobody put
together a patch as far as I can see:
http://comments.gmane.org/gmane.comp.version-control.git/173873


-Mostyn.

Mostyn Bramley-Moore (2):
  describe: add option to use perl-compatible regexes with --match
  describe: add basic and extended posix regex matching for completeness

 Documentation/git-describe.txt |  21 ++++++-
 builtin/describe.c             | 131 ++++++++++++++++++++++++++++++++++++++++-
 t/README                       |   3 +-
 t/t6120-describe.sh            |  38 ++++++++++--
 4 files changed, 184 insertions(+), 9 deletions(-)

-- 
2.5.0
