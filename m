From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Review of git multimail
Date: Wed, 3 Jul 2013 15:53:03 +0530
Message-ID: <CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com> <51D36BD8.1060909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuKE2-0007AZ-G3
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab3GCKXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:23:46 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:40176 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352Ab3GCKXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 06:23:44 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so15322600iej.29
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ANowC/9lZ58u6rRqHt6UumdUUUdW69dlyBXkZ3LeJQw=;
        b=rcjduI7i7G+OVCITL+mml7Kz9MnlFX0621mEPlHn6emBYQGXYYLtGponaxdotjWmoX
         /Zf6A7vFKrD8B19S+422uNcjLS6MH7eaq5/IwqiIQS1WPtFZ+0Ir0IunMqJzKa33CLPU
         uhjf+Ym56oTGPOLBS8giCZFb0PWnR0J6QSeZ9ska+keNOVE+bi/QibyvJQ4ehHnLR+WV
         EFywEf8m8+pmHMFl+BSpPsVZ2BEETj0GxvdZ9uKJCvey9RMjphMpUBouRBRQSjOrWJLK
         FRPkMYBLoR7EXByf79/LzByWzxwX53gBUYf4N/rgkegI0PA6CMWT5Ul6IJMHKbPPV7OK
         7Zlw==
X-Received: by 10.50.1.37 with SMTP id 5mr24430155igj.29.1372847023885; Wed,
 03 Jul 2013 03:23:43 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 3 Jul 2013 03:23:03 -0700 (PDT)
In-Reply-To: <51D36BD8.1060909@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229484>

Michael Haggerty wrote:
> On 07/02/2013 09:23 PM, Ramkumar Ramachandra wrote:
>> git_multimail.py wrote:
>>> #! /usr/bin/env python2
>>
>> Do all distributions ship it as python2 now?
>
> No, but nor is "python" always Python version 2.x (I believe that Arch
> Linux now installs Python 3 as "python").  This topic was discussed here
> [1].  Basically, my reasoning is that (a) PEP 394 [2] says that
> "python2" is the correct name for a Python 2.x interpreter, (b) I
> believe that other distros are moving in that direction, and (c) if the
> script says "python2" but no python2 is installed, the error is pretty
> obvious, whereas if the script says "python" and that is actually Python
> 3.x, the error would be more cryptic.

Yeah, this is good reasoning.  And yes, I'm on Arch: python points to
python3, and python2 points to python2.  A couple of thoughts while
we're on the subject:

1. We should probably convert git-remote-{hg,bzr} to use this style
too: they give cryptic errors now, and I have a ~/bin/python pointing
to python2 which is higher up in $PATH to work around it.  Debian uses
an alternatives mechanism to have multiple versions of the same
package, but I personally think the system is ugly.

2. Is there a way to determine the python version in-script and
error-out quickly?  Is it worth the ugliness?

>>>             'Command "%s" failed with retcode %s' % (' '.join(cmd), retcode,)
>>
>> So cmd is a list.
>
> Yes, commands are always lists in my code because it is less error-prone
> than trying to quote arguments correctly for the shell.  Do you think I
> should document that here, or elsewhere, or everywhere, or ...?

If you look at the prototype of execvpe(), the calling semantics are
immediately clear, but we don't have that luxury in Python: probably
rename the variable cmd_argv?

>>> class ConfigurationException(Exception):
>>>     pass
>>
>> Dead code?
>
> No, this defines an exception class that inherits all of its methods
> (including its constructors) from Exception.  This is useful because an
> exception of type ConfigurationException is distinguishable from other
> types of Exceptions, and can be caught using "except
> ConfigurationException, e".

Okay.  I was under the impression that you had some future extension plans.

>>>     def get(self, name, default=''):
>>>         try:
>>>             values = self._split(read_git_output(
>>>                     ['config', '--get', '--null', '%s.%s' % (self.section, name)],
>>>                     env=self.env, keepends=True,
>>>                     ))
>>
>> Wait, what is the point of using --null and then splitting by hand
>> using a poorly-defined static method?  Why not drop the --null and
>> splitlines() as usual?
>
> To avoid confusion if a single config value contains end-of-line
> characters.  In this case we are using --get, so only a single value is
> allowed anyway, and presumably we could take the output and strip a
> single last '\n' from it.  But null-terminated output is simply easier
> to handle in general and I don't see an advantage to avoiding its usage.

My rationale for avoiding it comes from Python's lack of inbuilt
functions to handle it; but yeah, Junio pointed out that quirk in the
previous email.

>>>                 return default
>>>             else:
>>>                 raise
>>
>> raise what?
>
> This is the Python construct to re-throw the exception that was caught
> in the catch block containing it; i.e., the CommandError from a few
> lines earlier.

Ah, thanks.

>>>     def get_recipients(self, name, default=None):
>>>         lines = self.get_all(name, default=None)
>>>         if lines is None:
>>>             return default
>>>         return ', '.join(line.strip() for line in lines)
>>
>> Ugh.
>
> ?

I would expect it to return a list that can be churned on further, not
a string that's ready for rendering.  Doesn't it resemble the
dictionary get(), and even your own get_all() in name and signature?

>> Dead code?
>
> git_multimail is used as a library by migrate-mailhook-config, and that
> script uses these methods.

I see.  Perhaps clean separation to avoid confusing readers?

>>> def generate_summaries(*log_args):
>>>     cmd = [
>>>         'log', '--abbrev', '--format=%h %s',
>>>         ] + list(log_args) + ['--']
>>
>> What is log_args if not a list?
>
> It is a tuple and therefore needs to be converted to a list here.

Oh, I always thought *log_args meant list; to my surprise, it's a tuple.

>> Just rev-parse --verify --short $SHA1^0: if it resolves, set
>> self.short; one liner?
>
> I don't follow.  We need both the long and the short SHA-1s to fill in
> the templates.  What code exactly do you propose to replace with your
> one-liner?

Oh, you need both.  I was hoping to cut the cat-file -t too, but you
need another call resolving $SHA1^{object} to distinguish between
commits and tags; so never mind.

>> What is the point of letting the user instantiate a GitObject without
>> a valid .sha1 in the first place?
>
> '0'*40 is passed to the post-receive script to indicate "no object"; for
> example, a branch deletion is represented as
>
> 0123456789abcdef0123456789abcdef01234567
> 0000000000000000000000000000000000000000 refs/heads/branch
>
> It is convenient to treat this as if it were a GitObject.
> GitObject.__nonzero__() (which is called if a GitObject is evaluated in
> a boolean context) returns False for these non-objects.

Fair enough, although my objection mainly has to do with not
separating logic and rendering cleanly.

>>>     def __str__(self):
>>>         return self.sha1 or ZEROS
>>
>> I wonder what value this adds when .short is around.
>
> The full object name is used in the X-Git-{Oldrev,Newrev} email headers
> and probably in some error messages and stuff.

If I manage to separate out the logic from the rendering, I'll send
PRs directly.

>>>     def _compute_values(self):
>>>         return self.environment.get_values()
>>
>> Why is this an "internal function"?  What is your criterion for
>> internal versus non-internal?
>
> This method is meant to be overridden by derived classes to affect the
> map returned by get_values().  But elsewhere get_values() should be
> called, not this method (because get_values() memoizes its return value).

Fair rationale.

>>>     def get_values(self, **extra_values):
>>>         if self._values is None:
>>>             self._values = self._compute_values()
>>>
>>>         values = self._values.copy()
>>>         if extra_values:
>>>             values.update(extra_values)
>>>         return values
>>
>> Unsure what this is about.
>
> The dictionary is mainly used to provide values that can be interpolated
> into the email templates.  It also has the advantage that it is only
> called once, and then its value is used multiple times, which limits the
> amount of boilerplate needed for derived classes to override the getter
> methods without forcing those methods to be called many times.

Makes sense.

>>>             try:
>>>                 value = value % values
>>>             except KeyError, e:
>>>                 if DEBUG:
>>>                     sys.stderr.write(
>>>                         'Warning: unknown variable %r in the following line; line skipped:\n'
>>>                         '    %s'
>>>                         % (e.args[0], line,)
>>>                         )
>>
>> If DEBUG isn't on, you risk leaving the value string interpolated
>> without even telling the user.  What does it mean to the end user?
>
> There are some "nice-to-have" values in the templates that are not
> necessary and might be missing if the user hasn't gone to the trouble to
> configure every last setting.  For example, if no emaildomain is defined
> then the pusher_email cannot be determined, resulting in the Reply-To
> header being omitted.
>
> My assumption is that a sysadmin would turn on DEBUG when testing the
> script, check that any missing headers are uninteresting, and then turn
> off DEBUG for production use so that users don't have to see the
> warnings every time they push.

Ah, so that is the intended usage.  If the impact of omitting certain
headers (due to lack of information) doesn't result in unusable emails
being generated, I think we're good.  Are you sure that doesn't
happen?

>>>         raise NotImplementedError()
>>
>> Unsure what these are about.
>
> These are basically just to allow code sharing across the various Change
> classes.

I'm not sure it's worth supporting Python < 2.6, especially if it
costs more to port it to Python 3+ (no abstract base classes; ugliness
like this).  Which brings me to: considering that the first commit is
in late 2012, why didn't you choose to code it in python3 directly?
Unless I'm mistaken, the only reason git-remote-{bzr,hg} aren't in
python3 is because the dependencies bzrlib and hglib are in python2.

>>>         body = self.generate_email_body(push)
>>>         if body_filter is not None:
>>
>> Redundant "is not None".
>
> This way of writing the test is robust against objects for which
> bool(body_filter) might return False.

If body_filter isn't a function, we have much larger problems, don't we? ;)

Nevertheless, I'm not going to argue with idioms (I've not written any
Python in years now, so I don't know them).

>>> class Revision(Change):
>>>     """A Change consisting of a single git commit."""
>>>
>>>     def __init__(self, reference_change, rev, num, tot):
>>>         Change.__init__(self, reference_change.environment)
>>
>> super?
>
> IMO, in Python 2.x, super() is really only useful in a class hierarchy
> where multiple inheritance is going to be supported, like in the
> Environment classes.  The problem is that even if you use super(), you
> have to type the name of the containing class explicitly; e.g.,
>
>     super(Revision, self).__init__(reference_change.environment)
>
> It is even longer than the explicit reference to the parent class, and
> though it doesn't break if another class is inserted into the
> inheritance chain, it *does* break if the class itself is renamed.  So I
> usually don't bother with super() unless I'm using multiple inheritance.
>
> In Python 3, where super() doesn't require redundant arguments, it is
> much less cumbersome to use.

I see.  Thanks for the explanation.

>> [...]
>>>         # First line of commit message:
>>>         try:
>>>             oneline = read_git_output(
>>>                 ['log', '--format=%s', '--no-walk', self.rev.sha1]
>>>                 )
>>>         except CommandError:
>>>             oneline = self.rev.sha1
>>
>> What does this mean?  When will you get a CommandError?
>
> I can't think of a plausible reason that this command would fail.
>
>>                                                          And how do
>> you respond to it?
>
> By using the commit's SHA-1 in place of its subject line.

What you have written translates to: "If there is a valid commit whose
subject cannot be determined (empty subject is still determinate), I
will use the commit's SHA-1 hex in its place", which implies that you
do not trust git to be sane ;)

Isn't the entire premise of your script that you have a sane git?

> Yes, I could do that (though it needs quotes around the key strings).
> Or the even more attractive
>
>     values.update(
>         rev=self.rev.sha1,
>         rev_short=self.rev.short,
>         ...
>         )
>
> I had the latter in an earlier version of the script, but I thought it
> might be too unfamiliar for non-Python-experts.  I guess I'm using
> pretty highfalutin Python anyway so this change wouldn't hurt.  What do
> you think?

I like pretty, maintainable, modern code with low redundancy.  As a
general principle, I always tilt towards educating users/ developers
about new (or "advanced") features, not abstaining from them because
they are too unfamiliar (or "complicated").

On this specifically, a beginner can look up help(values.update) to
understand what the code is doing.  So, yes: values.update() is
definitely better.

>>>         # The revision type tells us what type the commit is, combined with
>>>         # the location of the ref we can decide between
>>>         #  - working branch
>>>         #  - tracking branch
>>>         #  - unannotated tag
>>>         #  - annotated tag
>>
>> Could be simpler.
>
> If you mean the distinction between four types of ref is
> overcomplicated, this is something taken over from the old
> post-receive-email script.  If you just mean that the code could be
> simplified, then please make a suggestion.

I'll send a PR directly if I manage to simplify it.

>>>     def __init__(self, environment, refname, short_refname, old, new, rev):
>>>         Change.__init__(self, environment)
>>>         self.change_type = {
>>>             (False, True) : 'create',
>>>             (True, True) : 'update',
>>>             (True, False) : 'delete',
>>>             }[bool(old), bool(new)]
>>
>> As a general principle, avoid casting: if new is a dictionary, what
>> does bool(new) even mean?  You just have to trust types, and let go of
>> that much safety.
>
> old and new are not dictionaries, they are GitObject instances.  And
> this is not casting, it is calling old.__nonzero__() and
> new.__nonzero__() to see whether they are real objects vs. ZEROS and to
> canonicalize their values so that they can be used as indexes for the
> literal dictionary that decides what type of change is being described.

Ah, I missed that.

>>>     def describe_tag(self, push):
>>>         """Describe the new value of an annotated tag."""
>>>
>>>         # Use git for-each-ref to pull out the individual fields from
>>>         # the tag
>>>         [tagobject, tagtype, tagger, tagged] = read_git_lines(
>>>             ['for-each-ref', '--format=%s' % (self.ANNOTATED_TAG_FORMAT,), self.refname],
>>>             )
>>
>> You could've saved yourself a lot of trouble by running one f-e-r on
>> refs/tags and filtering that.  I don't know what you're gaining from
>> this overzealous object-orientation.
>
> It's only needed for the tags that have changed (which is probably zero
> in most cases).

Hm, we'll have to discuss performance in the "typical case" soon.

>>>         contents = list(read_git_lines(['cat-file', 'tag', self.new.sha1], keepends=True))
>>
>> You could've easily batched this.
>
> I don't understand what you mean.

Whenever I call cat-file from a script, I always find myself using the
--batch variant.

>> Way too many git invocations, I think.
>
> Luckily git is very fast :-)
>
> I'm not to worried about performance here.  The script will typically
> only be run on pushes, and most pushes affect only one or a few
> references.  I don't think these few git invocations will be prohibitive.

I personally push very often, so it's not a problem.  I'm thinking of
a mirroring batched push, where the maintainer pushes out history to a
"release" server every major release (every few months): is the script
intended to be used in such a scenario, when multiple refs and tags
are updated non-trivially?

>>>         ReferenceChange.__init__(
>>>             self, environment,
>>>             refname=refname, short_refname=refname,
>>>             old=old, new=new, rev=rev,
>>>             )
>>>         self.recipients = environment.get_refchange_recipients(self)
>>
>> What is the point of this?  Why not just use ReferenceChange directly?
>
> Maybe you missed "short_refname=refname" (one of the arguments is not
> being passed through 1:1).  The reason is explained in the comment.

Gah, my bad habit of not reading comments.

>> If you want to DWIM when the configuration variable is missing, do it
>> fully using a list of good candidates like /usr/lib/sendmail,
>> /usr/sbin/sendmail, /usr/ucblib/sendmail, /usr/bin/msmtp.
>
> OK, I just added /usr/sbin/sendmail and /usr/lib/sendmail, which are the
> paths checked by "git send-mail".

I'm on Arch, and sendmail is dead (only available in AUR now).  I
think we should support modern sendmail-compatible alternatives like
msmtp (which I have and use).

>>                                                            Also, what
>> happened to our faithful 'git send-email' Perl script?  Isn't that
>> most likely to be installed?
>
> We could use "git send-email" to generate and send the revision emails,
> but then we would lose most control over the contents of the emails.

I'm talking about the <file>... form.  Does it necessarily mangle the
headers of an mbox that is fed to it, or am I missing something?

> sys.stderr.write() can only take a single string argument.  You might
> have seen it called like this:
>
>     sys.stderr.write(
>         'foo\n'
>         'bar\n'
>         )
>
> This is using the Python compiler's feature that literal strings can be
> appended to each other by juxtaposition (notice there are no commas).
> But this only works for literal strings, not for string expressions.

Ouch, that's ugly.

>>> class Environment(object):
>>
>> New-style class.  I wonder why you suddenly switched.
>
> ?  All of the classes are new-style classes.

When you say class Foo:, aren't you declaring an old-style class by
default in python2?  New-style classes are those that explicitly
inherit from object (implicit in python3).

>> Overdoing the OO factories, much?
>
> I went to a lot of trouble to make the Environment mixin classes
> composable, because what I've learned from the feedback in the last
> months is that everybody wants to do something different with this
> script.  I tried out a few designs before I settled on this one.

I see.  I'm not a user, so I can't comment.

>>> class GenericEnvironment(
>>>     ProjectdescEnvironmentMixin,
>>>     ConfigMaxlinesEnvironmentMixin,
>>>     ConfigFilterLinesEnvironmentMixin,
>>>     ConfigRecipientsEnvironmentMixin,
>>>     PusherDomainEnvironmentMixin,
>>>     ConfigOptionsEnvironmentMixin,
>>>     GenericEnvironmentMixin,
>>>     Environment,
>>>     ):
>>>     pass
>>
>> Sigh.  I might as well be reading some Java now :/
>
> No, Java doesn't allow multiple inheritance :-)

Ha, yes: I meant in the way you factory'ified everything.  I don't
recall seeing this kind of code in a real-world application though: I
skimmed through Django's code many years ago, and haven't found such a
pattern.  I have seen instances where multiple inheritance may be
classified as borderline useful, but nothing as extensive as this.
Additionally, Ruby does not have multiple inheritance.  So, I tilt
towards the conclusion that multiple inheritance is Bad and Wrong.
Then again, I'm not an OO person in general, so I can't have a mature
opinion on the subject.  Can you present a case for this kind of
extensive usage quoting real-world examples?

> git_multimail.py is 2398 lines of Python script, including comments and
> string literals.  The fraction of that code that is dedicated to
> configurability is approximately 1000 lines.  Relative to
> post-receive-email, it adds
>
> * much more configurability, without the need to edit the script.

So this is the main selling point.

> * non-buggy determination of which commits have been added by a
> reference change, and distinction between commits that have been added
> to a branch vs. commits that have been added altogether and between
> commits that have been deleted from a branch vs. commits that have been
> deleted altogether.

Okay, so the post-receive-email script has corner-case bugs.

> [...]

The others seem to be small'ish features.

> Regarding efficiency, I don't think it is a problem.  But patches or
> concrete suggestions are certainly welcome.

Pre-optimization is the root of all evil :)  Can you give us some
numbers from real-world usecases, so we know whether or not it _needs_
to be optimized?  I ran your test script (test-email, I think) and it
generated 35 emails in ~10 seconds; but the repository was
super-trivial.

> Regarding separation of computation and rendering, yes, they could be
> separated better.  (BTW, it would make the script even longer.)  The
> rendering is already largely done via templates that can be changed from
> outside of the script.  But I might work on separating them more
> strictly so that some of the code could be reused, for example, to send
> notifications via IRC or XMPP.

My reasons for wanting to separate out the computation from rendering
are different: they centre around clarity, speed, ease of
maintainability and composability.  It's possible that I'm
irrationally biased towards such a separation because of my experience
with MVC-like frameworks.  Then again, I don't have code to show; talk
is cheap.

> Thanks for all of your comments!  I hope I have addressed most of them
> in this email and in the commits that I just pushed to GitHub.

Glad to be of help.  Good turnaround time.
