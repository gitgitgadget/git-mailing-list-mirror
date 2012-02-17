From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Fri, 17 Feb 2012 18:19:06 +0100
Message-ID: <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	<8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<20120215190318.GA5992@sigill.intra.peff.net>
	<CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
	<20120216192001.GB4348@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 17 18:19:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyRSn-0005te-S3
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 18:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2BQRTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Feb 2012 12:19:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59475 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab2BQRTI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 12:19:08 -0500
Received: by yenm8 with SMTP id m8so1926810yen.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XgXG/AZwcFx6w4olWwxpPIUwoSnA0jp9qvl0pervBjM=;
        b=XL2CiKdyyd6dmybwAahzGDjcoEFT3SquW6bBoIzXaiRm5QgmT+h5SyV9o3EQX1ckaR
         ZraTmEc8zhrAYHyise8Wp7F5XnHGO+VMfO6MPJG0Emm1tSC+MUkpTzJNyRakCtn3brpK
         M3L4CAx7GhiHZx/4dVwSCX/3w31DnE/Tclsy0=
Received: by 10.50.194.170 with SMTP id hx10mr24628004igc.6.1329499146934;
 Fri, 17 Feb 2012 09:19:06 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Fri, 17 Feb 2012 09:19:06 -0800 (PST)
In-Reply-To: <20120216192001.GB4348@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190965>

On Thu, Feb 16, 2012 at 8:20 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 16, 2012 at 02:37:47PM +0100, Piotr Krukowiecki wrote:
>
>> >> $ time git status =A0-- .
>> >> real =A0 =A00m2.503s
>> >> user =A0 =A00m0.160s
>> >> sys =A0 =A0 0m0.096s
>> >>
>> >> $ time git status
>> >> real =A0 =A00m9.663s
>> >> user =A0 =A00m0.232s
>> >> sys =A0 =A0 0m0.556s
>> >
>> > Did you drop caches here, too?
>>
>> Yes I did - with cache the status takes something like 0.1-0.3s on w=
hole repo.
>
> OK, then that makes sense. It's pretty much just I/O on the filesyste=
m
> and on the object db.
>
> You can break status down a little more to see which is which. Try "g=
it
> update-index --refresh" to see just how expensive the lstat and index
> handling is.

"git update-index --refresh" with dropped cache took
real	0m3.726s
user	0m0.024s
sys	0m0.404s

while "git status" with dropped cache takes
real	0m13.578s
user	0m0.240s
sys	0m0.600s

I'm not sure why it takes more than the 9s reported before - IIRC I
did the previous test in single mode under bare shell and this time
I'm testing under gnome. This or it's the effect of running
update-index :/
Now status on subdir takes 9.5s. But still the
not-much-faster-status-on-subdir rule is true.


> And then try "git diff-index HEAD" for an idea of how expensive it is=
 to
> just read the objects and compare to the index.

The diff-index after dropping cache takes
real	0m14.095s
user	0m0.268s
sys	0m0.564s


>> > Not really. You're showing an I/O problem, and repacking is git's =
way of
>> > reducing I/O.
>>
>> So if I understand correctly, the reason is because git must compare
>> workspace files with packed objects - and the problem is
>> reading/seeking/searching in the packs?
>
> Mostly reading (we keep a sorted index and access the packfiles via
> mmap, so we only touch the pages we need). But you're also paying to
> lstat() the directory tree, too. And you're paying to load (probably)
> the whole index into memory, although it's relatively compact compare=
d
> to the actual file data.

If the index is the objects/pack/*.idx files than it's 21MB


>> Is there a way to make packs better? I think most operations are on
>> workdir files - so maybe it'd be possible to tell gc/repack/whatever
>> to optimize access to files which I currently have in workdir?
>
> It already does optimize for that case. If you can make it even bette=
r,
> I'm sure people would be happy to see the numbers.

If I understand correctly, you only need to compute sha1 on the
workdir files and compare it with sha1 files recorded in index/gitdir.
It seems that to get the sha1 from index/gitdir I need to read the
packfiles? Maybe it'd be possible to cache/index it somehow, for
example in separate and smaller file?


> Mostly I think it is just the case that disk I/O is slow, and the
> operation you're asking for has to do a certain amount of it. What ki=
nd
> of disk/filesystem are you pulling off of?
>
> It's not a fuse filesystem by any chance, is it? I have a repo on an
> encfs-mounted filesystem, and the lstat times are absolutely horrific=
=2E

No, it's ext4 and the disk Seagate Barracuda 7200.12 500GB, as it
reads on the cover :)

But IMO faster disk won't help with this - times will be smaller, but
you'll still have to read the same data, so the subdir times will be
just 2x faster than whole repo, won't it? So maybe in my case it will
go down to e.g. 2s on subdir, but for someone with larger repository
it will still be 10s...


--=20
Piotr Krukowiecki
