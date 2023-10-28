Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5217E
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Td+xWDss"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B18B1B1
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 17:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698451610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJteAwsGQhm3qCfeoGfdsj9U13fFglcqZlMRlWAnQP0=;
	b=Td+xWDss9CWWKERKV/lTWkxzI4OEx3cQL7Mr4utns18ZX3GJwTnPcyJHpdjpoawXT/zMR1
	VfCibRDvAUBH0iyG02kbr9xSX45mBdBUxfiulzrjo392SscebrtX7mn6xjVHIfZltEfRLU
	2CAt0Kch/GcrMEsKPSjXncJ+57ZOTHNEpgVj4laOfUNQeAMJHH7kzp00dpo5sa5fPp6npO
	oR/RasPEbYfW9tQrsloK7TGtkL8b0GxoiHtMqZ/Len6wy2VEdxhhopf5VOhY2T78TmOgAT
	Th70a3a3zuL5Vp5wvQL+/XhNXkTNlpMfXtKIZjO2jdkUloml9LoVsZahYLjOIQ==
Date: Sat, 28 Oct 2023 02:06:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
In-Reply-To: <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
 <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
Message-ID: <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-27 19:13, Jacob Stopak wrote:
> On Fri, Oct 27, 2023 at 03:32:40PM +0200, Dragan Simic wrote:
>> On 2023-10-27 00:46, Jacob Stopak wrote:
>> > Take into account reviewer feedback by doing several things differently:
>> >
>> >   * Rename this feature (for now) as "noob format mode" (or just "noob
>> >     mode") instead of the original "--table" verbiage. As pointed out,
>> >     this no longer ties the name of the setting to it's proposed
>> >     implementation detail as a table. Noob mode is not necessarily the
>> >     right name, just a placeholder for now. Unless people like it :D
>> >
>> >   * Instead of manually having to invoke the -t, --table every time this
>> >     format is to be used, set the config option "status.noob" to true.
>> >     Although this is logically tied to the status command, there are
>> > many
>> >     commands that produce status output, (and this series adds more), so
>> >     assume that if the user wants to see the status this way, that it
>> >     should be enabled whenever the status info is displayed.
>> 
>> How would "status.noob" relate to and coexist with possible future
>> configuration options named "<command>.verbose", which would be 
>> somewhat
>> similar to the currently existing "commit.verbose" option?  IOW, 
>> perhaps it
>> would be better to have per-command options "<command>.verbose = noob" 
>> or,
>> even better, "<command>.verbose = extended", to make it all more
>> future-proof and more granular.
> 
> Hmm, do there currently exist other <command>.verbose config settings
> besides for commit? From what I can tell from "git help config", the
> commit.verbose setting is the only one I see, and it just adds the diff
> info into the editor if the user runs git commit without the -m flag, 
> but
> otherwise there seems to be no extra verbosity outputted.

They currently don't exist, but that's something I've planned to 
implement, e.g. to "add.verbose" as a new configuration option.  It 
should be usable, while not being messy or intrusive as a new feature.

> I noticed that git add and git mv have "verbose" (-v, --verbose) cli 
> flags
> which just output the name of the file being added or renamed, and that
> certain other commands like git branch has a verbose output which 
> includes
> the branch head commit hash and message in the output, so I guess this 
> one
> is actually kindof verbose in that it outputs more than the non-empty
> default output.

Yes, those are the basic per-command verbosity modes or levels, as I 
call them.  The way I see it, your patches would add new, extended 
per-command verbosity levels.

> So it seems like currently "verbose" is used for various things among 
> the
> command set, sometimes meaning "add something into the template if one 
> is
> used" or "add some tiny output to a command that has no default output"
> (which still seems more "--shy" than "--verbose" :P) or "add some
> additional output to a command that already has some sparse output".

Yes, that's the basic verbosity, as I named it above.

> Another thing is that commands like status have multiple flags that can 
> be
> used to specify the output format, such as --short, --long, 
> --porcelain,
> etc, but only --short seems to be configurable as a git config setting.
> Is there a reason (besides backward compatibility I guess) that these
> aren't rolled into a single thing like --format=<type>? This seems like
> it would be the easiest way to future proof for new formats like
> --format=verbose, --format=noob, --format=extended, etc.

That's a good question, but I'd need to go through the commit history to 
be able to provide some kind of an explanation.  It could also be all 
packed into "status.verbose" as a new configuration option.

> From a noob's perspective though, does adding a config setting for each
> command really make sense? I'm kindof envisioning this setting now as a
> "mode" that is either enabled for all commands it affects or for none.
> And it's highly unlikely a newish user would individually discover 
> which
> commands this "extended" format is available for, and run "git config
> <command>.verbose = extended" for every one. I mean we could do that
> in case there are folks who only want it for specific commands, but to
> fulfill it's purpose I think there should definetely be some general 
> way
> to enable the setting for all commands that have it.

Quite frankly, we shouldn't expect that all users are noobs, and as a 
result dumb everything down just to make them as comfortable as 
possible.  On the other hand, perhaps not everyone would like to have 
extended verbosity enabled for all commands, just as not everyone uses 
"-v" for all commands.
