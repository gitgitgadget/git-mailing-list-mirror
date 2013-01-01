From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correct example restore from bundle
Date: Tue, 01 Jan 2013 12:51:13 -0800
Message-ID: <7vvcbgaapq.fsf@alter.siamese.dyndns.org>
References: <1357053973.22772208@f75.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Kirill Brilliantov <brilliantov@inbox.ru>
X-From: git-owner@vger.kernel.org Tue Jan 01 21:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq8pR-0002cd-TM
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 21:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab3AAUvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 15:51:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3AAUvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 15:51:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C8F3BC8F;
	Tue,  1 Jan 2013 15:51:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=APXsnePg9alISzsvedi0zUdR6zQ=; b=Q546Inr+vuonkZdI5ZDN
	kxjmuZBpN41QBWJ4r9+lTIa1TWXVD4adC/Xl2a+8fgtBeD5Vqkn9GAH1y+IqQCFH
	idoUCOeGGh1IFxJ4voIqO5AcN/CiNrRtZ0mImxC3nF9AHHYgqJMrA7lGmZli6ExS
	lBDe+5NMMMFDsa+0Q0/2JeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KSxMFQU+sAyxiMlWCK0/9aj8xyvbmf2Zedq7ufdF4sSc8L
	SzpOkVZvu54Jlpkhdi15SYKeBgcEPjMfd9S8l6JBvqMJtp6kCDQFG/qv8X1FNgpm
	MvPX0/uqxWNX2eophi0GvHF0h52iua5i6M0ZVXzq68TD3+KlGIZl3u7SoMVP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D970BC8D;
	Tue,  1 Jan 2013 15:51:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1D07BC8C; Tue,  1 Jan 2013
 15:51:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB8A408E-5454-11E2-8373-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212438>

Kirill Brilliantov <brilliantov@inbox.ru> writes:

>  ----------------
> -machineB$ git clone /home/me/tmp/file.bundle R2
> +machineB$ git clone /home/me/tmp/file.bundle R2 -b master

I think the command line should follow the convention that is
suggested in "git clone -h" output, i.e.

    git clone -b master /home/me/tmp/file.bundle R2

I also think 'git bundle create" should record HEAD that points at
the only branch it is packing so the person who clones from it
should not say which branch, and when that is done this patch will
become unnecessary, but that is a separate topic.

Thanks; I'll queue this after rewording some.

-- >8 --
From: Kirill Brilliantov <brilliantov@inbox.ru>
Date: Tue, 1 Jan 2013 17:54:44 +0400
Subject: [PATCH] Documentation: correct example restore from bundle

Because the bundle created in the example does not record HEAD, "git
clone" will not check out the files to the working tree:

    $ git clone pr.bundle q/
    Cloning into 'q'...
    Receiving objects: 100% (619/619), 13.52 MiB | 18.74 MiB/s, done.
    Resolving deltas: 100% (413/413), done.
    warning: remote HEAD refers to nonexistent ref, unable to checkout.

Avoid alarming the readers by adding "-b master" to the example.  A
better fix may be to arrange the bundle created in the earlier step
to record HEAD, so that it can be cloned without this workaround.

Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-bundle.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 16a6b0a..5c8ba44 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -118,7 +118,7 @@ were a remote repository instead of creating an empty repository and then
 pulling or fetching objects from the bundle:
 
 ----------------
-machineB$ git clone /home/me/tmp/file.bundle R2
+machineB$ git clone -b master /home/me/tmp/file.bundle R2
 ----------------
 
 This will define a remote called "origin" in the resulting repository that
-- 
1.8.1.209.gc32ab23
