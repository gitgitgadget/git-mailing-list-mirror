From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving merge failure message
Date: Tue, 08 Sep 2009 00:15:41 -0700
Message-ID: <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
References: <20090908153101.6117@nanako3.lavabit.com>
 <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkuvo-0005xA-0j
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbZIHHPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbZIHHPu
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:15:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbZIHHPu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 03:15:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45FA248498;
	Tue,  8 Sep 2009 03:15:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hXhmaJA/NEWtdEFNz2d/L/UOBN0=; b=QynD2O
	jIj9vNvAhGCtOY24MGB0g8tDU/ZvkiQwmTF76Iq2qUE+zNhyfVMEhkNitILTwzjE
	v4EQksx2SaAlSAEQ5lN1sgQbXj4Rxk9cut5LNmZMfDoNNN08QoGXzDOkjMVDYheX
	d6GaESP3Ai4rLJsQcukRvCYwLjBIGTGoYv83k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gFRv1JN8DFrL3bsEPyOs7p8EP/XIX8me
	TvrunzT07dI9Lcm+9G60TwbUyeNErcBhLm1odfh9hKxpTgv6DeOixtGw8jo3Ifn9
	+wKrgYMbscrB7dI7l84/KLdvXcsRIqjTk0eto5+YQQPnmq6/pjreFysdhT3kWgr6
	tck2ly91chQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2766548496;
	Tue,  8 Sep 2009 03:15:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8F3FA48495; Tue,  8 Sep 2009
 03:15:44 -0400 (EDT)
In-Reply-To: <7vbplmhr0i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 07 Sep 2009 23\:47\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FC70122-9C47-11DE-9815-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127983>

Junio C Hamano <gitster@pobox.com> writes:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> [2]% git merge feature
>> error: Entry 'cool' not uptodate. Cannot merge.
>> fatal: merging of trees 8ec1d96451ff05451720e4e8968812c46b35e5e4 and aad8d5cef3915ab78b3227abaaac99b62db9eb54 failed
>>
>> ... the messages look unnecessarily scary, with two
>> "error" and "fatal" comments, and long sha1 commit names.
>
> Just a technical nit.  I think these are tree object names.
>
>> Those of us who used git for some time can tell what it wants to say.
>> The merge checked the files in the working tree before doing anything,
>> found that the user has uncommitted change to a file that is involved in
>> the merge, and it stopped. And it didn't change anything. It may be "fatal"
>> but the user has much less reason to be scared about this failure than
>> the conflicting case.
>>
>> It would be nice if the message in the latter case can be toned down.
>
> Yeah, it would be nice.  This actually was something that bothered me as
> well while trying to explain the recovery procedure for these two cases.
> Give me half an hour or so to cook up something...

It turns out to be a lot simpler than I thought, because 8ccba00
(unpack-trees: allow Porcelain to give different error messages,
2008-05-17) already laid enough groundwork for doing this kind of thing
easily.

Notable points are:

 - End the messages with "Aborting."; they are given when the three-way
   merge stops without harming the work tree;

 - Do not give the extra message after unpack_trees() already errored out.
   This "merging of trees failed" message was primarily for debugging
   merge-recursive itself, and the end user cannot do much with the object
   names given in the message anyway.

   But do give it under higher verbosity level, or when it happens during
   the inner merge (the "recursive" one), as unpack_trees() should not
   fail for the inner merge under normal conditions.

We could later add instructions on how to recover (i.e. "stash changes
away or commit on a side branch and retry") instead of the silent
exit(128) I have down there, and then use Peff's advice.* mechanism to
squelch it (e.g. "advice.mergeindirtytree"), but they are separate topics.

 merge-recursive.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 10d7913..a237240 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -170,6 +170,18 @@ static int git_merge_trees(int index_only,
 	int rc;
 	struct tree_desc t[3];
 	struct unpack_trees_options opts;
+	static struct unpack_trees_error_msgs msgs = {
+		/* would_overwrite */
+		"Your local changes to '%s' will be clobbered by merge.  Aborting.",
+		/* not_uptodate_file */
+		"Your local changes to '%s' will be clobbered by merge.  Aborting.",
+		/* not_uptodate_dir */
+		"Updating '%s' would lose untracked files in it.  Aborting.",
+		/* would_lose_untracked */
+		"Untracked working tree file '%s' would be %s by merge.  Aborting",
+		/* bind_overlap -- will not happen here */
+		NULL,
+	};
 
 	memset(&opts, 0, sizeof(opts));
 	if (index_only)
@@ -181,6 +193,7 @@ static int git_merge_trees(int index_only,
 	opts.fn = threeway_merge;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.msgs = msgs;
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
@@ -1188,10 +1201,14 @@ int merge_trees(struct merge_options *o,
 
 	code = git_merge_trees(o->call_depth, common, head, merge);
 
-	if (code != 0)
-		die("merging of trees %s and %s failed",
-		    sha1_to_hex(head->object.sha1),
-		    sha1_to_hex(merge->object.sha1));
+	if (code != 0) {
+		if (show(o, 4) || o->call_depth)
+			die("merging of trees %s and %s failed",
+			    sha1_to_hex(head->object.sha1),
+			    sha1_to_hex(merge->object.sha1));
+		else
+			exit(128);
+	}
 
 	if (unmerged_cache()) {
 		struct string_list *entries, *re_head, *re_merge;
