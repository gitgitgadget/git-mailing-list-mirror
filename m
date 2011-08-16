From: "Christopher M. Fuhrman" <cfuhrman@panix.com>
Subject: Re: [PATCH/RFC] gitweb: highlight: strip non-printable characters
 via col(1)
Date: Tue, 16 Aug 2011 14:32:12 -0700 (PDT)
Message-ID: <alpine.NEB.2.01.1108161414030.7527@vc75.vc.panix.com>
References: <1313518605-26460-1-git-send-email-cfuhrman@panix.com> <4E4AD35E.8060907@eaglescrag.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jnareb@gmail.com, cwilson@cdwilson.us,
	sylvain@abstraction.fr
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 23:32:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtRFC-00044o-Mq
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 23:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1HPVcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 17:32:13 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:35235 "EHLO
	mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab1HPVcN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 17:32:13 -0400
Received: from vc75.vc.panix.com (vc75.vc.panix.com [166.84.7.75])
	by mailbackend.panix.com (Postfix) with ESMTP id 6433C34B07;
	Tue, 16 Aug 2011 17:32:12 -0400 (EDT)
X-X-Sender: cfuhrman@vc75.vc.panix.com
In-Reply-To: <4E4AD35E.8060907@eaglescrag.net>
User-Agent: Alpine 2.01 (NEB 1266 2009-07-14)
X-OpenPGP-Key-ID: F37818CF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179478>

On Tue, 16 Aug 2011 at 1:30pm, J.H. wrote:

> On 08/16/2011 11:16 AM, Christopher M. Fuhrman wrote:
> > From: "Christopher M. Fuhrman" <cfuhrman@panix.com>
> >
> > The current code, as is, passes control characters, such as form-feed
> > (^L) to highlight which then passes it through to the browser.  This
> > will cause the browser to display one of the following warnings:
> >

<snip>

> > Strip non-printable control-characters by piping the output produced
> > by git-cat-file(1) to col(1) as follows:
> >
> >   git cat-file blob deadbeef314159 | col -bx | highlight <args>
>
> So my only real concern here is that `col` itself is going to munge
> whitespace.  Quoting from the col man page:
>
> 	[...] and replaces white-space characters with tabs where
> 	    possible. [...]

I figured that would be a concern which is why I added the -x option.
From the col(1) man page:

  -x        Output multiple spaces instead of tabs.

I also took a diff between two XHTML files.  One that used col -bx and one
that didn't.  Here's the results:

--- withoutcol.xhtml	2011-08-16 14:11:39.000000000 -0700
+++ withcol.xhtml	2011-08-16 14:11:26.000000000 -0700
@@ -52,7 +52,7 @@
 <span class="hl dir"># define DBG_CFG(args)</span>
 <span class="hl dir">#endif</span>

-
+
 <span class="hl com">/*</span>
 <span class="hl com"> * Routines to access TIG registers.</span>
 <span class="hl com"> */</span>
@@ -76,7 +76,7 @@
         <span class="hl sym">*</span>tig_addr <span class="hl sym">= (</span><span class="hl kwb">unsigned long</span><span class="hl sym">)</span>value<span class="hl sym">;</span>
 <span class="hl sym">}</span>

-
+
 <span class="hl com">/*</span>
 <span class="hl com"> * Given a bus, device, and function number, compute resulting</span>
 <span class="hl com"> * configuration space address</span>
@@ -197,7 +197,7 @@
         <span class="hl sym">.</span>write <span class="hl sym">=</span>        titan_write_config<span class="hl sym">,</span>
 <span class="hl sym">};</span>

(remainder stripped)

>
> Have you actually run into a situation where something like ^L was
> present in a blob that was being passed to highlight?
>

I've seen ^L is the Linux kernel source tree as well as the NetBSD src
tree.  I've not encountered it elsewhere although I would think it would
be present depending on personal/corporate coding preferences.

> - John

Cheers!

-- 
Chris Fuhrman
cfuhrman@panix.com
