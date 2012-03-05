From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mergetools: add support for DeltaWalker
Date: Sun, 04 Mar 2012 18:38:11 -0800
Message-ID: <7v399n7ox8.fsf@alter.siamese.dyndns.org>
References: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com>
 <7vaa3ybpat.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4q7gmFeHuGM5hFruduHw-3mGa+CMU=U6X0jjXUsJLsvw@mail.gmail.com>
 <7vmx7x5ml0.fsf@alter.siamese.dyndns.org>
 <CAFouetjZ0kQMnAPdNey5kSEmq+fmQqq+fC51hcT+9k6T8c6uOw@mail.gmail.com>
 <CAJDDKr6toChs8KpnAbjxeemBZT1AT1Uk9Ajk7DWBREuM6yFMzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 03:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Not-0006fX-36
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 03:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2CECiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 21:38:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab2CECiO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 21:38:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F356210;
	Sun,  4 Mar 2012 21:38:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Ed2dySF61XTaWhsnSMGO74bqjE=; b=U0Ahp+
	xYq7czcVYThrrR7CHRMZyXC4Ox4pg31A2dCaURO4sQiDLxwXswGCnJ8Cfcgp5UVn
	2F3J814uNwqZBj1v0JmdIRyYwbsCshJvE220ALzZQkGL19zbhvaHAt4hcDtrGw4T
	XAhie1XxKcETo0dvUfQa1XqQMK4SIUaZ2jRCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ig036XnLUt9ZEvXov3RkpAlgD04nH1bL
	/1Z/sZg00FnLkAamPqg/2C08sw9AZnQVBm/cGVHTat4tre459LnKKrQkHLJCvjYa
	KmZPwumqp73xWDtp5ep/rD1AJMrBHJ+X/SaFF7outo3l9fSQu5dxdxn5u/Fz+cA8
	GJpSaSYXE2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BE7E620F;
	Sun,  4 Mar 2012 21:38:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E340620E; Sun,  4 Mar 2012
 21:38:12 -0500 (EST)
In-Reply-To: <CAJDDKr6toChs8KpnAbjxeemBZT1AT1Uk9Ajk7DWBREuM6yFMzg@mail.gmail.com> (David
 Aguilar's message of "Sun, 4 Mar 2012 18:10:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40FDB2D6-666C-11E1-839E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192188>

David Aguilar <davvid@gmail.com> writes:

> Can you mention this in a comment so that someone doesn't copy/paste
> it into another tool in the future?

Ok, I think the result should look like this, but could you fill in the
details in the below?

-- >8 --
From: Tim Henigan <tim.henigan@gmail.com>
Date: Sat, 3 Mar 2012 11:56:34 -0500
Subject: [PATCH] mergetools: add a plug-in to support DeltaWalker

DeltaWalker is a non-free tool that is popular among xxxxxxx users. Add a
plug-in to support it from difftool and mergetool.

Note that $(pwd)/ in front of $MERGED shouldn't be necessary, but without
it, DeltaWalker crashes with an JRE exception.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
Helped-by: David Aguilar
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mergetools/deltawalker |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 mergetools/deltawalker

diff --git a/mergetools/deltawalker b/mergetools/deltawalker
new file mode 100644
index 0000000..f8631f2
--- /dev/null
+++ b/mergetools/deltawalker
@@ -0,0 +1,19 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
+}
+
+merge_cmd () {
+	# The $(pwd)/ in front of $MERGED should not be necessary but
+	# DeltaWalker (at least ver XXX) crashes with a JRE exception
+	# and the $(pwd)/ seems to work around it.
+	if $base_present
+	then
+		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -merged="$(pwd)/$MERGED"
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -merged="$(pwd)/$MERGED"
+	fi >/dev/null 2>&1
+}
+
+translate_merge_tool_path() {
+	echo DeltaWalker
+}
-- 
1.7.9.2.390.g8f827
