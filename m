From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: created new mergetool file for ExamDiff
Date: Sun, 20 Mar 2016 18:02:55 -0700
Message-ID: <xmqqfuvkod6o.fsf@gitster.mtv.corp.google.com>
References: <1458449932-24342-1-git-send-email-jacob.nisnevich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jacob Nisnevich <jacob.nisnevich@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 02:03:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahoFT-0004d8-PX
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 02:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbcCUBDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 21:03:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750787AbcCUBC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 21:02:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A70F14F918;
	Sun, 20 Mar 2016 21:02:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GsBfe9cXVRN839tk3psG3Z8oIcE=; b=iM7x0B
	bOdnKePC/lR6ENOSIcwB+vmIUWV7YejENrzUK/AiRMl1fwx8S099w74RMgNYiJdW
	kzPWlY5EPSDSB2zYTdZxBPA7Kai1u8tByGL2w9kkxYB2oCyaXykrlSIi9h0Rronv
	FKYlSfleXtdqEheiTRzTYvZJwK2VLNDhIYW6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BU88c6f/ULO9J+UPpZtnU73WO4dUxqDW
	/sP7Gheoj5hnsn/WwHTHRZ2xD5Z1mE54EyfPEeltXWvh2rmJsJQ196//WrM8737D
	HB/DGl7NnBwo/s53vGnN/vLKyWrJlSje1P9KDsVsLQ6lOI7l3fkBUVBdUKwbNtEd
	w6Yv8yirOtQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EF564F917;
	Sun, 20 Mar 2016 21:02:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 25FD24F916;
	Sun, 20 Mar 2016 21:02:57 -0400 (EDT)
In-Reply-To: <1458449932-24342-1-git-send-email-jacob.nisnevich@gmail.com>
	(Jacob Nisnevich's message of "Sat, 19 Mar 2016 21:58:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A62D2ED6-EF00-11E5-9AC6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289392>

Jacob Nisnevich <jacob.nisnevich@gmail.com> writes:

> ---

Missing sign-off.

I'll Cc the area expert (David Aguilar).

>  mergetools/examdiff | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 mergetools/examdiff
>
> diff --git a/mergetools/examdiff b/mergetools/examdiff
> new file mode 100644
> index 0000000..474fffe
> --- /dev/null
> +++ b/mergetools/examdiff
> @@ -0,0 +1,37 @@
> +diff_cmd () {
> +	"$merge_tool_path" "$LOCAL" "$REMOTE" -nh
> +}
> +
> +merge_cmd () {
> +	touch "$BACKUP"
> +	if $base_present
> +	then
> +		"$merge_tool_path" -merge "$LOCAL" "$BASE" "$REMOTE" -o:"$MERGED" -nh
> +	else
> +		"$merge_tool_path" -merge "$LOCAL" "$REMOTE" -o:"$MERGED" -nh
> +	fi
> +	check_unchanged
> +}
> +
> +translate_merge_tool_path() {
> +	# Use ExamDiff.com if it exists in $PATH
> +	if type -p ExamDiff.com >/dev/null 2>&1
> +	then
> +		printf ExamDiff.com
> +		return
> +	fi
> +
> +	# Look for ExamDiff.com in the typical locations
> +	examdiff="ExamDiff Pro/ExamDiff.com"
> +	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
> +		cut -d '=' -f 2- | sort -u)
> +	do
> +		if test -n "$directory" && test -x "$directory/$examdiff"
> +		then
> +			printf '%s' "$directory/$examdiff"
> +			return
> +		fi
> +	done
> +
> +	printf ExamDiff.com

This complicated heuristics look like a cut-and-paste from the
neighbouring winmerge; makes me suspect that they should share the
same helper function to implement the bulk of the above code for
better maintainability (e.g. imagine in the future Microsoft decides
to introduce another directory organization and makes it necessary
to tweak the pattern you give to 'grep -Ei'---WinMergeU user may
notice that and fix it, while this script will be overlooked and
will stay stale until somebody from examdiff camp do the same fix
later).


> +}
> \ No newline at end of file

No newline at end of file?
