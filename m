From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Wed, 14 Jan 2015 15:21:46 +0100
Message-ID: <20150114142146.16390.54937@typhoon.lan>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
 <xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
 <xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
 <20150112231231.GA4023@peff.net>
 <xmqqzj9n4k11.fsf@gitster.dls.corp.google.com>
 <20150113015427.GA5497@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 15:21:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBOpY-0004KL-HG
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 15:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbbANOVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 09:21:52 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:27781 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbbANOVv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2015 09:21:51 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 321a3560;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Wed, 14 Jan 2015 15:21:46 +0100 (CET)
In-Reply-To: <20150113015427.GA5497@peff.net>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262387>

On Tue, 13 Jan 2015 at 02:54:27, Jeff King wrote:
> On Mon, Jan 12, 2015 at 04:11:06PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > As an aside, I have often been tempted to have xstrdup silently
> > > propagate a NULL. It would have been the right thing to do here, but
> > > maybe there are cases where the segfault is preferable for catching a
> > > mistake early (otherwise you might store the NULL and then segfault much
> > > later).
> > 
> > Great minds think alike.  The sentence after "but maybe ..." was
> > what I had in mind as a response in anticipation that somebody might
> > suggest that; a separate xstrdup_or_null() might be fine, but I'd
> > rather not to have xstrdup() that is _too_ magical.
> 
> Yeah. Of course, it is not _that_ many more characters to do a ternary
> conditional. I guess the main benefit is that you do not have to repeat
> the name of the variable (which lets you reuse a function result
> directly, avoiding an explicit temporary).
> 
> Here's my attempt. Some cases are a little nicer, but overall, it does
> not feel significantly more readable to me. I dunno. I could go either
> way. I stuck Lukas's patch on top (modified to use xstrdup_or_null), if
> we do want to go that route. Otherwise it needs the ?: treatment.
> 
>   [1/5]: git-compat-util: add xstrdup_or_null helper
>   [2/5]: builtin/apply.c: use xstrdup_or_null instead of null_strdup
>   [3/5]: builtin/commit.c: use xstrdup_or_null instead of envdup
>   [4/5]: use xstrdup_or_null to replace ternary conditionals
>   [5/5]: blame.c: fix garbled error message
> 

Looks good to me! I am not sure whether those patches should be built on
top of (a fixed version of) my patch, though, which would make
backporting the fix to the maintenance branch straightforward. Junio?
