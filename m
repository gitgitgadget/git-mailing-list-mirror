From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: Disallow reusing non-blob as a note object
Date: Fri, 14 Feb 2014 08:19:44 -0800
Message-ID: <xmqq7g8xk6ov.fsf@gitster.dls.corp.google.com>
References: <CALKQrgdnGhc-y3WMf+zej4M+O4NMhLKusE-N6dX_xKVViZmQzA@mail.gmail.com>
	<1392198856-3908-1-git-send-email-johan@herland.net>
	<CAPig+cSQ12Ga4kEnNrspzru2F3p0jWb2i=1GRX84k0am5AA6Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, Git List <git@vger.kernel.org>,
	Joachim Breitner <mail@joachim-breitner.de>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 17:20:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WELUX-0008So-QA
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 17:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbaBNQTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 11:19:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbaBNQTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 11:19:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99BFD6C238;
	Fri, 14 Feb 2014 11:19:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z94qeNaguLpBzig8T17SOYf0d7s=; b=Cqqj3h
	Woi/eEtRk25V1eRzyKKYWbuXPt+NWij/IWbIw3yzQIEQnw6qqXYCl3ho995WnnWV
	DJphww7CyftfllxVQTS7xOqq0wVQ0zx/bB2SnndKORc4lipnQu7RKTFCsRti4Gha
	wk1Oh45CrKyLmsffW5dAIleKCHbwBo7/lUS1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I18Q8ugIOkbpgHApVP/LYNVMq+rwBlk3
	zDC8hbeeGWJEXj9Ot4trcWqwQ6XeAZTG4LokTvwdZXpbNXWXSKvPXamEd+RYAo9E
	BwvcT3TQpiq5oPuWMYo4HpfpaD6ExJSfPgVMByyfRNauZCWZNI0rrcd0CZMqGBY2
	KdpjD3u/fkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF636C236;
	Fri, 14 Feb 2014 11:19:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DB3A6C231;
	Fri, 14 Feb 2014 11:19:46 -0500 (EST)
In-Reply-To: <CAPig+cSQ12Ga4kEnNrspzru2F3p0jWb2i=1GRX84k0am5AA6Bw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 14 Feb 2014 10:19:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1D847AA-9593-11E3-A283-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242108>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       if (type != OBJ_BLOB) {
>> +               free(buf);
>> +               die(_("Cannot read note data from non-blob object '%s'."), arg);
>
> The way this diagnostic is worded, it sound as if the 'read' failed
> rather than that the user specified an incorrect object type. Perhaps
> "Object is not a blob '%s'" or "Expected blob but '%s' has type '%s'"
> or something along those lines?

Yeah, sounds good.  You also need to say what expects a blob, too.
Perhaps something like this?

 builtin/notes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index c11d6e6..a16bc00 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -272,8 +272,10 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 		die(_("Failed to read object '%s'."), arg);
 	}
 	if (type != OBJ_BLOB) {
+		struct msg_arg *msg = opt->value;
 		free(buf);
-		die(_("Cannot read note data from non-blob object '%s'."), arg);
+		die(_("The -%c option takes a blob, which '%s' is not.",
+		      msg->use_editor ? 'c' : 'C', arg));
 	}
 	strbuf_add(&(msg->buf), buf, len);
 	free(buf);
