From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 01:35:11 -0700
Message-ID: <7vk4sdm5kw.fsf@alter.siamese.dyndns.org>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
 <4BC2D61B.7050902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Hajnoczi <stefanha@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 10:35:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1F79-0002Ff-PF
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 10:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab0DLIfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 04:35:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab0DLIfX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 04:35:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3AC9A8364;
	Mon, 12 Apr 2010 04:35:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zLrbnNR8WjSPeEMJZ9gEe6xzW8U=; b=UNnnp/
	brnPbijCiBsbiE7FxcbkN4drCln/9739Uo7QNJ4nv8RlqU1+mslGAJKHf9rgYlY4
	vcxiLK4nFHsI3yQP93y05rwpK0J4tcdYAQixHI60rZXtCFo4XrLxw8kM+qfQTStd
	Cuuszo9gU/yjz2K9FfvU+7P6I67YezzNjnbuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bard9Lqah4xwXTDlsfgKYKMx1QYQjQWS
	FgZx1kqdWxrJ7sn1uPIAvYdsGr6ecvaB7XkpOVzrOzFn/W+4ZaNPwFVJ5QTDG+q4
	gzdUmud1k1fcnYt1W+55ZOQ/Xp7F+dipaZGTZaBJBsAhAYefj2WnusvnL+49R0fk
	7jqeEY1PdY8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6971A8362;
	Mon, 12 Apr 2010 04:35:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05E31A835C; Mon, 12 Apr
 2010 04:35:12 -0400 (EDT)
In-Reply-To: <4BC2D61B.7050902@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 12 Apr 2010 16\:13\:15 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 522BE27E-460E-11DF-A251-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144713>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> have you tried setting it to an empty value?

That sounds like a useful thing in general even outside override context.
I however suspect that the code is not written carefully to check for
empty string (which cannot possibly mean any valid username).

Perhaps we would need something like this.

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ce569a9..7c3f7c1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1043,7 +1043,7 @@ X-Mailer: git-send-email $gitversion
 			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
 		}
 
-		if (defined $smtp_authuser) {
+		if (defined $smtp_authuser && $smtp_authuser ne '') {
 
 			if (!defined $smtp_authpass) {
 
