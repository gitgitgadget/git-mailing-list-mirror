From: Moe <moe@signalbeam.net>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Sat, 19 Dec 2009 08:20:35 +0100
Message-ID: <4B2C7EC3.6070501@signalbeam.net>
References: <4B2C0828.4010505@signalbeam.net> <20091219013246.GD25474@genesis.frugalware.org> <7vhbrnodd9.fsf@alter.siamese.dyndns.org> <4B2C5A1A.8000201@signalbeam.net> <7vzl5fik3o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 08:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLtcM-0003v8-0V
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 08:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbZLSHUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 02:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbZLSHUk
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 02:20:40 -0500
Received: from s2.mbox.bz ([85.214.91.204]:49503 "EHLO s2.mbox.bz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbZLSHUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 02:20:38 -0500
Received: from mini.local (unknown [92.206.21.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by s2.mbox.bz (Postfix) with ESMTPSA id 7E1C0E04B6C;
	Sat, 19 Dec 2009 08:20:36 +0100 (CET)
User-Agent: Postbox 1.1.0 (Macintosh/20091201)
In-Reply-To: <7vzl5fik3o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135467>

Junio C Hamano wrote:
> Moe <moe@signalbeam.net> writes:
> 
>>> I find the original use case highly moronic.
>>>
>>> For people to be sharing an account, hence $HOME, there must be a reason.
>>> They want to (rather, the administrator wants them to) use a common shared
>>> set of settings, so $HOME/.gitconfig should be shared among them, just
>>> like $HOME/.emacs and $HOME/.login are, unless there is some strong reason
>>> to treat .gitconfig any differently from all the other $HOME/.whatever
>>> files.  But I don't think there wasn't any argument to defend that.
>> I'm not arguing to treat .gitconfig differently from other
>> dot-files, but to treat it differently from .git/config.
>>
>> The former is user-specific, the latter is repository-specific.
> 
> That is something we already do, like everybody else.  $HOME/.emacs is
> user specific, /etc/emacs.d/* are site-wide, and "Local Variables:..End:"
> section is per-document.  Have you asked emacs guys (and vim folks) about
> a change similar to the one on topic here?  This question is rhetoric and
> you do not have to answer it.
> 
>>> Wouldn't it be just a matter of giving different HOME after they log-in?
>>>
>>> After all, Moe will be giving _some_ way to his users set different value
>>> to GIT_CONFIG_EXTRA depending on who they really are, and that same
>>> mechanism should be usable to set different HOME to them, no?
>> The individual users are identified by their ssh key. Ssh sets a
>> distinct environment variable for each, which in turn is used in
>> .bash_profile to read an additional user-profile.
>>
>> Yes, we could overwrite $HOME but that would defeat the purpose.
>> The goal of this setup is to share almost all settings.
> 
> You haven't answered the crucial question, and repeating yourself is not
> an explanation.  I've already said sharing the account is to share things,
> you know I understand you want to _share_.  I asked why $HOME/.gitconfig
> has to be treated differently from others like $HOME/.mailrc, $HOME/.gitk,
> etc. that are shared.  You are not answering the question.

I refrained from delving deeper into our particular use-case at first,
due to the verbosity and to avoid a potential "git wasn't meant for
this" knockout. But it seems we're over this, so see below.

> What makes $HOME/.gitconfig different from $HOME/.ssh/., $HOME/.vimrc, and
> all the other things?  Why do you want to share all the other dot files,
> most of which lack the support for you to do the "set-up" you have to do
> in $HOME/.bashrc to switch based on something other than the UID (I would
> call that a "set-up", not a "hack", because you have to do that
> somewhere)?  Why do your users tolerate that they cannot have their own
> private $HOME/.rpmmacros nor $HOME/.newsrc but it is not Ok that they have
> to share $HOME/.gitconfig with others?
>
> Knowing that is very important for us, as $HOME/.gitconfig will not stay
> the only thing you would need to single out with future versions of git.
> 
> For example, we have discussed a support for $HOME/.git-excludes that sits
> between $GIT_DIR/info/exclude and the file pointed at by core.excludesfile
> configuration variable.  Should it be shared, or separated?  Why?
> 
> I do not want to count on you, who I have never seen on this list before,
> being around to ask if such a change would break your use case when the
> day comes.  If we do not know the _criteria_ you are using, the reason why
> you want to single out $HOME/.gitconfig when it is Ok for your users to
> share $HOME/.vimrc, we will not be able to make good design decisions to
> support this "shared account" configuration [*1*].  Will we introduce
> GIT_EXCLUDE_EXTRA at the time like Miklos added GIT_CONFIG_EXTRA?  Where
> does it end?
> 
>> I hope this can still make it, considering the small size of
>> the patch and the .git/config vs ~/.gitconfig argument.
> 
> That is not an argument at all.  We handle .git/config vs $HOME/.gitconfig
> just fine; see above.
> 
> One plausible answer you could have given is that your users do not have
> an account in the usual sense of the word at all, and the _only_ thing
> they can do with your system is to run git and nothing else.  IOW they
> have no business with even having $HOME/.vimrc or $HOME/.rhosts, so these
> other dotfiles do not matter at all.  That makes $HOME/.gitconfig special.

Yes, that's pretty close. What we do is, we put our entire runtime
environment [for a web application] under a dedicated user and under
version control. This is a very comfortable way to maintain an
identical environment across the board, we even deploy this way
to our production servers by the means of a git pull on a
dedicated branch.

In practice our developers will su or ssh to this user to get working
and generally they need only a very small set of divertions from the
common configuration - such as their personal git identity and their
preferred editor settings.

One may argue that a bunch of host-specific symlinks could achieve a
similar effect - and that would be correct - but having literally
everything under version control yields certain advantages that we
wouldn't want to miss. Such as any developer being able to ssh into
the shared user on any host and being right at home (including
properly attributed git commits) without further twiddling.
(that usually comes into play when ssh'ing into a production host,
 performing a hotfix and feeding it back)

This all may seem esoteric or even moronic to you. All I can say is
that it's been working extraordinary well for us over the past 2 years,
despite the minor git inconvenience.

> A possible solution might be for us to honor $GIT_HOME that is favoured
> over $HOME, just like $GIT_EDITOR overrides $EDITOR.  That allows us to
> extend the notion more naturally in the future.  For example, when we
> start reading from $HOME/.git-excludes, if the GIT_HOME environment is
> set, we would instead read from $GIT_HOME/.git-excludes.  That would be a
> much cleaner solution than Miklos's patch [*2*].

Sounds like that would serve our case just as well
and yes, probably much cleaner in the long run.

> But you have given us too little for us to be able to judge what the best
> longer-term course of action is.  How could you even _hope_ it can "make
> it"?

Well, sorry for being so brief initially. Being not as involved with git
development I based my request on what I figured could be a
sane generalization of our particular problem.

Also I don't mean to blow this out of proportion; it's a minor,
mostly cosmetic inconvenience for us and we can stick to our workarounds
or Miklos' patch if a mainline change shakes
things up too much.
