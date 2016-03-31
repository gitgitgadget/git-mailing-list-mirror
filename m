From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] submodule--helper clone: simplify path check
Date: Thu, 31 Mar 2016 09:36:53 -0700
Message-ID: <xmqqlh4yppsq.fsf@gitster.mtv.corp.google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:37:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfae-0004wR-GF
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbcCaQg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:36:57 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752206AbcCaQg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:36:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4480E50E3A;
	Thu, 31 Mar 2016 12:36:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lnWZbypof/1MsiDZoCpDxdrZFXw=; b=qaXhxN
	IoxS7UFbvRPQRlJNTYSROpHpHAFvqYlmaLyEUIuZgawFny+yWpQQAGVC7qUtV7xd
	Dp2FWR0s1CtmkigF4d+xweOxbZTJGNDAV5QE+uui8a/PjHqKjtnRywjWBA04r8pS
	FuNKI07wa9TauT6z0tiUgzE8B1O5ee7XL27H4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lm2tCi+72311jbzbWHDJRZ4DNVabdlF+
	Xv5qvvpsC3Xm7z0pgcLm5H+F5VpuVmN0znWH5P0e/JqUGbRjHOnDzk6qvKY5Dz1h
	ubglWxQUY2/x8RhjddsEaNlCqF1HR525daeMovHMMjEFscZ7KOxAfj1JoIIoDSM7
	xlBWCtBUDmM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BB3350E39;
	Thu, 31 Mar 2016 12:36:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6865F50E29;
	Thu, 31 Mar 2016 12:36:54 -0400 (EDT)
In-Reply-To: <1459383457-6848-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 30 Mar 2016 17:17:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C71FC534-F75E-11E5-AB04-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290414>

Stefan Beller <sbeller@google.com> writes:

> The calling shell code makes sure that `path` is non null and non empty.
> (side note: it cannot be null as just three lines before it is passed
> to safe_create_leading_directories_const which would crash as you feed
> it null).

This is not Java so let's spell that thing NULL.

Perhaps it would be cheap-enough prudence to do this on top?

 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 88002ca..f11796a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -194,6 +194,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
+	assert(path);
+
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
 	sm_gitdir = strbuf_detach(&sb, NULL);
 
