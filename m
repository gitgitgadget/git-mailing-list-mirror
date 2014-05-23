From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE costruct
Date: Fri, 23 May 2014 11:18:35 -0700
Message-ID: <xmqqmwe8jr44.fsf@gitster.dls.corp.google.com>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de, dak@gnu.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:18:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnu3L-0007hl-D9
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 20:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbaEWSSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 14:18:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56550 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbaEWSSl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 14:18:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4890919DA2;
	Fri, 23 May 2014 14:18:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XojqQvx2TTvTZGR3A6CcBcQQqPg=; b=WOWj3r
	zwskRA7I9uxcluwLZXdrFYoqGdoZmXgXlxlMZmmgQxHb71y77SFWB2bR4nu1H8YS
	3H3Cv/9rC82JnsFYcQ4Lsrc4DxBnkirYldObjoW29Z3CqWJRwU6+PyKOW9IZv/8z
	PjgMZf3Jk0lNmZcfmZlaChgRMeXD4N0EKx9Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rTZ1aKjeexR5utU9UNVvJQAtBXOK+zsZ
	ozcqf7szoit0SM1SJnNztHZmLPo7IA8u/OwoS3LQgd7BHG27Y/SmvpJPO6EVOROB
	zX8SgfJXNjTqqzh2XDhtyTxfQHcOLmfrflk+7vPWfIjvNbQjPNEHfVXWchxv27kI
	y4y8OBHB4ro=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3EA8119DA0;
	Fri, 23 May 2014 14:18:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A97F19D9A;
	Fri, 23 May 2014 14:18:37 -0400 (EDT)
In-Reply-To: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Fri, 23 May 2014 03:15:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A8D87AFE-E2A6-11E3-8D71-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250007>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Found by check-non-portable-shell.pl

Thanks.

Makes me wonder why these two were missed, though.


 t/t3032-merge-recursive-options.sh | 6 +++++-
 t/t5560-http-backend-noserver.sh   | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 5fd7bbb..4029c9c 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -14,7 +14,11 @@ test_description='merge-recursive options
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
-test_have_prereq GREP_STRIPS_CR && export GREP_OPTIONS=-U
+if test_have_prereq GREP_STRIPS_CR
+then
+	GREP_OPTIONS=-U
+	export GREP_OPTIONS
+fi
 
 test_expect_success 'setup' '
 	conflict_hunks () {
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 9be9ae3..1e25128 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -5,7 +5,11 @@ test_description='test git-http-backend-noserver'
 
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
 
-test_have_prereq GREP_STRIPS_CR && export GREP_OPTIONS=-U
+if test_have_prereq GREP_STRIPS_CR
+then
+	GREP_OPTIONS=-U
+	export GREP_OPTIONS
+fi
 
 run_backend() {
 	echo "$2" |
