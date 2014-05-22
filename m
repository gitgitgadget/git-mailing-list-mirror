From: David Turner <dturner@twopensource.com>
Subject: git reset for index restoration?
Date: Thu, 22 May 2014 12:22:43 -0400
Organization: Twitter
Message-ID: <1400775763.1933.5.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 22 18:22:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnVla-0000IZ-K4
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 18:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbaEVQWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 12:22:46 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:56181 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbaEVQWq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 12:22:46 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so6044936qge.40
        for <git@vger.kernel.org>; Thu, 22 May 2014 09:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:content-transfer-encoding:mime-version;
        bh=XZu50TN3S4C+Wzrs6mgdpYUtTC2xO50FL4S4EYjQ3Vo=;
        b=ZZ9tVE8yj3/E9ZAFqkYj1Z4PfyaXBS6JJirpN9ROU5sGhXEfAeBY5RhNKxCewPGSQW
         7s5HpK42FVYCjW8r1zlBkrcl3vbU3sdv7R5A/D5p5PSYjnsfSR0qrcuyNwO74rUEZhFZ
         JYfwRiSyWnDJvUlRu0ucZGwygEpBfbVgWjcapPWiMc88/idmpsEhQMhGRntkaW8aHhkA
         4aX+puf/dtwcXO4jzQEKDuT4ON/gNb44s8gqdQ+rpUSxgevE4dVnnIePQhv3Xf1SBVTV
         q3o3ALXPjzNfBuTBAXJ9RzUrbs/7hO0xfGjqWyuA17ySmFzmo/r69hc1zuLzhNFoJRYG
         DRrQ==
X-Gm-Message-State: ALoCoQn0pemfzLIkCSIoqDolzWfJ9P0VcKnzhPFm+5VtTu6pmDIvOX9jARLQkz69yLdGc81yyfd3
X-Received: by 10.229.239.4 with SMTP id ku4mr81485396qcb.17.1400775765267;
        Thu, 22 May 2014 09:22:45 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id a9sm404473qaa.26.2014.05.22.09.22.44
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 09:22:44 -0700 (PDT)
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249912>

If I have a git repository with a clean working tree, and I delete the
index, then I can use git reset (with no arguments) to recreate it.
However, when I do recreate it, it doesn't come back the same.  I have
not analyzed this in detail, but the effect is that commands like git
status take much longer because they must read objects out of a pack
file.  In other words, the index seems to not realize that the index (or
at least most of it) represents the same state as HEAD.  If I do git
reset --hard, the index is restored to the original state (it's
byte-for-byte identical), and the pack file is no longer read.

Before I try to dig in to why this should be so, does anyone happen to
know off the top of their head?  Does this constitute a bug in git, or a
bug in my understanding of git?
