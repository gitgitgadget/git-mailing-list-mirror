Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF64B1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbfIMU1D (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:27:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58172 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfIMU1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:27:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F055301BA;
        Fri, 13 Sep 2019 16:26:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IAAZji2WyZkZmUHN7uZUDhw33TM=; b=WdOZ23
        1IKQKfgFBlmJvKIkwbo8ioFnHUOS2+YYoppJUSis93UBQgdhCKZWgaJPQemuC0f/
        03byPguFa95egXVdVlH/6Cj5yefkAWoQwm6vefXMGYza7YJBh29UQLgZBzeBM0J6
        rtTy934Tegyez4c1NmV5ltz/JRE7FHp5GQ1rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GKSK+3ZsiwK5Fwm+1Wi0otLPEAmgcMAM
        vDhPA+K2/BAsANqvb/JcH7HOS9nms/FHAMT2trV7wz1nuec3GMEbww5ZOyvsFtL1
        Szz8C6OPpm8RVOHv4/Ov7J2by7FKZfs23SP79vD0+ZW8pR8VeRdZIpiUE6z/M1oW
        EnmHtcZohuU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37152301B9;
        Fri, 13 Sep 2019 16:26:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C2BD301B8;
        Fri, 13 Sep 2019 16:26:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Baker <williamtbakeremail@gmail.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH 1/1] multi-pack-index: add --no-progress Add --no-progress option to git multi-pack-index. The progress feature was added in 144d703 ("multi-pack-index: report progress during 'verify'", 2018-09-13) but the ability to opt-out was overlooked.
References: <pull.337.git.gitgitgadget@gmail.com>
        <0821a8073a48067ecd9ce08226656fa04d803f6b.1568216234.git.gitgitgadget@gmail.com>
        <xmqqlfutfewv.fsf@gitster-ct.c.googlers.com>
        <24c1a9aa-c83b-a984-8821-ecc51a4bc0e2@gmail.com>
Date:   Fri, 13 Sep 2019 13:26:57 -0700
In-Reply-To: <24c1a9aa-c83b-a984-8821-ecc51a4bc0e2@gmail.com> (William Baker's
        message of "Fri, 13 Sep 2019 11:45:29 -0700")
Message-ID: <xmqqo8zoc57y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5FACB56-D664-11E9-9BF1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Baker <williamtbakeremail@gmail.com> writes:

>> I also see in the code that
>> handles opts.batch_size that there is a workaround for this inverted
>> code structure to make sure subcommands other than repack does not
>> allow --batch-size option specified.
>
>> we probably would want to correct the use
>> of parse_options() API in the implementation of this command before
>> adding any new option or subcommand.
>
> To confirm I understand, is the recommendation that
> cmd_multi_pack_index be updated to only parse "batch-size" for the repack
> subcommand (i.e. use PARSE_OPT_STOP_AT_NON_OPTION to parse all of the common
> options, and then only parse "batch-size" when the repack subcommand is running)?

Compare the ways how dispatching and command line option parsing of
subcommands in "multi-pack-index" and "commit-graph" are
implemented.  When a command (e.g. "commit-graph") takes common
options and also has subcommands (e.g. "read" and "write") that take
different set of options, there is a common options parser in the
primary entry point (e.g. "cmd_commit_graph()"), and after
dispatching to a chosen subcommand, the implementation of each
subcommand (e.g. "graph_read()" and "graph_write()") parses its own
options.  That's bog-standard way.

cmd_multi_pack_index() "cheats" and does not implement proper
subcommand dispatch (it directly makes underlying API calls
instead).  Started as an isolated experimental command whose
existence as a standalone command is solely because it was easier to
experiment with (as opposed to being a plumbing command to be used
by scripters), it probably was an acceptable trade-off to leave the
code in this shape.  In the longer run, I suspect we'd rather want
to get rid of "git multi-pack-index" as a standalone command and
instead make "git gc" and other commands make direct calls to the
internal machinery of midx code from strategic places.  So in that
sense, I am not sure if I should "recommend" fixing the way the
subcommand dispatching works in this command, or just accept to keep
the ugly technical debt and let it limp along...

>> subcommands to also understand the progress output or verbosity
>> option (and if the excuse given as a response to the above analysis
>> is "this is just a first step, more will come later")
>
> Yep this was my thinking.  Today "repack" and "verify" are the only subcommands
> that have any progress output but as the other subcommands learn how to provide
> progress the [--[no-]progress] option can be used to control it. 
>
>> instead of adding a "unsigned flag" local variable to the function, it would
>> probably make much more sense to
>> 
>>  (1) make struct opts_multi_pack_index as a part of the public API
>>      between cmd_multi_pack_index() and midx.c and document it in
>>      midx.h;
>> 
>>  (2) instead of passing opts.object_dir to existing command
>>      implementations, pass &opts, the pointer to the whole
>>      structure;
>> 
>>  (3) add a new field "unsigned progress" to the structure, and teach
>>      the command line parser to flip it upon seeing "--[no-]progress".
>> 
>
> Thanks for this suggestion I'll use this approach in the next patch.

...but it appears to me that you are more enthused than I am in
improving this code, so I probably should actually recommend fixing
the main entry point function of this command to imitate the way
"commit-graph" implements subcommands and their own set of options
;-)

