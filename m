From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 11:44:40 +0200
Message-ID: <4AA8CA88.9060802@drmicha.warpmail.net>
References: <20090904135414.GA3728@honk.padd.com> <4AA124DD.1030208@drmicha.warpmail.net> <20090904181846.GC19093@coredump.intra.peff.net> <20090904185949.GA21583@atjola.homenet> <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet> <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net> <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de> <20090909104550.GA20108@coredump.intra.peff.net> <7vzl93cncn.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 11:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlgDb-0005pZ-AP
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 11:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333AbZIJJov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 05:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZIJJov
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 05:44:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35535 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752962AbZIJJou (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 05:44:50 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CF7DF693D2;
	Thu, 10 Sep 2009 05:44:53 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 10 Sep 2009 05:44:53 -0400
X-Sasl-enc: 7NuSo0LbfShgo0CVVu6CEt3MtZSHcEQSkLk/vLOutFAh 1252575893
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8FC6669088;
	Thu, 10 Sep 2009 05:44:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090908 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128104>

Johannes Schindelin venit, vidit, dixit 10.09.2009 11:36:
> 
> Often, it is quite interesting to inspect the branch tracked by a given
> branch.  This patch introduces a nice notation to get at the tracked
> branch: '<branch>@{tracked}' can be used to access that tracked branch.
> 
> A special shortcut '@{tracked}' refers to the branch tracked by the
> current branch.

Sorry, I didn't know the name of the long form was up for discussion.
But it should certainly coincide with the key which for-each-ref uses,
shouldn't it? I don't care whether tracked or upstream, but
for-each-ref's "upstream" has set the precedent.

> 
> Suggested by Pasky.
> 
> The syntax was suggested by Junio.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	I decided that I like @{tracked} better than @{upstream} (which
> 	reads to me more like the upstream _repository_), but hey, I made
> 	the code flexible enough to change that at a whim.
> 
>  Documentation/git-rev-parse.txt |    4 ++
>  sha1_name.c                     |   37 ++++++++++++++++++++--
>  t/t1506-rev-parse-tracked.sh    |   64 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+), 3 deletions(-)
>  create mode 100755 t/t1506-rev-parse-tracked.sh
> 
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 82045a2..09a2145 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -231,6 +231,10 @@ when you run 'git-merge'.
>  * The special construct '@\{-<n>\}' means the <n>th branch checked out
>    before the current one.
>  
> +* The suffix '@{tracked}' to a ref (short form 'blabla@{t}') refers to
> +  the branch tracked by that ref.  If no ref was specified, it means the
> +  branch tracked by the current branch.
> +
>  * A suffix '{caret}' to a revision parameter means the first parent of
>    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
>    'rev{caret}'
> diff --git a/sha1_name.c b/sha1_name.c
> index 44bb62d..a886846 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -5,6 +5,7 @@
>  #include "blob.h"
>  #include "tree-walk.h"
>  #include "refs.h"
> +#include "remote.h"
>  
>  static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
>  {
> @@ -238,9 +239,24 @@ static int ambiguous_path(const char *path, int len)
>  	return slash;
>  }
>  
> +static inline int tracked_suffix(const char *string, int len)
> +{
> +	const char *suffix[] = { "@{tracked}", "@{t}" };
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
> +		int suffix_len = strlen(suffix[i]);
> +		if (len >= suffix_len && !memcmp(string + len - suffix_len,
> +					suffix[i], suffix_len))
> +			return suffix_len;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * *string and *len will only be substituted, and *string returned (for
> - * later free()ing) if the string passed in is of the form @{-<n>}.
> + * later free()ing) if the string passed in is of the form @{-<n>} or
> + * of the form <branch>@{tracked}.
>   */
>  static char *substitute_branch_name(const char **string, int *len)
>  {
> @@ -254,6 +270,19 @@ static char *substitute_branch_name(const char **string, int *len)
>  		return (char *)*string;
>  	}
>  
> +	ret = tracked_suffix(*string, *len);
> +	if (ret) {
> +		char *ref = xstrndup(*string, *len - ret);
> +		struct branch *tracking = branch_get(*ref ? ref : NULL);
> +
> +		free(ref);
> +		if (tracking->merge && tracking->merge[0]->dst) {
> +			*string = xstrdup(tracking->merge[0]->dst);
> +			*len = strlen(*string);
> +			return (char *)*string;
> +		}
> +	}
> +
>  	return NULL;
>  }
>  
> @@ -340,8 +369,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  	if (len && str[len-1] == '}') {
>  		for (at = len-2; at >= 0; at--) {
>  			if (str[at] == '@' && str[at+1] == '{') {
> -				reflog_len = (len-1) - (at+2);
> -				len = at;
> +				if (!tracked_suffix(str + at, len - at)) {
> +					reflog_len = (len-1) - (at+2);
> +					len = at;
> +				}
>  				break;
>  			}
>  		}
> diff --git a/t/t1506-rev-parse-tracked.sh b/t/t1506-rev-parse-tracked.sh
> new file mode 100755
> index 0000000..89193e1
> --- /dev/null
> +++ b/t/t1506-rev-parse-tracked.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description='test <branch>@{tracked} syntax'
> +
> +. ./test-lib.sh
> +
> +
> +test_expect_success 'setup' '
> +
> +	test_commit 1 &&
> +	git checkout -b side &&
> +	test_commit 2 &&
> +	git checkout master &&
> +	git clone . clone &&
> +	test_commit 3 &&
> +	(cd clone &&
> +	 test_commit 4 &&
> +	 git branch --track my-side origin/side)
> +
> +'
> +
> +full_name () {
> +	(cd clone &&
> +	 git rev-parse --symbolic-full-name "$@")
> +}
> +
> +commit_subject () {
> +	(cd clone &&
> +	 git show -s --pretty=format:%s "$@")
> +}
> +
> +test_expect_success '@{tracked} resolves to correct full name' '
> +	test refs/remotes/origin/master = "$(full_name @{tracked})"
> +'
> +
> +test_expect_success '@{t} resolves to correct full name' '
> +	test refs/remotes/origin/master = "$(full_name @{t})"
> +'
> +
> +test_expect_success 'my-side@{tracked} resolves to correct full name' '
> +	test refs/remotes/origin/side = "$(full_name my-side@{t})"
> +'
> +
> +test_expect_success 'my-side@{t} resolves to correct commit' '
> +	git checkout side &&
> +	test_commit 5 &&
> +	(cd clone && git fetch) &&
> +	test 2 = "$(commit_subject my-side)" &&
> +	test 5 = "$(commit_subject my-side@{t})"
> +'
> +
> +test_expect_success 'not-tracking@{t} fails' '
> +	test_must_fail full_name non-tracking@{t} &&
> +	(cd clone && git checkout --no-track -b non-tracking) &&
> +	test_must_fail full_name non-tracking@{t}
> +'
> +
> +test_expect_success '<branch>@{t}@{1} resolves correctly' '
> +	test_commit 6 &&
> +	(cd clone && git fetch) &&
> +	test 5 = $(commit_subject my-side@{t}@{1})
> +'
> +
> +test_done
