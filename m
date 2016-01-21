From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule update: Initialize all group-selected submodules by default
Date: Wed, 20 Jan 2016 20:40:14 -0800
Message-ID: <xmqqlh7jzgsx.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-4-git-send-email-sbeller@google.com>
	<xmqqr3hc3pmz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYJJ+JxgLBqD1Y_UWACUd7yJGnU+rnwEnU6X041deftjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 05:40:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM72l-0008Lu-C1
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 05:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbcAUEkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 23:40:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753547AbcAUEkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 23:40:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BC943E4AB;
	Wed, 20 Jan 2016 23:40:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=BFR9A5E4ZEjYnmWjPbOIIgRJyfg=; b=FCE5osqVlKpH6SFqrFPq
	miRW1nv3DJUuDDdLBSCPHkh5DgX0QynKu368Tz2POIwjjUneJnlOc2OFZbjVPqCE
	8pZcEuS3Qt4UeQXfhA1M9bBSTc7511bXj4n7DutdNIaJsCq+Wy+LtokrGqRk7ogQ
	7xfAFyS472SF4E6YAMI8ul0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bcr0bfvAy6Lmvx+H2Qsmot+OPRbzn6oUS5+NsC89OT923f
	K1AtVRkqZzTM7O6QWy7Inqg+vMkWGTfduohcPc3pGbs3boCwS2IwBKnWZpllGqrk
	ye0V4UOWK+6MTU+5i+nOb49g79bnVZaAwWjh8DMcjg6Z0p1TzBpfMBKjz4q0o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 53D183E4AA;
	Wed, 20 Jan 2016 23:40:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF7123E4A6;
	Wed, 20 Jan 2016 23:40:15 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10FB12E6-BFF9-11E5-AA2A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284501>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Jan 20, 2016 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> If this were used to implement "there are various groups defined,
>> and the user tells us that submodules in this and that groups are to
>> be automatically initialized", then naming the field with a name
>> that is more specific than just "groups" makes tons of sense, but
>> even in such a case, the best adjective to clarify what kind of
>> "group" this field is about is not "this is a submodule group".
>>
>> The answer I would give to a question "what kind of group this field
>> is about?" would be "this is an auto-init group", so I'd have that
>> 'auto-init' ness somewhere in its name.
>
> So you mean something like `autoinit` would maybe already suffice.

If you have (and I wish we have, but I do not seem to be able to
come up with myself offhand) a shorter and more intuitive word than
auto-init, that may be preferred, but basically yes.  I'd call that
autoinit_group or something, as you might want to come up with ways
other than using groups to specify which ones are to be automatically
initialized.

Come to think of it, I think we should drop "auto" from the name.

The only reason we think of this as "auto" is because we know that
historically "clone" was purely about cloning and anything submodule
related had to be done as a separate step, and this series makes the
second step a part of the "clone" proper.  But from the point of the
end user, who specifies that "init" to be done for the specified set
of submodules, there is no longer anything "auto" about it.  We are
doing what the user asked us to do; "auto" is what we do without
explicitly being told, but the user is telling as explicitly which
modules to work on with the option.

> Which leads to another question if we want to extend the concept of
> these submodule groups a little bit, such that we also allow
> direct names in there, in .git/config we may have the configuration
>
>     [submodule]
>         groups = <groupname-as-annotated-in-.gitmodules>
>         groups = <explicit-submodule>
>
> such that `git clone --group=default --group=mySingleSubmodule ....` would work.

I am not sure what you mean by the above snippet.  With

	[submodule "foo"]
        	group = default
	[submodule "bar"]
        	group = optional
	[submodule "baz"]
        	group = optional
                path = sub/baz

it would be nice if you can say "modules in the default group",
"modules in the default group and the module 'bar'", "modules at
path sub/baz", etc.

Am I repeating more or less the same thing as you wanted to say with
the above?  If so, yes, I do think there should be a uniform syntax
that lets users specify set of modules via different mechanisms.

> Of course then the --group option would need to be named
> differently in git clone and probably the submodule.groups should
> also be named differently.

I do think --group option is a mistake, as you are only saying
"please give a name of a group to this option" without hinting how
the modules in the specified group are to be treated differently, or
more importantly, the option is about submodules.

    Side note: this is a common delusion developers fall into
    thinking that the feature they currently working on is the most
    important thing in the world.  In the context of "clone", there
    is no reason to expect that "groups of submodules" is any
    special than groups of other things.  For the same reason, I
    think --init=<group> is a mistake, as it is not clear from the
    option name that we are initializing submodules in the context
    of "clone".

So perhaps --init-module.

Once we establish a uniform convention for specifying a group of
submodules is by giving the names of groups, the "group" ness of the
option argument becomes less and less important, as that would be
implicitly known by users.  "clone --init=A" would be more
understandable than "clone --group=A", as everybody would know A is
naming a set of submodules either way, but the latter does not say
what will happen to the chosen modules.

There could be other ways to specify the modules, and as long as we
can come up with the "uniform convention for specifying a group of
submodules", "clone --init-module=$X --init-module=$Y", would be
understandable by the users when $X specifies the modules by their
group name and $Y specifies another set of modules by something else,
e.g. their names or paths to them.

    A strawman.  You can pass (1) the path to a submodule, (2) you
    can pass a colon followed by the name of a submodule, or (3) you
    can pass an asterisk followed by the name of a group.  (1) and
    (2) specifies a single submodule, (3) specifies the submodules
    that belong to the group.  I.e.

    $ git clone --init-module='*default' --init-module=sub/module

    would be a way to say "clone and then initialize the submodule
    at path sub/module and also those in the default group.

    This strawman makes "path" the default way, merely because many
    subcommands of "git submodule" already specify which submodule
    to operate on by taking paths arguments, and '*' prefix as the
    sign to specify by a group, as an asterisk looks like specifying
    multiple things.  ':' is just another prefix that is unlikely to
    be in a pathname.

    This is merely an illustration of the kind of syntax that can be
    used to name a set of modules using different ways.  I am sure
    people can come up with a different and better syntax, but the
    point of this illustration is not the exact syntax but showing
    that a way to uniformly specify a set of modules to operate on
    would allow us not having to worry about making 'groups' any
    special.

I however do not see why you think "submodule.group" needs to be
spelled differently (it should be "submodule.$name.group", though).
The 'group' is merely a convenient way to name and choose a set of
modules.  The name of the operation, i.e. what is to be done to the
chosen modules, should be orthogonal, so I do not think you should
have "submodule.autoinitgroup" or somesuch.

> However:
> At this point in time we only care about auto-initing submodules
> to get submodules somewhat easier to handle when having lots of them.
> Maybe we also want to add other features to these "groups" concept, e.g.
> all submodules of one groups should have the "(force-)checkout" update strategy.
> If the submodule consists of binaries only, this would make lots of sense to me.
>
> So it is not yet clear to me if we want to extend the grouping feature
> later on for
> other things, which is why I named it by its concept. A group can be used for
> different purposes, where as "all submodules having the same auto-init-tag can
> be treated the same using one update strategy" just adds to user confusion,
> hence I'd think telling the user about groups is the right thing to do?

"clone" and other commands may want to gain use of some mechanism to
specify a set of modules, and 'group' is one of the mechanisms to do
so.  Also "clone" and other commands may want to gain features to do
different things to such sets of modules.  So there are two orthogonal
axes.

Which one is more pleasant to use from the end-user's point of view?

 (1) options are named after _how_ you specify the submodules:

     $ clone --init-group=A --init-name=B --init-path=C

     and what is done to them is implicit.

 (2) options are named after _what_ is done to them:

     $ clone --init-module=A --init-module=\*B --init-module=/C

     and how the set is specified is implicit to the syntax.

And more importantly, which one is more extensible in the future
when you want to add more features that work on multiple but not all
submodules?

	clone --init-module='*A' --distim-module=':B'

would be one clear way to say that modules in group A would be
inited, while the submodule B would be distimmed.  What would an
equivalent of it look like in your "clone --group=A --name=B" world?
Wouldn't the design along the lines of (2) above be much better?
