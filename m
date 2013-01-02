From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless
 configure.ac changed
Date: Wed, 02 Jan 2013 08:50:57 -0800
Message-ID: <7va9sr4jgu.fsf@alter.siamese.dyndns.org>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
 <20130102072141.GB18974@elie.Belkin>
 <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
 <20130102082544.GD18974@elie.Belkin>
 <20130102083837.GA9328@sigill.intra.peff.net>
 <20130102084807.GB22919@elie.Belkin> <50E4409B.4070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	git <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRXF-0002b7-1W
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3ABQvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:51:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab3ABQvA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:51:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4B5CB90F;
	Wed,  2 Jan 2013 11:50:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6jU0OaDNzHEYxq1mlPPgXgffsN0=; b=ZA11Ja
	9twBNG1CJMYGTPR9jbTrERRPZXn3r35haEvs5ynOrvBSoNQ4ElJJZvuEgeEbOF/2
	qo2/EHURn7brIBGa7i0ulrcso3UXfSOkqgmFF8xKW+i1isvvzGuTEXXtLtiUTSbC
	HG8C7aGZObPlwrSYBbIRh/8zoM5lUjStWgnxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoFFrWywZyacs9lk0KpD56Rt7MkJU8Xp
	q6nWpRHgS9YI0bvaKVzRueayUthJCCt/IKnhE1A6XyKlTUtnb4n5GnaXNyIt/LTj
	KIVObDT89//unvxKkWWTmO9gzhqqkx13TiTzDvRAY5fRX6CG1prZ29T/jrxjORes
	bEjFd9IQLfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7789B90E;
	Wed,  2 Jan 2013 11:50:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0354CB90D; Wed,  2 Jan 2013
 11:50:58 -0500 (EST)
In-Reply-To: <50E4409B.4070203@gmail.com> (Stefano Lattarini's message of
 "Wed, 02 Jan 2013 15:13:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9570E818-54FC-11E2-8258-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212526>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 01/02/2013 09:48 AM, Jonathan Nieder wrote:
>> Jeff King wrote:
>> 
>>> It seems I am late to the party. But FWIW, this looks the most sane to
>>> me of the patches posted in this thread.
>> ...
> FYI, this seems a sane approach to me....
> The only nit I have to offer is that I'd like to see more comments in
> the git Makefile about why this "semi-hack" is needed.

Thanks, everybody.

Please eyeball the below for (hopefully) the last time, to be
eventually merged to maint-1.7.12, maint-1.8.0 and maint (aka
maint-1.8.1) branches.

-- >8 --
From: Jonathan Nieder <jrnieder@gmail.com>
Date: Wed, 2 Jan 2013 00:25:44 -0800
Subject: [PATCH] build: do not automatically reconfigure unless configure.ac changed

Starting with v1.7.12-rc0~4^2 (build: reconfigure automatically if
configure.ac changes, 2012-07-19), "config.status --recheck" is
automatically run every time the "configure" script changes.  In
particular, that means the configuration procedure repeats whenever
the version number changes (since the configure script changes to
support "./configure --version" and "./configure --help"), making
bisecting painfully slow.

The intent was to make the reconfiguration process only trigger for
changes to configure.ac's logic.  Tweak the Makefile rule to match
that intent by depending on configure.ac instead of configure.

Reported-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 26b697d..2f5e2ab 100644
--- a/Makefile
+++ b/Makefile
@@ -2167,8 +2167,14 @@ configure: configure.ac GIT-VERSION-FILE
 	$(RM) $<+
 
 ifdef AUTOCONFIGURED
-config.status: configure
-	$(QUIET_GEN)if test -f config.status; then \
+# We avoid depending on 'configure' here, because it gets rebuilt
+# every time GIT-VERSION-FILE is modified, only to update the embedded
+# version number string, which config.status does not care about.  We
+# do want to recheck when the platform/environment detection logic
+# changes, hence this depends on configure.ac.
+config.status: configure.ac
+	$(QUIET_GEN)$(MAKE) configure && \
+	if test -f config.status; then \
 	  ./config.status --recheck; \
 	else \
 	  ./configure; \
-- 
1.8.1.200.gd2acdf2
