From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: only show "Fetching remote" when verbose mode is enabled
Date: Sun, 25 Oct 2015 19:21:45 -0700
Message-ID: <xmqqio5ujrnq.fsf@gitster.mtv.corp.google.com>
References: <1445741384-30828-1-git-send-email-pabs3@bonedaddy.net>
	<xmqqwpuakd9y.fsf@gitster.mtv.corp.google.com>
	<1445817847.23160.31.camel@bonedaddy.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Wise <pabs3@bonedaddy.net>
X-From: git-owner@vger.kernel.org Mon Oct 26 03:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqXQ1-0004Wl-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 03:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbbJZCVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 22:21:49 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752430AbbJZCVs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 22:21:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 411D7271B3;
	Sun, 25 Oct 2015 22:21:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=62w+BF4ll6GVw2bfsENHcbtoPzI=; b=Hfv4pH
	4ioULuk8jlI4UzvCKFMp4c36gejon8ZuX+r/f9dq6pg97Yw4YpFK6R1MMLMnK1/B
	FqxbDwA4VdRB+g7g2fqsbm1qfr68sXjdzx03PPjNH0TirBx8t3XRLsGcOImG4gjZ
	SVJ8NtnU7jWNQt/qnsEZ+ivsMs90zPgPjpXMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cbJ14iBgN5foTL01f7uFlOVvxdPAlMA7
	++pqO8GC+X+M2QXpxicttQq3QDBjVwgteCoCM+dlnG0ef87DY9wS6/loLw53iy9E
	2vXww4rnXkFunRBeMdxuzAVlE44tPt/ceqV9shd9DeXju9smWX6eFvr0iKP3KMdz
	pphZdrz+1go=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37FEB271B2;
	Sun, 25 Oct 2015 22:21:47 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B43EB271B1;
	Sun, 25 Oct 2015 22:21:46 -0400 (EDT)
In-Reply-To: <1445817847.23160.31.camel@bonedaddy.net> (Paul Wise's message of
	"Mon, 26 Oct 2015 08:04:07 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E80B68A-7B88-11E5-B0A6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280170>

Paul Wise <pabs3@bonedaddy.net> writes:

> It definitely wouldn't be appropriate to add screen scraping and
> parsing of different version control systems to myrepos.

Huh?  If the tool claims to support VCS X and Y and Z, it needs to
know how to cause X and Y and Z to "fetch" in their own ways, and it
needs to know how X and Y and Z report what they have done.

The tool can choose to be lazy and not understand the outcome.  But
then if the tool misbehaves because it does not know and care what
happened, don't come here blaming the underlying VCS.  It is the
laziness of the tool that causes such a bug in the tool.

>> Having said all that, this time I read the change and the change
>> itself feels 40% sensible, even for those who do not care about
>> "myrepos" at all.
> All I want is for "Fetching remote" to not be printed when there are no
> changes fetched and I haven't used the --verbose option.
>
> I realise now that my patch is actually incorrect in that it also
> suppresses "Fetching remote" messages when some changes were fetched.

I actually think it makes things even worse.  I can come up with a
justification for the change in your patch as posted (but with
reservations, aka "the last paragraph"), but not with such a
behaviour.

> I will come back with a correct patch that is better explained.
>
>> I'd sell it like the attached, if I were doing this patch.  The last
>> paragraph is where the remaining 60% went ;-)
>
> Thanks, I will try to re-use that for the next patch.
>
>> Note that the current output was deliberately designed like this to
>> give an easy reminder for the user what the components of 'group'
>> are.  With this change, we are selfishly and unilaterally breaking a
>> feature that was designed to help them, but if they strongly care,
>> they can complain and revert this change.
>
> To be honest I didn't know this group feature existed and I am
> surprised that anyone would want anything other than --all.

I admit that I do not care too deeply myself, but I do care about
existing users (and possibly tools) that expect the current output,
so if you are going to argue for discarding some information from
the output, I'd want to make sure that you understand what you are
discarding and how they are supposed to be used and how they are
useful.

Unfortunately I am not getting that sense from the above "I'll show
the message only for the ones that were updated".

The thing is, the story does not change an iota between --all and a
named group.  Imagine you have three remotes X, Y and Z, and you
have a named group that contains all of them called G.  These are
the same:

    $ git fetch G
    $ git fetch --all

Further imagine that only X has something new.  Both of the above
would give you

    $ git fetch --all ;# or G
    Fetching X
    From git://...
        xxxxx..yyyyy master -> X/master
    Fetching Y
    Fetching Z

Remember that the user never said "X Y Z" from the command line; it
is because "--all" (and named group) is "once I configure, I do not
have to remember each and every one every time" mechanism.  That is
the crucial point.

The above output shows that the command tried to fetch from X and Y
and Z, it got something interesting from X, *AND* it also shows that
Y and Z were unchanged.  And this last part "Y and Z were unchanged"
is a useful information.  If you do not give the last two lines, the
user _must_ remember that --all (or G) consists of X, Y and Z, in
order to infer that.  That defeats the whole point of --all/group to
relieve the user from having to remember the set of remotes and
having to type them from the command line every time.

Contrast the following command sequence with the above:

    $ git fetch X
    From git://...
        xxxxx..yyyyy master -> X/master
    $ git fetch Y
    $ git fetch Z

The responses from the command in the above sequence do not say
anything about Y and Z and that is totally sensible.  The user
explicitly said Y (and Z), and the command did not say anything for
them--it is clear enough for the user to know Y (and Z) did not have
anything new.

So fetching from multiple repositories with "--all" or group cannot
be fundamentally "consistent" with the single remote case, if you do
not want to lose information.

One tangent worth noting is this.  You can fetch from multiple
repositories that are explicitly named from the command line:

    $ git fetch --multiple X Y
    Fetching X
    From git://...
        xxxxx..yyyyy master -> X/master
    Fetching Y

I do think that we do not need "Fetching Y" for this case, and I
actually think we shouldn't even say "Fetching X".

> I am not sure what the solution here is but perhaps the behaviour
> demonstrated below is acceptable to users of this feature:

I do not think so.  It does not address the fact that it loses
information to throw away "Fetching ..." message for repositories
with nothing new at all.  What gives us the right to break existing
users' expectations and force them to add --verbose on their command
line?
