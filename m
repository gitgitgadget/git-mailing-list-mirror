From: Steven Michalske <smichalske@gmail.com>
Subject: Re: SVN Branch Description Format
Date: Sun, 18 Mar 2012 16:18:03 -0700
Message-ID: <7B2F5CA7-F2C1-483A-9913-B19A14AA9101@gmail.com>
References: <4F5C85A3.4080806@pileofstuff.org>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:18:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9PMd-0003PK-Va
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 00:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab2CRXSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 19:18:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59737 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756930Ab2CRXSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2012 19:18:07 -0400
Received: by dajr28 with SMTP id r28so8991606daj.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 16:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=ACPeMQFcaMFQhsJyZ8o8lEHiIHKDKtICl5GxZo4jzto=;
        b=D8nU05vUukFSV4AOOR1rj6UnIrBEHnMhMzOdjHZ4opbFfpXnNbG74DdvQr74cJ+C3f
         3ngQmbRKyj3YkMcqcgQIxvQhxNG45EOALRvFDuWxr44tYxurlkYDxRgoaPhGrEbv44Ms
         KafeWLCw2/BcybzQ2ucLfKt0/XBaIL7or4ZHwPJt80PMtc5bO/VjYbv+F26m1qbX/LzL
         Lnc6lz9z/9XLQMHHCcZxUY2Kix/HJN/cg+fjqbG1XC0BAZbOe5ddibJntid4hZ8wZrov
         D45OsaXQZysqFzkgs1awbzfSBYmCliK2eAb3mRJkchu7qeloBzFuk7tSb8zZ+MMVabVu
         VH2w==
Received: by 10.68.74.197 with SMTP id w5mr34406402pbv.129.1332112687045;
        Sun, 18 Mar 2012 16:18:07 -0700 (PDT)
Received: from [192.168.1.114] (c-67-161-24-30.hsd1.ca.comcast.net. [67.161.24.30])
        by mx.google.com with ESMTPS id u10sm9825367pbf.37.2012.03.18.16.18.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 16:18:06 -0700 (PDT)
In-Reply-To: <4F5C85A3.4080806@pileofstuff.org>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193395>

Consider .SVN_BDF or .SVN.BDF instead of .BDF

I worry about a branch or tag containing a "
Can subversion contain a "?

Steve
On Mar 11, 2012, at 3:59 AM, Andrew Sayers wrote:

> (CCing everyone from the "Approaches to SVN to Git conversion" thread)
> 
> A recent discussion of the remote helper for Subversion turned into a plan for
> separating out revision->commit mapper projects.  Just as content import is
> split into three parts (svn-fe, fast-import protocol, git-fast-import), r2c
> mapping can be split into SVN export, protocol, and git import.  I've included
> an initial draft protocol below.
> 
> My approximate roadmap from here is to add test cases and a reference
> implementation to the protocol, then create an SVN exporter from my existing
> proof-of-concept, then finally write a git importer.  My proof-of-concept work
> is at https://github.com/andrew-sayers/Proof-of-concept-History-Converter
> 
> All comments gladly welcomed, but I would particularly appreciate suggestions
> about how to specify the format more clearly, example SVN use cases that can't
> be readily expressed with the language as specified, and suggestions about
> whether forward compatibility should be built in.
> 
> 	- Andrew
> 
> 
> SVN Branch Description Format v0.1
> ==================================
> Andrew Sayers <andrew-svn@pileofstuff.org>
> 
> This file specifies a simple format for describing how SVN revisions
> apply to branches.  The goals of this format are to be a communication
> protocol for programs operating on SVN history and to provide a common
> language for developers discussing unusual SVN use cases.
> 
> Overview
> --------
> 
> The SVN Branch Description Format (``BDF'') is a line-based ASCII
> format, where each line specifies one action in the SVN history.  An
> SVN history file contains two sections: the first is the ``header''
> section that provides information about the file as a whole, the
> second is the ``body'' section that provides information about things
> that happened in specific revisions.
> 
> Any line in a BDF file that begins with a hash or semicolon character,
> or that contains only whitespace (including empty lines) is considered
> to be a comment, and must be ignored.  Clients should use a leading
> '#' to create ordinary comments to be read by users, and a leading ';'
> for commented-out actions the client wishes to suggest to a user.
> This makes it easier for a user to accept/reject actions by
> search-and-replace.
> 
> Here is an example file:
> 
>    # the file must begin by specifying the revision of the format being used:
>    This is a version 0.1 SVN Branch Description file
>    Body:
>    In r1, create branch "trunk"
>    In r10, create branch "branches/1.0" from "trunk" r9
>    In r20, create tag "tags/version_1" from "branches/1.0" r19
>    In r20, deactivate "tags/version_1"
>    # User intervention is required to confirm this action:
>    ; In r25, merge "trunk" r24 into "branches/1.0"
> 
> Header section
> --------------
> 
> The header section begins with a version identifier, continues with
> any number of private actions, and ends with the header-body boundary
> marker.
> 
> Any unrecognised action in the header should be treated as a fatal
> error.
> 
> Version identifier
> ~~~~~~~~~~~~~~~~~~
> 
> The first action in this section must exactly match the following:
> 
>    This is a version 0.1 SVN Branch Description file
> 
> Later versions of the format will use a different identifier here.
> This might be another number (e.g. ``version 3''), a non-numeric
> identifier (e.g. ``experimental version''), a different format name
> (e.g. ``SVN-BDF file''), or anything else.  Clients should treat anything
> other than the exact string above as a fatal error.
> 
> Private actions
> ~~~~~~~~~~~~~~~
> 
> Private actions begin with an open bracket and end with a close
> bracket.  For example:
> 
>    (my-great-parser will write debugging information to "debug.log")
> 
> These actions are intended for internal use by clients using BDF as a
> storage format.  Clients must begin any private action they create
> with a client-specific identifier (`my-great-parser` in the above
> example), and must ignore any private action that does not begin with
> their identifier.  These requirements are designed to ensure that
> clients do not use private actions to communicate with other clients -
> please send such messages out-of-band (e.g. through arguments to a
> command-line program), or propose a revision to the format so that all
> clients can communicate using a standard language.
> 
> Header-body boundary marker
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The last action in this section must exactly match the following:
> 
>    Body:
> 
> This serves only to indicate that the header is finishing, and the
> body beginning.  The remainder of the file must be treated as the body
> section.
> 
> Body section
> ------------
> 
> The body section contains zero or more actions as described below.
> The following components are widely used in these actions:
> 
> Revision identifiers::
>  These strings begin with the letter `r`, followed by a number in the
>  range 1-9, then zero or more numbers in the range 0-9.  So `r1`,
>  `r10` and `r999` are valid revision identifiers, but `1`, `r01` and
>  `revision 999` are not.  Revision identifiers are indicated with
>  `<revision>` in the definition of an action.
> 
> String identifiers::
> 
>  These strings begin with a double quote, then contain zero or more
>  valid characters, then another double quote.  Valid characters
>  include a backslash followed by `\`, `r`, `n`, or `"`, or any
>  character other than backslash, carriage return, newline, or double
>  quote.  So `"foo"`, `"foo\""` and `"foo\\"` are valid identifiers,
>  but `"foo\"`, `"foo""` and `"foo\t"` are not.  Clients must unescape
>  string identifiers by converting `\"`, `\\`, `\r` and `\n` to double
>  quote, backslash, carriage return and newline respectively.  String
>  identifiers are indicated with `<string>` in the definition of an
>  action.
> 
> These are the valid actions in the body section:
> 
>    In <revision>, create branch <string>
>    In <revision>, create branch <string> as <string>
>    In <revision>, create branch <string> from <string> <revision>
>    In <revision>, create branch <string> as <string> from <string> <revision>
> 
>    In <revision>, create tag <string>
>    In <revision>, create tag <string> as <string>
>    In <revision>, create tag <string> from <string> <revision>
>    In <revision>, create tag <string> as <string> from <string> <revision>
> 
>    In <revision>, deactivate <string>
>    In <revision>, delete <string>
> 
>    In <revision>, merge <string> up to <revision> into <string>
>    In <revision>, cherry-pick <string> <revision> into <string>
>    In <revision>, cherry-pick <string> <revision> to <revision> into <string>
>    In <revision>, revert <string> <revision> from <string>
>    In <revision>, revert <string> <revision> to <revision> from <string>
> 
>    In <revision>, ignore <string>
>    In <revision>, amend <string>, keeping the old log message
>    In <revision>, amend <string>, keeping the new log message
>    In <revision>, amend <string>, keeping both log messages
> 
> All actions begin with `In <revision>,`.  This identifies the revision
> the action applies to.  Each action must refer to a revision greater
> than or equal to the previous action, except the first action which
> must be greater than or equal to revision 1.  Clients should treat
> revision numbers that are too low as fatal errors.  Clients may treat
> revision numbers as errors if they are not present in the repository
> (i.e. higher than the maximum revision or not part of the
> sub-repository being examined)
> 
> Create actions
> ~~~~~~~~~~~~~~
> 
> The `create branch` and `create tag` actions identify a branch or tag
> being created in the specified revision.  The first string identifier
> indicates the SVN directory name associated with the branch.  The `as
> <string>` identifier indicates the name the user intended for the
> branch or tag (if unspecified, clients should assume the user intended
> the branch to have the same name as the directory).  The `from
> <string> <revision>` identifiers indicate the directory associated
> with a previously-named branch, and the revision number used as the
> parent for this branch or tag (if unspecified, clients should assume
> the user intended this to be a trunk).  Here are some examples:
> 
>    # Create a trunk branch named "trunk" from directory "trunk":
>    In r1, create branch "trunk"
> 
>    # Create a branch named "branches/foo" from directory "branches/foo",
>    # whose parent is the directory "trunk" as it was in revision 5:
>    In r10, create branch "branches/foo" as "foo" from "trunk" r5
> 
>    # Create a tag named "1.0" from directory "tags/1.0",
>    # whose parent is the directory "branches/foo" as it was in revision 15:
>    In r20, create tag "tags/1.0" as "1.0" from "branches/foo" r15
> 
> Clients should treat it as a fatal error if the `from` revision is
> greater than the current revision, or if the `from` branch was not
> active in the specified revision (i.e. it hadn't been created, had
> been deactivated or had been deleted).
> 
> If the `from` branch was active but not changed in the specified
> revision, clients should behave as if the user specified the last
> revision in which the branch was edited prior to the specified
> revision.  If the `from` revision is equal to the current revision,
> clients should warn the user if the `from` branch was edited in that
> revision.  These requirements make it significantly easier for users
> to manually edit a BDF file.
> 
> Clients should treat it as a fatal error if the name specified for a
> branch or tag is currently in use.  A name is currently in use if it
> was previously declared with one of the `create` actions, and has not
> yet been deleted with the `delete` action (the `deactivate` action
> must not be treated as removing a branch name).  Clients that check
> for names currently in use must treat branch and tag names to be in
> different namespaces - in other words, it is legal to have a branch
> named `foo` at the same time as a tag named `foo`.
> 
> Delete actions
> ~~~~~~~~~~~~~~
> 
> The `deactivate` and `delete` actions identify a branch or tag that
> should no longer be considered active.  The string identifier
> indicates the directory name associated with the branch.
> 
> The `deactivate` action indicates that a branch or tag is still of
> historical interest, but should no longer be updated when changes are
> made.  For example, a tag might be deactivated after it is created, to
> indicate that the tag should be considered immutable even though
> changes were accidentally made later on.
> 
> The `delete` action indicates that a branch or tag is no longer of any
> interest, and can be ignored completely.  For example, a branch might
> be deleted if it had been fully merged into another branch before the
> directory was removed.
> 
> Merge actions
> ~~~~~~~~~~~~~
> 
> The `merge`, `cherry-pick` and `revert` actions identify changes in
> the relationship between two branches.  The first string identifier
> indicates the directory name for the action's source.  The last string
> identifier indicates the directory name for the action's destination.
> The revision identifier(s) indicates the revision(s) for the action's
> source.
> 
> The `merge` action indicates that all revisions up to the specified
> point have been applied from the source to the destination.  The
> `cherry-pick` and `revert` actions identify an inclusive set of
> revisions that have been applied from the source to the destination.  The
> `merge` and `cherry-pick` actions indicate that revisions that
> previously had not been merged now have been merged.  The `revert`
> action indicates that revisions which had previously been merged have
> no longer been merged.
> 
> If two revisions were specified, clients must treat it as a fatal
> error if the second revision is less than or equal to the first.
> 
> Clients must treat it as a fatal error if the `from` branch was not
> active in the specified revision.  If two revisions are specified,
> clients must treat it as a fatal error unless the `from` branch was
> active in both revisions.
> 
> For the `merge` action, if the `from` branch was active but not
> changed in the specified revision, clients must behave as if the user
> specified the highest revision before the specified revision in which
> the branch was changed.  If the `from` revision is equal to the
> current revision, clients should warn the user if the from branch was
> changed in that revision.
> 
> For the two-revision `revert` and `cherry-pick` actions, clients must
> treat the second revision as in the previous paragraph.  If the branch
> was not changed in the first revision, clients must behave as if the
> user specified the lowest revision after the specified revision in
> which the branch was changed.
> 
> For all `revert` and `cherry-pick` actions, clients must treat it as a
> fatal error if no revisions in the specified range changed the branch.
> 
> Note: the above requirements for altering revision numbers make it
> significantly easier for users to manually edit an SVN Branch
> Description file.
> 
> If a `merge` action specifies a revision less than or equal to any
> earlier merge action that has not been reverted, clients must treat it
> as a fatal error.  Clients should not treat it as an error if the
> merge includes revisions that have previously been cherry-picked.
> 
> If a `cherry-pick` action includes the first revision in which the
> branch was changed after any earlier merge action, or if the
> destination branch was originally created from the source branch and
> the `cherry-pick` action includes the next revision in which the
> branch was changed, clients should warn the user that they probably
> meant to merge.
> 
> If a `revert` action specifies a revision that has not been
> cherry-picked, or is greater than any earlier merge action that has
> not been reverted, clients should treat it as a fatal error.
> 
> Clients may warn about any merge actions they feel are unusual, but
> should not treat anything as a fatal error unless specified above.
> 
> Note: there is no `unmerge` action.  See the `merge` examples in the
> library for how unmerging is achieved.
> 
> Edit actions
> ~~~~~~~~~~~~
> 
> The `ignore` and `amend` actions identify a directory and revision
> which should not create a new revision in the history.  For example,
> an accidental `svn commit` followed immediately by an `svn commit`
> reverting it might simply be ignored.  The string identifier indicates
> the name of the directory to be edited.
> 
> The `ignore` action indicates that the client must act as if no
> changes were made to the directory in the specified revision, whether
> or not changes were actually made.  Note that this only includes
> changes made in the SVN repository itself, not those indicated by
> actions in the SVN history file.
> 
> The `amend` actions indicate that the state of the branch in the
> current revision should overwrite the most recent revision for that
> branch.  Clients may warn, but should not treat it as a fatal error,
> if the branch was not actually changed in the current revision.  When
> overwriting the most recent revision, clients must retain the revision
> log from the previous revison if the action specifies `keeping the old
> log message`, replace the revision log entirely with the log message
> for the current revision if the action specifies `keeping the new log
> message`, or concatenate the new log message to the end of the old one
> if the action specifies `keeping both log messages`.  Clients may
> reformat log messages when keeping both, but are reminded of the need
> for messages to look sensible when long chains of amendments are
> created.
> 
> Clients should treat it as a fatal error if an edit action is applied
> to a branch in the same revision as the branch is created.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
