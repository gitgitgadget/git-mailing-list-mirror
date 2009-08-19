From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 21:42:50 +0200
Message-ID: <200908192142.51384.jnareb@gmail.com>
References: <1250509342.2885.13.camel@cf-48> <200908191719.52974.jnareb@gmail.com> <alpine.LFD.2.00.0908191326360.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:43:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdr3w-0000LK-NR
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 21:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZHSTnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 15:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZHSTnC
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 15:43:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:18771 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbZHSTnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 15:43:00 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1121146fga.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NrvZmHj9MOfkL22HqN+c0bi3Lv+ELLa0JKTxIirMLUM=;
        b=qfgDy98C7DcyXY9Mu5D6QWc7iXkxNqQrnl7pZJPmyHP3Nq31aTbwLBqMkvtRjQPqP5
         bX8o/T6q7/oB382mhSI2CAsPla7ewcbhB0LOUa6T1EHmvMYceootYakAs2CEssxPwUSr
         ulfBtrh/DMLSkgGsBwEUQuL4+iqZXmFA0zAhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HQ1KdjoJ6Tt/cP3u3CDnLYNaeTz8M/atc433EeXNc1u5yWtzloOfoRf4VF+KnQUlku
         p+KK0W45uDQJT1L1DoVP6wDU0Gkn64AGjfDiFP1W4i76yqiuvHehhhMhMDbo0oLVkN3S
         /Cs/FvcwAy5OdGl6YNm+jGkawlFglityerePw=
Received: by 10.86.231.17 with SMTP id d17mr4411449fgh.46.1250710980710;
        Wed, 19 Aug 2009 12:43:00 -0700 (PDT)
Received: from ?192.168.1.13? (abvn197.neoplus.adsl.tpnet.pl [83.8.211.197])
        by mx.google.com with ESMTPS id 4sm1142079fge.16.2009.08.19.12.42.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 12:42:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0908191326360.6044@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126576>

Cc-ed Dscho, so he can easier participate in this subthread.

On Wed, 19 Aug 2009, Nicolas Pitre wrote:
> On Wed, 19 Aug 2009, Jakub Narebski wrote:

> > P.S. What do you think about 'bundle' capability extension mentioned
> >      in a side sub-thread?
> 
> I don't like it.  Reason is that it forces the server to be (somewhat) 
> stateful by having to keep track of those bundles and cycle them, and it 
> doubles the disk usage by having one copy of the repository in the form 
> of the original pack(s) and another copy as a bundle.

I agree about problems with disk usage, but I disagree about server
having to be stateful; server can just simply scan for bundles, and
offer links to them if client requests 'bundles' capability, somewhere
around initial git-ls-remote list of refs.

> Of course, the idea of having a cron job generating a bundle and 
> offering it for download through HTTP or the like is fine if people are 
> OK with that, and that requires zero modifications to git.  But I don't 
> think that is a solution that scales.

Well, offering daily bundle in addition to daily snapshot could be
a good practice, at least until git acquires resumable fetch (resumable
clone).

> 
> If you think about git.kernel.org which has maybe hundreds of 
> repositories where the big majority of them are actually forks of Linus' 
> own repository, then having all those forks reference Linus' repository 
> is a big disk space saver (and IO too as the referenced repository is 
> likely to remain cached in memory).  Having a bundle ready for each of 
> them will simply kill that space advantage, unless they all share the 
> same bundle.

I am thinking about sharing the same bundle for related projects.

> 
> Now sharing that common bundle could be done of course, but that makes 
> things yet more complex while still wasting IO because some requests 
> will hit the common pack and some others will hit the bundle, making 
> less efficient usage of the disk cache on the server.

Hmmm... true (unless bundles are on separate server).

> 
> Yet, that bundle would probably not contain the latest revision if it is 
> only periodically updated, even less so if it is shared between multiple 
> repositories as outlined above.  And what people with slow/unreliable 
> network links are probably most interested in is the latest revision and 
> maybe a few older revisions, but probably not the whole repository as 
> that is simply too long to wait for.  Hence having a big bundle is not 
> flexible either with regards to the actual data transfer size.

I agree that bundle would be useful for restartable clone, and not
useful for restartable fetch.  Well, unless you count (non-existing)
GitTorrent / git-mirror-sync as this solution... ;-)

> 
> Hence having a restartable git-archive service to create the top 
> revision with the ability to cheaply (in terms of network bandwidth) 
> deepen the history afterwards is probably the most straight forward way 
> to achieve that.  The server needs no be aware of separate bundles, etc.  
> And the shared object store still works as usual with the same cached IO 
> whether the data is needed for a traditional fetch or a "git archive" 
> operation.

It's the "cheaply deepen history" that I doubt would be easy.  This is
the most difficult part, I think (see also below).

> 
> Why "git archive"?  Because its content is well defined.  So if you give 
> it a commit SHA1 you will always get the same stream of bytes (after 
> decompression) since the way git sort files is strictly defined.  It is 
> therefore easy to tell a remote "git archive" instance that we want the 
> content for commit xyz but that we already got n files already, and that 
> the last file we've got has m bytes.  There is simply no confusion about 
> what we've got already, unlike with a partial pack which might need 
> yet-to-be-received objects in order to make sense of what has been 
> already received.  The server simply has to skip that many files and 
> resume the transfer at that point, independently of the compression or 
> even the archive format.

Let's reiterate it to check if I understand it correctly:


Any "restartable clone" / "resumable fetch" solution must begin with
a file which is rock-solid stable wrt. reproductability given the same
parameters.  git-archive has this feature, packfile doesn't (so I guess
that bundle also doesn't, unless it was cached / saved on disk).

It would be useful if it was possible to generate part of this rock-solid
file for partial (range, resume) request, without need to generate 
(calculate) parts that client already downloaded.  Otherwise server has
to either waste disk space and IO for caching, or waste CPU (and IO)
on generating part which is not needed and dropping it to /dev/null.
git-archive you say has this feature.

Next you need to tell server that you have those objects got using
resumable download part ("git archive HEAD" in your proposal), and
that it can use them and do not include them in prepared file/pack.
"have" is limited to commits, and "have <sha1>" tells server that
you have <sha1> and all its prerequisites (dependences).  You can't 
use "have <sha1>" with git-archive solution.  I don't know enough
about 'shallow' capability (and what it enables) to know whether
it can be used for that.  Can you elaborate?

Then you have to finish clone / fetch.  All solutions so far include
some kind of incremental improvements.  My first proposal of bisect
fetching 1/nth or predefined size pack is buttom-up solution, where
we build full clone from root commits up.  You propose, from what
I understand build full clone from top commit down, using deepening
from shallow clone.  In this step you either get full incremental
or not; downloading incremental (from what I understand) is not
resumable / they do not support partial fetch.

Do I understand this correctly?
-- 
Jakub Narebski
Poland
