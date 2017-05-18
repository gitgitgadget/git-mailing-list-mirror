Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86D2201CF
	for <e@80x24.org>; Thu, 18 May 2017 14:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbdEROvf (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 10:51:35 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:46916 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756523AbdEROve (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 10:51:34 -0400
Received: from [192.168.2.240] ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id BMm3delAD46SJBMm3dzddt; Thu, 18 May 2017 15:51:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495119092; bh=chMG0Aoaguo0bqIe1ZKi2aw95DKLCA11TTIsbe+Ftt0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=S1IfucAFevldx6NqHgxoGrNkaJzX9/dk8GDX/ElXgzot0l3TQE+wtDH8wAS/UlgEY
         BwVWPRuzDVrqrg9qRxvmyd1hSDEcNhkyxNWdUkrk0T09wAFvNLOK1yFOPVaMwW4znG
         fesfPinHypa29JVWSv/9gG5opAZoqrNrWmWSvD9k=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=eXVhgkzaaXJeeeuyyWsA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase -i: silence stash apply
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <20170518100233.30559-1-phillip.wood@talktalk.net>
 <20170518100233.30559-3-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1705181246430.3610@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <decdfff1-dd21-4e10-44d5-9dbee38ba05f@talktalk.net>
Date:   Thu, 18 May 2017 15:51:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705181246430.3610@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHgI87FpNF/tYhK0n92UOo7j1wTVSjr9EFhgVAuOzQ2lG62iR3uTHxKnyLr0rdoIyTgIk5njGxlvyla/2x0QCeopcAgXOFcpzGamWK7bUVDl1h4jwFg7
 3WPKZ/7KpxelX0x0Jt3Hyc8KIC2r8VCX2N4WtNbWBV21mvZGuZZ5y6/Evd+li+UfHvejtYJ9OCqqDFZwxmVN3rxJk6GhaY+vHqE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

Thanks for your reply
On 18/05/17 11:49, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 18 May 2017, Phillip Wood wrote:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index f8bc18badf1a3fb1b39656501c5a316e229968d2..311728a145dfc66e230334221a2610468239932d 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1914,6 +1914,8 @@ static int apply_autostash(struct replay_opts *opts)
>>   	strbuf_trim(&stash_sha1);
>>   
>>   	child.git_cmd = 1;
>> +	child.no_stdout = 1;
>> +	child.no_stderr = 1;
>>   	argv_array_push(&child.args, "stash");
>>   	argv_array_push(&child.args, "apply");
>>   	argv_array_push(&child.args, stash_sha1.buf);
> 
> If I remember correctly, then the shell version prints the output in case
> of an error.

The shell version prints it's own error message if there's an error, the 
C version does this as well

Shell version:
apply_autostash () {
	if test -f "$state_dir/autostash"
	then
		stash_sha1=$(cat "$state_dir/autostash")
		if git stash apply $stash_sha1 2>&1 >/dev/null
		then
			echo "$(gettext 'Applied autostash.')"
		else
			git stash store -m "autostash" -q $stash_sha1 ||
			die "$(eval_gettext "Cannot store \$stash_sha1")"
			gettext 'Applying autostash resulted in conflicts.
Your changes are safe in the stash.
You can run "git stash pop" or "git stash drop" at any time.
'
		fi
	fi
}

C version:
static int apply_autostash(struct replay_opts *opts)
{
	struct strbuf stash_sha1 = STRBUF_INIT;
	struct child_process child = CHILD_PROCESS_INIT;
	int ret = 0;

	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
		strbuf_release(&stash_sha1);
		return 0;
	}
	strbuf_trim(&stash_sha1);

	child.git_cmd = 1;
	child.no_stdout = 1;
	child.no_stderr = 1;
	argv_array_push(&child.args, "stash");
	argv_array_push(&child.args, "apply");
	argv_array_push(&child.args, stash_sha1.buf);
	if (!run_command(&child))
		printf(_("Applied autostash.\n"));
	else {
		struct child_process store = CHILD_PROCESS_INIT;

		store.git_cmd = 1;
		argv_array_push(&store.args, "stash");
		argv_array_push(&store.args, "store");
		argv_array_push(&store.args, "-m");
		argv_array_push(&store.args, "autostash");
		argv_array_push(&store.args, "-q");
		argv_array_push(&store.args, stash_sha1.buf);
		if (run_command(&store))
			ret = error(_("cannot store %s"), stash_sha1.buf);
		else
			printf(_("Applying autostash resulted in conflicts.\n"
				"Your changes are safe in the stash.\n"
				"You can run \"git stash pop\" or"
				" \"git stash drop\" at any time.\n"));
	}

	strbuf_release(&stash_sha1);
	return ret;
}


> We already imitated that behavior in `git commit`
> (https://github.com/git-for-windows/git/blob/v2.13.0.windows.1/sequencer.c#L674-L684):
> 
> 		/* hide stderr on success */
> 		struct strbuf buf = STRBUF_INIT;
> 		int rc = pipe_command(&cmd,
> 				      NULL, 0,
> 				      /* stdout is already redirected */
> 				      NULL, 0,
> 				      &buf, 0);
> 		if (rc)
> 			fputs(buf.buf, stderr);
> 		strbuf_release(&buf);
> 
> I think that would be the appropriate approach here, too.

I can change it to do this if you think it is an improvement but the 
existing error message seems fairly clear to me and I think (though I 
haven't checked) that the call to stash store should print out the id of 
the stash for the user

> P.S.: it may be a very good idea to accompany this patch (as well as the
> previous one) by a patch to the test suite to verify that the fixed code
> does not regress.

I agree that a test for this (and probably my other changes) would be 
useful, I'll try and put something together but it won't be until after 
the end of next week.

Thanks

Phillip
