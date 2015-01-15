From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cosmetic bug: "git show --pretty:format" produces different output than "git show --format"
Date: Thu, 15 Jan 2015 11:25:47 -0800
Message-ID: <xmqqegqv7sn8.fsf@gitster.dls.corp.google.com>
References: <CAEKevnWfFq9gyN8Ga8zXUDwk_+Mk6RK0HVT-+sbejjVPw0U0=w@mail.gmail.com>
	<54B7E98B.6020907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Francesc Zacarias <francesc@spotify.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 20:25:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBq3H-0006PJ-C2
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 20:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbbAOTZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 14:25:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751879AbbAOTZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 14:25:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8731F2E590;
	Thu, 15 Jan 2015 14:25:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xOt1o8o8edFvMkiu1X4JQ45XW+Y=; b=PN+ImH
	hpJqjirVbew70LxjKGGiqPwa0xmv0WBJ9X1IlJN7HsnybaGz3SmCb22emWgSYjWR
	0wvNUBvrqkPZNP9f9N53AhPxK16Mf8p5DPvqqiPtGyzZ3ZvTo/3r2Rkrr/vIMTFv
	HtlnekdT8iiuxHNAk4i/xZ5IlJzjyi8Z5Yxuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZQsro4NNsPKhnNH0+uVIIaOQlq44ikY+
	SRPAGDzBODARugSSpqRYntwkcOHaHxNzuz1dWdrmr1G7czxuByp3+T9cHuusVDQg
	sH28XIjcPmkU+r7xd3sUCTlyP4dWpwX3RP0xIkHMg9am4ks1xOXI9nHT6gL1LBXr
	7NWzm1v7TsY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C5002E58F;
	Thu, 15 Jan 2015 14:25:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3DB12E58E;
	Thu, 15 Jan 2015 14:25:48 -0500 (EST)
In-Reply-To: <54B7E98B.6020907@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 15 Jan 2015 17:23:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FA1D27C-9CEC-11E4-96CE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262503>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The first part of the man page is a bit sloppy, but refers to the FORMAT
> section. There, it says that "--pretty" is equivalent to
> "--pretty=tformat:" which is different from "--pretty=format:".

It is indeed sloppy.  It says --(pretty|format)=<format> can take
these canned <format>s or 'format:<string>', but

 - it does not say it can also take 'tformat:<string>' at all; and

 - it does not say a <format> that is none of the above is dwimmed
   with 'tformat:' prefixed.

Perhaps something like this is needed.


 Documentation/pretty-options.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 8569e29..7e17af9 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,9 +3,13 @@
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw' and 'format:<string>'.  See
-	the "PRETTY FORMATS" section for some additional details for each
-	format.  When omitted, the format defaults to 'medium'.
+	'full', 'fuller', 'email', 'raw', 'format:<string>'
+	and 'tformat:<string>'.  When '<format>' is none of the above,
+	acts as if '--pretty=tformat:<format>' were given.
++
+See
+the "PRETTY FORMATS" section for some additional details for each
+format.  When omitted, the format defaults to 'medium'.
 +
 Note: you can specify the default pretty format in the repository
 configuration (see linkgit:git-config[1]).
