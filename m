From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git peer-to-peer project: info needed
Date: Sun, 29 Aug 2010 23:57:47 +0100
Message-ID: <AANLkTi=vcXX8n3NzGF51c=wPhgqushpwM4R7hR=O6QuU@mail.gmail.com>
References: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
	<20100829220654.GH1890@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 00:57:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opqoz-0008V2-QS
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 00:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab0H2W5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 18:57:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33887 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab0H2W5r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 18:57:47 -0400
Received: by vws3 with SMTP id 3so4519422vws.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jcAg+oKtaG2/IKv0neUPGBCKAeF+r/3wnHhGkSigo/Q=;
        b=Qc0UZOqjwDHC/ExlasoPmacVKLjmCbLcOotwof5dCXU4az6xRhrsPyJmhII7K108hu
         PDIe1wrWOUdeZdNZ+tPz0kVdp4hEPN1YXEcfdZRPfZxXAf67zfr4gAXTbC6EHtBm2k5u
         qMp5uJ0K0g5EtslUI7brvHtCi0k9XhlSKKWfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m25ztVtFZ6Q5XqkVEPHKn56EgbVPAiGANRxJZl02sFpPfAcgYnmZLKjq08P0SPTjf6
         ipFDBQ/h91Ok2Bd86k39zqiqcBP1U0v2jkpQ+pGowuWFbei4YICeG+BNqvOGDnaz+vcs
         OW9qLDTbwhrThq90NxsYq+7haAK7C3+gt3Hr4=
Received: by 10.220.126.130 with SMTP id c2mr2291869vcs.224.1283122667076;
 Sun, 29 Aug 2010 15:57:47 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Sun, 29 Aug 2010 15:57:47 -0700 (PDT)
In-Reply-To: <20100829220654.GH1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154732>

On Sun, Aug 29, 2010 at 11:06 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Hi Luke,
>
> Luke Kenneth Casson Leighton wrote:
>
>> i need some guidance on what i should be doing, to add peer-to-peer
>> networking to "git fetch". =C2=A0i can take care of the peer-to-peer
>> networking side: the bit i'm unsure about is what sequence of events
>> are required to happen.
>
> Not sure if this is the best answer or not, but you might enjoy
> looking at the git-remote-helpers(7) feature

       git-remote-helpers - Helper programs to interact with remote
       repositories

okaay, i see where you're going with that one.  thanks.

> and git-remote-testgit.py
> example.

 have to find that.

> Also, in case it is useful: the old scripted "git fetch" is available
> as contrib/examples/git-fetch.sh.

 ahh.  ah _ha_.  yes.  excellent.

 btw, gitpython interestingly has a 4-line method for working out the
list of commits required to be obtained in order for the local copy to
catch up:

        repo_refs =3D self.git.rev_list(ref, '--').strip().splitlines()
        other_repo_refs =3D other_repo.git.rev_list(other_ref,
'--').strip().splitlines()
        diff_refs =3D list(set(other_repo_refs) - set(repo_refs))
        return map(lambda ref: Commit.find_all(other_repo, ref,
max_count=3D1)[0], diff_refs)

it's going to be a leeetle more tricky than that, over a p2p network,
unless i cheat, and place the other_repo's rev-list into a meta-file
which is also distributed over the p2p network.... yuk to that, on the
basis that long-living repos that's going to be a biiig file (would
that actually be the case?  what's the largest "git rev-list --all"
that anyone's ever seen?  yikes - on git itself it's 860k!)   hmmm..
git rev {commit1}...{commit2} might give me what i need (and be
equivalent to the above 4 python lines but it can be done by the
remote end - that's still potentially a damn big amount of info.
well, i'm sure i'll cope :)

i just want to get something working, damnit.  there simply aren't
enough free software client-server-paradigm-independent development
tools around, and that's a situation that's causing me some concern.

l.
