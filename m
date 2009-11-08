From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [gitweb feature request] Release snapshots with vX.X.X tags
Date: Sun, 08 Nov 2009 13:27:51 -0800
Message-ID: <4AF737D7.8030203@eaglescrag.net>
References: <1257680442.14087.78.camel@owl>	 <7vbpjcetlp.fsf@alter.siamese.dyndns.org> <1257714522.14087.133.camel@owl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Bram Neijt <bneijt@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 22:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7FIl-00060b-AY
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 22:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbZKHV1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 16:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbZKHV1s
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 16:27:48 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:59245 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbZKHV1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 16:27:47 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nA8LRp16004635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 Nov 2009 13:27:51 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <1257714522.14087.133.camel@owl>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10000/Sat Nov  7 19:28:38 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Sun, 08 Nov 2009 13:27:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132418>

Bram,

This is true, but gitweb, in it's current incarnation, is *SLOW* using 
it as a primary distribution means is ludicrous.  Regenerating a tarball 
on each request will destroy a server, plain and simple.  Git/Gitweb 
should *NOT* be used in place of doing properly release engineering.

If Debian requires their tarballs to be done up in a certain way, this 
is either the problem of the packager, or if you want to be kind create 
a makefile target that will generate this and release both when you do a 
release:

I.E.

# make release
Generating Normal Tarball: <project>-<version>.tar.gz
Generating Debian Tarball: <project>-<version>.deb.tar.gz
# ls
Makefile  <project>-<version>.tar.gz <project>-<version>.deb.tar.gz src/
#

Then take your releases and put them on your release server.

- John 'Warthog9' Hawley

Bram Neijt wrote:
> I was going to comment inline but I think the general question can be
> read as "why would you want this?". For me it's just an extra bit of
> automation. It would keep me from having to make release tarballs. I
> would just refer all the users to a gitweb snapshot link of the "v..."
> tag. Having a release tarball with "projectname-version" with a single
> directory called "projectname-version/" in it is just good practice if
> you ask me.
> 
> Therefore it would benefit any developer like me :D : a spare time
> hobbyist who likes to automate as much of the administrative tasks, that
> go into running an open source project, as possible.
> 
> Greets,
>   Bram
> 
> PS I've found that cgit: http://hjemli.net/git/cgit/
> has this feature, so I'm probably going to give that a try and get back
> to you if I find any problems with it (the feature that is).
> 
> On Sun, 2009-11-08 at 10:53 -0800, Junio C Hamano wrote:
>> Bram Neijt <bneijt@gmail.com> writes:
>>
>>> I would like to create release snapshots with a git tag like "v0.0.1".
>>> For proper Debian packaging, a release snapshot of tag "v0.0.1" would
>>> have to be named "project-0.0.1.tar.gz" and contain a single directory
>>> with "project-0.0.1/" in the archive.
>> What the intended audience of this feature?  IOW,
>>
>>  - who are going to "click" such a link on gitweb to obtain
>>    project-0.0.1.tar.gz with project-0.0.1/?
>>
>>  - how are they going to use that tarball?
>>
>> I somehow suspect that they won't be the official Debian distro packagers.
>>
>> Most likely they actually have a clone of the upstream project (how else
>> they can stay up to date?  In addition they would want to track their own
>> changes), so it would be more efficient for them to generate such a
>> tarball from a tag, and more importantly, doing it locally means that they
>> can they can verify the tag (and the whole history leading to it) before
>> doing so, instead of relying on somebody else's gitweb.
>>
>> You could be a mere Debian user who produces a *.deb for his own use out
>> of such tarball, and in such a case you are a lot less likely be tracking
>> the project (meaning, reading the history and keeping track of fixed bugs,
>> new regressions and such) than just getting a snapshot that happens to be
>> there and building it blindly, and I can understand it would be nicer if
>> you did not have to unpack, rename and regenerate an archive.
>>
>> Also, whose gitweb installations are you envisioning to enable this new
>> feature?  Are you going to convince all the gitweb administrators of
>> projects packaged by Debian (and derivatives) that have gitweb, and what
>> are the incentive for these upstream projects to do so?  I would guess
>> that most of the upstream projects do not consider Debian as their sole
>> target distribution, and it would be a tough sell if changing the snapshot
>> name to suit Debian breaks some other distro's (or human users) needs.
>>
>> Jakub is polishing Mark's patch to change the snapshot name and contents
>> hierarchy, but I think it won't satisfy Debian's naming guideline (it will
>> have v0.0.1, not 0.0.1 in the name).  Changing the series's default to
>> drop 'v' from the beginning of the tagname when the rest of it consists of
>> all digits and dots would not be a correct solution, as Debian is not the
>> only system in the world and other people may want different naming rules.
>>
>> In order to make his series useful for your objective, it probably would
>> require a bit more customizability, but because I cannot tell whom such a
>> feature is really trying to help, and what the deployment plans are, I
>> cannot judge if extra complexity to add such a customizability is worth
>> it.  Also because there will be conflicts in the desired archive format
>> ("Distro X people want this kind of archive, distro Y people want this
>> different kind"), the choice somehow how to come from whoever is clicking
>> the link, not from the gitweb administrator, and it probably would mean
>> the codepath involved would need a lot more careful audit than just a
>> server only "this gitweb installation would use this format"
>> configuration.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
