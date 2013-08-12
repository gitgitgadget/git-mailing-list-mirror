From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Fix occasional truncation of symlink contents.
Date: Mon, 12 Aug 2013 10:11:51 -0700
Message-ID: <7v4nau25rc.fsf@alter.siamese.dyndns.org>
References: <1375967858-10615-1-git-send-email-ajuncu@ixiacom.com>
	<20130811115738.GA26658@padd.com>
	<CAPhGq=YBVvejZ2gacwroX3cw0K3nDo02kWmMdP6Uwgd5sfPXKQ@mail.gmail.com>
	<20130812123850.GA25532@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandru Juncu <alexj@rosedu.org>, git@vger.kernel.org,
	Alexandru Juncu <ajuncu@ixiacom.com>,
	Alex Badea <abadea@ixiacom.com>,
	Alexander Tomlinson <alex@aivor.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 19:12:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8vf1-0002Xe-4T
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 19:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab3HLRL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 13:11:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756738Ab3HLRL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 13:11:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5F1C385A2;
	Mon, 12 Aug 2013 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8Rsy+W6CK+JoD4uFGUTcb7BDtI=; b=rw3hn6
	Erx5XyziSeZgmsdnQKtE5wSdOzAlfW42k9H0m4SmgUTiDTibjwVyBqWWgidejlNx
	X+kvop5hl1MBV7K3XpdjJBYGLDt10E5roBMqRKpF9pODahsKA90ra74/AA117pfq
	Qe9EwPyV9aJIRDDT3jgaAjWOzxuUUB4XjsblI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ulRVn+ubUrHwNClwhxnaXxL6lNFm77Zw
	DAg0DqNuV8HEgwtF99sltGryIyfv1zr1rGoBqsghaSeD/yE6d9jvIZdnmJELnbPS
	WsyupSAPllOMKXhOhoYo/LyUKCRQnKTW1NAWWXhflYbgdMGCL95JXGOzI7j+rfIn
	qPENbOClImk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6312385A1;
	Mon, 12 Aug 2013 17:11:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F31CF3859C;
	Mon, 12 Aug 2013 17:11:53 +0000 (UTC)
In-Reply-To: <20130812123850.GA25532@padd.com> (Pete Wyckoff's message of
	"Mon, 12 Aug 2013 08:38:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4934D994-0372-11E3-A8F6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232199>

Pete Wyckoff <pw@padd.com> writes:

> You should send the patch to junio for inclusion in pu/ for the
> next release, with:
>
> Acked-by: Pete Wyckoff <pw@padd.com>

Thanks; I'll queue this then.

-- >8 --
From: Alexandru Juncu <alexj@rosedu.org>
Date: Thu, 8 Aug 2013 16:17:38 +0300
Subject: [PATCH] git-p4: Fix occasional truncation of symlink contents.

Symlink contents in p4 print sometimes have a trailing
new line character, but sometimes it doesn't. git-p4
should only remove the last character if that character
is '\n'.

Signed-off-by: Alex Juncu <ajuncu@ixiacom.com>
Signed-off-by: Alex Badea <abadea@ixiacom.com>
Acked-by: Pete Wyckoff <pw@padd.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-p4.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 31e71ff..a53a6dc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2180,9 +2180,13 @@ class P4Sync(Command, P4UserMap):
             git_mode = "100755"
         if type_base == "symlink":
             git_mode = "120000"
-            # p4 print on a symlink contains "target\n"; remove the newline
+            # p4 print on a symlink sometimes contains "target\n";
+            # if it does, remove the newline
             data = ''.join(contents)
-            contents = [data[:-1]]
+            if data[-1] == '\n':
+                contents = [data[:-1]]
+            else:
+                contents = [data]
 
         if type_base == "utf16":
             # p4 delivers different text in the python output to -G
-- 
1.8.4-rc2-235-g32b7467
