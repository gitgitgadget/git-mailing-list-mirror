From: "Thanassis Tsiodras" <ttsiodras@gmail.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Mon, 3 Nov 2008 22:35:07 +0200
Message-ID: <f1d2d9ca0811031235w3581f7ffnc7380b4cb488e71a@mail.gmail.com>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
	 <m37i7pggnk.fsf@localhost.localdomain>
	 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
	 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
	 <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
	 <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
	 <alpine.LFD.2.00.0811010924550.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:36:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx6A3-0003is-VB
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 21:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbYKCUfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 15:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458AbYKCUfL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 15:35:11 -0500
Received: from hs-out-0708.google.com ([64.233.178.250]:24744 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbYKCUfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 15:35:09 -0500
Received: by hs-out-0708.google.com with SMTP id 4so1428041hsl.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 12:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=juuy+yNz3qX+dbuq0um0C+xtXjVccXXNMbgnsYSqZ84=;
        b=spJ44ZpDL2DS4fsmg9ky4WYosE2LFoBhNYk3UFC6p5VzZfCuOEctMHimT3aLFgjBxb
         eVIov4pTI4BrszkGxX0femwK9+yc2pMXLilpTDtaxnc7NHb78BAyPvxAKuOmg2k4VY+K
         dUXsv/2Hl0bEvKPVWXFWTpeV9DUD7IvXWWuxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=S0sgwMGeOQV4fMVFZMZ3zuVruCoxeACv1o1BZp1/wo1ieccWpDCF1j6tCwxC+q/91A
         1p5yYwpL7XqBbubOl6jICd2BP3xsQOvhy6ZGBg2INIcqzfwP/JvyoKs9uDb6/ON6TvQE
         jg9Ue7vMDM7jeAxQFIg354oUzBDAjfqd3KItc=
Received: by 10.100.105.15 with SMTP id d15mr210654anc.69.1225744507941;
        Mon, 03 Nov 2008 12:35:07 -0800 (PST)
Received: by 10.100.11.13 with HTTP; Mon, 3 Nov 2008 12:35:07 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811010924550.13034@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99989>

Despair...

I just tested "git push --thin"...
Doesn't work.

It still sends the complete object, not a tiny pack as it could (should).

But perhaps I now understand why:

I run git-gc on both the remote end and the working end (before
changing anything,
i.e. with both repos being in sync - "git pull" and "git push" report all OK).
I then noticed that on the remote side, .git/objects/pack had one big pack file,
but on the local one I have two .pack files...!

I proceeded to try (many combinations of params on) git-repack in a vain attempt
to make my local repos also have one single .pack file (presumably, it
should be able
to exactly mirror the remote one, since it has the same objects inside
it!). No way...
git-prune and "git-fsck --full --strict --unreachable" report no errors either.

I'm at a loss as to why the two repos are having different "pack
representation" of the
same objects and why git-gc and git-repack fail to create a single
pack on my working
side, but I'm guessing that this is why "git push --thin" fails to
send small xdeltas...

Any help/advice on what to try next would be most welcome...

Thanassis.





On 11/1/08, Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 1 Nov 2008, Thanassis Tsiodras wrote:
>
>> Thanks to everybody for your help.
>>
>> I will setup an alias to always use "git push --thin".
>> For the reverse direction, I don't see a --thin for "git pull",
>>
>> My understanding is that "git pull" is optimal,
>> and does what --thin does for push anyway, right?
>
> Exact.
>
>
> Nicolas
>


-- 
What I gave, I have; what I spent, I had; what I kept, I lost. -Old Epitaph
