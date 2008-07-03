From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix describe --tags --long so it does not segfault
Date: Wed, 02 Jul 2008 21:23:28 -0700
Message-ID: <7vvdzn4mv3.fsf@gitster.siamese.dyndns.org>
References: <20080703023245.GA31579@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mikael Magnusson <mikachu@gmail.com>,
	Mark Burton <markb@ordern.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7j-0002yW-70
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbYGCG7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbYGCG5t
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYGCEXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 00:23:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D6686BA6C;
	Thu,  3 Jul 2008 00:23:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EA8C0BA6A; Thu,  3 Jul 2008 00:23:31 -0400 (EDT)
In-Reply-To: <20080703023245.GA31579@spearce.org> (Shawn O. Pearce's message
 of "Thu, 3 Jul 2008 02:32:45 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CE519EF8-48B7-11DD-85BF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87247>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If we match a lightweight (non-annotated tag) as the name to
> output and --long was requested we do not have a tag, nor do
> we have a tagged object to display.  Instead we must use the
> object we were passed as input for the long format display.
>
> Reported-by: Mark Burton <markb@ordern.com>
> Backtraced-by: Mikael Magnusson <mikachu@gmail.com>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
>  Thanks Mikael, the backtrace really made it easy to figure out
>  what the breakage was here.

Thanks.  I'll squash this in and apply to 'maint'.  Perhaps 1.5.6.2
after the 4th holiday.

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index c6be259..2fb672c 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -139,4 +139,6 @@ check_describe "test1-lightweight-*" --tags --match="test1-*"
 
 check_describe "test2-lightweight-*" --tags --match="test2-*"
 
+check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
+
 test_done
