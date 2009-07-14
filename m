From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: Recover broken git repository?
Date: Tue, 14 Jul 2009 19:48:19 +0200
Organization: -no organization-
Message-ID: <20090714174819.GC9919@scotty.home>
References: <1247577632053-3255106.post@n2.nabble.com> <alpine.LFD.2.01.0907141019380.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Florian Breitwieser <florian.bw@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 19:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQm7G-0002AL-NJ
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 19:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbZGNRsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 13:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbZGNRsZ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 13:48:25 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:49492 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZGNRsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 13:48:24 -0400
Received: from scotty.home (port-92-206-225-9.dynamic.qsc.de [92.206.225.9])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MKsym-1MQm733N9Z-000Y2O; Tue, 14 Jul 2009 19:48:23 +0200
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id n6EHmJEf001633;
	Tue, 14 Jul 2009 19:48:19 +0200
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id n6EHmJTf001629;
	Tue, 14 Jul 2009 19:48:19 +0200
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907141019380.13838@localhost.localdomain>
X-Mailer: Mutt 1.5.18 http://www.mutt.org/
X-Editor: GNU Emacs 22.2.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
	F986 E4FC D563
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: ClamAV 0.94.2/9564/Tue Jul 14 18:22:26 2009 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX19GUhpwono/16iw/tLOaP8lAvQmbowBMx1WBeQ
 z5CBfyI3RODoXysjeDx9mDoV3vb+COuLCZ5c6Vn4ByedXSackW
 PnRpyQvOOtDK9sp8pjDEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123261>

Also sprach Linus Torvalds am Tue, 14 Jul 2009 at 10:33:58 -0700:
> 
> 
> On Tue, 14 Jul 2009, Florian Breitwieser wrote:
> >
> > $ git commit -m "Some message"
> > error: invalid object 1086b1c606a04bcb78b92d1d411a299d20d18034
> > fatal: Error building trees
> 
> Hmm. That "invalid object" error comes from 'update_one()' when it cannot 
> find the object it is looking for. That, in turn, tends to be an issue of 
> the index containing a SHA1 that does not exist in the database.
> 
> Do you trust your filesystem? The symptoms really sound like you did a 
> "git add .." earlier, and populated the index, but now the object that got 
> populated is no longer found.
> 
> What OS, what filesystem?  Oh, and what version of git?
> 
> > $ git-fsck --full
> > dangling tree c2549a3cdd83098a523cb707f217f4656cde7eb5
> 
> The fsck seems to imply that things are ok. The fsck _should_ have checked 
> the index too.
> 
> The 'git commit' obviously disagrees.
> 
> Two things to check:
> 
>  - do you use grafts to hide old history, rather than connect additional 
>    history?
> 
>    That can be really dangerous, and will make fsck (and other tools) not 
>    look at the hidden state. 
> 
>  - do you have alternates (is multiple _different_ repositories tat point 
>    to each other)? That can cause problems if you then do things like git 
>    prune in them. It wouldn't explain this particular case, but it's 
>    something I look out for when I hear about corruption.
> 
> > $ git prune
> 
> Not a good idea. When you suspect corruption, the _last_ thing you want to 
> do is prune things. Who knows what happened?
> 
> > $ git commit -m "Some message"
> > Created commit e32d5dd: Some message
> >  2 files changed, 167 insertions(+), 10 deletions(-)
> 
> So now the same commit worked? It _really_ sounds like your filesystem has 
> a hard time finding the files it just created. Some local caching issue.
> 
> Is it a network filesystem? If so, what's the filesystem server and 
> version, if you can find it out?
> 
> > $ git push
> > Counting objects: 15, done.
> > Compressing objects: 100% (6/6), done.
> > Writing objects: 100% (8/8), 2.44 KiB, done.
> > Total 8 (delta 4), reused 0 (delta 0)
> > Unpacking objects: 100% (8/8), done.
> > fatal: unresolved deltas left after unpacking
> > error: unpack failed: unpacker exited with error code
> > To /mnt/extstore2/bioinformatic/git/ppi.git
> >  ! [remote rejected] master -> master (n/a (unpacker error))
> > error: failed to push some refs to
> > '/mnt/extstore2/bioinformatic/git/ppi.git'
> 
> Here the other end doesn't have some object that we expect it to have, and 
> that we sent a delta to it against. Sounds like potentially the exact same 
> problem (it created some new file, but then couldn't see it). Is the thign 
> you are pushing to a similar machine with similar filesystems?
> 
> We've had issues with both CIFS and NFS. Using
> 
> 	[core]
> 		fsyncobjectfiles = true
> 
> might work around some issues where the filesystem does crazy things. But 
> I'd really like to hear what OS and filesystem versions you're running.
> 
> 			Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

Please note that according to the German law on data retention,
information on every electronic information exchange with me is
retained for a period of six months.
Bundesgesetzblatt:
http://www.bgblportal.de/BGBL/bgbl1f/bgbl107s3198.pdf
