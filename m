From: Spencer Baugh <catern@catern.com>
Subject: Re: [PATCH] checkout: don't check worktrees when not necessary
Date: Wed, 10 Jun 2015 15:21:44 -0400
Message-ID: <87zj47gyif.fsf@earth.i-did-not-set--mail-host-address--so-tickle-me>
References: <1433114189-9779-1-git-send-email-sbaugh@catern.com> <20150601102317.GA20607@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>, Spencer Baugh <sbaugh@catern.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:31:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2liL-0002kT-Cp
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 21:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbbFJTbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 15:31:01 -0400
Received: from catern.com ([104.131.201.120]:47639 "EHLO mail.catern.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754428AbbFJTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 15:31:00 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2015 15:31:00 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.catern.com (Postfix) with ESMTPSA id 69BAF4724F;
	Wed, 10 Jun 2015 19:21:51 +0000 (UTC)
In-Reply-To: <20150601102317.GA20607@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271349>


Duy Nguyen <pclouds@gmail.com> writes:
> On Sun, May 31, 2015 at 07:16:29PM -0400, Spencer Baugh wrote:
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1237,6 +1237,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>>  		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
>>  		if (head_ref &&
>>  		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
>> +		    !(opts->patch_mode || opts->pathspec.nr) &&
>>  		    !opts->ignore_other_worktrees)
>>  			check_linked_checkouts(new);
>>  		free(head_ref);
>
> Simple and effective. But if in future we add more options for
> non-switching-branch checkout, we need to update both places, here and
> near the end of cmd_checkout().
>
> Perhaps we can move all this block inside checkout_branch() so we only
> need to test "opts->patch_mode || opts->pathspec.nr" once, at the end
> of cmd_checkout(). Something like below?
>
> I'm not opposed to your change, but if you go with it, you should
> cherry pick my test in the below patch. Or create a similar test.

Sorry for late reply, but I think your change is much better than mine
so I'd suggest just using that instead.
