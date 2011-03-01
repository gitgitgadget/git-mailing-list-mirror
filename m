From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 16:11:55 -0800
Message-ID: <7vy64zg0ms.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <20110228122335.GB5197@sigill.intra.peff.net>
 <7vy650hvwa.fsf@alter.siamese.dyndns.org>
 <20110228222352.GC5854@sigill.intra.peff.net>
 <7vfwr7hh7f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Mart =?utf-8?Q?S=C3=B5mermaa?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 01:12:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuDCJ-0007qe-Av
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 01:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab1CAAMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 19:12:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab1CAAMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 19:12:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 423AF4C42;
	Mon, 28 Feb 2011 19:13:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w+njQbIJP9TFoygYJJLlWyg7Nac=; b=UJa0eB
	kYC7jfokLuEgkfaLW8YfImEV4UVqdnrnJ9OJUdGCsUshkVSPhvdUIm6G9n0EExsk
	J3iImkSwNaBsMQgDWR0cVxUGGSEuojpua0xn5Osl2nFV9mLJV6dWSkMtiP8Cjmfr
	4iCF1YEufrq9pcWbiEY/XebErICLLIZRiS77w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g+IpFH36H/Q2rTtWLVoklxtJBzOU/nkW
	iYJn01mbgTnttlJgBAQEea3JJgFWeGVju8Cg0pB+4qecvzlXb374Xl+GeEkqF5bA
	IF9Lv+u7hVXOuyEPEYrJx88TSAFzJ7d/7iNR1+hqh6oIUpBX4H/Nbd3WOFngCkbw
	5nBQcI7owyc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 020024C3D;
	Mon, 28 Feb 2011 19:13:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 65C7E4C3C; Mon, 28 Feb 2011
 19:13:15 -0500 (EST)
In-Reply-To: <7vfwr7hh7f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 28 Feb 2011 15\:28\:36 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B74093DE-4398-11E0-867C-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168167>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I'm not quite sure what lossage you mean. On the recipient's end? They
>> can just "git revert", no?

This is beating on a dead horse, but in my previous life, in a project I
wasn't deeply involved in, a deployment procedure used was to:

 - give git-archive tarball of a major release to the target machine that
   does not have git repository, and extract the tarball;

 - maintain 'maint' branch, and show the tip of 'maint' on a test server,
   but give the client vetoing power on individual changes;

 - hence ending up preparing a format-patch output for selected changes,
   and running git-apply on the target machine to update it.

The -M/-C options would have worked well in this scenario, including the
recovery from "oops--that didn't work, please revert asap" (I don't know
if they actually used -M/-C when preparing the incremental updates,
though).  The -D option does not have the same reversibility.

I am (have been) only reacting to the earlier statement by Michael that -D
is the same as -M/-C and reversibility does not matter.  It does in such a
situation.

Now that the project with that deployment procedure is totally behind me,
I probably shouldn't care too much about such a workflow, but I suspect
there still are people using that sort of workflow, and this would matter
to them.

In any case, a minimum patch to give what Mart wanted to see would
probably look like this.  I'll leave bugfixes, documentation and tests to
the readers ;-).

 diff.c |   12 +++++++++---
 diff.h |    1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 5422c43..5c66a53 100644
--- a/diff.c
+++ b/diff.c
@@ -1943,7 +1943,11 @@ static void builtin_diff(const char *name_a,
 		}
 	}
 
-	if (!DIFF_OPT_TST(o, TEXT) &&
+	if (o->irreversible_delete && lbl[1][0] == '/') {
+		fprintf(o->file, "%s", header.buf);
+		strbuf_reset(&header);
+		goto free_ab_and_return;
+	} else if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -1963,8 +1967,7 @@ static void builtin_diff(const char *name_a,
 			fprintf(o->file, "%sBinary files %s and %s differ\n",
 				line_prefix, lbl[0], lbl[1]);
 		o->found_changes = 1;
-	}
-	else {
+	} else {
 		/* Crazy xdl interfaces.. */
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
 		xpparam_t xpp;
@@ -3160,6 +3163,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 			return error("invalid argument to -M: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
+	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
+		options->irreversible_delete = 1;
+	}
 	else if (!prefixcmp(arg, "-C") || !prefixcmp(arg, "--find-copies=") ||
 		 !strcmp(arg, "--find-copies")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
diff --git a/diff.h b/diff.h
index 310bd6b..11d13cf 100644
--- a/diff.h
+++ b/diff.h
@@ -104,6 +104,7 @@ struct diff_options {
 	int interhunkcontext;
 	int break_opt;
 	int detect_rename;
+	int irreversible_delete;
 	int skip_stat_unmatch;
 	int line_termination;
 	int output_format;
