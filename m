From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] git-blame.el: use mapc instead of mapcar
Date: Sun, 10 Jun 2012 02:38:03 -0500
Message-ID: <20120610073803.GA29461@burratino>
References: <2608010.fNV39qBMLu@descartes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davidk@lysator.liu.se,
	Sergei Organov <osv@javad.com>, Kevin Ryde <user42@zip.com.au>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdcjc-0000MA-81
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 09:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab2FJHiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 03:38:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34656 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab2FJHiM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 03:38:12 -0400
Received: by yhmm54 with SMTP id m54so2010532yhm.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qHt3tVv8n4BjhykL1ToGDawN+mEUjmataf7gSb9hJl4=;
        b=F7/QOQZEUbLM+P6ycVeJbtA2kmhNs6xSzAaxop5zIiFbnFHe943GMICgR1J7F4uygb
         p19U6AQIF725ijBDXOiMK1HQ2zF5apva/G2ws2Modo9n8LOxIjbqV92WmqKQTRJPsxye
         4Hx7hK8sjPbomXlD7wkA6N0LptZtB/uMOaQCLZjFgmLhHOjOnNG7P1fhaUzGX23ciCX3
         QWHsO20d2gKm9VIE6f+BKRuMHpdiEIYWu0VyO73Cu2BHqkQ2xF+562PdaxH9zn6UQ0Pc
         O26D1og0J3HFCgr4dt28AO5ITaakY5mF9akMrb4hsdrYDU4JkqOqR4CDISUXYsx26c/N
         4MFQ==
Received: by 10.101.135.22 with SMTP id m22mr4640637ann.67.1339313891961;
        Sun, 10 Jun 2012 00:38:11 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id q32sm18962994anh.21.2012.06.10.00.38.10
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 00:38:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2608010.fNV39qBMLu@descartes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199575>

=46rom: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>

Using mapcar here is a waste of memory because the mapped result
is not used.

Noticed by emacs ("Warning: `mapcar' called for effect").

[jn: split from a larger patch, with new description]

Signed-off-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
In January, R=C3=BCdiger Sonderfeld wrote:

> Replace mapcar with mapc because accumulation of the results was not
> needed. (git-blame-cleanup)
>
> Replace two occurrences of (save-excursion (set-buffer buf) ...)
> with (with-current-buffer buf ...). (git-blame-filter and
> git-blame-create-overlay)
>
> Replace goto-line with (goto-char (point-min)) (forward-line (1-
> start-line)). According to the documentation of goto-line it should
> not be called from elisp code. (git-blame-create-overlay)
>
> Signed-off-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
> ---
>  contrib/emacs/git-blame.el |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

Thanks again, and sorry for the long silence.

I'd prefer to see someone more knowledgeable than I am about elisp
submit the other two fixes.  This one is simple enough that I can
vouch for it, though.  One out of three is not that bad, I guess. :)

Thoughts?
Jonathan

 contrib/emacs/git-blame.el |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index d351cfb6..37d797e1 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -304,7 +304,7 @@ See also function `git-blame-mode'."
=20
 (defun git-blame-cleanup ()
   "Remove all blame properties"
-    (mapcar 'delete-overlay git-blame-overlays)
+    (mapc 'delete-overlay git-blame-overlays)
     (setq git-blame-overlays nil)
     (remove-git-blame-text-properties (point-min) (point-max)))
=20
--=20
1.7.10
