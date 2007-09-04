From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 20:44:49 +0100
Message-ID: <3f4fd2640709041244s125f5988j1c2d28f06bfbe098@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
	 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
	 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
	 <20070904180429.GA626@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Mike Hommey" <mh@glandium.org>, "Jon Smirl" <jonsmirl@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:45:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISeKZ-0000z1-7o
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 21:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbXIDTov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 15:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754404AbXIDTov
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 15:44:51 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:63669 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbXIDTou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 15:44:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1256993rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 12:44:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ea6Dxoi15Gbb0806ogADBfVX2KuM0M6B5dhifdkS2A3TeSLc25AAaKUoftcqORemIsDKNdvo5o3phnxWNLeLIc3Cyk3BJT65g5ZOHE4AJDaA4CkhYATXIf9sTxlktw1LpxVnC6iNulOW3KGwd1URF1KZaV0Y7Slu3/FLf2+ogCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VUMbxmtZNtoBWzWE2El6yw5Yq/4E8PsIk3mo98KvAkiJ3NxOnR7q8rRPXgoY0inFKUtiw2l1BDAvRr9+IaoEov88mSCe51OGjQ6W4ADNJlbYLP9SJrlRcUZnaOKinIRhKqJ+XUEUd/VMWB5BEJmYsXh6AJKIB6HCRhtxPKymQ90=
Received: by 10.141.160.9 with SMTP id m9mr2434924rvo.1188935089324;
        Tue, 04 Sep 2007 12:44:49 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Tue, 4 Sep 2007 12:44:49 -0700 (PDT)
In-Reply-To: <20070904180429.GA626@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57636>

On 04/09/07, Mike Hommey <mh@glandium.org> wrote:
> On Tue, Sep 04, 2007 at 01:44:47PM -0400, Jon Smirl <jonsmirl@gmail.com> wrote:
> > The reason databases don't encode the fields into the index is that
> > you can only have a single index on the table if you do that.
> > Databases do sometimes duplicate the field in both the index and the
> > table. Databases also have the property that indexes are just a cache
> > and can be dropped at any time.
>
> The big difference between a database and git is that a database is a
> general purpose tool. git has a much more restricted scope. As such, it
> doesn't need *that much* flexibility.

Databases are designed to be efficient at storing and accessing large
amounts of data. The key thing about a database is that it does not
track the *history* of the data it is storing. This is the main
problem with using a database as a metadata storage facility.

Modern source control systems such as Perforce (and possibly
Subversion), use a database to track metadata such as branch/merge
history, user data and so on. This, IMHO is a huge weakness of these
SCM systems. It is impossible to fully roll back to a given point in
time, because that metadata is stored independently of the file
content tracking.

Git *is not a database*. This is fundamental to understanding how git
works. Git stores *all* of its data in a Directed Acyclic Graph (with
the exception of the pointers to tag and the current head of each
branch, that it stores locally in the .git directory). Read
http://eagain.net/articles/git-for-computer-scientists/ for more
information on this.

What this means is that for any commit, git has all the information it
needs about the repository at that point in time. It doesn't need
anything else. If you then store information in a database, you lose
having the complete picture at any point in the history of the
repository.

- Reece
