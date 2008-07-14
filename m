From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Tue, 15 Jul 2008 00:19:31 +0200
Message-ID: <487BD0F3.2060508@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 15 00:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIWPN-0006P1-Qu
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 00:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbYGNWTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 18:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbYGNWTh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 18:19:37 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:34374 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbYGNWTg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 18:19:36 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3016077fkq.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 15:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=lIm9R37WYTb45X04SbzJjSWd1Lih2V7bR2z5xKUfeLw=;
        b=QQ0a5M5a0DVuasV0gtpuVAmB1u83ywCzkfKTlIKsvkqOpH5629gVLdfBI9tH647Jjs
         LqL9IwuD6nmvrFEyXU8xHJdK8yxPNjX/Ckouv6Tb7dD9fvq3lNJlSajNCAu/ZB/CdVfk
         J45sQXb8WGQOxScJjCErNuRyOWhS2FP4eWoHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=SGFkbMSIO08xKO5jq19jwZ2sTZBjJGZ7w04HboKKRCBB0FU5wB1W4vSXhq8mNJRjuQ
         XFc+r09KgrGTEbvecaPm2yvGHgcW42rN8kuDfHYMU8l2970NoA5TQwufNl74eFXeXrB9
         5TUwPsCygfOt9kP4oFSrpD5hfKRM8LdoLWnTE=
Received: by 10.187.252.8 with SMTP id e8mr2032112fas.92.1216073973403;
        Mon, 14 Jul 2008 15:19:33 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id 22sm12674052fkr.4.2008.07.14.15.19.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 15:19:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <20080714014051.GK10151@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88472>

Petr Baudis wrote:
> Maybe I sound too mentoring at places; [OTOH] if something general gets into
> the Git tree, I'd like to make sure it's something we can live happily
> with for long time, not just a hack tailored for gitweb caching.

Yup, I agree (and you don't sound too mentoring ^^).  Thanks for the
review and feedback.

> I really miss some more detailed writeup on the envisioned design here. [...]
> Most importantly, how is Git::Repo interacting with working copies,

Git::Repo is not interacting with working copies at all right now.  Is
there anything you think should be considered for its design?

Here's a write-up about the design (I'll probably move this into
Git::Repo's man page):

----------
Git::Repo aims to provide low-level access to Git repositories.  For
instance, you can resolve object names (like "HEAD~2") to SHA1s, and
inspect objects.  It does not attempt to be a wrapper around the git
plumbing or porcelain commands.

Error handling is simple: On a consistent repository, the Perl interface
will never die.  You can use the get_sha1 method to resolve arbitrary
object names or check the existence of SHA1 hashes; get_sha1 will return
undef if the object does not exist in the repository.  Any SHA1 that is
returned by get_sha1 can be safely passed to the other Git::Repo methods.
----------

> First, I don't think it's good idea at all to put the pipe-related stuff
> to Git::Repo - this is botched up API just like the current one.

Well, they're more like helper methods.  Since they don't fit into the
design goals of the Git::Repo API at all, I'd suggest we just
underscore-prefix them and take them out of the man page.  (The only
reason why I hadn't done this is that gitweb uses $repo->cmd_output
extensively, so it'd end up with a lot of underscore calls.  But I
suppose we can either alias _cmd_output to cmd_output in gitweb's
CachedRepo subclass, or live with $repo->_cmd_output calls.)  Does
underscore-prefixing sound good to you?

If someone wants to come up with a consistent nice interface for calling
git commands, sure.  I wasn't actually trying to do that.

> Here is an idea: Introduce Git::Command object [and a Git::CommandFactory]
> 
> 	my $c = Git::Command->new(['git', '--git-dir=.', 'cat-file', \
> 		'-p', 'bla'], {pipe_out=>1})    [...]
> 	my $cf = Git::CommandFactory->new('git', '--git-dir=.');
> 
> Or am I overdoing it?

Yes, I think so. ;-)  All we're talking about here is a wrapper around
"open '-|'" calls (plus some workarounds for Windows I suppose).

I don't have much of a notion of a 'command' as an object in my head;
your (snipped) example makes it look like you're trying to create a
IO::Handle-compatible interface, which I think is way too much effort
(and error-prone) for simple pipes.  Also, a CommandFactory class just
to catenate lists together seems like overkill to me.

Something like a command interface *may* make sense if it's tied to
repositories or working copies, in which case it could automatically set
--git-dir or --work-tree, but it's beyond the scope of what I'm trying
to create here, and I don't think it's even overly useful.

> Instead, I believe the best course is to gradually translate all the
> Git.pm functionality to the new OO model, leaving Git.pm as a
> compatibility wrapper. Now, if you believe this is a non-trivial task,
> please tell us why.

Well, as I said, the fact that there are untested parts in Git.pm
doesn't exactly make it trivial to refactor.  Also, only very few parts
can be cleanly moved to Git::Repo.  In "grep '^sub [^_]' Git.pm" I find
only cat_blob and perhaps hash_object to be eligible to be moved (though
hash_object should probably live in a working-copy/non-bare-repo class,
with an optional insert => 1 parameter).  And even cat_blob is
non-trivial to move unless you want the whole blob to be read into memory.

That's a lot of non-trivialness for very little gain.  I doubt I'd even
have enough time till the end of GSoC (minus vacation) to do this.

> It should be actually very easy to start with moving all the pipe
> functionality to Git::Command.

Creating a new (Git::Command) API is very much non-trivial, apart from
the fact that I'm not convinced that we need Git::Command, and that a
clean command interface neither falls out of Git.pm nor Git::Repo.

>>   I'm working on caching for gitweb, not on implementing the
>>   next great Perl API for Git.  (And Git::Repo isn't great, FTR.)
> 
> Wait, I can't make sense out of this paragraph. If Git.pm sucks, we can
> work on new API. But we better _make_ it great. Or someone else comes by
> next year and says "oh, but it's buggy and needs refactoring, let's
> throw it away and redesign it!"

Sorry, I wasn't clear with my parenthesed remark: I actually think that
Git::Repo is pretty good in terms of code and interface quality.  It's
just not *complete*, even in its limited scope, and I'm not attempting
to make it complete.

I do think that someone who wants to extend Git::Repo (like Jakub with
Git::Config) won't have much trouble doing so with the existing design.

>> +use constant _MESSAGE => 'M';
>> +use constant _ENCODING => 'E';   [snip]
> 
> if you are going to use hashes
> anyway, why not actually key by sensible name directly?

Embarrassingly premature optimization here. ^_^  I'll fix it.

>> $commit = Git::Commit->new($repo, $sha1)
> 
> Are we sure we don't want hash-based arguments instead? This is badly
> extensible and inconsistent with the rest of the API.

*ponders*  Every commit needs a repo and a SHA1, so those will never get
optional.  We can always add hash-based options after the two mandatory
arguments, but I don't even see any such possible options at the moment.
 (And if I turn out to be completely wrong, we can even move to a
hash-only argument list by checking the type of the first parameter.)
Really, I wouldn't worry.

>> [Git::Commit->new, Git::Tag->new:]
>> +Calls to this method are free, since it does not check whether $sha1
>> +exists and has the right type.  However, accessing any of the commit
>> +object's properties will fail if $sha1 is not a valid commit object.
> 
> This is nice idea, but I'd also provide a well-defined way for the user
> to verify the object's validity at a good moment; basically, make load()
> a public method. The user can deal with errors then and rely on
> error-free behavior later.

No, you should never pass in an invalid SHA1 in the first place.  The
above piece of documentation is just a warning that bugs will show up
delayed.  IOW, this is not the right place to have your error handling.

If you're getting a SHA1 through the user-interface, check its existence
with get_sha1 before passing it to the constructor.

>> +Note that $sha1 must be the SHA1 of a commit object; tag objects are
>> +not dereferenced.
> 
> Why not?

Because the SHA1 might resolve to an object of the wrong type, which
means you have to do error handling in Git::Object objects; that's the
wrong place.

If tag-resolving is really needed, we can add an optional $type
parameter to get_sha1, which will cause get_sha1 to resolve the object
until a $type object is found, or return undef if the object is or
resolves to an object of the wrong type.

I have resolving code in gitweb's git_get_sha1_or_die (which I didn't
implement in Git::Repo since it uses some customized error reporting).
The resolving code could conceivably be extracted and moved to get_sha1.
 I think there are a few things to ponder and maybe discuss, so I'd do
that in a separate patch (if I get around it before the end of the project).

>> +=item $commit->authors
> 
> author

Fixed.

>> +Objects are loaded lazily, and hence instantiation is free.  Objects
>> +stringify to their SHA1s.
> 
> Maybe use the term 'Git database objects'? This way, it seems as if we
> are talking about all Git/*.pm objects.

I've replaced it with: "Objects are loaded lazily, and hence
instantiation is free.  Git::Object instances stringify to their SHA1s."

>> +sub sha1 {
>> +sub stringify {
> 
> Why not overload "" directly to sha1()?

Done (and removed stringify).

>> +sub assert_opts {
>> +sub assert_sha1 {
> 
> Pretend names with underscores, since they are internal?

Done, and removed them from @EXPORT_OK.

>> 'directory': The directory of the repository (mandatory).
> 
> I don't think making this mandatory is reasonable, since all the git
> commands can automatically figure this out by themselves too; so can
> Git::Repo easily by calling git rev-parse --git-dir.

Sure, it can be made non-mandatory if it's needed, but there are so many
possibilities for the exact time and place at which the repo directory
should be resolved using rev-parse (if at all) that I'd rather leave
this to the person who has an actual use-case for it.  I'm not a fan of
designing APIs before they are needed.

>> [Snipped a lot of quoting --LW]
>> +=item $repo->repo_dir
>> +=item $repo->git_binary
>> +=item $repo->version
>> +sub _get_git_cmd {
> 
> This definitely does not belong to a Git::Repo object.

Which of those methods are you referring to?  I think $repo->version
might reasonably be removed (and the code re-added to gitweb); I'll do
so unless you object.  _get_git_cmd is already underscored, and repo_dir
and git_binary only access attributes passed in through the constructor,
so I think those three should stay.

>> +=item $repo->cat_file($sha1)
> 
> I don't think this is good combination of semantic and name. Since we
> don't do the same thing as plain git cat-file, we might as well call it
> cat_object() or even better get_object().

Yup; I like get_object (I think I was planning to rename it and then
didn't remember doing so before sending off the patch).  Will rename it.

>> +=item $repo->get_path($tree_sha1, $file_sha1)
> 
> Now we are quickly getting messy again. This should definitely live in
> Git::Tree.

Yup, that's true.  I'll move it into gitweb until we have Git::Tree
(with a comment that it can be moved to Git::Tree once it exists).

>> +=item $repo->get_refs
>> +=item $repo->get_refs($pattern)
> 
> Again, the refs should be properly integrated into the object structure.

Really?  I think it's generally fine for get_refs to exist and to live
in Git::Repo.

Its return value (currently an an arrayref of [$sha1, $object_type,
$ref_name] arrayrefs) might need improvement though, and I find the
$pattern parameter pretty suspect (in that it smells like a for-each-ref
wrapper).  Since get_refs is unused at the moment (gitweb ended up
needing the slightly different show-ref), I'll remove it for now.  (Same
thing about me not being a fan of premature API design applies.)

I keep patches of everything I remove so other people will be able to
use them as starting points; I'll probably post them as "FYI"-patches to
the list at the end of my project, to preserve them for posterity.
