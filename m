From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 08:41:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605310822490.4449@virtualbox>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr> <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr> <alpine.DEB.2.20.1605301326530.4449@virtualbox> <574CFF75.3090805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, matthieu.moy@grenoble-inp.fr
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 31 08:42:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7dNQ-000467-Bh
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 08:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbcEaGmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 02:42:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:60644 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbcEaGmD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 02:42:03 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mgt3g-1auUEc1KfQ-00M4Bf; Tue, 31 May 2016 08:41:54
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <574CFF75.3090805@alum.mit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:L/ocRD6hwVS2/fjD5ec6HlBK1MW1lr5t0Fn7+EnwZ6nUKghHjdp
 UqfW5hWpWPYzQjHu+TSCWRmwWkpsgKAmurY473+UvEmfDyj8VtcZoRGpVwuqsmMtT/IXFxM
 0SvcJxo6tyV0wcgh6jdbfxb5lKT40j2CXboYe36IIFq8myLh75FugiHj1XyGUJ0wMEF4ywl
 bu98GQcKOXbC8ZquSOTig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7PXyqXrYHeg=:xGoPaUr4Tc5f+gYOqL+FWY
 45LrjmPBFWHXeUDq3gGXcpGgHmUizRp76R26kW2eaHAllYUh9YDIFCjPW26l27ye6lE0QwHW6
 q+FcMgd+bAKPFfxq/hxbkY07IAi3bYCoSSjJi22woRGYRD+uuIa5fu077xFeZGni1aurAAUSm
 nqGwQRImjZxOI7MiRKgrwArsbxuktcjq+Wnt/IeS7mMgQL5RY14K7jtmpSimkSBkQWMt4Koix
 iPjiGdI91Z95dIgzomoq/lx3ThjONRFZiDt/W2chViwa2PNBIfbmp5ga2tXaORJ+4E4ge5aLs
 ENNpKrGiccS5O2++OEypDNcppkveXqAaSXR5P2DDU6mYvim5XkBaddG/pyBzs3hw4Kk5Fj2TB
 DAdGo45+NSRp7TsTGiL05R/u+7achliW5SA6mmcC6x/QxCb9lVJLncHV+9rMVPE+3G1FHSm+n
 4GnQ7Rnlv9wam97sC6TZqhsbpDmQxttWNxTkR2DvyhO//Me7kOgK3nQBNnoHQwdTnK9X0OK6N
 EdaNk2s/TbAQZuXkwH/iXAAjkUzyCEXI5bunFOHoR14TcjnBLsB9DRCiBOxpHmQMiTQZ/6orB
 iEtM9pyTF47J23g+jOartOAnICy330myOOcErdcDLExMc/BmF9DCbr+2/FkiRX/1Vvuonermh
 pr95QnD0IKwDhRWtBQe3rr0kJQAb+rGFLGw5g/uYZ9GfVisRdCw6qwabAHSIRdMmBOT4IOLkM
 HCdpVg1BuaBBvKag9AhEWXjk1lWIbcwi/s0BR+Oq+8S3ZkvK6FZ0/G1omu26F47MOtOM2hyY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295960>

Hi Michael,

On Tue, 31 May 2016, Michael Haggerty wrote:

> On 05/30/2016 02:13 PM, Johannes Schindelin wrote:
> > [...]
> >> @@ -38,7 +67,11 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
> >>  {
> >>  	char *res;
> >>  	strbuf_grow(sb, 0);
> >> -	res = sb->buf;
> >> +	if (sb->flags & STRBUF_OWNS_MEMORY)
> >> +		res = sb->buf;
> >> +	else
> >> +		res = xmemdupz(sb->buf, sb->alloc - 1);
> > 
> > This looks like a usage to be avoided: if we plan to detach the buffer,
> > anyway, there is no good reason to allocate it on the heap first. I would
> > at least issue a warning here.
> 
> I think this last case should be changed to
> 
>     res = xmemdupz(sb->buf, sb->len);
> 
> Johannes, if this change is made then I think that there is a reasonable
> use case for calling `strbuf_detach()` on a strbuf that wraps a
> stack-allocated string, so I don't think that a warning is needed.
> 
> I think this change makes sense. After all, once a caller detaches a
> string, it is probably not planning on growing/shrinking it anymore, so
> any more space than that would probably be wasted. In fact, since the
> caller has no way to ask how much extra space the detached string has
> allocated, it is almost guaranteed that the space would be wasted.

Ah, I did not think of that. (We could of course introduce
strbuf_realloc_snugly() or some such, but I agree: why?) So the best
counter-example to my objection might be something like this:

-- snip --
Subject: git_pathdup(): avoid realloc()

When generating Git paths, we already know the maximum length:
MAX_PATH. Let's avoid realloc()-caused fragmentation by using a
fixed buffer.

As a side effect, we avoid overallocating the end result, too:
previously, strbuf_detach() would not realloc() to avoid wasting
the (sb->alloc - sb->len) bytes, while it malloc()s the precisely
needed amount of memory when detaching fixed buffers.

diff --git a/path.c b/path.c
index 2511d8a..64fd3ee 100644
--- a/path.c
+++ b/path.c
@@ -426,7 +426,8 @@ const char *git_path(const char *fmt, ...)
 
 char *git_pathdup(const char *fmt, ...)
 {
-	struct strbuf path = STRBUF_INIT;
+	char buffer[MAX_PATH];
+	struct strbuf path = STRBUF_WRAP_FIXED(buffer);
 	va_list args;
 	va_start(args, fmt);
 	do_git_path(&path, fmt, args);
-- snap --

Color me convinced,
Dscho
