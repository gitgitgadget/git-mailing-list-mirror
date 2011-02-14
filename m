From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 10:06:03 -0800
Message-ID: <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 19:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp2p2-0000TO-3P
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 19:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799Ab1BNSGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 13:06:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab1BNSGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 13:06:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C19E4375C;
	Mon, 14 Feb 2011 13:07:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8vMcbwdfm4QZ511okBzDNAfjUWg=; b=jaLg6s
	Y3BwnboxWVNcl7qeX56JiINxkvCm6+sfeupmxKiN/MfcegBSEXIGcvN200mNsYGL
	ubhg/p3U43E0Nqlp5dCZBqTm/WsApxANc93em0yCUzL93sFwIPXbOSmNXEidipaj
	l2T1bmelE020F1lHckxn2Qz4mQYeqjBqD62Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FtMDKa2uWjrViCuDXy/GK3TmRK6y2NqV
	VfjR0uWwHXaohj+SgDWFRyR0D0gMUJKCjtp2aQqzdIbaeSsF+FWcVSaigMxE+LuY
	XkfdQ0VOtj/g3L+YIcTjMNb27FdYH2N18f8+2TB07PG5IOsUrV3L7JSJ2THL4JFZ
	aMpdBpPQpEw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C9E23752;
	Mon, 14 Feb 2011 13:07:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 48AB4374D; Mon, 14 Feb 2011
 13:07:11 -0500 (EST)
In-Reply-To: <201102141018.46527.johan@herland.net> (Johan Herland's message
 of "Mon\, 14 Feb 2011 10\:18\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45962DF4-3865-11E0-B7B8-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166743>

Johan Herland <johan@herland.net> writes:

> It's not, except that "refs/*:refs/remotes/origin/*" would fetch a too-large 
> superset. E.g. it would fetch "refs/remotes/third-party/heads/foo" into 
> "refs/remotes/origin/remotes/third-party/heads/foo", which we probably don't 
> want.

Ah, very true.  We are generally not interested in remote's remotes that
possibly include ourselves ;-)

> "Now you could argue that auto-follow is not worth the effort. It is
> somewhat confusing, and I can't think of a time when it ever actually
> reduced the set of objects I was fetching (as opposed to just fetching
> all tags). But maybe others have use cases where it matters."
>
> So if nobody disagree, I would have no problem with dropping the leading "~" 
> from the refspec, thus disabling auto-following (tracking all tags 
> explicitly instead).

I am not sure what you mean by this.  I think we agree that it would be Ok
if you cannot add "~" in front to cause automatic following when tracking
tags in separate namespaces using "refs/tags/*:refs/remotes/origin/tags/*".

But are you saying:

 (1) There is no other change than that; or

 (2) Even when not using such a refspec i.e. using the traditional "tags
     live in a single global namespace", automatic following feature will
     be disabled;

I would be moderately unhappy if the latter.

> ... However, what I've seen at $dayjob is 
> that more inexperienced users will often push right after committing, and at 
> that time they're still very much in the "working-on-one-branch" state of 
> mind (as opposed to the "administering-multiple-branches" state of mind),...

Then "current" mode is a good setting for them, I would presume.  I don't
think it is a bad idea to make that the default given sufficient lead time
to warn the current users, and if we want to make the switch at 1.8.0, the
time to start issuing a warning is now.  Perhaps like this.

-- >8 --
Subject: [1.8.0 RFC] push: start warning upcoming default change for push.default

More inexperienced users will often push right after committing, and at
that time they're still very much in the "working-on-one-branch" state of
mind.  "current" would be a safer default mode of operation for 'git push'
for them even when they have their personal publishing repository (also in
a shared public repository settings, "matching" is rarely the right
default mode).

In preparation for flipping the default to the "current" mode from the
"matching" mode that is the current default, start warning users when they
rely on unconfigured "git push" to default to the "matching" mode.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c |   13 +++++++++++++
 cache.h        |    1 +
 environment.c  |    2 +-
 3 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index e655eb7..fe6665e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -80,10 +80,23 @@ static void setup_push_tracking(void)
 	add_refspec(refspec.buf);
 }
 
+static void warn_unspecified_push_default_configuration(void)
+{
+	static int warn_once;
+
+	if (warn_once++)
+		return;
+	warning("You do not have an explicit 'matching' setting for push.default");
+	warning("Your workflow will be broken at 1.8.0 unless you do so now");
+}
+
 static void setup_default_push_refspecs(void)
 {
 	switch (push_default) {
 	default:
+	case PUSH_DEFAULT_UNSPECIFIED:
+		warn_unspecified_push_default_configuration();
+		/* fallthru */
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
diff --git a/cache.h b/cache.h
index d83d68c..6c47867 100644
--- a/cache.h
+++ b/cache.h
@@ -606,6 +606,7 @@ enum rebase_setup_type {
 };
 
 enum push_default_type {
+	PUSH_DEFAULT_UNSPECIFIED = -1,
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_TRACKING,
diff --git a/environment.c b/environment.c
index 9564475..577177f 100644
--- a/environment.c
+++ b/environment.c
@@ -47,7 +47,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
+enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
