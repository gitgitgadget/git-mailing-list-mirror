From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] convert.c clean-up
Date: Mon,  9 May 2011 15:04:57 -0700
Message-ID: <1304978701-19310-1-git-send-email-gitster@pobox.com>
References: <20110508101925.GA19525@do>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 00:05:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYaG-0005q9-H7
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195Ab1EIWFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:05:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab1EIWFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:05:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 554F84788;
	Mon,  9 May 2011 18:07:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Y/wO
	VIFWwYvazTJcb99qlO1pmpU=; b=uWTOOChPsx/FeB3ENtjvJRyryVXSRD57DHHg
	tMVWLZyO1xrmy/i9frSUlTnJNOlnfQyrsaPCmspvDzk4WZclReMaw0PcZGiRizXf
	7DrD05jXqQosixzLSW6HqUtG+AaNiPxYdih0slzTTTJ6QjaMtwknpStpdDaZTlDb
	ObHmkjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	QSEd+2ZldslZTdSL7UMKi3ol+iEkLw6gnx8mb11YndG8UYF3AZZXG4nzblv43lK+
	CR8j2bfI91n0tI44s7mdiyuHvKoaYVB4esHq7jpClMMmZo4nGs0UrPXJdvXQ0ZBB
	6MtQf5nvf1EqahsQhZNWYz0ax+mzHDBYn8zPPG5qs0s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 409304785;
	Mon,  9 May 2011 18:07:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 82AF1477F; Mon,  9 May 2011
 18:07:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.288.g93ebc
In-Reply-To: <20110508101925.GA19525@do>
X-Pobox-Relay-ID: B0365CC8-7A88-11E0-BD23-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173268>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Instead we could detect if convert-from/to-git is unnecessary and
> stream big blobs based on core.bigFileThresold. The below patch may
> help.

Yeah, I think that would probably make more sense. If a file is small
enough, it is more sensible to send it to a loose object just like any
other files. We do not want to invite users to make a mistake of marking
it as bigdata and send it straight to a packfile. Having one less knob to
tweak is always a good thing to do.

However, while reviewing your patch, I noticed that convert.c was littered
with misnamed types, variables and functions to the point to make it
almost unreadble as the result of its evolution.  I originally wrote this
series so that I can add "bigdata" sensibly, and it turns out that there
is no benefit to do so for now, but the clean-up by itself would be worth
it.

So there...

Junio C Hamano (4):
  convert: rename the "eol" global variable to "core_eol"
  convert: give saner names to crlf/eol variables, types and functions
  convert: make it safer to add conversion attributes
  convert: make it harder to screw up adding a conversion attribute

 cache.h       |    2 +-
 config.c      |   12 ++--
 convert.c     |  158 +++++++++++++++++++++++++++-----------------------------
 environment.c |    2 +-
 4 files changed, 84 insertions(+), 90 deletions(-)

-- 
1.7.5.1.288.g93ebc
