From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Wed, 16 Jul 2008 20:21:55 +0200
Message-ID: <200807162021.56380.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBee-00055C-5y
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbYGPSWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752955AbYGPSWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:22:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12396 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbYGPSWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:22:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1858747nfc.21
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=xJ+rk/UQGtACj2jOIGbWjuTRBW4Loa5EnKOtl1XV9QE=;
        b=p1vwYIfzokAWljO/FAcc1xasjWf+6bj2I5xApula1OXwI1TMMYOnC++q9G+1R3ukd3
         8R4YmQyllnGxAs3aLZ8qO0Isev6han3srcqY3vhl6KgiyIN7rinyROrkOK9uEIbbjNHF
         2zVm4Jv08aWlhDyVLWqdBT5ppK9BhlCLhKbyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=tIzBfDpa5r/oe2DfsBPMU3kS3DD3pP5Pp3wxVjEmboH68sc/CdvWMgSmtcKs/EB6K6
         o4kb0H7pVdzqTqjoAyVPwA4Fj9T2ds5SifYtX21tqkQOISg2Ss2/ItMYPwi6hLIXXUTn
         4DMjmPZa2laPHDO0iQZWd+PBP71XGjkggNHik=
Received: by 10.210.128.5 with SMTP id a5mr279852ebd.62.1216232522946;
        Wed, 16 Jul 2008 11:22:02 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.240.223])
        by mx.google.com with ESMTPS id z37sm10312439ikz.6.2008.07.16.11.21.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 11:22:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1215738665-5153-1-git-send-email-LeWiemann@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88709>

[Here is promised patch review]

On Fri, 11 July 2008, Lea Wiemann wrote:

>  create mode 100644 perl/Git/Commit.pm
>  create mode 100644 perl/Git/Object.pm
>  create mode 100644 perl/Git/Repo.pm
>  create mode 100644 perl/Git/RepoRoot.pm
>  create mode 100644 perl/Git/Tag.pm

Does splitting into many small files is really necessary?

>  create mode 100755 t/t9710-perl-git-repo.sh
>  create mode 100755 t/t9710/test.pl
 
Good that you provided test suite.

> diff --git a/perl/Git/Commit.pm b/perl/Git/Commit.pm
> new file mode 100644
> index 0000000..a9bc304
> --- /dev/null
> +++ b/perl/Git/Commit.pm
> @@ -0,0 +1,163 @@
> +=head1 NAME
> +
> +Git::Commit - Object-oriented interface to Git commit objects.
> +
> +=cut
> +
> +use strict;
> +use warnings;
> +
> +
> +package Git::Commit;
> +
> +use base qw(Git::Object);
> +
> +use constant _MESSAGE => 'M';
> +use constant _ENCODING => 'E';
> +use constant _TREE => 'T';
> +use constant _PARENTS => 'P';
> +use constant _AUTHOR => 'A';
> +use constant _COMMITTER => 'C';

What is this for? Why not keep content of commit headers keyed under
their names? It would be much simpler code, and I don't think the
above buys anything in terms of performance.

There is another thing to consider: commit object and tag object format
was deliberately (I think) designed to be *extensible* (in a way).
You can add new headers, and old git binary should simply ignore
unknown headers.  This is what allowed us to add 'encoding' header
to commit object, and propose 'keyword' header to tag object (which
was to be used for notes / post-factum annotations).

> +# Keep documentation in one place to save space.

Errrrr... that is a stupid idea, and even more stupid reasoning.

Embedded PODs in Perl modules serve as sort of literate programming,
serving to describe code (technical/usage documentation) in addition
to comments in code.

> +=item $commit = Git::Commit->new($repo, $sha1)
> +
> +Return a new Git::Commit instance for a commit object with $sha1 in
> +repository $repo.
> +
> +Calls to this method are free, since it does not check whether $sha1
> +exists and has the right type.  However, accessing any of the commit
> +object's properties will fail if $sha1 is not a valid commit object.
> +
> +Note that $sha1 must be the SHA1 of a commit object; tag objects are
> +not dereferenced.

The technique you use has a name, and it is (IIUC) "lazy evaluation".
By the way, wouldn't it be better to make this method internal, and
use instead the following code to generate Git::Commit object

  $commit = $repo->commit($sha1);

> +=item $obj->repo
> +=item $obj->sha1

Those do not access the repository, isn't it?

> +=item $commit->tree
> +
> +Return the tree this commit object refers to.

I think you should say there explicitely that it is SHA-1 of tree
(tree object identifier) that is returned.  Isn't it?

By the way I think it should be mentioned explicitly in documentation
which methods cause "instantation" (which cause evaluation).

[The fact that documentation is separated from code means that
 I cannot easily tell and write if code match documentation]

> +=item $commit->parents
> +
> +Return a list of zero or more parent commit objects.  Note that commit
> +objects stringify to their respective SHA1s, so you can alternatively
> +treat this as a list of SHA1 strings.

Array or arrayref?

There is little inconsistency that tree object is (from the lack of
Git::Tree object) returned as SHA1, and parents as objects.

NOTE that element of list of revisions has in addition to that also
_effective_ parents in the event of history simplification, for example
for 'history' view, or when using '--first-parent' extra option.

> +=item $commit->authors

s/authors/author/; singular.

> +
> +Return the author string of this commit object.
> +
> +=item $commit->committer
> +
> +Return the committer string of this commit object.

It returns whole value of 'author' and 'committer' headers, not
something extracted from it (into name, email, epoch and timezone),
isn't it?

> +=item $commit->message
> +
> +Return the undecoded commit message of this commit object.

Just raw data?

NOTE that for element of list of revisions (as returned by git-rev-list
or git-log) would probably have commit message decoded to UTF-8 by git.

> +=item $commit->encoding
> +
> +Return the encoding header of the commit object.

Normalized?

> +sub tree {
> +	my $self = shift;
> +	$self->_load;
> +	$self->{_TREE()};
> +}
> +
> +sub parents {
> +	my $self = shift;
> +	$self->_load;
> +	map { ref($self)->new($self->repo, $_) } @{$self->{_PARENTS()}};
> +}

Nice... but shouldn't ->tree return Git::Tree?


> +sub author {
> +	my $self = shift;
> +	$self->_load;
> +	$self->{_AUTHOR()} or '';
> +}
> +
> +sub committer {
> +	my $self = shift;
> +	$self->_load;
> +	$self->{_COMMITTER()} or '';
> +}

Nowhere in documentation is mentioned that you use empty value for no
author or no committer (isn't commit object invalid then?).

> +# Auxiliary method to load (and parse) the commit object from the
> +# repository if it hasn't already been loaded.
> +
> +sub _load {
> +	my($self, $raw_text) = shift;

Probably should read:

+	my ($self, $raw_text) = shift;


> +	return if defined $self->{_MESSAGE()};  # already loaded

Do you ensure that 'message' (or 'body') is always defined?  Why not
use "exists" instead; is there some reason to chose "defined"?

> +	my $sha1 = $self->sha1;
> +	if (!defined $raw_text) {
> +		# Retrieve from the repository.
> +		(my $type, $raw_text) = $self->repo->cat_file($sha1);
> +		die "$sha1 is a $type object (expected a commit object)"
> +		    unless $type eq 'commit';
> +	}

The above makes Git::Commit good solution for gitweb's 'commit' and
'commitdiff' views, but bad solution for 'log', 'shortlog', 'history'
and 'rss'/'atom' views, where you would need to many command
invocations, which is very bad on OS with slow fork.

> +	(my $header, $self->{_MESSAGE()}) = split "\n\n", $raw_text, 2;
> +	# Parse header.

Why not simply parse headers, then slurp rest of object into 'message'
field?  I'm just asking, because it is alternate (but I don't know if
better) solution.

> +	for my $line (split "\n", $header) {
> +		local $/ = "\n"; # for chomp
> +		chomp($line);
> +		my($key, $value) = split ' ', $line, 2;
> +		if ($key eq 'tree') {
> +			$self->{_TREE()} = $value;
> +		} elsif ($key eq 'parent') {
> +			push @{$self->{_PARENTS()}}, $value;
> +		} elsif ($key eq 'author') {
> +			$self->{_AUTHOR()} = $value;
> +		} elsif ($key eq 'committer') {
> +			$self->{_COMMITTER()} = $value;
> +		} elsif ($key eq 'encoding') {
> +			$self->{_ENCODING()} = $value;
> +		} else {
> +			die "unrecognized commit header $key";
> +		}

IMHO you should not die at unrecognized header, but simply store it
under its name (and make available using ->header('<NAME>')).  Please
remember that commit object format is extensible.

Nevertheless I think you can check for header name validation (there
are some restrictions on header names, isn't it?).

> +=head1 NOTES
> +
> +You will usually want to call $repo->get_commit($sha1) instead of
> +instantiating this class directly; see L<Git::Repo>.
> +
> +=cut

Ahhh, O.K.

Why not $repo->commit($sha1)?


> diff --git a/perl/Git/Object.pm b/perl/Git/Object.pm
> new file mode 100644
> index 0000000..a5126f9
> --- /dev/null
> +++ b/perl/Git/Object.pm
> @@ -0,0 +1,81 @@
> +=head1 NAME
> +
> +Git::Object - Object-oriented interface to Git objects (base class).
> +
> +=head1 DESCRIPTION
> +
> +Git::Object is a base class that provides access to commit, tag and
> +(unimplemented) tree objects.  See L<Git::Commit> and L<Git::Tag>.

Is it base class which represents types of objects in git repository:
commits, tags, trees and blobs?  Or just a class which represent
headers+payload objects, i.e. commits and tags?

> +Objects are loaded lazily, and hence instantiation is free.  Objects
> +stringify to their SHA1s.

This should probably be repeated in documentation for Git::Commit and
Git::Tree (possibly linking to Git::Object(3pm) manpage), to be more
self sufficient.

> +use overload
> +    '""' => \&stringify;

Nice.

> +# Hash indices:
> +use constant _REPO => 'R';
> +use constant _SHA1 => 'H';

Again: Is it necessary?

> +=head1 METHODS
> +=item Git::Object->new($repo, $sha1)
> +=item $obj->repo
> +=item $obj->sha1

Why those methods are IIRC repeated in Git::Commit, instead of being
inherited?

I wonder if Git::Object should provide $obj->id alias to $obj->sha1...


> diff --git a/perl/Git/Repo.pm b/perl/Git/Repo.pm
> new file mode 100644
> index 0000000..5a4c7e0

> +use strict;
> +use warnings;
> +use 5.006002;

Why is this "use 5.006002" for?

By the way here you (correctly) intersperse code and its documentation,
contrary to some other files in this patch.

> +our @EXPORT = qw();
> +our @EXPORT_OK = qw(assert_sha1 assert_opts);
> +
> +# Auxiliary subroutines
> +
> +sub assert_opts {
> +	die "must have an even number of arguments for named options"
> +	    unless $#_ % 2;
> +}
> +
> +sub assert_sha1 {
> +	my $sha1 = shift;
> +	die "'$sha1' is not a SHA1 (need to use get_sha1?)"
> +	    unless $sha1 && $sha1 =~ /^[a-f0-9]{40}$/;
> +}

Hmmm... exporting auxiliary subroutines?

> +=item $repo = Git::Repo->new(%opts)
> +
> +Return a new Git::Repo object.  The following options are supported:
> +
> +=over
> +
> +=item 'directory'
> +
> +The directory of the repository (mandatory).
> +
> +Note that this option is working-copy agnostic; you need to
> +instantiate it with the working copy's .git directory as the
> +'directory' option.

Wouldn't it be better to allow the same discovery of '.git' directory
as other git command do, and leave 'git_dir' to set directly path to
repository itself?

> +=item 'git_binary'
> +
> +The name or full path of the git binary (default: 'git').

Probably should be Git::Cmd or Git object, instead.  Well,
'git_binary' could set this up indirectly, though...

> +
> +=back
> +
> +Calling this method is free, since it does not check whether the
> +repository exists.  Trying to access the repository through one of the
> +instance methods will fail if it doesn't exist though.

> +sub new {
> +	my $class = shift;
> +	assert_opts(@_);
> +	my $self = {@_};
> +	bless $self, $class;
> +	die 'no directory given' unless $self->{directory};
> +	return $self;
> +}

Not even rudimentary check: if directory exists, if it looks like
git repository?

> +
> +=item $repo->repo_dir
> +
> +Return the directory of the repository (.../.git in case of a working
> +copy).

I think $repo->git_dir (perhaps in addition to above) would be better
name, as it is already established among git commands.

> +=item $repo->version
> +
> +Return the output of 'git --version', with /^git version / stripped.
> +
> +This method does not require the repository to exist.
> +
> +=cut
> +
> +sub version{
> +	my $self = shift;
> +	chomp(my $version = $self->cmd_output(cmd => ['--version']));
> +	$version =~ s/^git version //;  # be permissive if this does not match
> +	return $version;
> +}

We could rely instead on embedded (during build) version string...
or leave _that_ to $Git::Repo::VERSION / $Git::VERSION.

> +=back
> +
> +=head2 Calling the Git binary
> +
> +=over
> +
> +=item $repo->cmd_output(%opts)

Please do remember that there are git commands which do not need
access to git repository, for example git-ls-remote, git-clone,
git-init, even git-config.  So tying calling Git binary to
_repository_ instance is a bad API; as a convenience (adding
'--git-dir=<path to repo>' automatically) it is a good idea.

> +Return the output of the given git command as a string, or as a list
> +of lines in array context.  Valid options are:
> +
> +=over
> +
> +=item 'cmd'
> +
> +An arrayref of arguments to pass to git (mandatory).
> +
> +=item 'max_exit_code'
> +
> +Die if the exit code of the git binary is greater than
> +C<max_exit_code> (default: 0).
> +
> +=back
> +
> +Example:
> +
> +    $output = $repo->cmd_output(cmd => ['show', 'HEAD'])
> +

I think it would be easier on users if you provide two ways of calling
this command: simple and advanced (see for example CGI methods):

	$output = $repo->cmd_output('show', 'HEAD');

or

	$output = $repo->cmd_output(['show', 'HEAD'],
	                            max_exit_code=>undef);

(which I think should mean: do not die if git command dies).

> +=cut
> +
> +# To do: According to Git.pm, this might not work with ActiveState
> +# Perl on Win 32.  Need to check or wait for reports.

Why not copy code from Git.pm, then?


> +=item $repo->get_bidi_pipe(%opts)
> +
> +Open a new bidirectional pipe and return its STDIN and STDOUT file
> +handles.  Valid options are:

What about returning context, as it was done in Git.pm?

> +
> +=over
> +
> +=item 'cmd'
> +
> +An arrayref of arguments to pass to git (mandatory).

Same comment as for cmd_output.

> +=item 'reuse'
> +
> +If true, reuse a previously opened pipe with the same command line and
> +whose C<reuse> option was true (default: false).

What is this for?  Can you show example usage of this feature?  Or is
it a bit of overengineering, perhaps?

You didn't provide equivalents for the rest of command related methods
from Git.pm, even as simple wrappers around other methods: 
command_oneline, command_output_pipe, command_input_pipe; you do error
management in different way, so I think you don't need command.*close
methods (note that most of errors, beside not finding git binary and
such, are found on close, not on open).

> +=back
> +
> +=head2 Inspecting the Repository
> +
> +=over
> +
> +=item $repo->get_sha1($extended_object_identifier)
> +
> +Look up the object identified by $extended_object_identifier and
> +return its SHA1 hash in scalar context or its ($sha1, $type, $size) in
> +list context, or undef or () if the lookup failed, where $type is one
> +of 'tag', 'commit', 'tree', or 'blob'.
> +
> +See L<git-rev-parse(1)>, section "Specifying Revisions", for the
> +syntax of the $extended_object_identifier string.
> +
> +Note that even if you pass a SHA1 hash, its existence is still
> +checked, and this method returns undef or () if it doesn't exist in
> +the repository.

I think I'd rather allow extended SHA1 syntax in Git::Commit
and Git::Tag constructors; it is one call to git command less
(I think).

Nevertheless providing equivalent of git-rev-parse (the --revs part)
is, I think, a good idea.

> +=cut
> +
> +sub get_sha1 {
> +	my ($self, $object_id) = @_;
> +	die 'no object identifier given' unless $object_id;
> +	die 'object identifier must not contain newlines' if $object_id =~ /\n/;
> +	my ($in, $out) = $self->get_bidi_pipe(
> +		cmd => ['cat-file','--batch-check'], reuse => 1);

Ahhh... here I can see what 'reuse => 1' means, and when it is useful.
But doesn't it make sense _only_ for _bi-directional pipe_?  Are you
sure that you wouldn't get deadlock?

> +=item $repo->cat_file($sha1)
> +
> +Return the ($type, $content) of the object identified by $sha1, or die
> +if no such object exists in the repository.
> +
> +Note that you may want to use the higher-level methods get_commit and
> +get_tag instead.

Shouldn't it be $repo->get_object($sha1) instead?  You don't need to
repeat strange choice of git-cat-file name of command in git, which
is "hysterical raisin"

> +=cut
> +
> +# Possible to-do items: Add optional $file_handle parameter.  Guard
> +# against getting huge blobs back when we don't expect it (for
> +# instance, we could limit the size and send SIGPIPE to git if we get
> +# a blob that is too large).

If I remember correctly you do implement something like that (streamed
output) in gitweb patch.

> +=item $repo->get_commit($commit_sha1)
> +=item $repo->get_tag($tag_sha1)
> +
> +Return a new L<Git::Tag> instance referring to the tag object with SHA1
> +$tag_sha1.

Probably should mention lazy evaluation, too.

By the way, for gitweb you would need (for performance and for
rewritten parents) also get_log / get_commits / get_commits_list

> +=item $repo->get_path($tree_sha1, $file_sha1)
> +
> +Return the path of the tree or blob identified by $file_sha1 in the
> +tree identified by $tree_sha1, or undef if the tree or blob does not
> +exist in the given tree.

Note that it is *not* evaluated lazily.  Probably should go thru
Git::Tree when it gets implemented.

> +sub get_path {
> +	my ($self, $tree, $file_sha1) = @_;
> +	assert_sha1($tree, $file_sha1);
> +	my @lines = split "\n", $self->cmd_output(cmd => ['ls-tree', '-r', '-t', $tree]);
> +	for (@lines) {
> +		if (/^[0-9]+ [a-z]+ $file_sha1\t(.+)$/) {
> +			return $1;
> +		}
> +	}
> +	return undef;
> +}

You would have troubles with filename quoting!  (Probably should be
an option to get_path to get unquoted vs quoted filename).

> +=item $repo->get_refs
> +
> +=item $repo->get_refs($pattern)
> +
> +Return an arrayref of [$sha1, $object_type, $ref_name] triples.  If
> +$pattern is given, only refs matching the pattern are returned; see
> +L<git-for-each-ref(1)> for details.

> +sub get_refs {
> +	my ($self, $pattern) = @_;
> +
> +	return [ map [ split ], split("\n", $self->cmd_output(
> +			 cmd => [ 'for-each-ref',
> +				  defined $pattern ? $pattern : () ])) ];
> +}

I think you would need more complete interface to git-for-each-ref
and/or git-show-refs.

By the way, why split("\n", ...) instead of ensuring $\ = "\n" and
(en)forcing list context?


> +=item $repo->name_rev($committish_sha1, $tags_only = 0)
> +
> +Return a symbolic name for the commit identified by $committish_sha1,
> +or undef if no name can be found; see L<git-name-rev(1)> for details.
> +If $tags_only is true, no branch names are used to name the commit.

Why name_rev, and no describe?


> diff --git a/perl/Git/RepoRoot.pm b/perl/Git/RepoRoot.pm
> new file mode 100644
> index 0000000..12e1836
> --- /dev/null
> +++ b/perl/Git/RepoRoot.pm
> @@ -0,0 +1,103 @@
> +=head1 NAME
> +
> +Git::RepoRoot - A factory class representing a root directory
> +containing Git repositories.
> +
> +=head1 DESCRIPTION
> +
> +Git::RepoRoot is a factory class to create L<Git::Repo> instances that
> +are located under a common root directory.  It also allows for
> +specifying options that all Git::Repo instances will be created with.
> +
> +Using Git::RepoRoot to create Git::Repo instances is entirely
> +optional, but can be more convenient than instantiating them directly.

Nice.  Does Git::RepoRoot provides way to scan for repositories under
commin $projectroot?

> +=over
> +
> +=item 'directory'
> +
> +The directory holding all repositories.

Probably should be named 'root', or 'reporoot', or something...

> +Example:
> +
> +    $repo_root = Git::RepoRoot->new(directory => '/pub/git',
> +                                    git_binary => '/usr/bin/git'q);
                                                                   ^
It looks like typo ------------------------------------------------|

> diff --git a/perl/Git/Tag.pm b/perl/Git/Tag.pm
> new file mode 100644
> index 0000000..4e0549b

> +use constant _MESSAGE => 'M';
> +use constant _ENCODING => 'E';
> +use constant _TAGGER => 'A';
> +use constant _TAG => 'T';
> +use constant _TYPE => 'Y';
> +use constant _OBJECT => 'O';

Again.


> +# Keep documentation in one place to save space.

Again.

Tag object format is meant to be extensible; for example (unfortunately
abandoned) git-notes implementation added 'keyword' (IIRC) header to
tag object format.

> +=item $tag->tagger
> +
> +Return the tagger string of this tag object.

We would probably want some way to extract name, email, epoch/date
(and a way to convert epoch+timezone to RFC or ISO format), timezone.

> +=item $tag->message
> +=item $tag->encoding
> +
> +Return the encoding header of the tag object.

Does tag provide 'encoding' header?

Should (for completeness) Git::Tag provide $tag->validate() method?

> +=head1 NOTES
> +
> +You will usually want to call $repo->get_tag($sha1) instead of
> +instantiating this class directly; see L<Git::Repo>.

Good, although this could be put in description of new() instead...

> diff --git a/t/t9710/test.pl b/t/t9710/test.pl
> new file mode 100755
> index 0000000..188abba
> --- /dev/null
> +++ b/t/t9710/test.pl
> @@ -0,0 +1,165 @@
> +#!/usr/bin/perl
> +use lib (split(/:/, $ENV{GITPERLLIB}));
> +
> +use warnings;
> +use strict;
> +
> +use Test::More qw(no_plan);

> +use Test::Exception;
> +use Carp::Always;

Are those necessary?  If yes, shouldn't they be checked before running
this test script?

> +our $old_stderr;
> +sub discard_stderr {
> +	open our $old_stderr, ">&", STDERR or die "cannot save STDERR";
> +	close STDERR;
> +}
> +sub restore_stderr {
> +	open STDERR, ">&", $old_stderr or die "cannot restore STDERR";
> +}

Nice.

[I haven't examined test in detail].
-- 
Jakub Narebski
Poland
