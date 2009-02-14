From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading mbox message
Date: Fri, 13 Feb 2009 22:51:28 -0500
Message-ID: <1234583491-61260-1-git-send-email-jaysoffian@gmail.com>
References: <200902140032.19922.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, gitster@pobox.com,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 04:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYBbV-0007qd-0P
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 04:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbZBNDvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 22:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbZBNDvg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 22:51:36 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:6513 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZBNDvf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 22:51:35 -0500
Received: by yx-out-2324.google.com with SMTP id 8so735037yxm.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 19:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AMhHE4huRaXQTvCXjw9LChXjPxS1ovN0ATBlZEoATdg=;
        b=ZghXs4yl/fzm2qcY9UqEkfEGbZa7oMj1mKMyHrXLENhnQm+2ptYaVgnTPFX+d+/xZo
         eZo6F2uTsspF27/LOVNuwVXV1hIQzJoyyJeSug31fMDon698kHzQ78e/Z2Aj0Qd1ow/R
         qvPzinKJlp/yGz24V7uX8x08aP4802uhEp1c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gXbUKPf/wb1zZbxU2hNVHE2+3Oz5TnA9CU3vnnJ15FJFqgeU71sCEukuLVNC/nlG50
         PWZiej5zHB/WZH2oR4TurYAYxJSPV1dzmAP5cpnqee7+gHs3LaEtxS8yX6LumsVP2Tjp
         t3mA/KxxpUxfbntcARnIvjelwfzP5aGAbPW34=
Received: by 10.151.107.8 with SMTP id j8mr1383975ybm.183.1234583494211;
        Fri, 13 Feb 2009 19:51:34 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id e27sm4961764elf.7.2009.02.13.19.51.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 19:51:33 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.238.g0c1fe
In-Reply-To: <200902140032.19922.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109815>

From: Jay Soffian <jaysoffian@gmail.com>

On Fri, Feb 13, 2009 at 6:32 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Jay Soffian wrote:
>> -                     if (/^(Signed-off-by|Cc): (.*)$/i) {
>> -                             next if ($suppress_cc{'sob'});
> [...]
>> +             if (/^(Signed-off-by|Cc): (.*)$/i) {
>> +                     next if ($suppress_cc{'sob'});
>
> Doesn't this actually look like a long-standing send-email bug?  Since
> 6564828 (git-send-email: Generalize auto-cc recipient mechanism.,
> 2007-12-25) they should go in separate categories, but the above lines
> were just translated from the old $signed_off_cc setting.  It seems
> they should distinguish between SOB and Cc.

This is fixed by the last patch in this series. While I was working on
it I noticed two other minor issues, which is the first two patches.

This is meant to go on top of
http://thread.gmane.org/gmane.comp.version-control.git/109783

Jay Soffian (3):
  send-email: correct logic error with --suppress-cc=cc
  send-email: don't call unquote_rfc2047 unnecessarily
  send-email: --suppress-cc improvements

 Documentation/git-send-email.txt |   14 ++++++----
 git-send-email.perl              |   50 ++++++++++++++++++++++----------------
 t/t9001-send-email.sh            |   38 +++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 29 deletions(-)
