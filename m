From: =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2015, #01; Wed, 1)
Date: Tue, 21 Jul 2015 20:09:19 +0200
Message-ID: <55AE8ACF.6090508@gmail.com>
References: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tony Finch <dot@dotat.at>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 20:09:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHbzE-0003bH-HV
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 20:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbbGUSJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2015 14:09:48 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36104 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbbGUSJr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 14:09:47 -0400
Received: by wicgb10 with SMTP id gb10so64852529wic.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=lLaT3jlivku5nOL8U8gyCl6qDFluUnImpW4v1iPrmS0=;
        b=bKtcZimsRnye8Hx235S1LInNj7/YQ+U2wvw5+mkt8dKFEduQ22WpzyQQhLLQjzFtQC
         Ecc5xSoQVjE1n6S+MY3Q73lBMpuvc3jy9nwJIDvIj+3tE+ceAh4sPCBg1Ue+vuITqvyW
         bpRp8yGMmDmESjjiCoPsdUQM/s0X5uXT681pkUzbP7m6m9nFKOQbs2VKn8Eb6FHgd69i
         FZgJCOairGVpDVrm09kC4F45e1VfyJu1O2FmeOgHsKcOBhM2WJBONHcGTm/zz79zVEK+
         liUkp3ZufIqTOA/oee2joNtwcsODm/QF28S5WYFpVq3cVXnuxi8ihH75aspMtQkcRbBO
         /IKw==
X-Received: by 10.180.101.138 with SMTP id fg10mr34286177wib.46.1437502185619;
        Tue, 21 Jul 2015 11:09:45 -0700 (PDT)
Received: from [192.168.1.53] (eln240.neoplus.adsl.tpnet.pl. [83.21.207.240])
        by smtp.googlemail.com with ESMTPSA id 4sm11955640wjt.46.2015.07.21.11.09.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 11:09:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274391>

On 2015-07-02 at 00:37, Junio C Hamano wrote:
> What's cooking in git.git (Jul 2015, #01; Wed, 1)
> --------------------------------------------------

> * tf/gitweb-project-listing (2015-03-19) 5 commits
>  - gitweb: make category headings into links when they are directorie=
s
>  - gitweb: optionally set project category from its pathname
>  - gitweb: add a link under the search box to clear a project filter
>  - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
>  - gitweb: fix typo in man page
>=20
>  Update gitweb to make it more pleasant to deal with a hierarchical
>  forest of repositories.
>=20
>  Any comments from those who use or have their own code in Gitweb?

The first one is a simple typo fix (plural -> singular), so it can be
accepted without problems.

Second one, "gitweb: if the PATH_INFO is incomplete, use it as a
project_filter" looks interesting and quite useful. Though it doesn't
do much: it allows for handcrafted URL, and provides mechanism to
create breadcrumbs. It doesn't use this feature in its output...
Well, I think it doesn't: I cannot check it at this moment.

What is missing is a support for query parameters path, and not only
path info. Though that *might* be postponed for later patch; the
path info API is obvious, query params API for this feature isn't.
Thought some thought is needed for generating (or not) breadcrumbs
if path_info is turned off.

The third, "gitweb: add a link under the search box to clear a project
filter" notices a problem... then solves it in strange way. IMVHO
a better solution would be to add "List all projects" URL together
with " / " (or other separator) conditionally, if $project_filter
is set. Or have "List all projects" and add "List projects$limit"
if $project_filter is set.

The last two, which form the crux of this patch series, looks like
a good idea, though not without a few caveats. I am talking here
only about conceptual level, not about how it is coded (which has
few issues as well):

- I think that non-bare repositories "repo/.git" should be
  treated as one directory entry, i.e. gitweb should not create
  a separate category for "repo/".  This is admittedly a corner
  case, but useful for git-instaweb

- I think that people would want to be able to configure how
  many levels of directory hierarchy gets turned into categories.
  Perhaps only top level should be turned into category? Deep
  hierarchies means deep categories (usually with very few
  repositories) with current implementation.

- New global configuration variable, or new %features entry?=20
=20
> * tr/remerge-diff (2014-11-10) 9 commits
>  - t4213: avoid "|" in sed regexp
>  - log --remerge-diff: show what the conflict resolution changed
>  - name-hash: allow dir hashing even when !ignore_case
>  - merge-recursive: allow storing conflict hunks in index
>  - merge_diff_mode: fold all merge diff variants into an enum
>  - combine-diff: do not pass revs->dense_combined_merges redundantly
>  - merge-recursive: -Xindex-only to leave worktree unchanged
>  - merge-recursive: internal flag to avoid touching the worktree
>  - merge-recursive: remove dead conditional in update_stages()
>=20
>  "log -p" output learns a new way to let users inspect a merge
>  commit by showing the differences between the automerged result
>  with conflicts the person who recorded the merge would have seen
>  and the final conflict resolution that was recorded in the merge.
>=20
>  Waiting for a reroll.
>  ($gmane/256591).

Is it something that Atlassian uses as a differentiatior (instead
of sending patch upstream):

  https://developer.atlassian.com/blog/2015/01/a-better-pull-request/

--=20
Jakub Nar=C4=99bski
