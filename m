From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Re: Can I use git protocol to push change to remote repo?
Date: Tue, 16 Dec 2008 16:48:34 +0800
Message-ID: <856bfe0e0812160048l7d901658tca96f5055c69743c@mail.gmail.com>
References: <856bfe0e0812152318h1375401fx944834ad6410835d@mail.gmail.com>
	 <856bfe0e0812152322i3a7fa376h8a35466b7abf82a5@mail.gmail.com>
	 <20081216073835.GA2468@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 16 09:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCVco-0000mt-K3
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 09:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYLPIsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 03:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbYLPIsg
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 03:48:36 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:32775 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYLPIsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 03:48:35 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1290782yxm.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 00:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Nlv4KpFL/DEa4wy4wHIs6tvez+rOgTqUM/673Fi9SFY=;
        b=C/GVUotuJM4I1SwjMLk9OGw9cqwPZZxpFCKIAfXm56ckUQ1epBUoQQu9ehRDldatlh
         bUbDK14RVss+M9jp1w3wLK5JSp7yDzeHlb9GKpn/wQFNRS+2MHosYKnDdEOWumOSbZSU
         3o3uSWuoeuaB6VkkD/4AWi2P3boCRqn9kd9Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bxdciMDeHcUSVAueLLNv0E1bZ9buQMh0FMbMAlgLELp2mS2UXosdXNuvlJItxxzKCr
         e0lRC2Qrb+p66cTcWimEcJT7RKqPbINJPgkKdZ3Zg8geVc7Gv+D5xmWGrzOPFHV0V7V0
         8JNDt1/fkIrYU9uLoo9tFz58xpXms6MKNRH58=
Received: by 10.150.58.17 with SMTP id g17mr1332853yba.99.1229417314192;
        Tue, 16 Dec 2008 00:48:34 -0800 (PST)
Received: by 10.150.225.13 with HTTP; Tue, 16 Dec 2008 00:48:34 -0800 (PST)
In-Reply-To: <20081216073835.GA2468@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103258>

Peff,

Thank you for your help !  I read the git-daemon description, and
added following lines in the config file of remote repository.

 [daemon]
       receivepack = true

It failed with another error, is there anything I missed to config daemon ?
$ git push git://host.xz/testgit test_push2
updating 'refs/heads/test_push2'
  from 0000000000000000000000000000000000000000
  to   eebb60caae38a38361d002cdace043124a2fc871
Generating pack...
Done counting 3 objects.
Deltifying 3 objects...
 100% (3/3) done
Writing 3 objects...
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)
unpack unpacker exited with error code
ng refs/heads/test_push2 n/a (unpacker error)
error: failed to push to 'git://host.xz/testgit'

Thanks,
Emily

On Tue, Dec 16, 2008 at 3:38 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 16, 2008 at 03:22:17PM +0800, Emily Ren wrote:
>
>> I can clone a remote repo with git protocol, but I can't push my
>> branch to origin repo with git protocol. If I use ssh protocol, I can
>> push sccuessfully. I'm confused, can someone give me a guide on this?
>> Can I use git protocol to push my branch to remote repo? If yes, how
>> can I do ? Thank you for your help in advance !
>
> Yes, git-daemon does not support pushing by default, since it doesn't do
> any authentication of the pushing users. The recommended practice is to
> push over ssh, which uses the exact same protocol, but is tunneled over
> ssh, so the user is authenticated and the incoming data has an integrity
> check (note that pulling by ssh is also the same protocol as pulling via
> git://, except of course that it is also tunneled over ssh; this means
> that if you are pushing and pulling, you can just set your remote to
> talk to the ssh version).
>
> If you _really_ want totally anonymous, unsecured pushing to your repo
> (e.g., because you are on a restricted LAN and everybody is trusted),
> you can enable the receive-pack service. See the git-daemon
> documentation for details.
>
> -Peff
>
