From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v4 2/4] format-patch: add '--base' option to record base
 tree info
Date: Wed, 13 Apr 2016 22:42:24 +0800
Message-ID: <20160413144224.GA32367@yexl-desktop>
References: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
 <1460342873-28900-3-git-send-email-xiaolong.ye@intel.com>
 <xmqq7fg2r6fi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 16:49:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqM6a-0001lg-JL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 16:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757130AbcDMOnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 10:43:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:54179 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757037AbcDMOnY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 10:43:24 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP; 13 Apr 2016 07:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,479,1455004800"; 
   d="scan'208";a="957822738"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.139])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2016 07:43:17 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqq7fg2r6fi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291454>

On Tue, Apr 12, 2016 at 12:08:33PM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>> Maintainers or third party testers may want to know the exact base tree
>> the patch series applies to. Teach git format-patch a '--base' option
>> to record the base tree info and append it at the end of the_first_
>
>It probably was a good idea to add stress during the discussion to
>compare various possibilities, but there no longer is a need to
>italicise "first" like this, I think.
>
>> message(either the cover letter or the first patch in the series).
>
>Please have space before "(" (also found elsewhere in this message)
>to make this readable.
>
>>
>> The base tree info consists of the "base commit", which is a well-known
>> commit that is part of the stable part of the project history everybody
>> else works off of, and zero or more "prerequisite patches", which are
>> well-known patches in flight that is not yet part of the "base commit"
>> that need to be applied on top of "base commit" in topological order
>> before the patches can be applied.
>>
>> The "base commit" is shown as "base-commit: " followed by the 40-hex of
>> the commit object name.  A "prerequisite patch" is shown as
>> "prerequisite-patch-id: " followed by the 40-hex "patch id", which is a
>> sum of SHA-1 of the file diffs associated with a patch, with whitespace
>> and line numbers ignored, it's reasonably stable and unique.
>
>Let's be more helpful to end users.  They do not need to know the
>exact formula, especially when there is a command to generate or
>check the id for themselves:
>
>    "patch id", which can be obtained by passing the patch through the
>    "git patch-id --stable" command
>
>or something?  
>
>> For example, we have history where base is Z, with three prerequisites
>> X-Y-Z, before the patch series A-B-C, i.e.
>
>base is Z???
>
>	Imagine that on top of the public commit P, you applied
>	well-known patches X, Y and Z from somebody else, and then
>	built your three-patch series A, B, C.
>
>perhaps?
>
>>
>> 	P---X---Y---Z---A---B---C
>>
>> We could say "git format-patch --base=P -3 C"(or variants thereof, e.g.
>> with "--cover-letter" of using "Z..C" instead of "-3 C" to specify the
>> range), then we could get base tree information block showing at the
>> end of _first_ message as below:
>
>Again, if "first" is _so_ important to stress, it probably is worth
>saying that by "first" you mean either patch 1/n or patch 0/n when
>the cover letter exists.
>
>Also "could" may have made sense while we were having discussion on
>possible design of the hypothetical feature, but with the patch
>applied, the feature becomes a reality, so you can and should stop
>living in the hypothetical world and do s/could/can/ the above.
>
>	With "git format-patch --base=P -3 C" (or variants...), the
>	base tree information block is shown at the end of the first
>	message the command outputs (either the first patch, or the
>	cover letter), like this:
>
>perhaps?
>
>I assume that the patch to the documentation has the same text I
>commented on the above, so I won't repeat my comments to them.
>

Thanks for the review,  I'll follow all the comments above and
make changes to commit log as well as documentation.
 
>> 	base-commit: P
>> 	prerequisite-patch-id: X
>> 	prerequisite-patch-id: Y
>> 	prerequisite-patch-id: Z
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Wu Fengguang <fengguang.wu@intel.com>
>> Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
>> ---
>>  Documentation/git-format-patch.txt | 56 +++++++++++++++++++++++
>>  builtin/log.c                      | 92 ++++++++++++++++++++++++++++++++++++++
>>  t/t4014-format-patch.sh            | 15 +++++++
>>  3 files changed, 163 insertions(+)
>> ...
>> +static void prepare_bases(struct base_tree_info *bases,
>> +			  const char *base_commit,
>> +			  struct commit **list,
>> +			  int total)
>> +{
>> +	struct commit *base = NULL, *commit;
>> +	struct rev_info revs;
>> +	struct diff_options diffopt;
>> +	unsigned char sha1[20];
>> +	int i;
>> +
>> +	diff_setup(&diffopt);
>> +	DIFF_OPT_SET(&diffopt, RECURSIVE);
>> +	diff_setup_done(&diffopt);
>> +
>> +	base = lookup_commit_reference_by_name(base_commit);
>> +	if (!base)
>> +		die(_("Unknown commit %s"), base_commit);
>> +	oidcpy(&bases->base_commit, &base->object.oid);
>> +
>> +	init_revisions(&revs, NULL);
>> +	revs.max_parents = 1;
>> +	revs.topo_order = 1;
>> +	for (i = 0; i < total; i++) {
>> +		if (!in_merge_bases(base, list[i]) || base == list[i])
>> +			die(_("base commit should be the ancestor of revision list"));
>
>This check looks overly expensive, but I do not think of a more
>efficient way to do this, given that "All the commits from our
>series must reach the specified base" is what you seem to want.

Yes, that's what I want to make sure, for normal case, if patch
submitter has history as below:

	P---Z---A---B---C---D

and she may unintentionally specify wrong base by doing
"format-patch --base=B -4" while P or Z is the actual base,
the recevier such as robot would get confused or fooled if we
just provide B as the base commit in this case.

>
>My understanding is that if base=P is given and you are doing
>"format-patch Z..C" in this picture:
>
>    Q---P---Z---B---*---C
>     \             /
>      .-----------A
>
>your list would become A, B and C, and you want to detect that P is
>not an ancestor of A.  merge_bases_many() computes a wrong thing for
>this use case, and you'd need to go one-by-one.
>
>Unless there is some clever trick to take advantage of the previous
>traversal you made in order to find out A, B and C are the commits
>that are part of your series somehow.
>
>Anybody with clever ideas?
>
