From: Bo Chen <chen@chenirvine.org>
Subject: Re: GSoC - Some questions on the idea of
Date: Sat, 31 Mar 2012 17:27:49 -0400
Message-ID: <CA+M5ThTKtSFPq8A3oc1wvc9i0vG1NMyHCRE+poYaq+65FQWOxw@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
	<CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
	<loom.20120328T131530-717@post.gmane.org>
	<CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
	<20120330203430.GB20376@sigill.intra.peff.net>
	<4F7768D6.3010400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Sergio <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 23:27:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE5q0-00076Q-Jd
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 23:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab2CaV1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 17:27:51 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55226 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab2CaV1u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 17:27:50 -0400
Received: by wgbdr13 with SMTP id dr13so1557927wgb.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 14:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=xFHj7OI1G1de9FTXbGr24g8JTF9vTIk0B7BBhJwsrLE=;
        b=AfX0x35XjaDm+hddN8WUml9HpjMv8s1zVR5r5lmLx7qc/MnD7UwM4YvqaZ1XJq9Tik
         ZGqoccoc04R0s+WXcWdHuDJkKBtbxhzL6anuiAL/cybYY611aqVF2bXWopFC+FeWqOUe
         OmxsLbGzh4VQUZt5WpjrYuaBOyIBSscvkXO7O0Wqafnu4iq+OlrlKTPTV5cBIDGnc8am
         HsNnQIcHE7xr8n8jmshivcUeblPdE10+U7S8PLcAo88CukFqPaYnM3Q2cM2d4xP78e3f
         1ukyox3mtKaUILK8tjrsaYiN2n+y2wthd9h2OzXg5OhCydL40Tj8dwVLLTfyIcagJpVQ
         E+KQ==
Received: by 10.180.97.41 with SMTP id dx9mr10018131wib.9.1333229269229; Sat,
 31 Mar 2012 14:27:49 -0700 (PDT)
Received: by 10.216.47.65 with HTTP; Sat, 31 Mar 2012 14:27:49 -0700 (PDT)
X-Originating-IP: [69.248.109.119]
In-Reply-To: <4F7768D6.3010400@gmail.com>
X-Gm-Message-State: ALoCoQnCbiZkO95V6fNmSMpxmvpQjEBcScjxhSd3TztsiCTrTzNIX7wLV/pyyG+7ftCbnayPiknC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194465>

On Sat, Mar 31, 2012 at 4:28 PM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 3/30/2012 3:34 PM, Jeff King wrote:
>>
>> On Fri, Mar 30, 2012 at 03:51:20PM -0400, Bo Chen wrote:
>>
>>> The sub-problems of "delta for large file" problem.
>>>
>>> 1 large file
>>>
>> But let's take a step back for a moment. Forget about whether a file=
 is
>> binary or not. Imagine you want to store a very large file in git.
>>
>> What are the operations that will perform badly? How can we make the=
m
>> perform acceptably, and what tradeoffs must we make? E.g., the way t=
he
>> diff code is written, it would be very difficult to run "git diff" o=
n a
>> 2 gigabyte file. But is that actually a problem? Answering that mean=
s
>> talking about the characteristics of 2 gigabyte files, and what we
>> expect to see, and to what degree our tradeoffs will impact them.
>>
>> Here's a more concrete example. At first, even storing a 2 gigabyte =
file
>> with "git add" was painful, because we would load the whole thing in
>> memory. Repacking the repository was painful, because we had to rewr=
ite
>> the whole 2G file into a packfile. Nowadays, we stream large files
>> directly into their own packfiles, and we have to pay the I/O only o=
nce
>> (and the memory cost never). As a tradeoff, we no longer get delta
>> compression of large objects. That's OK for some large objects, like
>> movie files (which don't tend to delta well, anyway). But it's not f=
or
>> other objects, like virtual machine images, which do tend to delta w=
ell.
>>
>> So can we devise a solution which efficiently stores these
>> delta-friendly objects, without losing the performance improvements =
we
>> got with the stream-directly-to-packfile approach?
>>
>> One possible solution is breaking large files into smaller chunks us=
ing
>> something like the bupsplit algorithm (and I won't go into the detai=
ls
>> here, as links to bup have already been mentioned elsewhere, and Jun=
io's
>> patches make a start at this sort of splitting).
>>
> (I'm no expert on "big-files" in git or elsewhere, but this thread is
> immensely interesting to me as a git user who wants to track all sort=
s of
> binary files and possibly large text files in the very near future, i=
e. all
> components tied to a server build and upgrades beyond the linux-distr=
o/rpms
> and perhaps including them also.)
>
> Let's take an even bigger step back for a moment. =A0Who determines i=
f a file
> shall be a big-file or not? =A0Git or the user? =A0How is it determin=
ed if a
> file shall be a "big-file" or not?
>
> Who decides bigness:
> Bigness seems to be relative to system resources. =A0Does the user cr=
unch the
> numbers to determine if a file is big-file, or does git? =A0If the nu=
mbers are
> relative then should git query the system and make the determination?
> =A0Either way, once the system-resources are upgraded and formerly "b=
ig-files"
> are no longer considered "big" how is the previous history refactored=
 tot
> behave "non-big-file-like"? =A0Conversely, if the system-resources ar=
e
> re-distributed so that formerly non-big files are now relatively big =
(ie,
> moved from powerful central server login to laptops), how is the hist=
ory
> refactored to accommodate the newly-relative-bigness?
>

In common sense, a file of tens of MBs should not be considered as a
big file, but a file of tens of GBs should definitely be considered as
a big file. I think one simple workable solution is to let the user
set the threshold of the big file. One complicate but intelligent
solution is to let git auto-config the threshold by evaluating current
computing resources in the running platform (a physical machine or
just a VM). As to the problem of migrating git in different platforms
which equip with different computing power, the git repo should also
keep tract of under what big file threshold a specific file is
handled.


> How bigness is decided:
> There seems to be two basic types of big-files: =A0big-worktree-files=
, and
> big-history-files. =A0A big-worktree-file that is delta-friendly is n=
ot a
> big-history-file. =A0A non-big-worktree-file that is delta-unfriendly=
 is a
> big-file-history problem. =A0If you are working alone on an old compu=
ter you
> are probably more concerned about big-worktree-files (memory). =A0If =
you are
> working in a large group making lots of changes to the same files on =
a
> powerful server then you are probably more concerned about
> big-history-file-size (diskspace). =A0Of course, all are concerned ab=
out
> big-worktree-files that are delta-unfriendly.
>
> At what point is a delta-friendly file considered a "big-file"? =A0I =
assume
> that may depend on the degree delta-friendliness. =A0I imagine that a=
 text
> file and vm-image differ in delta-friendliness by several degrees.
>
> At what point(s) is a delta-unfriendly file considered a "big-file"? =
=A0I
> assume that may depend on the degree(s) of delta-unfriendliness. =A0I=
 imagine
> a compiled program and compressed-container differ in delta-unfriendl=
iness
> by several degrees.
>
> My understanding is that git does not ever delta-compress binary file=
s.
> =A0That would mean even a small-worktree-binary-file becomes a
> big-history-file over time.
>
> v/r,
> neal
