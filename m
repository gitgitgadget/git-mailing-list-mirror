From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 08:27:31 -0800
Message-ID: <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 17:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkJLJ-00035x-Sb
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 17:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab1BAQoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 11:44:30 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60538 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab1BAQoa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 11:44:30 -0500
Received: by gxk9 with SMTP id 9so2558671gxk.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 08:44:29 -0800 (PST)
Received: by 10.103.233.7 with SMTP id k7mr3285786mur.131.1296578668557; Tue,
 01 Feb 2011 08:44:28 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Tue, 1 Feb 2011 08:27:31 -0800 (PST)
In-Reply-To: <201102011451.17456.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165823>

On Tue, Feb 1, 2011 at 05:51, Jakub Narebski <jnareb@gmail.com> wrote:
>
>> > resumable clone/fetch (and other remote operations)
>>
>> Jakub Narebski seems to be interested in this and Nicolas Pitre has
>> given some good advice about it. =C2=A0You can get something usable =
today
>> by putting up a git bundle for download over HTTP or rsync, so it is
>> possible that this just involves some UI (porcelain) and documentati=
on
>> work to become standard practice.
>
> I wouldn't say that: it is Nicolas Pitre (IIRC) who was doing the wor=
k;
> I was only interested party posting comments, but no code.
>
> Again, this feature is not very easy to implement, and would require
> knowledge of git internals including "smart" git transport ("Pro Git"
> book can help there).

I think Nico and I have mostly solved this with the pack caching idea.
 If we cache the pack file, we can resume anywhere in about 97% of the
transfer.  The first 3% cannot be resumed easily, its back to the old
"git cannot be resumed" issue.  Fixing that last 3% is incredibly
difficult... but resuming within the remaining 97% is a pretty simple
extension of the protocol.  The hard part is the client side
infrastructure to remember where we left off and restart.

>> > GitTorrent Protocol, or git-mirror
>>
>> Sam Vilain and Jonas Fonseca did some good work on this, but it's
>> stalled.
>
> There was some recent discussion on this on git mailing llist, but
> without any code.
>
> One would need to know similar areas as for "resumable clone" feature=
=2E
> Plus some knowledge on P2P transport in GitTorrent case.

I think this is very similar to resumable clone.  With the cached
pack, clients could use torrent to find it.  But right now Nico and I
are sort of expecting a cached pack to live for about the release
cycle of a project... e.g. only a couple of months.  I don't know if
that can be seeded fast enough on P2P networks to make it useful to
torrent the ~97% of the project that is the cached pack during an
initial clone request.

>> > subtree clone
>>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy and Elijah Newren have don=
e some design and
>> prototyping work.
>
> Git mailing list archives should contain proof of concept / RFC patch=
es
> for this feature. =C2=A0Quite interesting.

I think Junio has already started thinking about this one.

--=20
Shawn.
