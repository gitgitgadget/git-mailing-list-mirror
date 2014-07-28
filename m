From: Jeff King <peff@peff.net>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 11:48:11 -0400
Message-ID: <20140728154810.GA28576@peff.net>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
 <20140728103504.GB10737@peff.net>
 <20140728104409.GC10737@peff.net>
 <CAGyf7-GVz8ME0Mq_DyHCSFCx5KN6qLGEgtgMSv2NkKb9AGEGdg@mail.gmail.com>
 <xmqqy4vd4ht3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 17:48:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBn9w-0002Vz-2r
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 17:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbaG1PsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 11:48:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:41781 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750999AbaG1PsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 11:48:15 -0400
Received: (qmail 14730 invoked by uid 102); 28 Jul 2014 15:48:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 10:48:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 11:48:11 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4vd4ht3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254326>

On Mon, Jul 28, 2014 at 08:35:52AM -0700, Junio C Hamano wrote:

> I am tempted to revert that series; it already caused "oops, this
> needs a further fix" before it hit 'master' at least once, and we do
> not want any more headaches at this point in the release cycle.

Yeah, that sounds reasonable to me. I'm a little doubtful of its value
(and maintainability) at all, but certainly I do not think it would be a
big deal to push it off for one more cycle if David wants to rework it.

If you do revert it, we may want a test like below. That will make sure
the case is covered for future attempts.

-- >8 --
Subject: [PATCH] t1402: check for refs ending with a dot

This has been illegal since cbdffe4 (check_ref_format():
tighten refname rules, 2009-03-21), but we never tested it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1402-check-ref-format.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 9aeb352..8d2f75f 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -48,6 +48,7 @@ invalid_ref './foo/bar'
 invalid_ref 'foo/./bar'
 invalid_ref 'foo/bar/.'
 invalid_ref '.refs/foo'
+invalid_ref 'refs/heads/foo.'
 invalid_ref 'heads/foo..bar'
 invalid_ref 'heads/foo?bar'
 valid_ref 'foo./bar'
-- 
2.0.0.566.gfe3e6b2
