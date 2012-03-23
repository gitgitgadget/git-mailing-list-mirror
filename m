From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: SVN Branching Language (was Re: SVN Branch Description Format)
Date: Fri, 23 Mar 2012 00:08:34 +0000
Message-ID: <4F6BBF02.3000701@pileofstuff.org>
References: <4F5C85A3.4080806@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 01:08:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAs3s-0005HN-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 01:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760276Ab2CWAIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 20:08:44 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:38774 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760272Ab2CWAIj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 20:08:39 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120323000836.BPVA9621.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Fri, 23 Mar 2012 00:08:36 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120323000836.MGWY13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Fri, 23 Mar 2012 00:08:36 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F5C85A3.4080806@pileofstuff.org>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=X4WinW-tUEIA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8 a=TSbVqHtbAAAA:8 a=qOz2pZ_4AAAA:8 a=mV9VRH-2AAAA:8 a=GqZI9gvVAAAA:8 a=jFPv4crRFyjBmFg7uE0A:9 a=ScvdQeRhdAx4GRmkkYYA:7 a=wPNLvfGTeEIA:10 a=gHNH_UPw9HoA:10 a=7qzHkXPk5l4A:10 a=OPhaJYw1eNQorHNb:21 a=E_mW8FtLyIDQEStN:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193737>

This is the second draft of the SVN branching language.  If you're
interested in how SVN revisions map to git commits, please read it and
let me know what you think.  You might also be interested in the
reference implementation and nascent collection of tests[1], although
these wouldn't yet withstand a thorough review.

I plan to pause language work and concentrate on SVN export for a
while now, because it will be easier to e.g. write tests once I have
some code to test.

Here's a little background for people new to the list:

I'm interested in ways to map SVN revisions to git commits, but have
found it surprisingly hard to grasp the problem.  Having trouble
grasping a problem is generally a good sign that your solution is too
small, so I split the problem in three:

1. A language to describe SVN branching and merging
2. A program to export such a file from an SVN repository
3. A program to import such a file into a git repository

This has let me concentrate on manageable parts of the problem.  For
example, Sam Vilain recently pointed out[2] so-called "piecemeal
merges" that split a merge across several revisions.  There's no way I
could have figured out a plan to solve that in one go, but between us
we were able to find a representation and a way of importing it into
git.  I still don't know how to detect and export it from Subversion,
but I can worry about that another day.

This is the second draft I've brought to the git mailing list for
discussion.  The list has a long and proud tradition of including
patches in e-mails so people can review code from their e-mail client,
but in this case the patch would be so large that it's better simply
to include the new text.  I've deliberately left the reference
implementation and tests out of this e-mail because they're not ready
for review.

	- Andrew

[1] https://github.com/andrew-sayers/SVN-Branching-Language
[2] http://article.gmane.org/gmane.comp.version-control.git/192418



SVN Branching Language v0.1
===========================
Andrew Sayers <andrew-sbl@pileofstuff.org>

This file specifies a simple language for describing how SVN revisions
relate to branches.  The goals of this language are to be a
communication protocol for programs operating on SVN history and to
provide a lingua franca for developers discussing unusual SVN use
cases.

Overview
--------

The SVN Branching Language (``SBL'') is a line-based UTF-8 format,
where each line specifies one action in the SVN history.  An SBL file
contains two sections: the first is the ``header'' section that
provides information about the file as a whole, the second is the
``body'' section that provides information about things that happened
in specific revisions.

Any line in an SBL file that begins with a hash or semicolon
character, or that contains only whitespace (including empty lines) is
considered to be a comment, and must be ignored.  Clients should use a
leading '#' to create ordinary comments to be read by users, and a
leading ';' for commented-out actions the client wishes to suggest to
a user.  This makes it easier for a user to accept/reject actions by
search-and-replace.

Here is an example file:

    # the file must begin by specifying the revision of the language being used:
    This is a version 0.1 SVN Branching Language file
    Body:
    In r1, create branch "trunk"
    In r10, create branch "branches/1.0" from "trunk" r9
    In r20, create tag "tags/version_1" from "branches/1.0" r19
    In r20, deactivate "tags/version_1"
    # User intervention is required to confirm this action:
    ; In r25, merge "trunk" up to r24 into "branches/1.0"

Terminology
-----------

The following words should be interpreted as specified below:

Directory::
  A string representing a directory in the SVN tree.  A directory can
  have several flows (i.e. it can be created and deleted multiple
  times), some of which may have names and others not.  The exact
  rules for valid directory names are discussed below, but should be
  as close as possible to the rules for a valid SVN directory name.

Name::
  A string representing a branch or tag.  This is the conventional
  name for a tag as described by users, and is not represented
  anywhere in SVN.  For example, a directory "branches/v1.x/v1.0"
  might have the name "v1.0".  Note that although tags and branches
  are functionally identical, clients must treat tag names and branch
  names as being in different namespaces - for example, a branch name
  "v1.0" and a tag name "v1.0" can both exist at the same time.

Exist::
  A directory is said to exist in a given revision if the directory
  would appear in an `svn ls` command for that revision.  Clients can
  fully implement this language without tracking whether directories
  exist - the term is defined here purely to make discussion easier.

Active::
  A directory is said to be "active" if it its most recent "create"
  action occurred more recently than its most recent "delete" or
  "deactivate" action.  A branch will usually be active if it exists
  and has a name, but there are special cases - for example, an
  existent directory associated with a tag might be deactivated as a
  precautionary measure in case of accidental commits.  Note that only
  directories are said to be "active" - branches and tags are
  instead "accessible" (under a slightly different set of
  circumstances).

Accessible::
  A branch or tag is said to be "accessible" if it has been created
  more recently than it has been deleted (but not deactivated).  Note
  that only branches and tags are said to be "accessible".
  Directories are instead "active" (under a slightly different set of
  circumstances).

Trunk::
  A directory, branch or tag is said to be a "trunk" if it has no
  parent directory, branch or tag.  Trunk tags are possible but
  exceedingly rare.

Header section
--------------

The header section begins with a version identifier, continues with
any number of private actions, and ends with the header-body boundary
marker.

Any unrecognised action in the header should be treated as a fatal
error.

Version identifier
~~~~~~~~~~~~~~~~~~

The first action in this section (not including comments) must exactly
match the following:

    This is a version 0.1 SVN Branching Language file

Later versions of the language will use a different identifier here.
This might be another number (e.g. ``version 3''), a non-numeric
identifier (e.g. ``experimental version''), a different name
(e.g. ``SBL file''), or anything else.  Clients must treat anything
other than the exact string above as a fatal error.

Private actions
~~~~~~~~~~~~~~~

Private actions begin with an open bracket and end with a close
bracket.  For example:

    (my-great-parser will write debugging information to "debug.log")

These actions are intended for internal use by clients using SBL as a
storage format.  Clients must begin any private action they create
with a client-specific identifier followed by a space
(`my-great-parser` in the above example), and must ignore any private
action that does not begin with their identifier.  Client-specific
identifiers must contain one or more characters and must not include
the space, carriage return or newline characters.  These requirements
are designed to ensure that clients do not use private actions to
communicate with other clients - please send such messages out-of-band
(e.g. through arguments to a command-line program), or propose a
revision to the language so that all clients can communicate using a
standard language.

Header-body boundary marker
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The last action in this section must exactly match the following:

    Body:

This serves only to indicate that the header is finishing, and the
body beginning.  The remainder of the file must be treated as the body
section.  Note that this action significantly reduces the complexity
of writing an SBL parser, because clients can use this to switch
between ``header'' and ``body'' parsing modes.

Body section
------------

The body section contains zero or more actions as described below.
Any unrecognised action in the header should be treated as a fatal
error.

The following components are widely used in body actions:

Revision identifiers::
  These strings begin with the letter `r`, followed by a number in the
  range 1-9, then zero or more numbers in the range 0-9.  So `r1`,
  `r10` and `r999` are valid revision identifiers, but `1`, `r01` and
  `revision 999` are not.  Revision identifiers are indicated with
  `<revision>` in the definition of an action.

String identifiers::

  These strings begin with a double quote, then contain zero or more
  valid characters, then another double quote.  Valid characters
  include a backslash followed by `\`, `r`, `n`, or `"`, or any
  character other than backslash, carriage return, newline, double
  quote, or the null character (U+0000).  So `"foo"`, `"foo\""` and
  `"foo\\"` are valid identifiers, but `"foo\"`, `"foo""` and
  `"foo\t"` are not.  Clients must unescape string identifiers by
  removing the leading/trailing quotes and converting `\"`, `\\`, `\r`
  and `\n` to double quote, backslash, carriage return and newline
  respectively.

Directory identifiers::
  These string identifiers indicate a directory.  As well as the
  requirements of a string identifier, valid directory identifiers
  must be valid directories when unescaped.  A valid directory must be
  a sequence of zero or more directory entry names, separated by slash
  characters `/`, and possibly ending with slash characters.  Each
  directory entry name can contain any Unicode character except the
  null character and the slash character `/`. No directory entry may
  be named `.`, `..`, or the empty string.  When unescaping a
  directory, clients must first do the unescaping for a string
  identifier, then convert the identifier to Unicode canonical
  decomposition (NFD) form, then collapse every series of '/'
  characters to a single character (e.g. `foo//bar` should become
  `foo/bar`), and finally remove any trailing `/` character.
  Directory identifiers are indicated with `<directory>` in the
  definition of an action.
  Note that although this definition is based on SVN's own
  documentation, SBL clients must follow the rules above instead of
  the SVN rules in the event of any contradiction between the two.
  SVN's documentation is available from their source repository:
  http://subversion.apache.org/docs/api/latest/group__svn__fs__directories.html#details

Name identifiers::
  These string identifiers indicate a branch or tag name.  As well as
  the requirements for a string identifier, valid name identifiers
  must be valid names when unescaped (see the "terminology" section
  for details).  As well as the rules for string identifers, the empty
  string is not a valid name identifier.

These are the valid actions in the body section:

    In <revision>, create branch <directory>
    In <revision>, create branch <directory> as <name>
    In <revision>, create branch <directory> from <directory> <revision>
    In <revision>, create branch <directory> as <name> from <directory> <revision>

    In <revision>, create tag <directory>
    In <revision>, create tag <directory> as <name>
    In <revision>, create tag <directory> from <directory> <revision>
    In <revision>, create tag <directory> as <name> from <directory> <revision>

    In <revision>, deactivate <directory>
    In <revision>, delete <directory>
    In <revision>, delete branch <name>
    In <revision>, delete tag <name>

    In <revision>, merge <directory> up to <revision> into <directory>
    In <revision>, cherry-pick <directory> <revision> into <directory>
    In <revision>, cherry-pick <directory> <revision> to <revision> into <directory>
    In <revision>, revert <directory> <revision> from <directory>
    In <revision>, revert <directory> <revision> to <revision> from <directory>
    
    In <revision>, ignore <directory>
    In <revision>, amend <directory>, keeping the old log message
    In <revision>, amend <directory>, keeping the new log message
    In <revision>, amend <directory>, keeping both log messages

All actions begin with `In <revision>,`.  This identifies the revision
the action applies to.  Each action must refer to a revision greater
than or equal to the previous action, except the first action which
must be greater than or equal to revision 1.  Clients should treat
revision numbers that are too low as fatal errors.

Create actions
~~~~~~~~~~~~~~

The `create branch` and `create tag` actions identify a directory
being made active and a branch/tag being made accessible in the
specified revision.  The first string identifier indicates the SVN
directory name associated with the branch/tag.  The `as <name>`
identifier indicates the name the user intended for the branch/tag.
If the `as <name>` identifier is not specified, clients must use the
directory name as the identifier, unless the directory name is the
empty string (root directory), in which case they should treat it as a
fatal error (because the empty string is a valid directory but not a
valid name).  The `from <directory> <revision>` identifiers indicate
the directory and revision number to be used as the parent for this
branch/tag (if unspecified, clients should assume the user intended
this to be a trunk).  Here are some examples:

    # Create a trunk branch named "trunk" from directory "trunk":
    In r1, create branch "trunk"

    # Create a branch named "branches/foo" from directory "branches/foo",
    # whose parent is the directory "trunk" as it was in revision 5:
    In r10, create branch "branches/foo" as "foo" from "trunk" r5

    # Create a tag named "1.0" from directory "tags/1.0",
    # whose parent is the directory "branches/foo" as it was in revision 15:
    In r20, create tag "tags/1.0" as "1.0" from "branches/foo" r15

Clients should treat it as a fatal error if the directory was already
active in the current revision.

Clients should treat it as a fatal error if the name was already
accessible in the current revision (remember that branches and tags
must be treated as being in different namespaces).

Clients should treat it as a fatal error if the `from` revision is
greater than the current revision, or if the `from` directory was not
accessible in the specified revision.

If the `from` directory was active but not changed in the specified
revision, clients should behave as if the user specified the last
revision in which the directory was changed prior to the specified
revision.  If the `from` revision is equal to the current revision,
and the `from` directory was changed in the current revision, then
clients should warn the user, but should not treat it as a fatal
error.  These requirements make it significantly easier for users to
manually edit SBL files.

Delete actions
~~~~~~~~~~~~~~

The `deactivate` and `delete` actions identify a name that should
become inaccessible, and/or a directory that should become inactive.
The string identifier indicates the directory or name to be modified.

The `deactivate` action indicates that a directory should become
inactive, but that the associated name should remain accessible.  This
is commonly used for a branch or tag that is still of historical
interest, but should no longer be updated when changes are made.  For
example, a tag might be deactivated after it is created, to indicate
that the tag should be considered immutable even though changes were
accidentally committed to the directory later on.

The `delete` action indicates that a directory should become inactive,
and the associated name should become inaccessible.  This is commonly
used when a branch or tag is no longer of any interest, and can be
ignored completely.  For example, a branch might be deleted if it had
been fully merged into another branch before the directory was
removed.

The `delete branch` and `delete tag` actions indicate that a name
should become inaccessible, and the associated directory should become
inactive if it is still active.  For example, the branch associated
with a deactivated directory might be deleted when the user wants to
create a new branch with the same name.

Clients should only generate `delete branch` and `delete tag` actions
if it would be unsafe to generate a `delete` action because the
directory has already been deactivated, but should expect users
to manually edit files and add any type of action.

Actions that deactivate a directory should treat it as a fatal error
if the directory is not currently active.  This includes the `delete`
action, which behave in ways users would not exect if the directory is
renamed or replaced in SVN before the action occurs.

Actions that make a name inaccessible should treat it as a fatal error
if the name is not currently accessible.

Merge actions
~~~~~~~~~~~~~

The `merge`, `cherry-pick` and `revert` actions identify changes in
the relationship between two directories.  The first string identifier
indicates the directory name for the action's source.  The last string
identifier indicates the directory name for the action's destination.
The revision identifier(s) indicates the revision(s) for the action's
source.

The `merge` action indicates that all revisions up to the specified
point have been applied from the source to the destination.  The
`cherry-pick` and `revert` actions identify an inclusive set of
revisions that have been applied from the source to the destination.
The `merge` and `cherry-pick` actions indicate that revisions that
previously had not been applied now have been applied.  The `revert`
action indicates that revisions which had previously been applied have
no longer been applied.

If two revisions were specified, clients must treat it as a fatal
error if the first revision is greater than the second.

Clients must treat it as a fatal error if the `from` directory was not
active in the specified revision.  If two revisions are specified,
clients must treat it as a fatal error if the `from` directory was
inactive in either revision, or was deactivated after the first
revision and reactivated before the last revision.

For the `merge` action, if the `from` directory was active but not
changed in the specified revision, clients must behave as if the user
specified the highest revision in which the directory was changed
before the revision they actually specified.  If the `from` revision
is equal to the current revision, clients should warn the user if the
from directory was changed in that revision.

For the two-revision `revert` and `cherry-pick` actions, clients must
treat the second revision as in the previous paragraph.  If the from
directory was not changed in the first revision, clients must behave
as if the user specified the lowest revision in which the directory
was changed after the specified revision.

For all `revert` and `cherry-pick` actions, clients must treat it as a
fatal error if no revisions in the specified range changed the
directory.

Note: the above requirements for altering revision numbers make it
significantly easier for users to manually edit an SBL file.

If a `merge` action specifies a revision less than or equal to any
earlier merge action that has not been reverted, clients should treat
it as a fatal error.  Clients should not treat it as a fatal error if
the merge includes revisions that have previously been cherry-picked.

If a `cherry-pick` action includes the first revision in which the
directory was changed after any earlier merge action, or if the
destination directory was originally created from the source directory
and the `cherry-pick` action includes the next revision in which the
directory was changed, clients should warn the user that they probably
meant to merge.

If a `revert` action specifies a revision that has not been
cherry-picked, or is greater than any earlier merge action that has
not been reverted, clients should treat it as a fatal error.

Clients may warn about any merge actions they feel are unusual, but
should not treat anything as a fatal error unless specified above.

Note: there is no `unmerge` action.  See `t/basic/unmerge.sh` for
how unmerging is achieved.

Edit actions
~~~~~~~~~~~~

The `ignore` and `amend` actions identify a directory and revision
which should not create a new revision in the history.  For example,
an accidental `svn commit` followed immediately by an `svn commit`
reverting it might simply be ignored.  The string identifier indicates
the name of the directory to be edited.

The `ignore` action indicates that the client must act as if no
changes were made to the directory in the specified revision, whether
or not changes were actually made.  Note that this only includes
changes made in the SVN repository itself, not those indicated by
actions in the SBL file.

The `amend` actions indicate that the state of the directory in the
current revision should overwrite the most recent revision for that
directory.  When overwriting the most recent revision, clients must
retain the revision log from the previous revision if the action
specifies `keeping the old log message`, replace the revision log
entirely with the log message for the current revision if the action
specifies `keeping the new log message`, or concatenate the new log
message to the end of the old one if the action specifies `keeping
both log messages`.  Clients may reformat log messages when keeping
both, but are reminded of the need for messages to look sensible when
long chains of amendments are created.

Clients may warn, but should not treat it as a fatal error, if an edit
action is specified for a directory that was not changed in the
current revision.

Clients should treat it as a fatal error if an edit action is applied
to a directory in the same revision as the directory becomes active.

Limitations
-----------

SBL only allows a directory to be associated with a maximum of one
branch or one tag at once.  There is no clear use case for allowing a
user to e.g. associate a tag with a directory that is already a
branch, and disallowing it enables better detection of user errors.
Future versions of this language might allow multiple branches/tags
per directory if a use case is found.

Although not explicitly forbidden, clients are not required to support
recursive branches.  For example, if ``trunk'' is a branch, clients
may assume that ``trunk/foo'' is neither a branch nor a tag.

See `t/advanced/subproject_branch.sh` for a common edge case for
parsers that disallow recursive branches.

License
-------

SVN Branching Language by Andrew Sayers <andrew-sbl@pileofstuff.org>
is licensed under a Creative Commons Attribution 3.0 Unported License.

The full license is available here: http://creativecommons.org/licenses/by/3.0/legalcode
A human-readable summary is available here: http://creativecommons.org/licenses/by/3.0/

The following explanation must have no bearing on the meaning of the
above license:

My primary goal in drafting this language was to provide a single
format that everyone could use to describe the behaviour of SVN
repositories.  I felt this goal was best served by allowing commercial
use of the language, and by allowing other dialects to be formed but
discouraged because of the network effect of a common language.
