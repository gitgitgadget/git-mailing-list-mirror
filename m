From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Thu, 16 Jan 2014 15:19:14 -0800
Message-ID: <xmqqppnry0p9.fsf@gitster.dls.corp.google.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com>
	<xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com>
	<7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com>
	<xmqqob3d0w7g.fsf@gitster.dls.corp.google.com>
	<20140115215024.GM18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ruben Kerkhof <ruben@rubenkerkhof.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Igor Gnatenko <i.gnatenko.brain@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 00:19:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3wDc-0001eD-FG
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 00:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbaAPXTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 18:19:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbaAPXTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 18:19:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 000FC64FA4;
	Thu, 16 Jan 2014 18:19:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JgC86KgMpyPlMxKP77lB+GuR74g=; b=exqLV0
	C0cemuiQH4sru4wk10qwGT7WAwoGduEkZ+iZgP4ODf5yN7+s+jyb4fJ8JLsw4SSO
	3adwQPo0xtgelCV0qswF8cjXGOcSn+QQ3HG2FblleaHV8/vF4ZBaUrsxwBbZ39nX
	Pw5viZOB+ecOBZfoxDgQRWueYLjI1o8yxHBl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXwPM1+I1LjQMKiKPdICIIZtPFLZZuhE
	sgSDF26OvxDbQWdPB/JDAJpcQfZ8humBI6BeyDgL3s5USnjiwf1DCY81yVSwHUUI
	OU3/dUB7pxawNL/8CkaDh9oDyTZ7nMU59w7jkdaFF5/yK+SQcvlgdX2rWAEa2IOy
	xM39OCgbBDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28E964FA3;
	Thu, 16 Jan 2014 18:19:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1234064FA2;
	Thu, 16 Jan 2014 18:19:16 -0500 (EST)
In-Reply-To: <20140115215024.GM18964@google.com> (Jonathan Nieder's message of
	"Wed, 15 Jan 2014 13:50:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EB9F81E-7F04-11E3-82E1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240546>

Jonathan Nieder <jrnieder@gmail.com> writes:

> FWIW this should help on Mac OS X, too.  Folks using git on mac
> at $DAYJOB have been using the workaround described at
> http://mercurial.selenic.com/wiki/CACertificates#Mac_OS_X_10.6_and_higher
> so I forgot to report it. :/

Hmph, is that the same issue, though?  That page seems to suggest
using an empty ca file that does not have any useful information as
a workaround.  The issue Fedora folks saw is that we see a directory
/etc/ssl/certs exist on the system, and blindly attempt to use it as
SSL_ca_path when the directory is not suitable to be used as such.

In any case, I tried to summarize the discussion in the updated log
message.  I wanted to say "does not" but stopped at "should not" in
the last paragraph for now.  Maybe Ram can say something before we
merge it to 'next'.

The patch in the meantime will be queued on 'pu'.

-- >8 --
From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Date: Wed, 15 Jan 2014 21:31:11 +0400
Subject: [PATCH] send-email: /etc/ssl/certs/ directory may not be usable as ca_path

When sending patches on Fedora rawhide with
git-1.8.5.2-1.fc21.x86_64 and perl-IO-Socket-SSL-1.962-1.fc21.noarch,
with the following

    [sendemail]
	    smtpencryption = tls
	    smtpserver = smtp.gmail.com
	    smtpuser = ruben@rubenkerkhof.com
	    smtpserverport = 587

git-send-email fails with:

    STARTTLS failed! SSL connect attempt failed with unknown error
    error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate
    verify failed at /usr/libexec/git-core/git-send-email line 1236.

The current code detects the presence of /etc/ssl/certs directory
(it actually is a symlink to another directory, but that does not
matter) and uses SSL_ca_path to point at it when initializing the
connection with IO::Socket::SSL or Net::SMTP::SSL.  However, on the
said platform, it seems that this directory is not designed to be
used as SSL_ca_path.  Using a single file inside that directory
(cert.pem, which is a Mozilla CA bundle) with SSL_ca_file does work,
and also not specifying any SSL_ca_file/SSL_ca_path (and letting the
library use its own default) and asking for peer verification does
work.

By removing the code that blindly defaults $smtp_ssl_cert_path to
"/etc/ssl/certs", we can prevent the codepath that treats any
directory specified with that variable as usable for SSL_ca_path
from incorrectly triggering.

This change could introduce a regression for people on a platform
whose certificate directory is /etc/ssl/certs but its IO::Socket:SSL
somehow fails to use it as SSL_ca_path without being told.  Using
/etc/ssl/certs directory as SSL_ca_path by default like the current
code does would have been hiding such a broken installation without
its user needing to do anything.  These users can still work around
such a platform bug by setting the configuration variable explicitly
to point at /etc/ssl/certs.

This change should not negate what 35035bbf (send-email: be explicit
with SSL certificate verification, 2013-07-18), which was the
original change that introduced the defaulting to /etc/ssl/certs/,
attempted to do, which is to make sure we do not communicate over
insecure connection by default, triggering warning from the library.

Cf. https://bugzilla.redhat.com/show_bug.cgi?id=1043194

Tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Signed-off-by: Ruben Kerkhof <ruben@rubenkerkhof.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3782c3b..689944f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1095,7 +1095,8 @@ sub ssl_verify_params {
 	}
 
 	if (!defined $smtp_ssl_cert_path) {
-		$smtp_ssl_cert_path = "/etc/ssl/certs";
+		# use the OpenSSL defaults
+		return (SSL_verify_mode => SSL_VERIFY_PEER());
 	}
 
 	if ($smtp_ssl_cert_path eq "") {
-- 
1.8.5.3-493-gb139ac2
