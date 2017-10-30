Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7BE202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdJ3CnD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 29 Oct 2017 22:43:03 -0400
Received: from marcos.anarc.at ([206.248.172.91]:60146 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdJ3CnD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:43:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id A7EB11A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] remote-mediawiki: allow using (Main) as a namespace and skip special namespaces
In-Reply-To: <CAPig+cSTp1Udo6xXk5-L6MpWBdiy4sPO__NcND03-89EvRgLHQ@mail.gmail.com>
Organization: Debian
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-5-anarcat@debian.org> <CAPig+cSTp1Udo6xXk5-L6MpWBdiy4sPO__NcND03-89EvRgLHQ@mail.gmail.com>
Date:   Sun, 29 Oct 2017 22:43:01 -0400
Message-ID: <87y3nt73uy.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-29 15:49:28, Eric Sunshine wrote:
[...]
>> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
>> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
>> ---
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -264,16 +264,27 @@ sub get_mw_tracked_categories {
>>  sub get_mw_tracked_namespaces {
>>      my $pages = shift;
>> -    foreach my $local_namespace (@tracked_namespaces) {
>> -        my $mw_pages = $mediawiki->list( {
>> -            action => 'query',
>> -            list => 'allpages',
>> -            apnamespace => get_mw_namespace_id($local_namespace),
>> -            aplimit => 'max' } )
>> -            || die $mediawiki->{error}->{code} . ': '
>> -                . $mediawiki->{error}->{details} . "\n";
>> -        foreach my $page (@{$mw_pages}) {
>> -            $pages->{$page->{title}} = $page;
>> +    foreach my $local_namespace (sort @tracked_namespaces) {
>> +        my ($mw_pages, $namespace_id);
>> +        if ($local_namespace eq "(Main)") {
>> +            $namespace_id = 0;
>> +        } else {
>> +            $namespace_id = get_mw_namespace_id($local_namespace);
>> +        }
>> +        if ($namespace_id >= 0) {
>
> This may be problematic since get_mw_namespace_id() may return undef
> rather than a number, in which case Perl will complain.

[...]

Actually, get_mw_namespace_id() doesn't seem like it can return undef -
did you mistake it with get_mw_namespace_id_for_page()?

A.

-- 
Uncompromising war resistance and refusal to do military service under
any circumstances.
                       - Albert Einstein
