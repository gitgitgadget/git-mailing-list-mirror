From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 0/2] do_compare_entry: use already-computed path
Date: Mon, 21 Dec 2015 17:34:18 -0500
Message-ID: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 23:34:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB92Q-00019w-O8
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 23:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbbLUWei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 17:34:38 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36517 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbLUWeh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 17:34:37 -0500
Received: by mail-qg0-f51.google.com with SMTP id c96so98351115qgd.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6MhOEzxwwD7HyNInxklbOSamI6EqVUDPwfuHnEj6zus=;
        b=YQxephIHnuh4d5wWXEsIVulP0v2+TVlNCSQi6/HYIc35jgIc8zGg8krl+mBQTayhm6
         axtMgMd7j6o/R6SvQuc7vxYemLAamR06QkCr1ybVXc42HRrZ5fmmtLLGTDGEBmdRVRcx
         uxnCpk5EYa68mFt2pwP9W06LTUXTKd6XcOWrujsBOG20ZXjP2yH0oeY89pID2abdp2C8
         ORANtUdibVYElYTL2YkEQs4i6cFG4R9oeKs/zGSeRedck4arLWMYOhTbm3pIvQBuz5pK
         Rj1oecNkSUfS1RedIgdl8kCs0B6x8YfV/Fa5EHTGlVBecvtc1T8zt7iv0Bh+ze0mGqrt
         QXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6MhOEzxwwD7HyNInxklbOSamI6EqVUDPwfuHnEj6zus=;
        b=CpmsKTpY3nvfFqf2jdRLB9JTo7BtBTl2XlAufdQmV2X/I/2aJ9ex/Hb/LdFdFbLxkb
         0toMrs6232n6+hC6H3Uc4GlkWSEO+8mSjPzfyNTbQ5akNmRQhKnp33K63WZ0jndeGQng
         lhp6njKvlNCAjuAa6EVxdyiiRYiIgzVD6c92T1nPULKMRaeF1v7PTtbl2ai2JR0dBGej
         m8zZFpWDyMev+9bf8WS0ItwxfFCMiqiBOwa5pniqlhHIjt+SLK1fnydO3eubJlwBuuRZ
         eO/r0eEEdkQ4vIx8ubmziry4q1Bwndd4aFmLfyw0b5KBwlEpdEIl9elDUDwcCuynv9Jw
         lYTw==
X-Gm-Message-State: ALoCoQl3WSixybkHcW0+GkDHbN9G9tRPYBmkPOyBSIqTOz08Q+xlHz2/32gywyoMqBMFXON99ePKAL7x2YoD2Aw8KV2lK+/NBg==
X-Received: by 10.140.248.70 with SMTP id t67mr29780664qhc.97.1450737276974;
        Mon, 21 Dec 2015 14:34:36 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z21sm12643373qge.18.2015.12.21.14.34.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Dec 2015 14:34:35 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282821>

This version strdups the path to avoid it getting mutated.  Problem
noted by Junio.


David Turner (2):
  traverse_info: make mostly const
  do_compare_entry: use already-computed path

 builtin/merge-tree.c     |  2 +-
 cache-tree.c             |  4 ++--
 cache-tree.h             |  2 +-
 t/t4010-diff-pathspec.sh |  2 +-
 tree-walk.c              |  9 +++++++-
 tree-walk.h              |  5 +++--
 unpack-trees.c           | 55 ++++++++++++++++++++++++++++++++++++++++--------
 7 files changed, 62 insertions(+), 17 deletions(-)

-- 
2.4.2.749.g730654d-twtrsrc
