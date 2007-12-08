From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: RAM consumption when working with the gcc repo
Date: Sat, 8 Dec 2007 20:12:07 +0100
Message-ID: <e5bfff550712081112xf34eb1cua95da3f9397030f0@mail.gmail.com>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
	 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
	 <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
	 <e5bfff550712071325k3d4dadf2gf34c069022cc005@mail.gmail.com>
	 <Pine.LNX.4.64.0712081153500.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, david@lang.hm,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 08 20:12:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J156J-0000eb-M4
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 20:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbXLHTMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 14:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbXLHTMJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 14:12:09 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:55875 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbXLHTMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 14:12:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1115013rvb
        for <git@vger.kernel.org>; Sat, 08 Dec 2007 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c4ZlgTmq28vTFBe+MsQdknTj71TZ9CnDpr+4MNcjSe8=;
        b=WmpSfgXNGbRf0o5rLysbx7QKD9AcNCfDPr3FO4Q8LDgZyh1JSJx0Vmtvfl5p03Wj9odJJeP2S2Q4F9zcyB8HLFCQthilQSDu3IypvOP9kRTfht9Fbg68k5ygowv5Jv0X+qPfuLEPgAUZbm7VlY45ij7hp5E50m38swHghLMzrIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ea5B2bRWCUA5sF31w4nlICXGp20iGVBTTV0Hn0bfp8lq6k7lgSo6Eai/iDUbgA5Vblx8OW0Gkphc4PVJqaZz6qpCVR3b+Tifjh0HXWXLNJomTKwOzB2BbPHpEdTvGvxwb7ak2zTA3ERmbPx08eiTIaGrUxHXDPmPdxTJSmc+bXM=
Received: by 10.141.87.13 with SMTP id p13mr3366600rvl.1197141127777;
        Sat, 08 Dec 2007 11:12:07 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 8 Dec 2007 11:12:07 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712081153500.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67564>

On Dec 8, 2007 12:54 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > BTW does exist a tool to profile memory consumption by each source level
> > struct / vector/ or any other data container?
> >
> > Valgrind checks mainly memory leaks, callgrind gives profiling
> > information in terms of call graphs and times/cycles consumed by each
> > function.
>
> Have you looked at Massif (also part of Valgrind)?
>

Only very quickly, so probably I've missed something, but anyway
that's my comment on Massiv:

- Interesting output is in html format, graph is nice but gives very
general info.

- The tool mainly tracks who called malloc and friends also going back
in the stack frame (in my box if I try to set stack deep at 4 instead
of default 3 program crashes)

- Does not seem to give information regarding the structures where
memory is allocated, only the function names that allocate directly or
indirectly the memory. Nothing like

struct my_data has 34.256 instantiations
struct stuff has 2.456 instantiations


- Relation between memory and time of allocation is IMHO a little bit
confusing, it's like a parameter obtained from multipling allocated
bytes x time, not very useful.

- Regarding the previous point, it seems missing a way to
trigger/snapshotting the memory map in terms of source level
structures used by the application in a given time, triggable through
code.

Just to be clear, the much better callgrind tool allows to insert in
the code the macros

CALLGRIND_START_INSTRUMENTATION and
CALLGRIND_STOP_INSTRUMENTATION

that start/stop recording of events in the code ranges specified by
the developer. What it seems to be missing in massif it's a macro like

MASSIV_SNAPSHOT_MEM_MAP

to be used _where_ developer needs and that gives information on heap
allocation in terms of source level entities that *use* that memory,
not low level addresses or allocator functions.


Thanks
Marco
