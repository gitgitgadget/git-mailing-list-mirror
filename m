From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 3/2] doc: advertise GIT_CONFIG_NOSYSTEM
Date: Sun, 14 Oct 2012 01:53:59 -0700
Message-ID: <20121014085359.GD7190@elie.Belkin>
References: <20121014000210.GA19094@elie.Belkin>
 <20121014000402.GB11399@elie.Belkin>
 <20121014062218.GB13477@sigill.intra.peff.net>
 <20121014084244.GA7190@elie.Belkin>
 <20121014084437.GB7190@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 10:57:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNK0K-00058t-49
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 10:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334Ab2JNIyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 04:54:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37220 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2JNIyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 04:54:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4079294pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lbkl9fwRppOKRVbaG17UcXt4axz6leW2Yjq+yzlRc6k=;
        b=mgJzakwqGc0k0D9qzQgvOYI5HYG/RRDmqH5ZrfBV6qeJeCBV4b6WO1FmyUrX6mmO+G
         0+PH+8+wipeoAnH9TOoW76o5KRhjLCCyKaEr2AvydDTKo6SIxULy4Nr15z65KK9dmXdw
         ujF8Hs5IA4N9MA/y1svqIb3jESzzvtdxe99ZgTjchKJN8ChT5BgD73uIMvjGYXunMBjt
         6A8IL/JsuzIKjRdUBXiGsX498WDSXdchOezVOI8K1lpvUe9NE43zZV6k2NM+AuEeALhZ
         Ja6eAuzSlpXkULccDIYOVU44Yg0A+D50TL6hd3uL8uCrJGGi2beHR0NJKe0P1wSlOTLQ
         BG1w==
Received: by 10.68.136.231 with SMTP id qd7mr27647167pbb.3.1350204846517;
        Sun, 14 Oct 2012 01:54:06 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id p3sm706406paw.8.2012.10.14.01.54.05
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 01:54:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121014084437.GB7190@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207648>

On a multiuser system where mortals do not have write access to /etc,
the GIT_CONFIG_NOSYSTEM variable is the best tool we have to keep
getting work done when a syntax error or other problem renders
/etc/gitconfig buggy, until the sysadmin sorts the problem out.

Noticed while experimenting with teaching git to error out when
/etc/gitconfig is unreadable.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -240,6 +240,14 @@ GIT_CONFIG::
>  	Using the "--global" option forces this to ~/.gitconfig. Using the
>  	"--system" option forces this to $(prefix)/etc/gitconfig.
>  
> +GIT_CONFIG_NOSYSTEM::

Hm, unlike GIT_CONFIG this applies to all git commands (not just "git
config"), so it is misleading to document them in the same place.
Here's a better patch.

 Documentation/git-config.txt | 4 ++++
 Documentation/git.txt        | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index eaea0791..9ae2508f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -240,6 +240,10 @@ GIT_CONFIG::
 	Using the "--global" option forces this to ~/.gitconfig. Using the
 	"--system" option forces this to $(prefix)/etc/gitconfig.
 
+GIT_CONFIG_NOSYSTEM::
+	Whether to skip reading settings from the system-wide
+	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
+
 See also <<FILES>>.
 
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d1d227a3..ae1f833a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -757,6 +757,14 @@ for further details.
 	and read the password from its STDOUT. See also the 'core.askpass'
 	option in linkgit:git-config[1].
 
+'GIT_CONFIG_NOSYSTEM'::
+	Whether to skip reading settings from the system-wide
+	`$(prefix)/etc/gitconfig` file.  This environment variable can
+	be used along with `$HOME` and `$XDG_CONFIG_HOME` to create a
+	predictable environment for a picky script, or you can set it
+	temporarily to avoid using a buggy `/etc/gitconfig` file while
+	waiting for someone with sufficient permissions to fix it.
+
 'GIT_FLUSH'::
 	If this environment variable is set to "1", then commands such
 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
-- 
1.8.0.rc2
