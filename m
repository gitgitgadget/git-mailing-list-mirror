From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] pretty: test --expand-tabs
Date: Mon, 04 Apr 2016 23:32:21 -0700
Message-ID: <xmqqbn5o4lca.fsf@gitster.mtv.corp.google.com>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
	<1459817917-32078-1-git-send-email-gitster@pobox.com>
	<1459817917-32078-5-git-send-email-gitster@pobox.com>
	<20160405015234.GB29953@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 08:32:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anKXN-0007CK-Qq
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 08:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbcDEGcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 02:32:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbcDEGcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 02:32:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87E6E4B2C5;
	Tue,  5 Apr 2016 02:32:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JU4tUUuPF2YlQbXDX0cjo/X46Lo=; b=OjISmF
	VHabv51fwRFl9pvlR9hC9zUvs16J7iz/qoR3q7TQoQZUJXhfzfdNECKABzS78emG
	trv5ZwQ1fNL05BIpn3VBfBaqth6OZBxMvgvaZAfZ4YyT+mXCw07m5QMqwySHWtri
	lZwPAdfy6Xiv13pOWvL2LGI/iBZbnvsbUUEls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FlVkzd4Npv95DFN26/Dhr0/Sr0wp+MLd
	BTNYfhTPHOCVNFGtCtcm6WBqqfJ65SRczN5vWjlkQfaMLR6tDClKGuHCvQjOwUF3
	VVoRXgPBneFHNa/Wt82t94nD+ELxmGsw35ZfDIK19CDo4EVHESce7VJ/mhGtqiXl
	kXoo4k/+E0w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F6D74B2C2;
	Tue,  5 Apr 2016 02:32:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B38474B2C1;
	Tue,  5 Apr 2016 02:32:22 -0400 (EDT)
In-Reply-To: <20160405015234.GB29953@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Apr 2016 21:52:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2793886E-FAF8-11E5-9AC5-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290763>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 04, 2016 at 05:58:37PM -0700, Junio C Hamano wrote:
>
>> +count_expand ()
>> +{
>
> This function takes a lot of unnamed arguments that we process with
> "shift". It might be nice to give a brief comment describing them.
> ...
>> +test_expand --pretty=fuller
>> +test_expand --pretty=fuller
> ...
> Duplicated fuller?

Thanks.  Here is a replacement.

-- >8 --
The test prepares a simple commit with HT on its log message lines,
and makes sure that

 - formats that should or should not expand tabs by default do or do
   not expand tabs respectively,

 - with explicit --expand-tabs=<N> and short-hands --expand-tabs
   (equivalent to --expand-tabs=8) and --no-expand-tabs (equivalent
   to --expand-tabs=0) before or after the explicit --pretty=$fmt,
   the tabs are expanded (or not expanded) accordingly.

The tests use the second line of the log message for formats other
than --pretty=short, primarily because the first line of the email
format is handled specially to add the [PATCH] prefix, etc. in a
separate codepath (--pretty=short uses the first line because there
is no other line to test).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4213-log-tabexpand.sh | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100755 t/t4213-log-tabexpand.sh

diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
new file mode 100755
index 0000000..e01a8f6
--- /dev/null
+++ b/t/t4213-log-tabexpand.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+test_description='log/show --expand-tabs'
+
+. ./test-lib.sh
+
+HT="	"
+title='tab indent at the beginning of the title line'
+body='tab indent on a line in the body'
+
+# usage: count_expand $indent $numSP $numHT @format_args
+count_expand ()
+{
+	expect=
+	count=$(( $1 + $2 )) ;# expected spaces
+	while test $count -gt 0
+	do
+		expect="$expect "
+		count=$(( $count - 1 ))
+	done
+	shift 2
+	count=$1 ;# expected tabs
+	while test $count -gt 0
+	do
+		expect="$expect$HT"
+		count=$(( $count - 1 ))
+	done
+	shift
+
+	# The remainder of the command line is "git show -s" options
+	case " $* " in
+	*' --pretty=short '*)
+		line=$title ;;
+	*)
+		line=$body ;;
+	esac
+
+	# Prefix the output with the command line arguments, and
+	# replace SP with a dot both in the expecte and actual output
+	# so that test_cmp would show the differene together with the
+	# breakage in a way easier to consume by the debugging user.
+	{
+		echo "git show -s $*"
+		echo "$expect$line"
+	} | sed -e 's/ /./g' >expect
+
+	{
+		echo "git show -s $*"
+		git show -s "$@" |
+		sed -n -e "/$line\$/p"
+	} | sed -e 's/ /./g' >actual
+
+	test_cmp expect actual
+}
+
+test_expand ()
+{
+	fmt=$1
+	case "$fmt" in
+	*=raw | *=short | *=email)
+		default="0 1" ;;
+	*)
+		default="8 0" ;;
+	esac
+	case "$fmt" in
+	*=email)
+		in=0 ;;
+	*)
+		in=4 ;;
+	esac
+	test_expect_success "expand/no-expand${fmt:+ for $fmt}" '
+		count_expand $in $default $fmt &&
+		count_expand $in 8 0 $fmt --expand-tabs &&
+		count_expand $in 8 0 --expand-tabs $fmt &&
+		count_expand $in 8 0 $fmt --expand-tabs=8 &&
+		count_expand $in 8 0 --expand-tabs=8 $fmt &&
+		count_expand $in 0 1 $fmt --no-expand-tabs &&
+		count_expand $in 0 1 --no-expand-tabs $fmt &&
+		count_expand $in 0 1 $fmt --expand-tabs=0 &&
+		count_expand $in 0 1 --expand-tabs=0 $fmt &&
+		count_expand $in 4 0 $fmt --expand-tabs=4 &&
+		count_expand $in 4 0 --expand-tabs=4 $fmt
+	'
+}
+
+test_expect_success 'setup' '
+	test_tick &&
+	sed -e "s/Q/$HT/g" <<-EOF >msg &&
+	Q$title
+
+	Q$body
+	EOF
+	git commit --allow-empty -F msg
+'
+
+test_expand ""
+test_expand --pretty
+test_expand --pretty=short
+test_expand --pretty=medium
+test_expand --pretty=full
+test_expand --pretty=fuller
+test_expand --pretty=raw
+test_expand --pretty=email
+
+test_done
-- 
2.8.1-253-gd0f4798
