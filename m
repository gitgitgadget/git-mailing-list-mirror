From: szager@google.com
Subject: [PATCH] Fixes handling of --reference argument.
Date: Wed, 24 Oct 2012 21:52:52 -0700
Message-ID: <5088c5a4.L25tOcUVCSwBRpYF%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 06:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRFRK-0002nA-V1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 06:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab2JYEwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 00:52:55 -0400
Received: from mail-gh0-f202.google.com ([209.85.160.202]:44162 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab2JYEwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 00:52:54 -0400
Received: by mail-gh0-f202.google.com with SMTP id z15so154972ghb.1
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=PjqNhKz3S/aNOX7jDFRrd6ZiOFZofTaA7u1UWP+hlAY=;
        b=ZZmGvMCwv29hxGBvU5jyqz4OQhr/41x8/6Lyy4Z1IroueXBLRMZTB6+JHtco2vYOuA
         6RuMskrl0KQRj2Of4YOnB8CiXcYH29RfS5/rE8cbUKKSmNyARA78PwmFkiihsYNuGHf3
         AmPhzYK4Yr0zkxTMi9ilvHgwvYgzBpHEUdK6e1nt6/S38AF/OqZ2DXKCEj6QLCcs4jrI
         hMZYzMSq8zY7iiLJqU0p1oM/mET1X2yPd+Gj4UhbyQF/eb+K9OdGYKvcMnYZYCTC3KuE
         5WWb7H45rykxLp51p7OY0MqQo5KCikt+/ZIlRsEeIv90vREc65q8cke5g0NJA5jcJwwJ
         +Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=PjqNhKz3S/aNOX7jDFRrd6ZiOFZofTaA7u1UWP+hlAY=;
        b=QEJBMyQY+Koj4KYCnLcUMES9sFd02Ea67ev36XpR6pkMg4MzeSVjUjc6moBep+8oZZ
         wUTY+1BhXMbp5r3bEowuqw9F/1069F6DfJveHgMOaui6Stfjt3ZRLgEQv9xJPjBJ4WEC
         QcS64yVTl6tgPL+v7sbpwNU4TuWgRgwHp3I+/RQqiRFkNNuT8yawkmTle+6xYABHYJ/p
         PBuNQ4Cj3BPJmiHuDFpkYLpSThI3BiNbcA6qET7aA7JyXIEtUYZ3n8Qo5dmUW/65zh95
         /XgQZCoI15CiNjQ1eVU77sBwEu8PB8Rey3lgQf+H9VdVd2djhUya/P5F4Dxl9E9OAh32
         oAPg==
Received: by 10.101.128.38 with SMTP id f38mr2959937ann.22.1351140773660;
        Wed, 24 Oct 2012 21:52:53 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i27si1489239yhe.4.2012.10.24.21.52.53
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 24 Oct 2012 21:52:53 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 751F3100047
	for <git@vger.kernel.org>; Wed, 24 Oct 2012 21:52:53 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id D69B9404DC; Wed, 24 Oct 2012 21:52:52 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
X-Gm-Message-State: ALoCoQl7LqmM1rUI5dVaw29MR53PAJQ+SGn7i6M5Y1RykvoXhGMbhA/r3WBek/g04HEoWbWklkSMEocZLmlYYEEJiRO42l8YRnlrT7a9R78vGr86QqUIhTKEDYj3urGshoF/18EAA6QvxMe421Ui9fbfH28oAI/bAsZRvOJgHUzqYcZzIVRzWla3CNnd2ZNjYforwCRCjovKdXubSDBL7FWxPLr/5HLQjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208339>

Signed-off-by: Stefan Zager <szager@google.com>
---
 git-submodule.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..dcceb43 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -270,7 +270,6 @@ cmd_add()
 			;;
 		--reference=*)
 			reference="$1"
-			shift
 			;;
 		--)
 			shift
-- 
1.7.7.3
