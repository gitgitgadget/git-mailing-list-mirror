From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2011, #01; Wed, 9)
Date: Thu, 10 Mar 2011 17:46:09 -0500
Message-ID: <20110310224609.GG15828@sigill.intra.peff.net>
References: <7v62rr933v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:46:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxoca-0004rR-So
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab1CJWqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 17:46:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49005
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab1CJWqK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:46:10 -0500
Received: (qmail 31960 invoked by uid 107); 10 Mar 2011 22:46:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 17:46:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 17:46:09 -0500
Content-Disposition: inline
In-Reply-To: <7v62rr933v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168862>

On Wed, Mar 09, 2011 at 05:27:32PM -0800, Junio C Hamano wrote:

> * jc/rename-degrade-cc-to-c (2011-01-06) 3 commits
>  . diffcore-rename: fall back to -C when -C -C busts the rename limit
>  . diffcore-rename: record filepair for rename src
>  . diffcore-rename: refactor "too many candidates" logic
> 
> Somebody said that this is an expensive no-op?

It was me, but that was not quite what I said. It is still useful to
degrade "-C -C" to "-C". But the warning message is a no-op, because the
only caller who turns it on is merge-recursive, which does not use "-C
-C". It is probably still worth doing.

We may also consider turning on the warning message for "git diff". For
"git log", I'm not so sure. It would perhaps be lost in the spew of
output, but given that we send stderr to the pager these days, with some
appropriate calls to fflush() we could make it appear in a sane place.

> * jk/trace-sifter (2011-02-24) 6 commits
>   (merged to 'next' on 2011-03-09 at 07841db)
>  + trace: give repo_setup trace its own key
>  + add packet tracing debug code
>  + trace: add trace_strbuf
>  + trace: factor out "do we want to trace" logic
>  + trace: refactor to support multiple env variables
>  + trace: add trace_vprintf
>  (this branch uses jk/strbuf-vaddf; is tangled with ab/i18n-st and jn/status-translatable.)

Hmm, I was surprised to see this make it to next. I was planning a
re-roll based on list comments (but I got held up in commit-notes, which
I needed for my re-roll :) ). I can build on top, though.

> * jk/format-patch-multiline-header (2011-02-23) 3 commits
>   (merged to 'next' on 2011-03-09 at f970fe3)
>  + format-patch: rfc2047-encode newlines in headers
>  + format-patch: wrap long header lines
>  + strbuf: add fixed-length version of add_wrapped_text

I have a patch to make "format-patch -k" preserve newlines in subjects;
the result behaves sensibly with both "am" (which munges it to one line)
and "am -k" (which preserves the newlines).  Did we want to follow-up
with that or no?

-Peff
