From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git loses commits on git pull --rebase with Dictator and Lieutenants Workflow
Date: Thu, 29 Jan 2015 12:26:09 -0800
Message-ID: <xmqqegqde3ku.fsf_-_@gitster.dls.corp.google.com>
References: <loom.20150128T203924-608@post.gmane.org>
	<xmqqlhkle64d.fsf@gitster.dls.corp.google.com>
	<loom.20150129T205443-493@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dick <dick@mrns.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 21:26:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGvfQ-000226-4S
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 21:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359AbbA2U0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 15:26:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758345AbbA2U0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 15:26:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6390232A27;
	Thu, 29 Jan 2015 15:26:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YE+SziHa/AC9aKzOTHK0tkkiTL0=; b=dbvUS5
	p50ljtdFat7/xbGHV4pKBbMBFnQPnup5eYPBrxgURgFapBJ3esvndxMrwikLM0Wb
	Cf6N5rujrH5dvp/6R0wFtcTUw1cE4RepvXw8Y8nvHlYFQwlxW76P4hft/3638he6
	lWQ0cZ2kYO3drxe/9bHml6w/KJwG22rGpuDhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WjSxgwcfHGcHMfuLtuDVc31QwzM3DteA
	7kJxFZX3U3xf5pgmnpNBvd7QKrgajyxBM3H4iyEc07aXAqJ/yhrsm5JCKlo7ZzK2
	UT0PMcO4HBSn1SGoY7ViRGi3C9Y4VnYOAdxUH5FzVLOCiE03veEETPx9sfXkB7mf
	DfK/Ivxsm+g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55A1532A26;
	Thu, 29 Jan 2015 15:26:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFB8232A25;
	Thu, 29 Jan 2015 15:26:10 -0500 (EST)
In-Reply-To: <loom.20150129T205443-493@post.gmane.org> (dick@mrns.nl's message
	of "Thu, 29 Jan 2015 19:59:02 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 102B7026-A7F5-11E4-95F8-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263160>

Dick <dick@mrns.nl> writes:

> I guess the git remote set-url --push command should contain some warning 
> about this.

Perhaps something like this would be good enough for a starter.

-- >8 --
Subject: Documentation/git-remote.txt: stress that set-url is not for triangular

It seems to be a common mistake to try using a single remote
(e.g. 'origin') to fetch from one place (i.e. upstream) while
pushing to another (i.e. your publishing point).  That will never
work satisfactory.  Think about what refs/remotes/origin/* would
mean in such a world---it fundamentally cannot reflect the reality.
If it follows the state of your upstream, it cannot match what you
have published, and vice versa.

Some low-quality websites may be spreading misinformation.  Let's
counter them by adding a few words to our documentation.

 - The description was referring to <oldurl> and <newurl>, but never
   mentioned <name> argument you give from the command line.  By
   mentioning "remote <name>", stress the fact that it is configuring
   a single remote.

 - Add a reminder that explicitly states that this is about a single
   remote, which the triangular workflow is not about.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-remote.txt | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index cb103c8..a77607b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -130,17 +130,25 @@ branches, adds to that list.
 
 'set-url'::
 
-Changes URL remote points to. Sets first URL remote points to matching
+Changes URLs for the remote. Sets first URL for remote <name> that matches
 regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
-<oldurl> doesn't match any URL, error occurs and nothing is changed.
+<oldurl> doesn't match any URL, an error occurs and nothing is changed.
 +
 With '--push', push URLs are manipulated instead of fetch URLs.
 +
-With '--add', instead of changing some URL, new URL is added.
+With '--add', instead of changing existing URLs, new URL is added.
 +
-With '--delete', instead of changing some URL, all URLs matching
-regex <url> are deleted. Trying to delete all non-push URLs is an
-error.
+With '--delete', instead of changing existing URLs, all URLs matching
+regex <url> are deleted for remote <name>.  Trying to delete all
+non-push URLs is an error.
++
+Note that the push URL and the fetch URL, even though they can
+be set differently, must still refer to the same place.  What you
+pushed to the push URL should be what you would see if you
+immediately fetched from the fetch URL.  If you are trying to
+fetch from one place (e.g. your upstream) and push to another (e.g.
+your publishing repository), use two separate remotes.
+
 
 'show'::
 
