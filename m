Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22AFE1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdJ3MbL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 30 Oct 2017 08:31:11 -0400
Received: from marcos.anarc.at ([206.248.172.91]:42908 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbdJ3MbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:31:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 4B6C01A00AD
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] remote-mediawiki: limit filenames to legal
In-Reply-To: <q7h9fua0zzz0.fsf@orange.lip.ens-lyon.fr>
Organization: Debian
References: <20171029163714.4818-1-anarcat@debian.org> <20171029181034.27707-1-anarcat@debian.org> <q7h9fua0zzz0.fsf@orange.lip.ens-lyon.fr>
Date:   Mon, 30 Oct 2017 08:31:10 -0400
Message-ID: <87h8ug7r75.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-30 11:34:11, Matthieu Moy wrote:
> Antoine Beaupré <anarcat@debian.org> writes:
>
>> @@ -52,7 +53,7 @@ sub smudge_filename {
>>  	$filename =~ s/ /_/g;
>>  	# Decode forbidden characters encoded in clean_filename
>>  	$filename =~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf('%c', hex($1))/ge;
>> -	return $filename;
>> +	return substr($filename, 0, NAME_MAX-3);
>
> There's a request to allow a configurable extension (.mediawiki would
> help importing in some wikis, see
> https://github.com/Git-Mediawiki/Git-Mediawiki/issues/42). You should at
> least make this stg like length(".mw") so that the next search&replace
> for ".mw" finds this.

I believe I did that in v3.

> Also, note that your solution works for using Git-Mediawiki in a
> read-only way, but if you start modifying and pushing such files, you'll
> get into trouble. It probably makes sense to issue a warnign in such
> case.

True. I didn't consider that, but then again the patch is not a
regression: you couldn't have pushed those repos in the first place
anyways...

A.

-- 
The history of any one part of the earth, like the life of a soldier,
consists of long periods of boredom and short periods of terror.
                       - British geologist Derek V. Ager
