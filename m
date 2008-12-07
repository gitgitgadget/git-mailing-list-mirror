From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Sun, 7 Dec 2008 15:30:28 -0500
Message-ID: <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com>
References: <493A6CEC.4060601@tuffmail.com>
	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>
	 <493C1F36.7050504@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Grzegorz Kossakowski" <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 21:31:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9QI8-0003oP-MJ
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 21:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYLGUab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 15:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYLGUab
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 15:30:31 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:54365 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYLGUaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 15:30:30 -0500
Received: by yx-out-2324.google.com with SMTP id 8so344369yxm.1
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=flZtBE8VjVVEZ09TF9MTLtnNLd39Pu08HVlupQC/gtc=;
        b=juUqsEaBH0bZ2fgK5Nx5WWM3JaPZPSVPk9lEOndzmy71vb8dqR8UFt1ForYfMNsdTV
         chBtF0MUCh+cpWxPc+BTHivKkbnO8WJxfjkxRtkSQedZY3aFxbsflJvPi3nYruP7U191
         5cQKqb9RdJ2WtzKwjoHp6xV4iIjgiUyfWGQ2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=cvw02Z7DDzduP/Mm/rvJiMqpiDa06zylyaXwACpEu0Vv3WWpgjTbaxticsE41iO4mC
         fyyEwwcQF5ewcX9d+7MnDeWeKePqILJklQsilCVMm1XNe0A0BpDNAUD4vQH/2YmNb/SI
         84cSZ/0cA7CrB9U/FUmJAE2ElpR3RqYtjl97I=
Received: by 10.65.200.8 with SMTP id c8mr2130221qbq.57.1228681828492;
        Sun, 07 Dec 2008 12:30:28 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Sun, 7 Dec 2008 12:30:28 -0800 (PST)
In-Reply-To: <493C1F36.7050504@tuffmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: bf74291b08b7e78b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102505>

On Sun, Dec 7, 2008 at 2:08 PM, Grzegorz Kossakowski wrote:
> Peter Harris pisze:
>> Make sure you don't use the --no-metadata flag when setting up
>> git-svn. This will embed the metadata into commit messages, so git-svn
>> can rebuild it from scratch whenever it needs to. (You probably also
>> want git 1.6.1rc for incremental rebuild support). This also has the
>> advantage that you can see the svn revision number when looking at a
>> commit message.
>
> Not sure what you exactly mean here. Do you mean that if metadata is included in commit messages
> then there is an easy way to initialize git-svn after cloning the repo?

Yes.

> By easy I mean:
> a) it does not require to much of interactive actions to be performed
> b) it does not pull too much from svn server
>
> Point b) is important because we usually have quite large repositories.

To set up the remotes to mirror the remote svn-remotes, I do the clone manually:
git init
git remote add origin git://svn/mirror
git config --add remote.origin.fetch +refs/remotes/*:refs/remotes/*
git fetch
git reset --hard trunk

After the git clone, I do the following:
git svn init -s svn://repo/sitory
git svn rebase

No data is transferred[1], although 'git svn rebase' does spend a
minute or so reading the commit messages to rebuild its index.

This could all be in a common script you distribute to your users.

> Also, could you point me to a place where this rebuild support is described? I would like to know
> what our committer has to do after cloning from Jukka's server.

"git help svn" mentions the rebuild only in passing. I'm not sure if
it is described in better detail elsewhere.

>> In terms of re-pulling from the git-svn mirror, git-svn will create
>> the same commits (with the same sha1s) from svn every time, so there
>> will be no conflicts there.
>
> Just to make sure: so if one person pulls from git-svn mirror and another one pulls using git svn
> rebase they result in the same tree right?

Yes[2].

>> If C doesn't trust A, C should not pull from A. C should pull only
>> from (trusted) B. Presumably B knows who (of A and B) did which work,
>> and B's repository can be trusted?
>>
>> If neither of A or B can be trusted, then you have problems that a
>> computer cannot solve for you.
>
> Yep, I was having in mind the case when both A and B are untrusted. I don't want my computer to
> check if something coming from A or B is safe or not I just want to know which bits are coming from
> A and which from B.
>
> This is really important for us because of legal reasons.

If something is in A's tree, it is coming from A. Either A has
authority, or A has received authority from someone else, or A is
bringing the legal problem down on himself. When A says "Please Pull"
(or when A pushes) A is effectively saying "These changes are legally
mine to give you".

The Developer's Certificate of Origin 1.0 was designed to address this
issue; see also "Signed-off-by"

Of course, if it's a legal issue, make sure you consult your own lawyer.

>> You could maybe use signed tags ("git help tag")...
>
> The question is why Git doesn't sign all commits by default but only tags? Creating tags all the
> time is rather tedious process and seems to have no sense, right?

Typing in your GPG passphrase for every single little commit would be
even more tedious, IMHO.

> Does it mean that with current Git design it's the best to not use advanced features of Git like
> tree merging but simply go with posting e-mails with patches instead if contributors cannot be trusted?

That would be my policy. At the very least, I would have a human
review the tree before merging it.

Note that git was designed around a "git am" workflow, so it is very
efficient at dealing with large numbers of patches at a time.

Note also that you can do tree merging with an email-patch based
workflow, since git format-patch preserves parent information,
although it does take a little bit more work. See also: "git help am"
under --3way.

Peter Harris

[1] Not strictly true. git-svn does contact the svn server to see if
there are any revisions newer than the latest present in the git repo,
and will transfer those revisions (if any).
[2] Unless (a) someone edited the svn:log (or other) revprop in
between, or (b) you triggered the bug I saw reported (and fixed?) on
this list today. I've never personally triggered (b), but I have seen
(a).
