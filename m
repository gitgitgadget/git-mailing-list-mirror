From: Jon Nelson <jnelson@jamponi.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Mon, 8 Feb 2010 11:12:03 -0600
Message-ID: <cccedfc61002080912ybc7775by24fd5511fb67eac5@mail.gmail.com>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com> 
	<alpine.LFD.2.00.1002051539080.1681@xanadu.home> <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com> 
	<alpine.LFD.2.00.1002051634380.1681@xanadu.home> <cccedfc61002060553w464d5d9drd582b3b3c3f35227@mail.gmail.com> 
	<alpine.LFD.2.00.1002061935180.1681@xanadu.home> <cccedfc61002070948m2491b1e2ua633f125f3573ff9@mail.gmail.com> 
	<cccedfc61002071540l7019d5d0mc4666dbd81189064@mail.gmail.com> 
	<alpine.LFD.2.00.1002071937000.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Feb 08 18:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeXAB-0000fL-6A
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 18:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab0BHRM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 12:12:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:18437 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab0BHRMZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 12:12:25 -0500
Received: by fg-out-1718.google.com with SMTP id e21so55871fga.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 09:12:24 -0800 (PST)
Received: by 10.216.166.5 with SMTP id f5mr3617590wel.55.1265649143889; Mon, 
	08 Feb 2010 09:12:23 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002071937000.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139297>

On Sun, Feb 7, 2010 at 8:11 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 7 Feb 2010, Jon Nelson wrote:
>> On Sat, Feb 6, 2010 at 7:16 PM, Nicolas Pitre <nico@fluxnic.net> wro=
te:
>> >On Sat, 6 Feb 2010, Jon Nelson wrote:
>> >> =A0 =A0 =A0 =A0 packsizelimit =3D 256m
>> >
>> > Why are you using this?
>>
>> I didn't want my pack files to be too huge. I've bumped that up to 2=
G.
>>
>> >> pack.packsizelimit=3D2M
>>
>> My ~/.gitconfig normally uses 2M for easy rsyncing. In this repo I
>> thought the value was overridden by the project's config (which was
>> specifying 256m and now specifies 2048m).
>
> Why do you synchronize with rsync? =A0Why not a simple 'git fetch' wh=
ich
> is likely to be much faster in any case?

Often I need to sync the entire config, and am frequently rsyncing
(although not in this case) rsyncing repos made with git-svn. I've had
trouble using git clone on these repos, as I really want the duplicate
repo to use the svn upstream and not the git repo it was cloned from.

=2E.

> You previously had 2408195 packed objects and after the repack this i=
s
> 2674504. =A0The difference is 266309, which incidentally is the numbe=
r of
> objects 'git repack' counted.
>
> If that 266309 object count is stable between repack attempts (and it
> should), then something is failing to clean up the old packs. =A0If I
> remember right, you were playing with modifications to git-repack.sh
> lately? =A0It is well possible that you broke it.

Indeedly do I did.

The (now expected) results:

turnip:/mnt/backups.git # du -sh ; echo ; git count-objects -v ; echo
; git repack -ad ; echo ; git count-objects -v ; echo ; du -sh
204G    .

count: 0
size: 0
in-pack: 2939744
packs: 694
size-pack: 213284091
prune-packable: 0
garbage: 0

Counting objects: 266309, done.
Compressing objects: 100% (205176/205176), done.
Writing objects: 100% (266309/266309), done.
Total 266309 (delta 47781), reused 230413 (delta 47770)

count: 0
size: 0
in-pack: 266309
packs: 11
size-pack: 21590451
prune-packable: 0
garbage: 0

21G     .
turnip:/mnt/backups.git #

and of course now everything is nice and (reasonably) fast.
Thanks for the help, and pointing out that the problem was .. me.

--=20
Jon
