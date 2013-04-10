From: Tair Sabirgaliev <tair.sabirgaliev@bee.kz>
Subject: Re: [PATCH] gitk: workaround Tcl/Tk Cmd-TAB behavior on OSX
Date: Thu, 11 Apr 2013 01:12:48 +0600
Message-ID: <5165B9B0.8060301@bee.kz>
References: <5165B758.4070308@bee.kz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 21:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0S0-0007fA-AT
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759399Ab3DJTMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:12:52 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:40595 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134Ab3DJTMv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:12:51 -0400
Received: by mail-wg0-f49.google.com with SMTP id e12so897848wgh.16
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bee.kz; s=beekz;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zBlM3ay2N5OB2HVriOPT3X7fOgWY2zw90HxGTwGOJRo=;
        b=eMBaw1Ab6c+UhtoMH4IZyFYFPkeq4IMV5UQq1pFfGxN69WVBSZq6DGTDq8CRyCVkox
         sqeMqYV0zqK6/+KygMNC0FFLevPmJHYv4CECqYVyiRlkflVEcxqdmZbyAArAF2nLaRn4
         EVcaMWWvXjCF5VxfYCmJ+qM47wTbDdIsg63s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=zBlM3ay2N5OB2HVriOPT3X7fOgWY2zw90HxGTwGOJRo=;
        b=IBGp1nxHVh3B0x8JFN+A1QqVJjR9i+xAj0bHEYjIRW4nYbV+AhWM9SBLYuYuRkrkqp
         REVFBJp543DXUjT1GV1dobuuf48NFEUoUuBLESzfwLr8ufKl4VtSVTWNtZdLErkmYtl9
         bNXShZIHVdDRfWuQ5hbJ6Vkrp2Kak0+FJbol5lUxwnS6Af2SKXaysw2m6oYb482nj4xI
         DUYtAwsX4+1DWm70YG9m4iGB6125axTQKZx1oUchDpAwbk6iPZJ1PpTKdXn40D8hnS45
         hnVNkkz4pKjoXJ5gRNvB3ENZrURaH9xTn77I4LFa5E9TRVv1FTs8rtn6AyER6UG6Nwtk
         GAmQ==
X-Received: by 10.194.171.74 with SMTP id as10mr5774066wjc.0.1365621170739;
        Wed, 10 Apr 2013 12:12:50 -0700 (PDT)
Received: from Tairs-MacBook-Pro.local ([2.135.63.167])
        by mx.google.com with ESMTPS id ed6sm1748618wib.9.2013.04.10.12.12.49
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 12:12:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <5165B758.4070308@bee.kz>
X-Gm-Message-State: ALoCoQkbem1LytGzAyhENpJsVOX3ZkMlPImluKnr8PCKVBnz71PuXxdjpcMwJPqqE5R0LCSW7N0y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220728>

The prev message was garbled :( Here is the correct patch (I hope).

On OSX Tcl/Tk application windows are created behind all
the applications down the stack of windows. This is very
annoying, because once a gitk window appears, it's the
downmost window and switching to it is pain.

The patch is trivial: if we are on OSX, emulate Cmd-Shift-TAB
key event, so that the gitk application window is brought
from bottom to top.

Signed-off-by: Tair Sabirgaliev <tair.sabirgaliev@gmail.com>
---
  gitk | 13 +++++++++++++
  1 file changed, 13 insertions(+)

diff --git a/gitk b/gitk
index 572f73f..60a87fc 100755
--- a/gitk
+++ b/gitk
@@ -11687,6 +11687,19 @@ if {[catch {package require Tk 8.4} err]} {
      exit 1
  }

+# On OSX workaround the Tcl/Tk windows going down the stack of Cmd-TAB
+if {[tk windowingsystem] eq "aqua"} {
+    exec osascript -e {
+        tell application "System Events"
+            key down command
+            key down shift
+            keystroke tab
+            key up shift
+            key up command
+        end tell
+    }
+}
+
  # Unset GIT_TRACE var if set
  if { [info exists ::env(GIT_TRACE)] } {
      unset ::env(GIT_TRACE)
-- 
1.8.2
