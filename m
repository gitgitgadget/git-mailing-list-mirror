From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Wed, 16 Jul 2008 22:32:19 +0200
Message-ID: <487E5AD3.60202@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <200807162021.56380.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDgn-0008Qm-0G
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759397AbYGPUc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759358AbYGPUc1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:32:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:38397 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886AbYGPUcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:32:25 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3586579fkq.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=Gs4J9SyUDWQzp/ycpuiVUAwQXhri07D3lmV2xl538DY=;
        b=jcon3NyxCU8b/OkH3wxImFwcMPuwDLiMApGnH/pSh6mbGG1NND4KQWPtqsd8XUQj69
         WLtu8yyM/15TdKP349B6RZLLYdy9jxM4bR8hGRDGyYda5CvpEhF18SJcddlvp6GZTUgE
         TjVrWNPV1eD3p8XefdT//PtZqUWABQzxIgluw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=F7PFWhTFTVY64uovhw6iNTQiQIM0cR4VxTFS0s+FvO3pgjU17QeJy+BuTIyQ/RdScr
         ftBMg2PfCd80Lwpoou4MMJ56fSv1OcyN71wshiVfxLoiuzmuzcf9rLj5uoyVfoZwQED5
         Dd7K9qmTSuQZ770TY27mw1Nha6mZ5BdmErx5Y=
Received: by 10.187.191.13 with SMTP id t13mr307527fap.7.1216240342559;
        Wed, 16 Jul 2008 13:32:22 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.205.88])
        by mx.google.com with ESMTPS id 22sm19261278fkr.4.2008.07.16.13.32.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 13:32:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807162021.56380.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88745>

Jakub Narebski wrote:
> [Here is promised patch review]

Thanks.  A new patch series will follow today (hopefully).

For brevity, I'm incorporating all your suggested changes unless noted
otherwise.

> On Fri, 11 July 2008, Lea Wiemann wrote:
>>  create mode 100644 perl/Git/Commit.pm
>>  create mode 100644 perl/Git/Object.pm
>>  [...]
> 
> Does splitting into many small files is really necessary?

I think it's better.  People shouldn't get an error message if they
write "use Git::Commit".  Also we cannot split later if we don't split
now since people would write "use Git::Repo" and then access
Git::Commit; subsequently splitting the API would (might?) cause
breakage, I believe.

> Good that you provided test suite.

;-)

> You can add new headers, and old git binary should simply ignore
> unknown headers.

Unknown headers are now ignored.

>> +# Keep documentation in one place to save space.
> 
> Embedded PODs in Perl modules serve as sort of literate programming,
> serving to describe code (technical/usage documentation) in addition
> to comments in code.

Yeah, but this part is only a bunch of trivial accessor methods.  If the
module grows and the documentation needs to be split, it can be done
later.  No need to be purist here. ;-)  Also ...

> [The fact that documentation is separated from code means that
>  I cannot easily tell and write if code match documentation]

Several of the methods actually only exist in the Git::Object base
class.  I still documented them in the Commit and Tag modules since
having to look up methods in base class documentation can be a tad
annoying, especially if the base class is never used by users of the API.

>> +=item $commit = Git::Commit->new($repo, $sha1)
>> +
>> +Calls to this method are free, [...]
> 
> The technique you use has a name, and it is (IIUC) "lazy evaluation".

You understand correctly; I'd call it "lazy loading" though.  I've added
that term for clarity.

> By the way, wouldn't it be better to make this method internal, and
> use instead the following code to generate Git::Commit object
> 
>   $commit = $repo->commit($sha1);

I think the constructor shouldn't be internal (= underscore-prefixed,
you mean?), since the Commit/Tag APIs are usable on their own.

>> +=item $obj->repo
>> +=item $obj->sha1
> 
> Those do not access the repository, isn't it?

No, they don't.  (Clarified that in the documentation.)

>> +=item $commit->parents
>> +Return a list of zero or more parent commit objects.
> 
> Array or arrayref?

Array.  I've replaced "list" with "array" in case it helps clarity.

> There is little inconsistency that tree object is (from the lack of
> Git::Tree object) returned as SHA1, and parents as objects.

If we add a Git::Tree API, the Git::Tree objects will stringify to their
SHA1s, so we shouldn't have compatibility issues.  I've changed the
documentation of $commit->tree to this:

"Return an object that stringifies to the SHA1 of the tree that this
commit object refers to.  (Currently this returns an actual string,
but don't rely on it.)"

> NOTE that element of list of revisions has in addition to that also
> _effective_ parents in the event of history simplification, for example
> for 'history' view, or when using '--first-parent' extra option.

Yes, but we don't actually care about those effective parents for the
purpose of the Git::Commit API.  IOW, the effective parent should be
managed by the code that created a list of revisions, not by the
Git::Commit API.

>> +Return the author string of this commit object. [...]
>> +Return the committer string of this commit object.
> 
> It returns whole value of 'author' and 'committer' headers, not
> something extracted from it (into name, email, epoch and timezone),
> isn't it?

Yup; that's why I wrote "{author,committer} *string*". ;)

>> +=item $commit->message
>> +
>> +Return the undecoded commit message of this commit object.
> 
> Just raw data?

Yes, just raw data.  Decoding is too tricky (i.e. not guaranteed to
work) to just add a simple method to the API; IOW, it needs error
handling and perhaps fallback encodings.

> NOTE that for element of list of revisions (as returned by git-rev-list
> or git-log) would probably have commit message decoded to UTF-8 by git.

Yes, but the API doesn't use any of those commands internally, if that's
what you're worried about.

>> +=item $commit->encoding
>> +
>> +Return the encoding header of the commit object.
> 
> Normalized?

No.  (Otherwise I'd have written that ;-).)

>> +sub author { [...]
>> +	$self->{_AUTHOR()} or ''; }
> 
> Nowhere in documentation is mentioned that you use empty value for no
> author or no committer (isn't commit object invalid then?).

Yes, I'd believe so.  I basically wanted to make sure that those methods
always return a string; do you think that this is a bad idea?

>> +	if (!defined $raw_text) {
>> +		# Retrieve from the repository.
>> +		(my $type, $raw_text) = $self->repo->cat_file($sha1);
> 
> The above makes Git::Commit good solution for gitweb's 'commit' and
> 'commitdiff' views, but bad solution for 'log', 'shortlog', 'history'
> and 'rss'/'atom' views, where you would need to many command
> invocations, which is very bad on OS with slow fork.

$repo->cat_file (now renamed to get_object) actually doesn't fork but
uses a pipe (cat-file --batch); I don't think it should be a performance
issue.

>> +	(my $header, $self->{_MESSAGE()}) = split "\n\n", $raw_text, 2;
> 
> Why not simply parse headers, then slurp rest of object into 'message'
> field?

Because we happen to get the raw text in a single string from the Repo
API.  (It shouldn't be a performance/memory issue for Commit or Tag
objects at all. ;-))

> IMHO you should not die at unrecognized header,

Yes, changed, but ...

> but simply store it under its name (and make available using
> ->header('<NAME>')).

... let's not complicate the API unnecessarily.  If a new header pops up
we can immediately add it to the Commit/Tag API.

> Nevertheless I think you can check for header name validation (there
> are some restrictions on header names, isn't it?).

I don't really care, and it's too much work to come up with a test case
for this. ;-)  If the repository is borked to the point of invalid
header names, it's fine for Git::Commit to behave undefinedly.

>> +You will usually want to call $repo->get_commit($sha1) instead of
>> +instantiating this class directly; see L<Git::Repo>.
> 
> Why not $repo->commit($sha1)?

Intuition. ;-)  I think I'd read $repo->commit as "the commit of the
repository", akin to $commit->tree, which doesn't make sense here.

>> +Git::Object - Object-oriented interface to Git objects (base class).
> 
> Is it base class which represents types of objects in git repository:
> commits, tags, trees and blobs?  Or just a class which represent
> headers+payload objects, i.e. commits and tags?

It could represent any object, though I don't see a need for Git::Blob
right now (though it's possible that it's needed later).

> I wonder if Git::Object should provide $obj->id alias to $obj->sha1...

Why?  I don't think it's necessary.

>> +use 5.006002;
> 
> Why is this "use 5.006002" for?

It signifies that this module won't run with Perl <5.6.2.  I've had to
bump it to 5.008 (Perl 5.8); more about that in the message announcing
the next version of the patch series.

> Wouldn't it be better to allow the same discovery of '.git' directory
> as other git command do, and leave 'git_dir' to set directly path to
> repository itself?

I wouldn't use discovery magic here, at least for now, since it's
non-trivial to get it right (and it interacts with possible future
extensions of the API, like Git::WC).  Such a feature can be implemented
if/when it's needed.

>> +=item 'git_binary'
>> +The name or full path of the git binary (default: 'git').
> 
> Probably should be Git::Cmd or Git object, instead.

I don't think something Git::Cmd is a good idea (as I pointed out in my
reply to Petr, <487BD0F3.2060508@gmail.com>), or at least it shouldn't
be implemented as part of this patch series.  This method is really just
supposed to return an argument for exec*p, nothing more.

>> +Calling this method is free, since it does not check whether the
>> +repository exists.  Trying to access the repository through one of the
>> +instance methods will fail if it doesn't exist though.
> 
> Not even rudimentary check: if directory exists, if it looks like
> git repository?

No.  It's not helpful for error handling (which should happen in the
caller), and it's not helpful for bug detection (since it will die on
the first access to the repo anyway), but it causes performance penalty
that can be significant for programs like gitweb.

>> +=item $repo->repo_dir
>> +Return the directory of the repository (.../.git in case of a working
>> +copy).
> 
> I think $repo->git_dir (perhaps in addition to above) would be better
> name, as it is already established among git commands.

I find repo_dir somewhat clearer (and I don't like having more than one
name per method).  We're not trying to mimic or wrap standard git
commands here, anyway.

>> +sub version{
> 
> We could rely instead on embedded (during build) version string...

Yup; it's been deleted anyway.

>> +=item $repo->cmd_output(%opts)
> 
> Please do remember that there are git commands which do not need
> access to git repository,

As I wrote in my reply to Petr, Git::Repo is not trying to be a wrapper
around git binaries, so this method really shouldn't be part of the
official API -- it's just auxiliary; I'll underscore-prefix it.

> I think it would be easier on users if you provide two ways of calling
> [cmd_output]: simple and advanced

It's not part of the API anyway, so no need for complicated calling
conventions, IMO.

>> +# To do: According to Git.pm, this might not work with ActiveState
>> +# Perl on Win 32.  Need to check or wait for reports.
> 
> Why not copy code from Git.pm, then?

Apart from the fact that I don't do cargo-cult programming? ;-)  Git.pm
forks, whereas Git::Repo uses open, '-|', so it's actually different
(and it's not possible to copy the code).

>> +=item $repo->get_bidi_pipe(%opts)
>> +
>> +Open a new bidirectional pipe and return its STDIN and STDOUT file
>> +handles.  Valid options are:
> 
> What about returning context, as it was done in Git.pm?

Why, what should it do?  This just opens a pipe, nothing more.  No need
for introducing complicated concepts.

>> +=item 'reuse'
>> +
>> +If true, reuse a previously opened pipe with the same command line and
>> +whose C<reuse> option was true (default: false).
> 
> What is this for?  Can you show example usage of this feature?

You found it below. :-)  (If you had snipped this, I wouldn't have spent
time finding and pasting an example. ;-))

> I think I'd rather allow extended SHA1 syntax in Git::Commit
> and Git::Tag constructors; it is one call to git command less
> (I think).

I wouldn't -- see my blurb about error handling at the top of my reply
to Petr (<487BD0F3.2060508@gmail.com>).  You're not supposed to pass
anything that you didn't get from get_sha1 into Git::Commit or Git::Tag
constructors, or your error handling is invariably broken.

>> +	my ($in, $out) = $self->get_bidi_pipe(
>> +		cmd => ['cat-file','--batch-check'], reuse => 1);
> 
> Ahhh... here I can see what 'reuse => 1' means, and when it is useful.
> But doesn't it make sense _only_ for _bi-directional pipe_?  Are you
> sure that you wouldn't get deadlock?

Yes to both questions. :-)

>> [get_object:]
>> +# Possible to-do items: Add optional $file_handle parameter.
> 
> If I remember correctly you do implement something like that (streamed
> output) in gitweb patch.

Yes, but only for generic command calls, and with a somewhat unpleasant
(cache-specific) interface.  It'd need a bit of work for the API.

> By the way, for gitweb you would need (for performance and for
> rewritten parents) also get_log / get_commits / get_commits_list

No. ;-)  Doing fine without those.

>> +=item $repo->get_path($tree_sha1, $file_sha1)

This one has been removed as well since it would belong into Git::Tree.

>> +	my @lines = split "\n", $self->cmd_output(cmd => ['ls-tree', '-r', '-t', $tree]);
> 
> You would have troubles with filename quoting!

Thanks.  Since get_path isn't in the Git::Repo API anymore and gitweb's
get_path subroutine didn't handle quoted filenames even before my
patches, I'll only mark it as TODO for now. ;-)

>> +sub get_refs {

This has been removed as well, since it's not used and the interface
would need work.

>> +=item $repo->name_rev($committish_sha1, $tags_only = 0)
> 
> Why name_rev, and no describe?

Feel free to add it. ;-)  (It might take some work to come up with a
decent interface for that method.)

> Does Git::RepoRoot provides way to scan for repositories under
> commin $projectroot?

No.  If it's needed it could reasonably be extracted from gitweb though
(I think).

>> +Return the tagger string of this tag object.
> 
> We would probably want some way to extract name, email, epoch/date
> (and a way to convert epoch+timezone to RFC or ISO format), timezone.

Yeah.  At some point. ;-)

>> +=item $tag->encoding
>> +Return the encoding header of the tag object.
> 
> Does tag provide 'encoding' header?

Sure, for the message.

> Should (for completeness) Git::Tag provide $tag->validate() method?

No, since 'validate' sounds like it would have to do error handling.

If you mean that this should check if the object exists (and has the
advertised type), the user of the API should test for "defined
$tag->repo->get_sha1($tag->object)" or somesuch and do error handling
themselves.

-- Lea
