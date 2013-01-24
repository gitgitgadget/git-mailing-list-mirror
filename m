From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] pretty: Add failing tests: user format ignores
 i18n.logOutputEncoding setting
Date: Thu, 24 Jan 2013 12:44:15 -0800
Message-ID: <7vr4la9uqo.fsf@alter.siamese.dyndns.org>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
 <6de583a2d281b1614c69d5e7b6f5c4495488f6a3.1359018188.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyTf7-0005F5-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 21:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901Ab3AXUoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 15:44:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755749Ab3AXUoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 15:44:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A462BECE;
	Thu, 24 Jan 2013 15:44:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uaYDq5mGwfMvig7vIZtXmjcLfD4=; b=QsRfZq
	Xt2Ku8xn37Fhfo7PkyrQ0YS3vbCu7TsSYnZhrVGUJXhRYz6W6MIyYibS/NdPG7Pk
	3wV0EEi5261oCM45q/MfyAmuWQzph+bDZSN1m8c3FihAJzQvxFDFzLTOylqGmo8Y
	KxsXitlhlFSuw204KC+FiY8RrUbUN9TQgP7lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yEXUiLQrIXeFCLstYgIaIhsxjLhIjJbX
	fKuJgMt+46037BiiwVT6B9fPbZlLz9QIooM7mTddMO/UCssdTG0MWaOcADPdddOQ
	6qmA9XcX93cqYcrfDlm6uOTcVvaskvEQIkyW9YMeichY7xDZFkFhpBGQYWPmsXRY
	VY/PuBRrUyI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EEC5BECD;
	Thu, 24 Jan 2013 15:44:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2938BEC7; Thu, 24 Jan 2013
 15:44:16 -0500 (EST)
In-Reply-To: <6de583a2d281b1614c69d5e7b6f5c4495488f6a3.1359018188.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's message of "Thu, 24 Jan 2013 13:10:27 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1C7511E-6666-11E2-8B0B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214454>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> The following two commands are expected to give the same output to a terminal:
>
> 	$ git log --oneline --no-color
> 	$ git log --pretty=format:'%h %s'
>
> However, the former pays attention to i18n.logOutputEncoding
> configuration, while the latter does not when it format "%s".
> Log messages written in an encoding i18n.commitEncoding which differs
> from terminal encoding are shown corrupted with the latter even
> when i18n.logOutputEncoding and terminal encoding are the same.
>
> The same corruption is true for
> 	$ git diff --submodule=log
> and
> 	$ git rev-list --pretty=format:%s HEAD
> and
> 	$ git reset --hard
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> ---
>  t/t4041-diff-submodule-option.sh | 33 ++++++++-------
>  t/t4205-log-pretty-formats.sh    | 43 +++++++++++++++----
>  t/t6006-rev-list-format.sh       | 90 ++++++++++++++++++++++++++--------------
>  t/t7102-reset.sh                 | 32 +++++++++++---
>  4 files changed, 138 insertions(+), 60 deletions(-)
>
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index 32d4a60..e7d6363 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -1,6 +1,7 @@
>  #!/bin/sh
>  #
>  # Copyright (c) 2009 Jens Lehmann, based on t7401 by Ping Yin
> +# Copyright (c) 2011 Alexey Shumkin (+ non-UTF-8 commit encoding tests)
>  #
>  
>  test_description='Support for verbose submodule differences in git diff
> @@ -10,6 +11,7 @@ This test tries to verify the sanity of the --submodule option of git diff.
>  
>  . ./test-lib.sh
>  
> +added=$(printf "\320\264\320\276\320\261\320\260\320\262\320\273\320\265\320\275")

Please have an in-code comment before this line to explain what this
variable is about, e.g.

	# String "added" in Russian, encoded in UTF-8, used in
        # sample commit log messages in add_file() function below.
        added=$(printf "...")

>  add_file () {
>  	(
>  		cd "$1" &&
> @@ -19,7 +21,8 @@ add_file () {
>  			echo "$name" >"$name" &&
>  			git add "$name" &&
>  			test_tick &&
> -			git commit -m "Add $name" || exit
> +			msg_added_cp1251=$(echo "Add $name ($added $name)" | iconv -f utf-8 -t cp1251) &&
> +			git -c 'i18n.commitEncoding=cp1251' commit -m "$msg_added_cp1251"
>  		done >/dev/null &&
>  		git rev-parse --short --verify HEAD
>  	)

Does this patch make the all tests in this script fail for people
without cp1251 locale installed?  We already have tests that depend
on 8859-1 and some other locales, and we'd be better off limiting
such dependency to the minimum.

Same comment applies to the changes to other test scripts.

Thanks.
