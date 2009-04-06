From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to be 
	used
Date: Sun, 5 Apr 2009 21:34:34 -0500
Message-ID: <449c10960904051934l54d2d504w1af867dc53ef7dd7@mail.gmail.com>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
	 <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
	 <20090404180601.GA14888@coredump.intra.peff.net>
	 <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
	 <20090404232505.GA26906@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0904042001540.6741@xanadu.home>
	 <449c10960904051909v5ec5d7danc10d13d9a1d613f0@mail.gmail.com>
	 <alpine.LFD.2.00.0904052220060.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 04:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqegz-0003UM-Qp
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 04:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbZDFCek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 22:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbZDFCei
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 22:34:38 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:63190 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbZDFCei convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 22:34:38 -0400
Received: by ewy9 with SMTP id 9so1721233ewy.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 19:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1SibBgT2gYkQD5/a0fDVDT6pWYiXEIs21cuy3jaYYrQ=;
        b=n9DnYz2T4cYQqze2K0R8rKFBX91V7rOFKyPMFcMCMv2Datj7rNYmE9tb3kELtYkEp3
         MeYN1h5gjiVPzwsP/kdpAuxI/5OfIZ/0e3aDXqHNOFhxkmlD3oUFf03brjifvwE0bDL5
         OTuCUKWeCHWpGcLeWkR1+nrUCsLrYLlYzJoDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O542CBIsVL+5rLgVoHU2o5MNxKbRF7sq1wj6FiXXth0AuaXvmcZNIQy9kxCHSADFbF
         BG2L4fqZffMZ+kvxEV5MMF0M9SZoFkxzQh85GBjpBSrfVlrnCJ7UxtU5P3Yywkouiu7T
         oQYOhGLBa9SdpDcfBAdZdS+0r/npQ7Wb0pxT4=
Received: by 10.216.0.81 with SMTP id 59mr1047341wea.77.1238985274547; Sun, 05 
	Apr 2009 19:34:34 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904052220060.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115753>

On Sun, Apr 5, 2009 at 9:31 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 5 Apr 2009, Dan McGee wrote:
>
>> On Sat, Apr 4, 2009 at 7:11 PM, Nicolas Pitre <nico@cam.org> wrote:
>> > On Sat, 4 Apr 2009, Jeff King wrote:
>> >
>> >> On Sat, Apr 04, 2009 at 01:20:18PM -0500, Dan McGee wrote:
>> >>
>> >> > > That makes sense to me, though I wonder if it may confuse and=
 frustrate
>> >> > > users who are expecting their awesome quad-core machine to be=
 using 4
>> >> > > threads when it only uses 2. Is it worth printing both values=
, or some
>> >> > > indicator that we could have been using more?
>> >> >
>> >> > I thought of this, but decided it wasn't really worth it. The d=
efault
>> >> > window size of 10 makes it a very rare case that you will use f=
ewer
>> >> > than 4 threads. With the default, each thread needs a minimum o=
f 20
>> >> > objects, so even a 100-object repository would spawn the 4 thre=
ads.
>> >>
>> >> Good point. Though by that logic, isn't your patch also not worth=
 it
>> >> (i.e., it is unlikely not to fill the threads, so the output will=
 be the
>> >> same with or without it)?
>> >>
>> >> I still think yours is an improvement, though, however slight.
>> >
>> > I don't think this is worth it at all.
>> >
>> > This display is there mainly to confirm expected number of availab=
le
>> > threads. =C2=A0The number of actually active threads is an impleme=
ntation
>> > detail. =C2=A0Sure if the number of objects is too low, or if the =
window size
>> > is too large, then the number of active threads will be lower. =C2=
=A0But in
>> > practice it is also possible that with some patological object set=
 you
>> > end up with 2 threads out of 4 completing very quickly and the oth=
er 2
>> > threads still busy with big objects and total remaining work set t=
oo
>> > small to split it further amongst idle threads, meaning that you'l=
l end
>> > up with only 2 busy CPUs even though the display said 4 threads
>> > initially even with this patch.
>> >
>> > In other words I don't think this patch is a good idea as we don't
>> > update the display with remaining active threads along the way.
>>
>> Why do we show this misleading at best piece of information at all
>> then? I'd rather completely remove it than show lies to the user.
>
> As you might imagine, I don't share your above appreciation.
>
>> It
>> sounds like it is only there for debugging purposes.
>
> ... which is still worthwhile nevertheless.
>
>> If we choose to keep it, I propose either accepting my patch so we a=
re
>> not mislead, or dropping the thread count completely from the output
>> and saying only something like "Using multi-threaded delta
>> compression."
>
> Your patch is not better. =C2=A0Instead, it will confuse people who
> explicitly told git to use x threads but the display might say x-y
> threads, with 0 <=3D y < x.
>
> The number currently displayed has real meaning: this is the number o=
f
> threads git is allowed to use. =C2=A0The number of threads it will ac=
tually
> use is variable and it changes with time.

Would something like this be more ideal then? I wouldn't be so
persistent here if the current text wasn't misleading in a case like
the following:

dmcgee@galway ~/projects/devtools (master)
$ git push origin
Counting objects: 13, done.
Delta compression using 4 threads.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 1.28 KiB, done.
Total 8 (delta 6), reused 0 (delta 0)
To archlinux.org:/srv/projects/git/devtools.git
   bcb0e39..ea73c2b  master -> master

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9fc3b35..99181fd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1612,7 +1612,7 @@ static void ll_find_deltas(struct object_entry
**list, unsigned list_size,
                return;
        }
        if (progress > pack_to_stdout)
-               fprintf(stderr, "Delta compression using %d threads.\n"=
,
+               fprintf(stderr, "Delta compression using up to %d threa=
ds.\n",
                                delta_search_threads);

        /* Partition the work amongst work threads. */
