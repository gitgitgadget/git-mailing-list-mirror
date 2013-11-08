From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Fri, 08 Nov 2013 15:44:43 -0800
Message-ID: <xmqqwqkimpas.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
	<xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
	<CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
	<xmqq38n98cud.fsf@gitster.dls.corp.google.com>
	<20131106221427.GB13258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 09 00:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vevjt-0005EF-8f
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 00:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618Ab3KHXox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 18:44:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932606Ab3KHXot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 18:44:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58212514DA;
	Fri,  8 Nov 2013 18:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GSDd0PyJ30xn5o7kVXquL+0XfMc=; b=UuDYd4
	oP6FF21NXEOnHhRUuEkCSeUP0m6a60iPsXQK+SiuhXeZZBbhnFZwwoAW7VstyxEG
	b6g8B2DqVQFcPXqwLuFiH0pGofP/2jRREYV5l/4Nvy7iwgBzQw6g+WgoLNn+FNfZ
	cAtFijcLqrspA5dNol8FC/7ZgMR1Aen06AWlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NNDOeO+HIiiPwJMWq0AZcSE8b1WFUGDO
	7UMqZ0dxJeFwiWkplIqR8kb/307/JgTGxb9xmmhlSHqrOCGHiOMH6VRxcQub1y13
	QyZ17OnCzbZSMNoKkHsa45G0FJMtMZqbP1yMLJEVCk3vZi4JHw+pub26h0xs+/9a
	Hl5EVezxlZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F505514D9;
	Fri,  8 Nov 2013 18:44:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 653B4514D8;
	Fri,  8 Nov 2013 18:44:47 -0500 (EST)
In-Reply-To: <20131106221427.GB13258@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 6 Nov 2013 14:14:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C061363C-48CF-11E3-B4C3-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237473>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 06, 2013 at 01:00:42PM -0800, Junio C Hamano wrote:
>
>> It follows that the syntax naturally support
>> 
>> 	git fast-export refs/heads/master:refs/heads/foobar
>> 
>> I would think.
>> 
>> That approach lets you express ref mapping without a new option
>> --refspec, which goes contrary to existing UI for any commands in
>> Git (I think nobody takes refspec as a value to a dashed-option in
>> the transport; both in fetch and push, they are proper operands,
>> i.e. command line arguments to the command), no?
>
> I think that is much nicer for the simple cases, but how do we handle
> more complex rev expressions? ...
>
> The "^origin" is not a refspec, and finding the refspec in the
> dot-expression would involve parsing it into two components. I think you
> can come up with a workable system by parsing the arguments as revision
> specifiers and then applying some rules. E.g....

I was thinking about this a bit more today.  It is more or less
trivial to actually teach the setup_revisions() infrastructure to
optionally allow A:B to mean "We want a revision A, but with an
extra twist", and leave that "extra twist" information in the
rev_cmdline machinery.  After all, rev_cmdline was introduced for
doing exactly this kind of thing.

Earlier I said that all the existing transport commands take refspec
as proper operands, not a value to a dashed-option, but I can imagine
that we may in the future want to update "git push" in a way similar
to what Felipe did to "git fast-export" so that it allows something
like this:

    $ git push mothership \
    > --refspec refs/heads/*:refs/remotes/satellite/* master

which would mean "I am pushing out 'master', but anything I push out
to the mothership from my refs/heads/ hierarchy should be used to
update the refs/remotes/satellite/ hierarchy over there".  The same
thing can be done in the reverse direction for "git fetch".

But such a wildcard refspec cannot be supported naturally by
extending the setup_revisions(); what the wildcarded refspec expands
to will depend on what other things are on the command line (in this
case, 'master').  So I stopped there (I'll attach a toy patch at the
end, but I'll discard it once I send this message out).

If you set remote.*.fetch (or remote.*.push) refspec with the
current system, it tells us two logically separate/separable things:

 (1) what is the set of refs fetched (or pushed); and

 (2) what refs at the receiving end are updated.

"git push" and "git fetch" could borrow the independent ref-mapping
UI from "git fast-export" to allow us to dissociate these two
concepts.  In the above "mothership-satelite" example, the "master"
specifies what is pushed out, while the value of "--refspec" option
specifies the mapping.  It would open a door to even make the
mapping a configuration variable.  In short, "nobody uses an
independent refspec mapping parameter" does not necessarily mean "we
should not have such an independent refspec mapping parameter".

If we were to go that route, however, I would be strongly against
calling that option --refspec; perhaps calling it --refmap would
avoid confusion.

 remote.c   |  5 +++++
 remote.h   |  2 ++
 revision.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 revision.h | 10 +++++++++-
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 9f1a8aa..26b86a0 100644
--- a/remote.c
+++ b/remote.c
@@ -653,6 +653,11 @@ static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
 
+struct refspec *parse_push_refspec_verify(int nr_refspec, const char **refspec)
+{
+	return parse_refspec_internal(nr_refspec, refspec, 0, 1);
+}
+
 void free_refspec(int nr_refspec, struct refspec *refspec)
 {
 	int i;
diff --git a/remote.h b/remote.h
index 131130a..2bc0a7e 100644
--- a/remote.h
+++ b/remote.h
@@ -156,6 +156,8 @@ void ref_remove_duplicates(struct ref *ref_map);
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
+struct refspec *parse_push_refspec_verify(int nr_refspec, const char **refspec);
+
 void free_refspec(int nr_refspec, struct refspec *refspec);
 
 char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
diff --git a/revision.c b/revision.c
index 956040c..17e7b3d 100644
--- a/revision.c
+++ b/revision.c
@@ -16,6 +16,7 @@
 #include "line-log.h"
 #include "mailmap.h"
 #include "commit-slab.h"
+#include "remote.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1377,6 +1378,58 @@ static void prepare_show_merge(struct rev_info *revs)
 	revs->limited = 1;
 }
 
+static int handle_revision_refspec(const char *arg, struct rev_info *revs, unsigned revarg_opt)
+{
+	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
+	struct refspec *pair;
+	static struct ref *local_refs;
+	struct ref *remote_refs = NULL;
+	struct object *object;
+	int retval = 0;
+
+	pair = parse_push_refspec_verify(1, &arg);
+	if (!pair)
+		return -1;
+
+	if (pair->matching || pair->pattern) {
+		/* ":" or "refs/heads/<star>:refs/heads/<star>" are not revs */
+		retval = -1;
+		goto cleanup_return;
+	}
+
+	/* The source side is what we are pushing out */
+	if (!local_refs)
+		local_refs = get_local_heads();
+	if (match_push_refs(local_refs, &remote_refs, 1, &arg, 0)) {
+		retval = -1;
+		goto cleanup_return;
+	}
+
+	/*
+	 * Now, remote_refs should have a single element that tells
+	 * us what object we are pushing.
+	 */
+	if (!remote_refs || remote_refs->next || !remote_refs->peer_ref ||
+	    !(object = parse_object(remote_refs->peer_ref->new_sha1))) {
+		retval = -1;
+		goto cleanup_return;
+	}
+
+	if (!cant_be_filename)
+		verify_non_filename(revs->prefix, arg);
+
+	retval = 0;
+	add_rev_cmdline(revs, object, arg, REV_CMD_REFSPEC, 0);
+	add_pending_object(revs, object, arg);
+
+cleanup_return:
+	free_refs(remote_refs);
+	free(pair->src);
+	free(pair->dst);
+	free(pair);
+	return retval;
+}
+
 int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsigned revarg_opt)
 {
 	struct object_context oc;
@@ -1500,8 +1553,20 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags = GET_SHA1_COMMITTISH;
 
-	if (get_sha1_with_context(arg, get_sha1_flags, sha1, &oc))
+	/*
+	 * Are we allowed to interpret A:B refspec as a revision
+	 * specifying A?  ^A:B nor --not A:B would make any sense, so
+	 * do not route such cases to handle_revision_refspec().
+	 */
+	if (!local_flags && !flags &&
+	    (revarg_opt & REVARG_ALLOW_REFSPEC) &&
+	    !handle_revision_refspec(arg, revs, revarg_opt))
+		return 0;
+
+	if (get_sha1_with_context(arg, get_sha1_flags, sha1, &oc)) {
 		return revs->ignore_missing ? 0 : -1;
+	}
+
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
diff --git a/revision.h b/revision.h
index 89132df..c97805e 100644
--- a/revision.h
+++ b/revision.h
@@ -40,7 +40,8 @@ struct rev_cmdline_info {
 			REV_CMD_LEFT,
 			REV_CMD_RIGHT,
 			REV_CMD_MERGE_BASE,
-			REV_CMD_REV
+			REV_CMD_REV,
+			REV_CMD_REFSPEC
 		} whence;
 		unsigned flags;
 	} *rev;
@@ -205,7 +206,13 @@ extern volatile show_early_output_fn_t show_early_output;
 
 struct setup_revision_opt {
 	const char *def;
+	/* hook to call after parsing the command line */
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
+	/*
+	 * hook to call for a command line argument that is not a rev
+	 */
+	int (*parse_extended_rev)(struct rev_info *, struct setup_revision_opt *, const char *);
+
 	const char *submodule;
 	int assume_dashdash;
 	unsigned revarg_opt;
@@ -219,6 +226,7 @@ extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ct
 			       const char * const usagestr[]);
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
+#define REVARG_ALLOW_REFSPEC 04
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,
 			       int flags, unsigned revarg_opt);
 
