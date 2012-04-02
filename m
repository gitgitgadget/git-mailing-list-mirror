From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Mon, 2 Apr 2012 16:30:14 +0530
Message-ID: <CALkWK0nYhfPQrwrrnGP21za6CkryuzfV+ki+WKUdtA1BaLHTsA@mail.gmail.com>
References: <11292500.AVmZFUUvNi@flobuntu> <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
 <2148933.pnpYo0xMAP@flomedio> <2487557.B8qfnaixh3@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner@student.tugraz.at>
X-From: git-owner@vger.kernel.org Mon Apr 02 13:00:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEf05-0005k8-92
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 13:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab2DBLAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 07:00:36 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62754 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab2DBLAg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 07:00:36 -0400
Received: by wibhj6 with SMTP id hj6so2527489wib.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 04:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Y0NKiVMT9e91K/7oO1HXO+C/HIYZdC69iuEp6i3adtM=;
        b=bBU4ooqh5zQVOb7if2FWTeB2g1gMA9k6DN/oNEa/a9DUSEBxlTf2rY9H3qMWwCo8c7
         JU3+w2BXs5V3C9trw26jAMGr5dAQzH5bqur1+PsKzvbaTcXiZRv5VioPorWCih1HfDXA
         0tTfQ3tn5rqtNl/0LsujoR+H1DBATH37c8n3rVPAluMCYhbNMlIXEuPoJO/MshmC6BpJ
         PWFhZaeTpXSXE93LxzCA88PDN7+VViqhlnWRhEBe6EY/iVkssTtOXS3lcrnmLNt8/AKp
         uZ0zZtOEFAWDoCI6iwX8dHf+Zbg7uDKI/R7Zjt6N1miPJxryqKWh8P6GveiobPGQgUV9
         a4NQ==
Received: by 10.180.102.101 with SMTP id fn5mr24024752wib.6.1333364434531;
 Mon, 02 Apr 2012 04:00:34 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Mon, 2 Apr 2012 04:00:14 -0700 (PDT)
In-Reply-To: <2487557.B8qfnaixh3@flomedio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194509>

Hi Florian,

=46lorian Achleitner wrote:
> - svn commits are only possible after updating the working copy first=
, i.e.
> fetching and merging new revisions on the server. This is like implic=
itly
> rebasing your local work on the remote head before pushing to an svn
> repository.

This shouldn't worry you, because we don't have a Git -> SVN converter
yet.  However, I have written a prototype svn-fi.  Unfortunately, due
to the way marks work in fast-import, svn-fi is far from complete.

See: https://github.com/artagnon/git/tree/svn-fi

> Branches exist due to the convention of having branches/, trunk/, and=
 tags/
> directories in a repository, so do tags. But this is not mandatory an=
d
> therefore there are many different layouts. It follows that in svn it=
 is also
> possible to commit across branches. This means that a single commit c=
an change
> files on more than one branch (accidentally or deliberately).
> To convert svn branches to git we have to detect branch semantics by =
examining
> the svn tree's structure and it's metadata (it has a 'copyfrom' prope=
rty).
> Previous efforts show that this will not be possible fully automatica=
lly
> without configuration and interaction with the user.

See also: http://article.gmane.org/gmane.comp.version-control.git/15000=
7

> "esr" developed a tool to manipulate and export subversion repositori=
es [7]
> that should be able to detect branches, but it's sources are not avai=
lable
> yet.

Sources are available at git://gitorious.org/reposurgeon/reposurgeon.gi=
t
Do let us know how SBL compares to reposurgeon.  Personally, I like
the idea of a standard "language" to express the mapping.

> In git's source tree we have a vcs-svn/, a set of functions to conver=
t svn
> dumps to git-fast-import streams. Those are used by svn-fe to one-way=
 import
> svn history to git. svn-fe doesn't do branch mapping yet.

Are you planning to extend svn-fe to do the mapping, write it as a
separate program, or write it into the remote helper? I personally
don't mind if the mapping is done in Perl (like in git-svn or SBL) as
opposed to C; mapping is just parse-intensive.

> 1. Write a new bi-directional remote helper in C.
> [...]
> =C2=A0- It reads a configuration file containing branch mappings acco=
rding to [6].
> These mapping have to be pre-generated using tools developed along wi=
th the
> language. The remote helper has no way of asking the user what to do.=
 It will
> fail if a mapping is unclear.

Right.

> =C2=A0- Because generating the branch mapping configuration already r=
equires that
> you have a dump of the svn repo, the helper should probably be able t=
o read
> from a file in place of svnrdump too.

You can clone the SVN dumpstream from svnrdump using tee (or similar),
sending one copy to svn-fe and another to the SBL configuration
generator.

> =C2=A0- Using the config the helper translates svn branches/tags to g=
it
> branches/tags and converts other metadata as applicable. It probably =
has to
> store some information about the mapping in a file in .git to allow a
> reconstruction on subsequent invocations. I think this is especially =
important
> when pushing to branches (does it already exist in svn, and where? is=
 it new).

How will the actual mapping be done?  Using filter-branch's
subdirectory filter, or something else?

> 3. Add output capabilities to vcs-svn. Currently the code in vcs-svn =
can only
> convert svn to git. To push to svn we also need conversion and mappin=
g from
> git to svn. The actual mapping code for branches should also be place=
d here
> {??} and called by the remote helper.

I think this bit sounds overtly ambitious.  I think if you can build a
seamless one-way SVN -> Git bridge in one summer, it'll be quite an
achievement in itself.  Finishing and getting svn-fi merged should be
last priority; I'll try to work on it myself in summer.

    Ram
