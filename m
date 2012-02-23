From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: gitk: set uicolor SystemButtonFace error on X11 if .gitk created
 using Win32 tk
Date: Thu, 23 Feb 2012 15:03:12 +0100
Message-ID: <CABPQNSZqX0_YAn=mOpuRquG9OzFgwS9fQ6=YXqULxMz-hbH6Zw@mail.gmail.com>
References: <70952A932255A2489522275A628B97C31288FA0B@xmb-sjc-233.amer.cisco.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 15:04:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ZH4-0001vC-C5
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 15:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab2BWODy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 09:03:54 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53533 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab2BWODx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 09:03:53 -0500
Received: by daed14 with SMTP id d14so1305475dae.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 06:03:52 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 10.68.125.233 as permitted sender) client-ip=10.68.125.233;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of kusmabite@gmail.com designates 10.68.125.233 as permitted sender) smtp.mail=kusmabite@gmail.com; dkim=pass header.i=kusmabite@gmail.com
Received: from mr.google.com ([10.68.125.233])
        by 10.68.125.233 with SMTP id mt9mr4380699pbb.119.1330005832823 (num_hops = 1);
        Thu, 23 Feb 2012 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=agmQOaXEqtrAteMDI+b0Oxv8J45xubE2t/IPkBsPjoY=;
        b=pAjrzMkuQRYGsmgMGVDYOV3x2/DdhMmEcEr2xmv/9JnbeD9vPPsiF2CW1TY82qPfAd
         FnVQnBPFSrzhqLfaFl43vGrbyQC4BjIPalmonKQA1dzn+rpwnTSsoMCnXce94I3BMqjY
         g3YXUCCzodUiO/rGlJ1y6khP0x+MINWh4syQg=
Received: by 10.68.125.233 with SMTP id mt9mr3726669pbb.119.1330005832752;
 Thu, 23 Feb 2012 06:03:52 -0800 (PST)
Received: by 10.68.12.194 with HTTP; Thu, 23 Feb 2012 06:03:12 -0800 (PST)
In-Reply-To: <70952A932255A2489522275A628B97C31288FA0B@xmb-sjc-233.amer.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191366>

On Wed, Feb 22, 2012 at 11:13 PM, Matt Seitz (matseitz)
<matseitz@cisco.com> wrote:
> Would you please change gitk to not hard-code Win32-specific color
> values when creating .gitk on a Win32 windowing system?
>
> Gitk stopped working for me on Cygwin when Cygwin changed from using =
a
> Win32 native version of tk to using the standard X11 version. =A0The =
error
> was because gitk had previously created a .gitk file using Win32
> specific color values:
>
> https://github.com/gitster/git/commit/1924d1bc0dc99cd3460d3551671908c=
c76
> c09d3b
>
> I was able to work around the problem by replacing the Win32 specific
> colors in my .gitk file with the default colors gitk uses on other
> windowing systems.
>

Are you saying that the tk shipped with recent Cygwin reports "win32"
for "[tk windowingsystem]", but does not recognize the
"SystemButtonFace" etc values?

If so, perhaps adding a check for one of the constant values might
make sense. But I'd expect "[tk windowingsystem]" to report "x11" if
it's simply a Cygwin build of the X11-version as you say...

Anyway, this does sound like a regression in Cygwin; we're probably
not the only ones to use "SystemButtonFace" etc after consulting "[tk
windowingsystem]"...

Hm, no wait, the documentation seems to suggest ditching the
System-prefix to these constants:
http://www.tcl.tk/man/tcl/TkCmd/colors.htm

Does this patch help?

---

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f9e936d..7e9a01f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11559,10 +11559,10 @@ if {[tk windowingsystem] eq "aqua"} {

 set colors {green red blue magenta darkgrey brown orange}
 if {[tk windowingsystem] eq "win32"} {
-    set uicolor SystemButtonFace
-    set bgcolor SystemWindow
-    set fgcolor SystemButtonText
-    set selectbgcolor SystemHighlight
+    set uicolor ButtonFace
+    set bgcolor Window
+    set fgcolor ButtonText
+    set selectbgcolor Highlight
 } else {
     set uicolor grey85
     set bgcolor white
