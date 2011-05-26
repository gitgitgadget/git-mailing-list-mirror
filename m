From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Thu, 26 May 2011 08:48:47 -0700
Message-ID: <7vhb8hzcm8.fsf@alter.siamese.dyndns.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-3-git-send-email-mduft@gentoo.org>
 <20110526022045.GA8172@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mduft@gentoo.org, git@vger.kernel.org,
	Tor Arntsen <tor@spacetec.no>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 17:49:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcoC-0006M1-5R
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000Ab1EZPtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:49:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125Ab1EZPtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:49:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4B20494E;
	Thu, 26 May 2011 11:51:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L5nog9jeFDg1lwEWKUGNIsmZmU0=; b=gYaNSO
	8rDy/yuaxfDigjoTCw3uqH1bjJgSPENHH2oMTUsrw8KFuC6ekdYb8UKCw0sdKfNq
	0psFaRdR3r0kLzpmXGf086WYXp8qxqei3N5Clkvn0uMk3HbUFjfuTdT4z39BT6Jp
	gMzYDgak1HZstY3WvwYiPPpmx9F6eP+xRJxBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sGD+toa+sPU39OyHsahyyC0kEdIPFpz1
	jUG9LlP0ntnIX3D1/necGyDJJ7cJiyaXA6sW5KDXSVY+h+FlJLbIhEkILzEI9pk3
	VjtaLApwRTzATl2QYYUoJ5ZgFvy4E7KeufecThv/jh7nJZePDkkQbWmMIxHJN555
	zclZjhNYWc4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90B0E494D;
	Thu, 26 May 2011 11:51:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09076494C; Thu, 26 May 2011
 11:50:56 -0400 (EDT)
In-Reply-To: <20110526022045.GA8172@elie> (Jonathan Nieder's message of "Wed,
 25 May 2011 21:20:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F676310C-87AF-11E0-8E0D-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174525>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Given that we are touching this file anyway, how about relying on
> git-compat-util for this?

Many files in compat/ implementation already includes this header, so it
logically feels like a sane thing to do. I vaguely recall there was one
corner case where we didn't want to do this, but I do not remember the
details.

But I am tempted to do the following, as Tor Arntsen suggested, which I
think is the least risky solution. I deliberately spelled "0" without the
(void *) pointer cast, as this code borrowed from upstream is in old K&R
style and nobody talks about "void" elsewhere in the code.

 compat/fnmatch/fnmatch.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 14feac7..9473aed 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -127,6 +127,10 @@ extern char *getenv ();
 extern int errno;
 # endif
 
+# ifndef NULL
+#  define NULL 0
+# endif
+
 /* This function doesn't exist on most systems.  */
 
 # if !defined HAVE___STRCHRNUL && !defined _LIBC
