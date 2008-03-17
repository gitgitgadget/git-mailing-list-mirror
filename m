From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking repository
Date: Mon, 17 Mar 2008 00:48:40 -0700
Message-ID: <7v3aqpdc4n.fsf@gitster.siamese.dyndns.org>
References: <frh8dg$t9j$1@ger.gmane.org>
 <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo>
 <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161716470.19665@iabervon.org>
 <7vlk4ichm4.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803162234270.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 08:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbA6c-0008GM-Dm
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 08:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYCQHtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 03:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbYCQHtA
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 03:49:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbYCQHs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 03:48:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA1D620D4;
	Mon, 17 Mar 2008 03:48:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4FD5920D3; Mon, 17 Mar 2008 03:48:51 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803162234270.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 16 Mar 2008 22:37:53 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77416>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sun, 16 Mar 2008, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
>> > We don't currently have any concept of an invalid refspec;
>> 
>> We don't? or just that parse_ref_spec() does not detect one?
>> 
>> > ... we just have 
>> > things that fall back to not being patterns and not being possible to 
>> > match (due to one or the other side being invalid as a ref name).
>> 
>> I am afraid that is an invitation for more bugs and confusions.
>
> Yeah, we're definitely too lenient. t3200-branch has been using the 
> refspec "=" since July without anybody noticing that it's wrong.

You mean these that came in 6f084a5 (branch --track: code cleanup and
saner handling of local branches, 2007-07-10), right?

Will you fix them while you come up with a patch to tighten the parsing?
Fixing these does seem to trigger problems in later parts of the test
sequence.

---

 t/t3200-branch.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 38a90ad..48b8a45 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -155,10 +155,10 @@ test_expect_success 'test tracking setup via config' \
 
 test_expect_success 'avoid ambiguous track' '
 	git config branch.autosetupmerge true &&
-	git config remote.ambi1.url = lalala &&
-	git config remote.ambi1.fetch = refs/heads/lalala:refs/heads/master &&
-	git config remote.ambi2.url = lilili &&
-	git config remote.ambi2.fetch = refs/heads/lilili:refs/heads/master &&
+	git config remote.ambi1.url lalala &&
+	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
+	git config remote.ambi2.url lilili &&
+	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/master &&
 	git branch all1 master &&
 	test -z "$(git config branch.all1.merge)"
 '
