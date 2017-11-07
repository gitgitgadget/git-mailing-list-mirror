Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C383202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbdKGQDF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 7 Nov 2017 11:03:05 -0500
Received: from marcos.anarc.at ([206.248.172.91]:36738 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbdKGQDF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:03:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 066961A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Ingo Ruhnke <grumbel@gmail.com>
Subject: Re: [PATCH v4 2/7] remote-mediawiki: allow fetching namespaces with spaces
In-Reply-To: <20171107070808.q7zz4i73mkffomcb@laptop.local>
Organization: Debian
References: <20171102212518.1601-1-anarcat@debian.org> <20171106211953.27910-1-anarcat@debian.org> <20171106211953.27910-3-anarcat@debian.org> <20171107070808.q7zz4i73mkffomcb@laptop.local>
Date:   Tue, 07 Nov 2017 11:03:03 -0500
Message-ID: <87efpa2i14.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-07 07:08:08, Thomas Adam wrote:
> On Mon, Nov 06, 2017 at 04:19:48PM -0500, Antoine Beaupré wrote:
>> From: Ingo Ruhnke <grumbel@gmail.com>
>> 
>> we still want to use spaces as separators in the config, but we should
>> allow the user to specify namespaces with spaces, so we use underscore
>> for this.
>> 
>> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
>> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
>> ---
>>  contrib/mw-to-git/git-remote-mediawiki.perl | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
>> index 5ffb57595..a1d783789 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
>> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -65,6 +65,7 @@ chomp(@tracked_categories);
>>  
>>  # Just like @tracked_categories, but for MediaWiki namespaces.
>>  my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all remote.${remotename}.namespaces"));
>> +for (@tracked_namespaces) { s/_/ /g; }
>>  chomp(@tracked_namespaces);
>
> Depending on the number if namespaces returned, it might be easier to convert
> this to the following:
>
>     my @tracked_namespaces = map {
>     	chomp; s/_/ /g; $_;
>     } split(/[ \n]/, run_git("config --get-all remote.${remotename}.namespaces"));
>
> This would, once again, avoid creating @tracked_namespaces, and iterating over
> it.
>
> Note that this isn't about trying to 'golf' this; it's a performance
> consideration.

I'm not sure it's worth it. Mediawiki has only about 10 default
namespaces, and the user needs to specify them by hand here. I wouldn't
be concerned about the performance.

A.

-- 
Education is the most powerful weapon which we can use to change the
world.
                       - Nelson Mandela
