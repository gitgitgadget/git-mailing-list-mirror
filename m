From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Mon, 9 Aug 2010 12:50:30 -0400
Message-ID: <AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr> <AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
 <87ocdhlgbl.fsf@kanis.fr> <AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
 <AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
 <87hbj74pve.fsf@kanis.fr> <AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
 <wesy6cgm6wd.fsf_-_@kanis.fr> <AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com>
 <westyn3n3sa.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, jnareb@gmail.com, git <git@vger.kernel.org>
To: Ivan Kanis <expire-by-2010-08-14@kanis.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:52:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVaE-0006Ty-Bb
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157Ab0HIQwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 12:52:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57878 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124Ab0HIQwL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 12:52:11 -0400
Received: by wyb39 with SMTP id 39so209161wyb.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bKDRL1iO0M6DuyHBuICoE8mm59HcrQkU69AFuM4mA8c=;
        b=QJgNNP2wYfevRG5UF9tFACA7TuCb8qiSWLjgEbrBz5PGFEBTBdi3NVsSzvOQWetHqm
         egZLDNHQft9nOffGmrgEIvQ02v2yDXwRL10UK35dePrguTZs4KIPbccYwrNeW+sQ4YYy
         GOqH1s8/jmKXH4eL+rfyUNpyjnE/3mTd2JF2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sNJpe9vOTgtdPdukW+lSNxI7jgv/5Cp66GxsE9e0ZS4ddUY4WldhIqAiuE8upBfHSX
         sHknYVv1KW7wicdZpnZFrOt/P83DuzNAXKO7jutL4vbRC+6ltLRwdSiznjz3jdgN8JaQ
         geNZ0eFJBAQdlkg7q0xFez6/zWhpGGEfLG5LY=
Received: by 10.216.162.72 with SMTP id x50mr2879083wek.3.1281372650140; Mon,
 09 Aug 2010 09:50:50 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Mon, 9 Aug 2010 09:50:30 -0700 (PDT)
In-Reply-To: <westyn3n3sa.fsf@kanis.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152983>

On Mon, Aug 9, 2010 at 12:34 PM, Ivan Kanis
<expire-by-2010-08-14@kanis.fr> wrote:
> Dmitry Potapov <dpotapov@gmail.com> wrote:
>> On 64-bit architecture, you have plenty virtual space, and mapping
>> a file to memory should not take much physical memory (only space
>> needed for system tables).
>
> What I can tell from the mmap man page is that it should map memory t=
o a
> file. I assume it shouldn't take up physical memory. However I am see=
ing
> physical memory being consumed. It might be a feature of the kernel. =
Is
> there a way to turn it off?

'ps axu' will show two columns: VSIZE and RSS.  The only one that
actually matters is RSS.

When you mmap a file, it will immediately consume a lot of VSIZE - but
this won't affect your available system memory, because you have only
consumed "virtual" memory.  Instead of swapping that memory out to the
swap file, the kernel knows that this chunk of virtual memory is
already on disk - inside the mmap'd file.

When you access some of the pages of the mmap'd file, the kernel will
swap those pages into memory, which increases RSS.  This uses *real*
memory on the system.

As git generates a new pack file, it needs to access every single page
of every single pack that it's reading from, so eventually, all the
stuff you need will get sucked into RSS, so you'll see that number
grow and grow.  If your packfiles are huge, this is a lot of memory.

Now, the kernel is supposed to be smart enough to release old pages
out of RSS if you stop using them; it's no different from what the
kernel does with any cached file data.  So it shouldn't be expensive
to mmap instead of just reading the file.

> Looking some more into it today the bulk of the memory allocation
> happens in write_pack_file in the following loop.
>
> for (; i < nr_objects; i++) {
> =A0 =A0if (!write_one(f, objects + i, &offset))
> =A0 =A0 =A0 =A0break;
> =A0 =A0display_progress(progress_state, written);
> }
>
> This eventually calls write_object, here I am wondering if the
> unuse_pack function is doing its job. As far as I can tell it writes =
a
> null in memory, that I think is not enough to reclaim memory.

What do you mean by the "memory allocation" happens here?  How are you
measuring it?

unuse_pack indeed doesn't free any memory; it just zeroes a pointer
and decreases a refcount.  I don't know much about this code, but I
assume something else goes and cleans up the mmaps later.

In any case, mmap/munmap have little to do with your "real" memory
usage.  munmap() won't free any actual kernel memory; the used pages
will still be floating around in disk cache.

> I also looked at the use_pack function where the mmap is
> happening. Would it be worth refactoring this function so that it use=
s
> an index withing a file instead of mmap?
>
> Unless I hear of a better idea I'll be trying that tomorrow...

I wouldn't expect this to help, but I would be interested to hear if it=
 does.

If the problem is simply that you're flooding the kernel disk cache
with data you'll use only once, to the detriment of everything else on
the system, then one thing that might help could be posix_fadvise:

    posix_fadvise(fd, ofs, len, POSIX_FADV_DONTNEED);

bup uses this when backing up huge files, since it knows it's only
going to use each block once, and this seemed to decrease system load
(without affecting bup's own performance) in some test cases.
However, it uses this for filesystem files, not packs, so it's a
different use case.

On the other hand, perhaps a more important question is: why does git
feel like it needs to generate entirely new packs for each person
doing a clone on your system?  Shouldn't it be reusing existing ones
and just streaming them straight out to the recipient?

Have fun,

Avery
