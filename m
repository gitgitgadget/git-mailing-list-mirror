From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: validate & reconfirm interactive responses
Date: Tue, 14 Aug 2012 15:57:26 -0700
Message-ID: <7v1uj984kp.fsf@alter.siamese.dyndns.org>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
 <1344983132-22578-1-git-send-email-gitster@pobox.com>
 <CAOeW2eEOAdVJrVfyZ4osEARXWuXncy3ZSa4ir8BZbUjNjMzbSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 00:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Q3L-0007jE-QR
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 00:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab2HNW5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 18:57:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414Ab2HNW53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 18:57:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 334F480BD;
	Tue, 14 Aug 2012 18:57:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IFryxXP3nncuBCOYHDezi5cQha0=; b=kzL+47
	fB1GU/dzXtBKHfCVc+Robs1CSkAue+uQxaks5+ZbH4AAyVLn0l9w/cmgqY4h44Yj
	utDfcYFUIFHpU2cwE5r84Bsk3BiJJHL6lx+VEpwLc0YfxR3P6f74s+SSKz4YuOZX
	KvQL9m6/DhEZvtK1RORvm8gDh80MRNx7UaAzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lRMkeU+ub7Ld/bulME+O+Lt4QFXe3DVh
	EY5TD9rpsLuepn0h2gHZPhjqftQh78Xw/0doxuGzgwol76OYOjchgzrnNfhDoOqn
	3WhW0YpRQHtg+yL+hmpb0NN/w4HzNIemXey/O+HCYaCfThdnKNY6xYNwjTKRphhM
	rWZQgqhbppM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20ADC80BC;
	Tue, 14 Aug 2012 18:57:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC83F80A4; Tue, 14 Aug 2012
 18:57:27 -0400 (EDT)
In-Reply-To: <CAOeW2eEOAdVJrVfyZ4osEARXWuXncy3ZSa4ir8BZbUjNjMzbSw@mail.gmail.com> (Martin
 von Zweigbergk's message of "Tue, 14 Aug 2012 15:33:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B8430F8-E663-11E1-9553-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203459>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Tue, Aug 14, 2012 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> People answer 'y' to "Who should the emails appear to be from?"  and
>> 'n' to "Message-ID to be used as In-Reply-To for the first email?"
>> for some unknown reason.
>
> Yeah, I know :-(. I did feel stupid already. Thanks for improving.

Actually, it is a very understandable mistake and I do not think it
is a user stupidity.  It is a UI bug in the prompter that gives:

  Who should the emails appear to be from? [Junio C Hamano <gitster@pobox.com>]

and does *not* tell the user that the way to accept the default is
to just press RETURN.  It makes it look as if it is asking "Is it OK
to use this?", and it is a natural response to say "Yes" to the
prompt.

We would want to do something like the following pseudo-patch, I
think, but I do not know what is the best way to show both $prompt
and the "press return" suggestion to the user, so I am not going to
do this myself.

A tested patch to improve this is very much welcomed.

Thanks.

diff --git a/git-send-email.perl b/git-send-email.perl
index 607137b..2ec0ce8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -688,6 +688,9 @@ sub ask {
 		unless defined $term->IN and defined fileno($term->IN) and
 		       defined $term->OUT and defined fileno($term->OUT);
 	while ($i++ < 10) {
+		if (defined $default) {
+			SAY "(press RETURN to accept the default)";
+		}
 		$resp = $term->readline($prompt);
 		if (!defined $resp) { # EOF
 			print "\n";
