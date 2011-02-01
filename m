From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 09:34:40 -0800
Message-ID: <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com> <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 18:35:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkK8J-0002Ug-Sg
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 18:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795Ab1BARfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 12:35:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44809 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab1BARfC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 12:35:02 -0500
Received: by gxk9 with SMTP id 9so2586136gxk.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 09:35:01 -0800 (PST)
Received: by 10.103.246.14 with SMTP id y14mr3363610mur.77.1296581700884; Tue,
 01 Feb 2011 09:35:00 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Tue, 1 Feb 2011 09:34:40 -0800 (PST)
In-Reply-To: <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165832>

On Tue, Feb 1, 2011 at 09:11, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> On Tue, Feb 1, 2011 at 11:27 PM, Shawn Pearce <spearce@spearce.org> w=
rote:
>> On Tue, Feb 1, 2011 at 05:51, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>>>
>>>> > resumable clone/fetch (and other remote operations)
>>>>
>>>> Jakub Narebski seems to be interested in this and Nicolas Pitre ha=
s
>>>> given some good advice about it. =A0You can get something usable t=
oday
>>>> by putting up a git bundle for download over HTTP or rsync, so it =
is
>>>> possible that this just involves some UI (porcelain) and documenta=
tion
>>>> work to become standard practice.
>>>
>>> I wouldn't say that: it is Nicolas Pitre (IIRC) who was doing the w=
ork;
>>> I was only interested party posting comments, but no code.
>>>
>>> Again, this feature is not very easy to implement, and would requir=
e
>>> knowledge of git internals including "smart" git transport ("Pro Gi=
t"
>>> book can help there).
>>
>> I think Nico and I have mostly solved this with the pack caching ide=
a.
>> =A0If we cache the pack file, we can resume anywhere in about 97% of=
 the
>> transfer. =A0The first 3% cannot be resumed easily, its back to the =
old
>> "git cannot be resumed" issue. =A0Fixing that last 3% is incredibly
>
> I thought the cached pack contained anything and for initial clone, w=
e
> simply send the pack. What is this 3%? Commit list? Initial commit?

Its the recent changes.  If the cached pack starts from the tip of
master, its probably 0%.  But if the repository owner pushes new
changes since the cached pack was created, these are sent as a thin
pack in front of the cached pack... and make up that ~3% guess.  For
linux-2.6 I tested a 2 week period when the merge window as open right
after a release, and the new delta was about 3% of the overall
repository size.

> Narrow/Subtree clone is still just an idea, but can pack cache suppor=
t
> be made to resumable initial narrow clone too?

This would be very hard to do.  We could do cached packs for a popular
set of path specifications (e.g. Documentation/ if documentation only
editing is common), but once we start getting random requests for path
specifications that we cannot predict in advance and pre-pack we'd
have to fall back to the normal enumerate code path.

--=20
Shawn.
