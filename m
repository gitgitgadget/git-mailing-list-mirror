From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: print filename when it contains %
Date: Fri, 08 Feb 2013 13:09:56 -0800
Message-ID: <7vliayzf4r.fsf@alter.siamese.dyndns.org>
References: <1360286184-14278-1-git-send-email-asheesh@asheesh.org>
 <7vhalm3e54.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1302081558130.23245@rose.makesad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3vDE-0001Kf-Du
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 22:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947120Ab3BHVJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 16:09:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947070Ab3BHVJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 16:09:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A0F1C06E;
	Fri,  8 Feb 2013 16:09:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r9LgXQvlAaEVA70IEHAYJ0FBAGQ=; b=JtCCK4
	JPv8qW3rXT2OEQk7T34InoMx8O4AtmJJIbFajifR2KGwrmvno5a4oNH1QHP4tFys
	acHxvp4Y3GJd5bthOkaz37e07889qzM+ESfshsaiE6Txz5IOom0MmoX3lcxmRYGv
	gs5k5d/UEksIvegnJTFq145Nn0hZNcRz6CscY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=esr5QCS19X77BxCvlifL27XiWXEJ8+Rm
	PmwAdzi5V6Y9F6FsgxAvI8d3NFOj63zQWo/s/SzmF2TjJ+ppoRnvsV1r8LTXyqPb
	hEZBP0P6zPl8Xr6n8mMxZmXnOF2+0uXIMzMHXMrEjXh14jO+AYNf3iCDVx24JIEi
	3y4CIm++POY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C08AC06D;
	Fri,  8 Feb 2013 16:09:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFB63C069; Fri,  8 Feb 2013
 16:09:57 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1302081558130.23245@rose.makesad.us> (Asheesh
 Laroia's message of "Fri, 8 Feb 2013 15:58:54 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E48DCE94-7233-11E2-8A09-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215819>

Asheesh Laroia <asheesh@asheesh.org> writes:

> Junio, thanks for the quick reply! I agree with your suggestions, and
> will take a look at addressing them, hopefully by Tuesday or so.

FYI, here is what I queued for now.

-- >8 --
From: Asheesh Laroia <asheesh@asheesh.org>
Date: Thu, 7 Feb 2013 17:16:24 -0800
Subject: [PATCH] git-mergetool: print filename when it contains %

If git-mergetool was invoked with files with a percent sign (%) in
their names, it would print an error.  For example, if you were
calling mergetool on a file called "%2F":

    printf: %2F: invalid directive

Do not pass random string to printf as if it were a valid format.
Use format string "%s" and pass the string as a data to be formatted
instead.

Signed-off-by: Asheesh Laroia <asheesh@asheesh.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-mergetool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index c50e18a..012afa5 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -440,7 +440,7 @@ then
 fi
 
 printf "Merging:\n"
-printf "$files\n"
+printf "%s\n" "$files"
 
 IFS='
 '
-- 
1.8.1.3.617.gb5c8e72
