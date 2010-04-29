From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Multiblobs
Date: Wed, 28 Apr 2010 20:44:07 -0400
Message-ID: <h2w32541b131004281744xea800f1eq9459bbe462ba3a1e@mail.gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> 
	<loom.20100428T204406-308@post.gmane.org> <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com> 
	<loom.20100429T010742-199@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 29 02:44:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7Hrn-0000LL-Ln
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 02:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab0D2Aoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 20:44:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37330 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0D2Ao3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 20:44:29 -0400
Received: by gyg13 with SMTP id 13so7663918gyg.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 17:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=InKjzguoKp6HiKgZLTvHBKACccES2yR7owPhTB1V6xs=;
        b=rj7FEqqHb2JGz7z/vSUt0VfDGdsT34t21rxFmzQT26Na2ysI4/bGClmoqswtrtI4Lk
         IWRU5tmIlJi2JNxumAnUmxt0T6w8qaqYm8vbovgCnI1ztihmcGTZJImxFiUrCRFyBESu
         CSMciHlMdXjKTGiozpY8nNOmGu1dbYMVwvtCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JlHpkzo1GJck0vovRjyGpgBiuou+TV4sGCwuexqMa27rLx/c7jC2Elayd94c64bp20
         JQqLo+/K2kvU8lqv4RrAtnp/TixokCzCa3oeJkvTpZtoGwlAq24uxcwgv80FsxBVDIp2
         cT9HPPWOM7perdbW1q1uudwkP7upFz4NS6Lr0=
Received: by 10.150.66.8 with SMTP id o8mr1038643yba.28.1272501867840; Wed, 28 
	Apr 2010 17:44:27 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Wed, 28 Apr 2010 17:44:07 -0700 (PDT)
In-Reply-To: <loom.20100429T010742-199@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146023>

On Wed, Apr 28, 2010 at 7:26 PM, Sergio <sergio.callegari@gmail.com> wr=
ote:
> Avery Pennarun <apenwarr <at> gmail.com> writes:
>> But why not use a .gitattributes filter to recompress the zip/odp fi=
le
>> with no compression, as I suggested? =A0Then you can just dump the w=
hole
>> thing into git directly. =A0When you change the file, only the chang=
es
>> need to be stored thanks to delta compression. =A0Unless your
>> presentation is hundreds of megs in size, git should be able to hand=
le
>> that just fine already.
>
> Actually, I'm doing so... =A0But in some occasions odf file that shar=
e many
> components do not delta, even when passed through a filter that uncom=
presses
> them. Multiblobs are like taking advantage of a known structure to ge=
t better
> deltas.

Hmm, it might be a good idea to investigate the specific reasons why
that's not working.  Fixing it may be easier (and help more people)
than introducing a whole new infrastructure for these multiblobs.

>> But then you're digging around inside the pdf file by hand, which is=
 a
>> lot of pdf-specific work that probably doesn't belong inside git.
>
> I perfectly agree that git should not know about the inner structure =
of things
> like PDFs, Zips, Tars, Jars, whatever. But having an infrastructure a=
llowing
> multiblobs and attributes like clean/smudge to trigger creation and u=
se of
> multiblobs with user provided split/unsplit drivers could be nice.

Yes, it could.  Sorry to be playing the devil's advocate :)

>> Worse, because compression programs don't always produce the same
>> output, this operation would most likely actually *change* the hash =
of
>> your pdf file as you do it.
>
> This should depend on the split/unsplit driver that you write. If you=
r driver
> stores a sufficient amount of metadata about the streams and their or=
der, you
> should be able to recreate the original file.

Almost.  The one thing you can't count on replicating reliably is
compression.  If you use git-zlib the first time, and git-zlib the
second time with the same settings, of course the results will be
identical each time.  But if the original file used Acrobat-zlib, and
your new one uses git-zlib, the most likely situation is the files
will be functionally identical but not the same stream of bytes, and
that could be a problem.  (Then again, maybe it's not a problem in
some use cases.)

Another danger of this method is that different versions of git may
have slightly different versions of zlib that compress slightly
differently.  In that case, you'd (rather surprisingly) end up with
different output files depending which version of git you use to check
them out.  Maybe that's manageable, though.

>> In what way? =A0I doubt you'd get more efficient storage, at least.
>> Git's deltas are awfully hard to beat.
>
> Using the known structure of the file, you automatically identify the=
 bits that
> are identical and you save the need to find a delta altogether.

bup avoids the need to find a delta altogether.  This isn't entirely a
good thing; it's a necessity because it processes huge amounts of data
and doing deltas across it all would be ungodly slow.

However, in all my tests (except with massively self-redundant files
like VMware images) deltas are at least somewhat smaller than bup
deduplication.  This isn't surprising, since deltas can eliminate
duplication on a byte-by-byte level, while bup chunks have a much
larger threshold (around 8k).

So I question the idea that this method would actually save any space
over git's existing deltas.  CPU time, yes, but only really during gc,
and you can run gc overnight while you're not waiting for it.

>> In that case, I'd like to see some comparisons of real numbers
>> (memory, disk usage, CPU usage) when storing your openoffice documen=
ts
>> (using the .gitattributes filter, of course). =A0I can't really imag=
ine
>> how splitting the files into more pieces would really improve disk
>> space usage, at least.
>
> I'll try to isolate test cases, making test repos:
>
> a) with 1 odf file changing a little on each checkin
> b) the same storing the odf file with no compression with a suitable =
filter
> c) the same storing the tree inside the odf file.

This sounds like it would be quite interesting to see.  I would also
be interested in d) the test from (b) using bup instead of git.

You might also want to compare results with 'git gc' vs. 'git gc --aggr=
essive'.

>> Having done some tests while writing bup, my experience has been tha=
t
>> chunking-without-deltas is great for these situations:
>> 1) you have the same data shared across *multiple* files (eg. the sa=
me
>> images in lots of openoffice documents with different filenames);
>> 2) you have the same data *repeated* in the same file at large
>> distances (so that gzip compression doesn't catch it; eg. VMware
>> images)
>> 3) your file is too big to work with the delta compressor (eg. VMwar=
e images).
>
> An aside: bup is great!!! Thanks!

Glad you like it :)

Have fun,

Avery
