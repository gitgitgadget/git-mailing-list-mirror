Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5EEE49A4
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 18:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjIJSBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 14:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIJSBS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 14:01:18 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEA8CD9
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:01:07 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:44072)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfOk5-009xwj-4g; Sun, 10 Sep 2023 12:01:05 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54758 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfOk3-00CaG3-TT; Sun, 10 Sep 2023 12:01:04 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-2-ebiederm@xmission.com>
        <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net>
Date:   Sun, 10 Sep 2023 13:00:40 -0500
In-Reply-To: <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 10 Sep 2023 14:34:49 +0000")
Message-ID: <87bke9hprr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qfOk3-00CaG3-TT;;;mid=<87bke9hprr.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX188rEqXw3DafOJWQfJsIrWXXDiX7WJSb3U=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 02/32] doc hash-function-transition: Replace
 compatObjectFormat with compatMap
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-09-08 at 23:10:19, Eric W. Biederman wrote:
>> Ir makes a lot of sense for the hash algorithm that determines how all
>
> Minor nit: "It".
>
>> diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
>> index 4b937480848a..10572c5794f9 100644
>> --- a/Documentation/technical/hash-function-transition.txt
>> +++ b/Documentation/technical/hash-function-transition.txt
>> @@ -148,14 +148,14 @@ Detailed Design
>>  Repository format extension
>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  A SHA-256 repository uses repository format version `1` (see
>> -Documentation/technical/repository-version.txt) with extensions
>> -`objectFormat` and `compatObjectFormat`:
>> +Documentation/technical/repository-version.txt) with the extension
>> +`objectFormat`, and an optional core.compatMap configuration.
>>  
>>  	[core]
>>  		repositoryFormatVersion = 1
>> +		compatMap = on
>>  	[extensions]
>>  		objectFormat = sha256
>> -		compatObjectFormat = sha1
>
> While I'm in favour of an approach that uses the compat map, the
> situation we've implemented here doesn't specify the extra hash
> algorithm.  We want this approach to work just as well for moving from
> SHA-1 to SHA-256 as it might for a future transition from SHA-256 to,
> say, SHA-3-512, if that becomes necessary.
>
> Making a future transition easier has been a goal of my SHA-256 work
> (because who wants to write several hundred patches in such a case?), so
> my hope is we can keep that here as well by explicitly naming the
> algorithm we're using.
>
> I also wonder if an approach that doesn't use an extension is going to
> be helpful.  Say, that I have a repository that is using Git 3.x, which
> supports interop, but I also need to use Git 2.x, which does not.  While
> it's true that Git 2.x can read my SHA-256 repository, it won't write
> the appropriate objects into the map, and thus it will be practically
> very difficult to actually use Git 3.x to push data to a repository of a
> different hash function.  We might well prefer to have Git 2.x not work
> with the repository at all rather than have incomplete data preventing
> us from, well, interoperating.

First it is my hope that we can get a command such as "git gc" to scan
the repository and fill in all of the missing compatibility hashes.

Not so much for day to day work, but for people able to enable
compatibility hashes on an existing repository.  Enabling compatibility
hashes on a sha1 repository is going to be necessary to create a sha256
repository from it.  A depth first walk, or a topological sort of the
objects pretty much has to happen as a separate pass.  So it makes sense
just to require all of the objects have their compatibility hash
computed before attempting to generate a pack in the compatibility
format.

I say all of that and I feel silly.

The core and optimized path is what whatever receive pack does to deal
with a pack in the repositories compatibility format.  Once that is
built we can create a sha256 repository from a sha1 repository just
by cloning it, and letting receive-pack figure out the details.

Before we can generate a sha256 pack from a sha1 pack we still need
to compute the sha256 hash of every object, but that can be very
optimized and local to the case of receiving a non-native pack.  So a
repository that generates a compatibility hash for all of it's objects
is not necessary to transition to another hash algorithm.  All we need
is another repository in the other format.


That said there is value in being able to add compatibility hashes
to an existing repository.  The upstream repository can just convert
to the new hash function and all of the downstream repositories
can compute their compatibility hashes and convert when they are ready.

Basically once a git with transition support exists any repository can
convert at any time without creating a problem for other repositories.

In my head it seems cheaper/safer to compute the compatibility hash of
every object in an existing repository than it does to convert a
repository.  Is it?

I think that if the first pull from a repository in another format can
trigger the initial computation of the compatibility hash (like the
first use of a reverse index triggers the creation of the reverse
index), then it will definitely be easier to just enable compatibility
hashes in an existing repository.

The additional hash computation step every pull from upstream (even when
well optimized) should be an incentive for people to fully convert their
repositories after the upstream has converted.


That is when things get tricky and the transition plan has not talked
about.  There are references to existing oid's in email, bug trackers,
and commit comments.  Digging through the history and dealing with those
references is something that developers are going to need to do for the
rest of the life of a project.

Which means eventually we will need to support a mode where we have some
packs with a ``.compat'' index but we no longer compute or generate the
old hash for new objects.

In summary.  I agree that compatMap is likely insufficient. So far I
think it is too cheap/easy to generate the missing mappings to make it a
mandatory requirement that all operations always generate them.

I also agree that making the configuration resilient foreseeable future
demands is a good idea.

So I will push this change farther out in the patch series.

Eric
