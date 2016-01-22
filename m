From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge
 markers
Date: Fri, 22 Jan 2016 19:47:38 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601221937440.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de> <xmqqmvrxv5tn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:47:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMgkQ-0000D1-4C
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 19:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbcAVSrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 13:47:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:56635 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389AbcAVSrp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 13:47:45 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LeMij-1ZmkNS2qGT-00q9sj; Fri, 22 Jan 2016 19:47:39
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqmvrxv5tn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:o/JHbnsqomGNk+dBqk7DaKLnFikGO5rOBBDDoxr1V1UOUM32esL
 CzEBgj8+PUhL6S8HjSE9IYsGofWu2BYF4OdRR7M2tvC8ti65LUYiU58oOUqlzKFIn9PHq91
 +w31a9oO9+8LgR8z3RAmZZQGW6Opdfm/DvZ5tsqGF8FkYATHWw0HO7lz2KKc0rINzSCUecW
 ZjWf9CZcXANZ2Z5lxk2qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w7xo0bCSMjw=:HLx9wADEnHDVavTWOqFqrn
 3LT12lUH5JQCuTyGhR0/hpojl69pwaFGT4X0Qd7Tvb7+PT0+g+/RtzJPK4cq0voY7PfR0MZh4
 k923pw+DI5AjFdNlTmZ6A79QLgEKW/xBUtVtyVGCgCDhXiolz/HkGkAq5k93qMVchPzFwsFUE
 9uLDTTwXpkRX0JNcC2Gd4yw52FIT4K68QQ3QUnLc8Ml31s8iDRBO6qHfOteXq2PS2WkIghUym
 5Rp9KcrPJYsSxqIs2hv8pguxysDwJZWEp4wy6BGphJYMq1T6Al39PzEMMrJ4CMFYxZarAHPtX
 U5ZJfvuKpkPG9G04zbFRuS4s64flQAdVaEaIgH5JqmOxcKhTpt7/ZtAS2pebH5281e4j46k6q
 9rt5ivEX+Xx7p/TEsXH+QG+HWrv0pvPfcJZLtUx/haRZw4W7Ufl05FlhqQFUaMJIfL1RMkMgU
 aTH3OGcgMjv6wwV5NB44JVsW7LBoXeCu8wtn16qFxVh54FZkZ089DI+uECETRIwT4YUzg6mUk
 1m0wysptlWrshmH7QVzdqCMIs3iMLBPZ/8WDZ1vtzvhmiahbWLZ/SbCng2zqvgm/Juy+pjLL8
 gLwociN+YwDKISGamlzSC2kB3uPXF5WIFh6kRWAaZfxcx0ZUr46XQNVh9Kxi8/+sehjx0A7xD
 F7XHxzMCNtEcmnVJ99KPbgVXeX40e1gsg0j7dSnu47kvUtNuIVp/ZMwcyP8WyHJkyA1gliRoY
 MoFDvNl7OgA4qGAMM8JGVp54hpSmWAOjhSvjR9gnAeWDAb4Z9Ju/A+HuOxGOOqXIC8DSfs6b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284578>

Hi Junio,

On Fri, 22 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The original version of this patch also modified ll_merge(), but that
> > was incorrect: low-level merge operates on blobs, not on working
> > files.  Therefore, the data passed to the low-level merge, as well as
> > its result, is expected to have LF-only line endings.
> >
> > It is the duty of ll_merge()'s *caller* (in case of Git's `merge`
> > command, the merge_content() function) to convert the merge result
> > into the correct working file contents, and ll_merge() should not muck
> > with line endings at all.
> 
> Hmph, aren't there people who use CRLF throughout their set-up (that is,
> it is normal for both of their blobs and working tree files to use CRLF
> line endings)?  Or is such a setting illegal and unsupported?

Good point.

While I would love to simply not support such a case, it would be turning
a blind eye to reality.

So I guess I need another patch like this (plus a test case):

-- snipsnap --
t a/ll-merge.c b/ll-merge.c
index 0338630..4a565c8 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -111,6 +111,7 @@ static int ll_xdl_merge(const struct ll_merge_driver
*drv_unused,
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size = marker_size;
+	xmp.crlf = eol_for_path(NULL, src1->ptr, src1->size) == EOL_CRLF;
 	xmp.ancestor = orig_name;
 	xmp.file1 = name1;
 	xmp.file2 = name2;
