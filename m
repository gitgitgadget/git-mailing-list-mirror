From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] cherry-pick: allow to pick to unborn branches
Date: Tue, 7 Jun 2016 08:37:25 +0200
Message-ID: <88c61a4d-abee-2c01-a521-8094b4baf3ac@drmicha.warpmail.net>
References: <afafa51c-f950-594e-7142-5b28b1182add@drmicha.warpmail.net>
 <69f7973e353f52a62157ca59af5027c9617506a4.1465219182.git.git@drmicha.warpmail.net>
 <xmqq7fe2w087.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Fabrizio Cucci <fabrizio.cucci@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 08:37:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAAdo-000366-LJ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 08:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbcFGGh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 02:37:28 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48886 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753326AbcFGGh1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 02:37:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 990C820B39;
	Tue,  7 Jun 2016 02:37:26 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 07 Jun 2016 02:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=0C6tdIKRvADnJXAF48j0d/alpWE=; b=fr0oYY
	Pugu8tJY+VB0iUfQeg/+mGR8bJCetECKtKdNPhAUl/Y8Nupkea5O05Jocu1L41/y
	jgTqgLfngztUtpbTcGxUS0zg0mVG2uohl6sPVuVcxS4w/hAdNw6ZXN0oJ32zGGRt
	nuMZ6GpnNNfVMvRHMvvtlPzPb7Pal8fkT6+jI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=0C6tdIKRvADnJXA
	F48j0d/alpWE=; b=rNMTf3/c2g+uhicvfW4Fe1gMram9nkVYG6ZxgySXlo6Oxpn
	sj3BiKRN5mJTGwXSkKuwj0PYqcYrjrGz65K6w/R8lOMXsxvqRAjPI8HnJFimlGIh
	epKUTUYRXqnLdojEB2D8t6Zz+Op/ZT8AryT9SBIdL5Am4ZJ3tGtm8s7yspMY=
X-Sasl-enc: 1gAZLu1vUPMzgnWig+CMbBWtZpX3A6D2pgS3w4tunicv 1465281446
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id EC89ACCDA6;
	Tue,  7 Jun 2016 02:37:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqq7fe2w087.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296602>

Junio C Hamano venit, vidit, dixit 06.06.2016 22:06:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, cherry-pick allows tp pick single commits to an empty HEAD
>> but not multiple commits.
>>
>> Allow the multiple commit case, too.
>>
>> Reported-by: Fabrizio Cucci <fabrizio.cucci@gmail.com>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  sequencer.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> Thanks; we'd probably want a few tests in somewhere near 3503 or
> 3505.

I'll try my best.

>> diff --git a/sequencer.c b/sequencer.c
>> index 4687ad4..c6362d6 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -888,6 +888,10 @@ static int sequencer_rollback(struct replay_opts *opts)
>>  			git_path_head_file());
>>  		goto fail;
>>  	}
>> +	if (is_null_sha1(sha1)) {
>> +		error(_("cannot abort from a branch yet to be born"));
>> +		goto fail;
>> +	}
> 
> Is this error-fail desirable?  How do we get here?  Did a user start
> a cherry-pick on an unborn branch and then told us to abort that?
> Shouldn't we be taking the user back to the "orphan" state if that
> is the case?

Here and below, I'm mimicking/copying the behavior that we have right
now already. I asked myself the same question - rolling back to orphan
state shouldn't be that hard after all. But that would be a change in
behavior that - if considered a fix/improvement - would be orthogonal to
the multi-pick fix.

>>  	if (reset_for_rollback(sha1))
>>  		goto fail;
>>  	remove_sequencer_state();
>> @@ -1086,11 +1090,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>>  	walk_revs_populate_todo(&todo_list, opts);
>>  	if (create_seq_dir() < 0)
>>  		return -1;
>> -	if (get_sha1("HEAD", sha1)) {
>> -		if (opts->action == REPLAY_REVERT)
>> -			return error(_("Can't revert as initial commit"));
>> -		return error(_("Can't cherry-pick into empty head"));
>> -	}
>> +	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
>> +		return error(_("Can't revert as initial commit"));
> 
> Not a new issue, but I cannot quite fathom what this error message
> wants to say.  "Can't revert an initial commit"?

Cannot create a "revert commit" as the initial commit on a yet unborn
branch. Maybe "nothing to revert" would be clearer, but then another
user might ask: If I say "git revert deabeef" and there is a commit
"deadbeef" then why is there "nothing to revert"?

Applying the reverse of a patch to an empty tree should result in an
empty tree, and creating a commit with that empty tree as "This reverts
commit deadbeef" is what we are refusing here, unless I'm confused.

>>  	save_head(sha1_to_hex(sha1));
>>  	save_opts(opts);
>>  	return pick_commits(todo_list, opts);
> 
