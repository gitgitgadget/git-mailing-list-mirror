From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "t0001: test git init when run via an alias"
Date: Tue, 10 Jun 2014 11:53:47 -0700
Message-ID: <xmqqzjhk8ukk.fsf@gitster.dls.corp.google.com>
References: <20140606110935.GA14446@lanh>
	<1402220230-799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	dturner@twopensource.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:54:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuRBv-0001x2-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbaFJSyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 14:54:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50581 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbaFJSx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 14:53:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A1451CF9E;
	Tue, 10 Jun 2014 14:53:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1tSM+o4jGElQ07dWl38WMKkvgwA=; b=Lj2/d7
	x9bJVyZOMvwBj8xphOwSzTyvBNiG0JS2qZXYtEd5WBAF6/NIZShrxGYSBFkBflFn
	D2TMD7pvcz6keLkqavUsF0OuDKsJFfDtm1jFs1q3f6WMgeh3wcPT/jv9sAngOzg0
	rj1+LSV3pveEeyVal2Al4JJ/lYV5WJaWUcDBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G4d3P4W53Oi+ylqWbfixffydWFjS+QU+
	uvd1cvR4zMOLO8GUSBMhD6QnAPmt7U6XI8HGMFs87cjjVmDv0rQaGRHy93XPeAzs
	jLBC0XPC1M7vb5vdgA5X/TEeDyDfzIVCtIwmZV7gfawUTfKRIqkB1ye5DH5ztOFJ
	0OhC1T6EO30=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 605E41CF9D;
	Tue, 10 Jun 2014 14:53:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69F9E1CF97;
	Tue, 10 Jun 2014 14:53:49 -0400 (EDT)
In-Reply-To: <1402220230-799-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Sun, 8 Jun
 2014 16:37:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F03013E-F0D0-11E3-8FBF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251216>

I'd squash this in, though.

 git.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 6bb2043..9bfa8fb 100644
--- a/git.c
+++ b/git.c
@@ -36,7 +36,8 @@ static void save_env(void)
 	if (saved_environment)
 		return;
 	saved_environment = 1;
-	getcwd(orig_cwd, sizeof(orig_cwd));
+	if (getcwd(orig_cwd, sizeof(orig_cwd)))
+		die_errno("cannot getcwd");
 	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
 		orig_env[i] = getenv(env_names[i]);
 		if (orig_env[i])
