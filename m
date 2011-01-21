From: Eric Montellese <emontellese@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Fri, 21 Jan 2011 18:15:37 -0500
Message-ID: <AANLkTinKNtDDy6Pi4Tn+hpTrVw_DBoYpTn3ihCfN_fUd@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com> <20110121222440.GA1837@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 22 00:16:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgQD6-0001rd-Fu
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 00:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab1AUXP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 18:15:59 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52560 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab1AUXP7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jan 2011 18:15:59 -0500
Received: by bwz15 with SMTP id 15so2092787bwz.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 15:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=QR5Me9lXl0rlkSzNh0KOLvaqx0KPhkL19vaCcNuDSVw=;
        b=lhhWrMdATI25pR4xOcv/eHVKwglou7jWiRD8JIHP5nbDkgjENvwPmGN8Q/b1j16+pl
         w4YQtYREJXa/76DVM+bcl+jwFOg4PMr4mAJN/5gGDGRa0PWJruQGs2AiU39HaUfFk8N4
         +S4C/ry4WTUvz/7+r0vwrXGlfE9246iPvrEQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QDTveeEMIlkWniD0mb4jUgoM980E58g37S0JhKE49vdMsvCC09eVRCZmcxvJqlKPYo
         NLZm2oMD5bRmOEF1H+NapuzhSKKpot4GJ+zpGNfwZtNciq23RRlMpcC5FYkDjB+8U/mJ
         XOGjihOjZ1U6eaqL1k4BY6tLHWXAunAq4vx/E=
Received: by 10.204.56.3 with SMTP id w3mr1274033bkg.60.1295651757585; Fri, 21
 Jan 2011 15:15:57 -0800 (PST)
Received: by 10.204.60.11 with HTTP; Fri, 21 Jan 2011 15:15:37 -0800 (PST)
In-Reply-To: <20110121222440.GA1837@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165401>

Peff,

Thanks for your insight -- this looks great.

Once something like this is available and more polished, what's the
process to request that it join the main line of git development?   (i
know functionally there's "no main line" in git... but you know what I
mean)

Has there already been discussion to this effect?  I do think that a
fix like this would improve git adoption among certain groups.  (I
know I've heard the "big binaries" problem mentioned at least a few
times)


I haven't dug around in git code yet, so while I can get the gist of
your code, I'm unable to get the complete picture.  You wouldn't
happen to have a git patch, or a public repo somewhere that I can take
a look at?  Does there happen to be a git developers guide hidden away
anywhere?  Though I have very limited time, I'd be happy to help out
as much as I can.


Eric







On Fri, Jan 21, 2011 at 5:24 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 21, 2011 at 01:57:21PM -0500, Eric Montellese wrote:
>
>> I did a search for this issue before posting, but if I am touching o=
n
>> an old topic that already has a solution in progress, I apologize. =A0=
As
>
> It's been talked about a lot, but there is not exactly a solution in
> progress. One promising direction is not very different from what you=
're
> doing, though:
>
>> Solution:
>> The short version:
>> ***Don't track binaries in git. =A0Track their hashes.***
>
> Yes, exactly. But what your solution lacks, I think, is more integrat=
ion
> into git. Specifically, using clean/smudge filters you can have git t=
ake
> care of tracking the file contents automatically.
>
> At the very simplest, it would look like:
>
> -- >8 --
> cat >$HOME/local/bin/huge-clean <<'EOF'
> #!/bin/sh
>
> # In an ideal world, we could actually
> # access the original file directly instead of
> # having to cat it to a new file.
> temp=3D"$(git rev-parse --git-dir)"/huge.$$
> cat >"$temp"
> sha1=3D`sha1sum "$temp" | cut -d' ' -f1`
>
> # now move it to wherever your permanent storage is
> # scp "$root/$sha1" host:/path/to/big_storage/$sha1
> cp "$temp" /tmp/big_storage/$sha1
> rm -f "$temp"
>
> echo $sha1
> EOF
>
> cat >$HOME/local/bin/huge-smudge <<'EOF'
> #!/bin/sh
>
> # Get sha1 from stored blob via stdin
> read sha1
>
> # Now retrieve blob. We could optionally do some caching here.
> # ssh host cat /path/to/big/storage/$sha1
> cat /tmp/big_storage/$sha1
> EOF
> -- 8< --
>
> Obviously our storage mechanism (throwing things in /tmp) is simplist=
ic,
> but obviously you could store and retrieve via ssh, http, s3, or
> whatever.
>
> You can try it out like this:
>
> =A0# set up our filter config and fake storage area
> =A0mkdir /tmp/big_storage
> =A0git config --global filter.huge.clean huge-clean
> =A0git config --global filter.huge.smudge huge-smudge
>
> =A0# now make a repo, and make sure we mark *.bin files as huge
> =A0mkdir repo && cd repo && git init
> =A0echo '*.bin filter=3Dhuge' >.gitattributes
> =A0git add .gitattributes
> =A0git commit -m 'add attributes'
>
> =A0# let's do a moderate 20M file
> =A0perl -e 'print "foo\n" for (1 .. 5000000)' >foo.bin
> =A0git add foo.bin
> =A0git commit -m 'add huge file (foo)'
>
> =A0# and then another revision
> =A0perl -e 'print "bar\n" for (1 .. 5000000)' >foo.bin
> =A0git commit -a -m 'revise huge file (bar)'
>
> Notice that we just add and commit as normal. =A0And we can check tha=
t the
> space usage is what you expect:
>
> =A0$ du -sh repo/.git
> =A0196K =A0 =A0repo/.git
> =A0$ du -sh /tmp/big_storage
> =A039M =A0 =A0 /tmp/big_storage
>
> Diffs obviously are going to be less interesting, as we just see the
> hash:
>
> =A0$ git log --oneline -p foo.bin
> =A039e549c revise huge file (bar)
> =A0diff --git a/foo.bin b/foo.bin
> =A0index 281fd03..70874bd 100644
> =A0--- a/foo.bin
> =A0+++ b/foo.bin
> =A0@@ -1 +1 @@
> =A0-50a1ee265f4562721346566701fce1d06f54dd9e
> =A0+bbc2f7f191ad398fe3fcb57d885e1feacb4eae4e
> =A0845836e add huge file (foo)
> =A0diff --git a/foo.bin b/foo.bin
> =A0new file mode 100644
> =A0index 0000000..281fd03
> =A0--- /dev/null
> =A0+++ b/foo.bin
> =A0@@ -0,0 +1 @@
> =A0+50a1ee265f4562721346566701fce1d06f54dd9e
>
> but if you wanted to, you could write a custom diff driver that does
> something more meaningful with your particular binary format (it woul=
d
> have to grab from big_storage, though).
>
> Checking out other revisions works without extra action:
>
> =A0$ head -n 1 foo.bin
> =A0bar
> =A0$ git checkout HEAD^
> =A0HEAD is now at 845836e... add huge file (foo)
> =A0$ head -n 1 foo.bin
> =A0foo
>
> And since you have the filter config in your ~/.gitconfig, clones wil=
l
> just work:
>
> =A0$ git clone repo other
> =A0$ du -sh other/.git
> =A0204K =A0 =A0other/.git
> =A0$ du -sh other/foo.bin
> =A020M
>
> So conceptually it's pretty similar to yours, but the filter integrat=
ion
> means that git takes care of putting the right files in place at the
> right time.
>
> It would probably benefit a lot from caching the large binary files
> instead of hitting big_storage all the time. And probably the
> putting/getting from storage should be factored out so you can plug i=
n
> different storage. And it should all be configurable. Different users=
 of
> the same repo might want different caching policies, or to access the
> binary assets by different mechanisms or URLs.
>
>> I imagine these features (among others):
>>
>> 1. In my current setup, each large binary file has a different name =
(a
>> revision number). =A0This could be easily solved, however, by genera=
ting
>> unique names under the hood and tracking this within git.
>
> In the scheme above, we just index by their hash. So you can easily f=
sck
> your big_storage by making sure everything matches its hash (but you
> can't know that you have _all_ of the blobs needed unless you
> cross-reference with the history).
>
>> 2. A lot of the steps in my current setup are manual. =A0When I want=
 to
>> add a new binary file, I need to manually create the hash and manual=
ly
>> upload the binary to the joint server. =A0If done within git, this w=
ould
>> be automatic.
>
> I think the scheme above takes care of the manual bits.
>
>> 3. In my setup, all of the binary files are in a single "binrepo"
>> directory. =A0If done from within git, we would need a non-kludgey w=
ay
>> to allow large binaries to exist anywhere within the git tree. =A0If=
 git
>
> Any scheme, whether it uses clean/smudge filters or not, should proba=
bly
> tie in via gitattributes.
>
>> 4. User option to download all versions of all binaries, or only the
>> version necessary for the position on the current branch. =A0If you =
want
>> to be able to run all versions of the repository when offline, you c=
an
>> download all versions of all binaries. =A0If you don't need to do th=
is,
>> you can just download the versions you need. =A0Or perhaps have the
>> option to download all binaries smaller than X-bytes, but skip the b=
ig
>> ones.
>
> The scheme above will download on an as-needed basis. If caching were
> implemented, you could just make the cache infinitely big and do a "g=
it
> log -p" which would download everything. :)
>
> Probably you would also want the smudge filter to return "blob not
> available" when operating in some kind of offline mode.
>
>> 5. Command to purge all binaries in your "binrepo" that are not need=
ed
>> for the current revision (if you're running out of disk space
>> locally).
>
> In my scheme, just rm your cache directory (once it exists).
>
>> 6. Automatically upload new versions of files to the "binrepo" (rath=
er
>> than needing to do this manually)
>
> Handled by the clean filter above.
>
>
> So obviously this is not very complete. And there are a few changes t=
o
> git that could make it more efficient (e.g., letting the clean filter
> touch the file directly instead of having to make a copy via stdin). =
But
> the general idea is there, and it just needs somebody to make a nice
> polished script that is configurable, does caching, etc. I'll get to =
it
> eventually, but if you'd like to work on it, be my guest.
>
> -Peff
>
