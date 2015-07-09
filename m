From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Reset sometimes updates mtime
Date: Thu, 09 Jul 2015 16:02:14 +0200
Message-ID: <1436450534.15519.49.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 16:02:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDCP9-0006ca-4R
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 16:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbbGIOCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 10:02:19 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36735 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbbGIOCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 10:02:18 -0400
Received: by wgxm20 with SMTP id m20so41156026wgx.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 07:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:content-type
         :mime-version:content-transfer-encoding;
        bh=bj6jo3itDd987W4X3fcl/6DO0Ehwe1mSa8wlO96OT98=;
        b=K76TPQGlr9oFOBHhf6QotsrgkT/R3aHdolZfDepMSYAB7FXSpeVQou9ZN9WO/JStVu
         Kiwbf6duV4XyiDyaXbsCCcXpuhQNtq1pUOT7UsiLgEWDidkCsWfFzKkG6ot5b0hRzfqd
         oxEG7GOXBOIh7tNuwAWvEwJ9gAegz2J7jxXsxNxY3E2gSata8xupT+tsXX2Kt+ot18dJ
         eEYJRkE+B1VjFh41Be5by1Dm8PuIZIDXz9dsoepXtZqU/xfwL7ThKfkT13L23a1np0cQ
         z79JHRkUWkmfGUijGeRannYMgLlFRRPrT+08HvHCnzOw6YlsQrfmofryvk7DUX2mirLl
         35nA==
X-Gm-Message-State: ALoCoQnJhQmc8umUH7mHQvkqDnD6bgMLRpJoHJMC/uheL/NUCkX7foT0goAFnUJbbS6RGAJHrWNw
X-Received: by 10.194.2.51 with SMTP id 19mr32680990wjr.40.1436450537319;
        Thu, 09 Jul 2015 07:02:17 -0700 (PDT)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id lk5sm8449870wic.24.2015.07.09.07.02.15
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 07:02:16 -0700 (PDT)
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.4 points;
 *  3.2 RCVD_ILLEGAL_IP Received: contains illegal IP address
 *  2.2 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
 *      [Blocked - see <http://www.spamcop.net/bl.shtml?5.57.20.8>]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273756>

I'm seeing some behaviour with git reset that I find odd. Basically if I
do

git fetch && \
git reset --hard simple-tag-that-points-to-the-current-commit

sometimes the reset will update the mtime of all files and directories
in the repo and sometimes it will leave them alone. Changing it to

git fetch && \
git status && \
git reset --hard simple-tag-that-points-to-the-current-commit

Cause the mtime update to reliably not happen.

Bad thing is that I am relying on the mtime updates not to happen if the
files don't actually change. Is this an assumption I can safely make? If
it is, then I'll debug further (e.g. I don't even know yet if the file
gets rewritten or just touched, why the index gets updated as well
etc.).

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
