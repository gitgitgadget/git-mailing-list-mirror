From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 0/5] diff --ignore-case
Date: Tue, 21 Feb 2012 01:02:46 -0800
Message-ID: <7vwr7gh83t.fsf_-_@alter.siamese.dyndns.org>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
 <4F420749.9010206@kdbg.org> <7v8vjxnayn.fsf@alter.siamese.dyndns.org>
 <871upp4n15.fsf@thomas.inf.ethz.ch> <7vvcn1l21d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, <git@vger.kernel.org>,
	Chris Leong <walkraft@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 21 10:03:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzlcg-0003U6-Lr
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 10:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab2BUJCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 04:02:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab2BUJCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 04:02:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49FF4311F;
	Tue, 21 Feb 2012 04:02:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jzRLbyd/elhCV+jLboT7ZbwvPsM=; b=pI3CAi
	COGT0HlqRfX7PrVvChLHjWXRYsmo4j9l/+qeGHQx70UstMyMe5pv2K7dUr/FFr06
	MPeMAhcEHIjnsGggNdQLCVXM1gfMtSR0Sqk8aA8+b3qTdcKViwkkyx0yZ2SSVayg
	o5n2htzHkRd8qpzQHItNLs3MoPNcrhdco1O2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9Yt3eaFLMVQIpKNvnvUuEY/GueVP6/s
	w1WHxvBMYOZGZ/+DQhvYMScSbPWvSalHmqvIifQ+TMhXsGd9OJKg/9PbWGvLwdxF
	olUgl+4Sa0XbGbsIFKH52E42fcqtWDhc8FAptbx/j3wusNZsnivIr5XIwGKbIgwg
	4VugPkMsPmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41F30311E;
	Tue, 21 Feb 2012 04:02:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0E75311D; Tue, 21 Feb 2012
 04:02:47 -0500 (EST)
In-Reply-To: <7vvcn1l21d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 20 Feb 2012 11:47:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D331AABA-5C6A-11E1-9209-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191143>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> I wonder which one of us misunderstood the original request ;-)
>
> Heh, I did ;-)
>
>> It was
>>
>> } Is there any way to run diff -G with a case insensitivity flag?
>>
>> and I took that to mean "I want to find addition/removal of a string
>> like -G does, but I don't know how it was capitalized".
>
> I think it is just the matter of checking REG_ICASE that may be set in
> revs->grep_filter.regflags, and propagating it down to the regcomp at the
> beginning of diffcore_pickaxe_grep().
>
> Want to try and see how well it works?

The gist of the patch should look like this.

Even though I haven't done anything more than just to compile and run "git
log -p -i -G search 233054d", it looks obviously correct ;-)

Note that this does not depend on any of the "diff --ignore-case" topic,
and it may conflict with [PATCH 6/5].  Among the two "else if" that flips
the REG_ICASE in revision.c, it needs to be decided if only one of them,
or both of them should set the new option. I haven't thought things through
to decide which.

 diff.h             |    1 +
 diffcore-pickaxe.c |    6 +++++-
 revision.c         |    1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index 7af5f1e..182cb0e 100644
--- a/diff.h
+++ b/diff.h
@@ -82,6 +82,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
 #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
+#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 380a837..8ffb741 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -138,8 +138,12 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 {
 	int err;
 	regex_t regex;
+	int cflags = REG_EXTENDED | REG_NEWLINE;
 
-	err = regcomp(&regex, o->pickaxe, REG_EXTENDED | REG_NEWLINE);
+	if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
+		cflags |= REG_ICASE;
+
+	err = regcomp(&regex, o->pickaxe, cflags);
 	if (err) {
 		char errbuf[1024];
 		regerror(err, &regex, errbuf, 1024);
diff --git a/revision.c b/revision.c
index 819ff01..b3554ed 100644
--- a/revision.c
+++ b/revision.c
@@ -1582,6 +1582,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.regflags |= REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
 		revs->grep_filter.regflags |= REG_ICASE;
+		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.fixed = 1;
 	} else if (!strcmp(arg, "--all-match")) {
