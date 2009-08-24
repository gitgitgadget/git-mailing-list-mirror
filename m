From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
Date: Sun, 23 Aug 2009 22:36:15 -0700
Message-ID: <7vmy5pojsg.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <20090823171819.6117@nanako3.lavabit.com>
 <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
 <20090824060708.6117@nanako3.lavabit.com>
 <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
 <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic>
 <7vk50tq0g5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thell Fowler <git@tbfowler.name>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 07:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfSEX-0004SS-Fi
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 07:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbZHXFgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 01:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbZHXFgf
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 01:36:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZHXFge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 01:36:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E27C165CC;
	Mon, 24 Aug 2009 01:36:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HhdJ+pjfEUYxwb6byF9BotpuSKI=; b=LUGTzi
	L5wflsmxIU69/SaFEHlMESNzcjrHusqQaWyc3k08ux6jBXUffyx+gGFaY8JZi2eD
	zVMscW0iiBZFcMgdQbtI4zxePEg3WlYfULS1wb/tcG0IPGi5SlRUxHSPVPx+3XKY
	MHxYZYvG0g51BwYYmB0XrYvhe2bHRA9Nuq2TI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=arMuSPtOM+FJP+X3B+Hm//GdmzMTg2w6
	R+befAK7DdWtn+zHV7GMcSZRvVLI9/AD+RXdAOm9R/UlbXY4GKM6m+Dl2nZ+r6Is
	bgc498605OpOC8Rn/5IHVp/19XV/S91KS1qMUNw9wmdx+FwplSkxaMGhWamUGoTD
	wgtLBDh/0JQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B787E165C7;
	Mon, 24 Aug 2009 01:36:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE814165C3; Mon, 24 Aug
 2009 01:36:16 -0400 (EDT)
In-Reply-To: <7vk50tq0g5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 23 Aug 2009 21\:51\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1300BA60-9070-11DE-8520-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126907>

Try this patch, perhaps?  I forgot to reset the mysteriously named s_hdr
buffer.

Does anybody remember what these s_hdr (vs p_hdr) buffers stand for, by
the way?

 -- >8 -- cut here -- >8 --
Subject: [PATCH] squashme to 925bd84 (Teach mailinfo to ignore everything before -- >8 -- mark, 2009-08-23)

 builtin-mailinfo.c  |    6 ++++++
 t/t5100/sample.mbox |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 26548f0..8a3a184 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -758,9 +758,15 @@ static int handle_commit_msg(struct strbuf *line)
 	}
 
 	if (scissors(line)) {
+		int i;
 		rewind(cmitmsg);
 		ftruncate(fileno(cmitmsg), 0);
 		still_looking = 1;
+		for (i = 0; header[i]; i++) {
+			if (s_hdr_data[i])
+				strbuf_release(s_hdr_data[i]);
+			s_hdr_data[i] = NULL;
+		}
 		return 0;
 	}
 
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 95b6842..2c3da52 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -566,10 +566,14 @@ From: Junio Hamano <junkio@cox.net>
 Date: Thu, 20 Aug 2009 17:18:22 -0700
 Subject: Why doesn't git-am does not like >8 scissors mark?
 
+Subject: [PATCH] BLAH ONE
+
 In real life, we will see a discussion that inspired this patch
 discussing related and unrelated things around >8 scissors mark
 in this part of the message.
 
+Subject: [PATCH] BLAH TWO
+
 And the we will see the scissors.
 
 -- >8 -- cut here -- 8< --
