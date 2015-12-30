From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 09/10] config: add core.untrackedCache
Date: Wed, 30 Dec 2015 23:47:44 +0100
Message-ID: <CAP8UFD0pOiqa5ZxwM0Vfzr_wMJ+HDrXyhzJ+TmRDED5GH+koMw@mail.gmail.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-10-git-send-email-chriscool@tuxfamily.org>
	<xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 23:47:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEPX4-0003xU-91
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 23:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbbL3Wrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 17:47:47 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35853 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbL3Wrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 17:47:46 -0500
Received: by mail-lb0-f173.google.com with SMTP id oh2so121347894lbb.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 14:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IoFk4vryPOx6B2EUlADqFl8eJTvpK7C+E4wzNUWHZ0Q=;
        b=KQYD79zg8cMRzNw+06sWCkO4VhulI4l0fF0eT+jlyHAUwGg6MzHhoZRvqEBeuv2/Q5
         P91JPMwV8s7aL9v2oYYOFL3LV1x+EGnMQedL0x3NmfBRm8flFmZ5tnrgasliuYn1qy42
         4MNdTeshXGmHpUKHntdbl4FRP/HPaHX129CtLgqglchdQlzLIbzfSjEb4uPkCEc/5IoB
         3NEIVt1Xehr/FRo6DFmwVU1fC/Hw8ElPelgNtT4IxsQTh0KGgY/2TAfDumaIF5GcdYk6
         ObKYHdW1XvLCeoFnwSMYdSsgri6aWciNDeM5Urkiyvi1UhF+WL5qZdkIsvNS8L51hKNW
         p5lQ==
X-Received: by 10.112.172.130 with SMTP id bc2mr23501959lbc.132.1451515664212;
 Wed, 30 Dec 2015 14:47:44 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Wed, 30 Dec 2015 14:47:44 -0800 (PST)
In-Reply-To: <xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283212>

On Tue, Dec 29, 2015 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +core.untrackedCache::
>> +     Determines if untracked cache will be automatically enabled or
>> +     disabled. It can be `keep`, `true` or `false`. Before setting
>> +     it to `true`, you should check that mtime is working properly
>> +     on your system.
>> +     See linkgit:git-update-index[1]. `keep` by default.
>> +
>
> Before "Before setting it to `true`", the reader needs to be told
> what would happen when this is set to each of these three values (as
> well as what happens when this is not set at all).

Ok, then I think I will write something like:

core.untrackedCache::
     Determines what to do about the untracked cache feature of the
index. It will
     be kept, if this variable is unset or set to `keep`. It will
automatically be added
     if set to `true`. And it will automatically be removed, if set to
`false`. Before
     setting it to `true`, you should check that mtime is working
properly on your
     system.
     See linkgit:git-update-index[1]. `keep` by default.

>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
>> index a0afe17..813f6cc 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -174,27 +174,31 @@ may not support it yet.
>>
>>  --untracked-cache::
>>  --no-untracked-cache::
>> -     Enable or disable untracked cache extension. This could speed
>> -     up for commands that involve determining untracked files such
>> -     as `git status`. The underlying operating system and file
>> -     system must change `st_mtime` field of a directory if files
>> -     are added or deleted in that directory.
>> +     Enable or disable untracked cache extension. Please use
>> +     `--test-untracked-cache` before enabling it.
>
> "extension" is a term that is fairly close to the machinery.  In
> other parts of the documentation (like the added text below in this
> patch), it is called "untracked cache FEATURE", which probably is a
> better word to use here as well.

Ok, I will use "feature".

>> +These options cannot override the `core.untrackedCache` configuration
>> +variable when it is set to `true` or `false` (see
>> +linkgit:git-config[1]). They can override it only when it is unset or
>> +set to `keep`. If you want untracked cache to persist, it is better
>> +anyway to just set this configuration variable to `true` or `false`
>> +directly.
>
> While the above is not wrong per-se, from the point of those who
> looked for these options (that is, those who wanted to do a one-shot
> enabling or disabling of the feature, perhaps to try it out to see
> how well it helps on their system), I think the explanation of the
> interaction between the option and the config is backwards.  For
> their purpose, setting it to `true` or `false` will be hinderance,
> because the options are made no-op by such a setting.  IOW, the
> advertisement "once you decided that you want to use the feature,
> configuration is a better place to set it" does not belong here.
>
> If I were writing this documentation, I'd probably rephrase the
> second paragraph like so:
>
>         These options take effect only when the
>         `core.untrackedCache` configuration variable (see
>         linkgit:git-config[1]) is set to `keep` (or it is left
>         unset).  When the configuration variable is set to `true`,
>         the untracked cache feature is always enabled (and when it
>         is set to `false`, it is always disabled), making these
>         options no-op.
>
> perhaps.

Yeah, but "no-op" is not technically true, as if you just set the
config variable to true for example and then use "--untracked-cache"
then the cache will be added immediately. Also it does not explain
that for example "git update-index --untracked-cache" will die() if
the config variable is set to false.

>> @@ -385,6 +389,34 @@ Although this bit looks similar to assume-unchanged bit, its goal is
>>  different from assume-unchanged bit's. Skip-worktree also takes
>>  precedence over assume-unchanged bit when both are set.
>>
>> +Untracked cache
>> +---------------
>> +
>> +This cache could speed up commands that involve determining untracked
>> +...
>> +It is recommended to use the `core.untrackedCache` configuration
>> +variable (see linkgit:git-config[1]) to enable or disable this feature
>> +instead of using the `--[no-|force-]untracked-cache`, as it is more
>> +persistant and visible with a configuration variable.
>
> s/persistant/persistent/; but more importantly, I do not think
> persistence has much to do with the choice between the option and
> configuration.  Once it is set with `--untracked-cache`, it should
> persist until you explicitly use `--no-untracked-cache` to disable
> it, no?  Otherwise you have a bug that needs to be fixed.

Yeah, it should persist except if you clone and copy the config file.
I agree that it is not clear what "persistent" means, so maybe I can
just remove "as it is more persistant and visible with a configuration
variable".

> The reason you'd want to use a configuration is because the effect
> of using the `--untracked-cache` option is per repository (rather,
> per index-file).
>
>     If you want to enable (or disable) this feature, it is easier to
>     use the `core.untrackedCache` configuration variable than using
>     the `--untracked-cache` option to `git update-index` in each
>     repository, especially if you want to do so across all
>     repositories you use, because you can set the configuration
>     variable to `true` (or `false`) in your `$HOME/.gitconfig` just
>     once and have it affect all repositories you touch.
>
> or something, perhaps.

Ok, I will use something like that.

>> +When the `core.untrackedCache` configuration variable is changed, the
>> +untracked cache is added to or removed from the index the next time
>> +"git status" is run; while when `--[no-|force-]untracked-cache` are
>> +used, the untracked cache is immediately added to or removed from the
>> +index.
>
> Is it only "git status", or anything that writes/updates the index
> file?  The above makes it sound as if you are saying "If you change
> the variable, you must run `git status` for the change to take
> effect", and if that is indeed the case, perhaps you should say so
> more explicitly.  My cursory reading of the code suggests that the
> user must run `git status` in a mode that shows untracked files
> (i.e. "git status -uno" does not fix)?

Yeah, that's what the code does.

> I somehow thought, per the previous discussion with Duy, that the
> check and addition of an empty one (if missing in the index and
> configuration is set to `true`) or removal of an existing one (if
> configuration is set to `false`) were to be done when the index is
> read by read_index_from(), though.  If you have to say "After
> setting the configuration, you must run this command", that does not
> sound like a huge improvement over "If you want to enable this
> feature, you must run this command".

The untracked-cache feature, as I tried to explain in an email in the
previous discussion, has an effect only on git status when it has to
show untracked files. Otherwise the untracked-cache is simply not
used. It might be a goal to use it more often, but it's not my patch
series' goal.

So why should we have a check to see if maybe the cache should be
added or removed in all the other cases when the cache is not used?

>> +     switch (untracked_cache) {
>> +     case UC_UNSPECIFIED:
>> +             break;
>> +     case UC_DISABLE:
>> +             if (use_untracked_cache == 1)
>> +                     die("core.untrackedCache is set to true; "
>> +                         "remove or change it, if you really want to "
>> +                         "disable the untracked cache");
>>               remove_untracked_cache();
>>               report(_("Untracked cache disabled"));
>> +             break;
>> +     case UC_TEST:
>> +             setup_work_tree();
>> +             return !test_if_untracked_cache_is_supported();
>> +     case UC_ENABLE:
>> +     case UC_FORCE:
>> +             if (use_untracked_cache == 0)
>> +                     die("core.untrackedCache is set to false; "
>> +                         "remove or change it, if you really want to "
>> +                         "enable the untracked cache");
>> +             add_untracked_cache();
>> +             report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
>> +             break;
>
> I do buy the decision to make these no-op when the configuration
> says `true` or `false`, but I am not sure if these deserve die().
>
> Exiting with 0 (= success) after issuing a warning() might be more
> appropriate.

Scripts users might just not look at the warnings and expect things to
work if the exit code is 0.

> I'd especially anticipate that some newbies will
> complain that they got "fatal:" when they used the "--force-"
> variant, saying "I know what I am doing, that is why I said 'force',
> why does stupid Git refuse?".

I think this should be taken care of in the "--force-" documentation.
Maybe we should say that it is deprecated and make it clear, if we
don't already, that it does nothing more than without "force-".
