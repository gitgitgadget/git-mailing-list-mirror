Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3A7FD
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QkyF/tI7"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D37F4
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 22:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698472532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6EsrNvPwB3I8EBt4C9+P7c78BYrESdbRMfL3EZD+wZU=;
	b=QkyF/tI71vELgXwJzKbDKkRC1RLmXiw7VqDwwwtXxf9NZdiJJSdcxg/g++dySNJQZq6OQD
	ECTwn8ac23/VYgIMOS5gpwqPJNVH6IlnAWDovsDjVxSr0RtITSHf3Q1yZ4XaVxCO5/ixi0
	v8bsZ/+0sfCELiAfKFaY9XIOm0+KxLZ2gHCbe402I2DyDMVkrMoN7SMOoZyiG3F3LACH8z
	m2HoPFlaj+tAGcjOEDl2l26Sqz8lWa73aybE6PdoY7qq1sPiimBjpx4pZti6spCXsVAFWy
	Z7jNIMj+tVsqmTU0KdrM3Fb1Q+gc8vT+QACq6doZfNFesb0C/Y8mjG5kMoqgjA==
Date: Sat, 28 Oct 2023 07:55:31 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
In-Reply-To: <ZTx3fIGpdGl4JpaV.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
 <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
 <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>
 <ZTx3fIGpdGl4JpaV.jacob@initialcommit.io>
Message-ID: <2a0ba4c8e96cb7d2ea66dd1e78cdd39c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-28 04:52, Jacob Stopak wrote:
>> They currently don't exist, but that's something I've planned to 
>> implement,
>> e.g. to "add.verbose" as a new configuration option.  It should be 
>> usable,
>> while not being messy or intrusive as a new feature.
> 
> "git add" already has the -v, --verbose flag available for the command
> itself like:
> 
> $ git add -v foo.txt
> add 'foo.txt'
> 
> But like you said the config option add.verbose doesn't seem to exist 
> yet.
> 
> So I assume an "add.verbose" config option would just always print that
> without having to specify the -v, --verbose flag when running the 
> command?

Yes, that's how I see it.  Setting "add.verbose" to "true", to be 
precise, or to "basic", which I'll explain a bit further later in my 
response.

> Basically what I'm asking is if commands that already have a --verbose 
> flag
> would just get a config setting that does the existing thing by 
> default?

Well, not by default.  The default values would remain "false", so 
nothing jumps out of nowhere.

>>> So it seems like currently "verbose" is used for various things among
>>> the command set...
>> 
>> Yes, that's the basic verbosity, as I named it above.
> 
> Would it make sense to try to define a more consistent type of output 
> or
> format style for "verbosity" across different commands? As it stands it
> seems each command treats verbosity in its own way which makes it hard 
> to
> interpret exactly what it will do each time...

We'd have to follow the already established behavior of the commands, 
and there are the man pages to describe what's going on with the 
verbosity for each command.  In other words, nothing would get changed, 
just some more knobs would be added, for those who prefer to have the 
additional verbosity enabled.

>>> Another thing is that commands like status have multiple flags that 
>>> can be
>>> used to specify the output format, such as --short, --long, 
>>> --porcelain,
>>> etc, but only --short seems to be configurable as a git config 
>>> setting.
>>> Is there a reason (besides backward compatibility I guess) that these
>>> aren't rolled into a single thing like --format=<type>? This seems 
>>> like
>>> it would be the easiest way to future proof for new formats like
>>> --format=verbose, --format=noob, --format=extended, etc.
>> 
>> That's a good question, but I'd need to go through the commit history 
>> to be
>> able to provide some kind of an explanation.  It could also be all 
>> packed
>> into "status.verbose" as a new configuration option.
> 
> Ok so it sounds like you prefer to use "verbose" as the setting key?
> I guess at this point that might make more sense since commit.verbose
> already exists, and existing options could be packed into it like you
> said instead of just true or false.

It looks like a logical choice to me.

> And then my thing here would just be called "command.verbose = 
> extended"?

Yes, that's what I propose.  It also looks like a logical choice to me, 
and it would leave space for some possible later changes to the 
"<command>.verbose = extended" verbosity, without tying it to the 
tables.  We'd also leave some space that way for even maybe an 
additional level of verbosity, be it "<command>.verbose = simple", 
"<command>.verbose = graphical" or whatever.

Perhaps this scheme should also support "<command>.verbose = basic", 
which would be an alias for "<command>.verbose = true", for additional 
clarity.

>>> From a noob's perspective though, does adding a config setting for 
>>> each
>>> command really make sense? I'm kindof envisioning this setting now as 
>>> a
>>> "mode" that is either enabled for all commands it affects or for 
>>> none.
>>> And it's highly unlikely a newish user would individually discover 
>>> which
>>> commands this "extended" format is available for, and run "git config
>>> <command>.verbose = extended" for every one. I mean we could do that
>>> in case there are folks who only want it for specific commands, but 
>>> to
>>> fulfill it's purpose I think there should definetely be some general 
>>> way
>>> to enable the setting for all commands that have it.
>> 
>> Quite frankly, we shouldn't expect that all users are noobs, and as a 
>> result
>> dumb everything down just to make them as comfortable as possible.  On 
>> the
>> other hand, perhaps not everyone would like to have extended verbosity
>> enabled for all commands, just as not everyone uses "-v" for all 
>> commands.
> 
> I agree with this, and I think it's important to cater to both newbies 
> and
> experienced users alike. That's why I said I never dreamed of making 
> this
> new format the default.

Perhaps it would also be good to nudge the newbies a bit by requesting 
them to enable the extended verbosity for each command by hand.  That 
way they would both learn a bit about the way git configuration works, 
which they ultimately can't escape from, and they would be excited to 
learn new git commands.  Or I at least hope so. :)

> And it's true that some users might only want the extended (or any 
> format)
> for specific commands. I think a happy medium then is to have the 
> command-
> specific settings like you mention, plus one toplevel option that 
> enables a
> specific type of output format among all commands (and overrides the
> command-specific settings), so that the user can choose which they 
> prefer.

That's something we can consider as an additional configuration option.  
That way, users could also enable the basic verbosity for all commands, 
which may also be usable.

> Any thoughts on what the section in the config for a more general 
> setting
> like this might be named? If "status.verbose = extended" would already 
> be
> taken specifically for the status command, what terminology could we 
> use
> to mean something like "global.verbose = extended" or "global.extended 
> =
> true"? Although the former seems better to me since other format values
> could be implemented, like "global.verbose = standard"...

Maybe "core.verbose"?  We already have "core.pager", which kind of 
affects the way all command outputs look like.
