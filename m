From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] i18n: Only extract comments marked by special tag
Date: Fri, 18 Apr 2014 09:52:06 -0700
Message-ID: <xmqqha5qd1hl.fsf@gitster.dls.corp.google.com>
References: <cover.1397712142.git.worldhello.net@gmail.com>
	<2ce9ec406501d112e032c8208417f8100bed04c6.1397712142.git.worldhello.net@gmail.com>
	<xmqqk3anesml.fsf@gitster.dls.corp.google.com>
	<CANYiYbGkjpdrzE25iRS33sm1=AodiREqWmJVkKVEok4mb4G5mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 18:52:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbC1R-0006Bk-Q9
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 18:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbaDRQwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 12:52:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaDRQwL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 12:52:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2A88790AD;
	Fri, 18 Apr 2014 12:52:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8JXAM4NZXABFT6kaBOxXecuALNY=; b=ER12Gy
	kVTP/EQCLV49El/XPZ8CU4RCN/0cRGJWJStY8Tr6R3aKnzYpgKd6qvrYVSL5E1ZN
	iJqoM6+EMd1V1XRdNixNLnHK6mw0JNH6GSJA81ODbUtcQqpsl1nUiR27RCzmEPEX
	eWRkNYj+KQqBZMAsk2HBlKLzQyeWGgq0sCtVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WLlEYYF9OG2DGM1at4tU31ToAcrawobn
	CDdYUzEqZTk0tl5uD08a1SHgYyCv3GlrOB1TDeipPh8zEf7OOi50FvEPeR6+qxM0
	rvqcw2zvvfQEVTI/vtBW7VzrKHlRVVlT0FwF9/9I6TYWhaQnsYf9MevfAcE7gLqr
	XLe9E3Cfqvk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 974D2790AC;
	Fri, 18 Apr 2014 12:52:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4A83790AA;
	Fri, 18 Apr 2014 12:52:08 -0400 (EDT)
In-Reply-To: <CANYiYbGkjpdrzE25iRS33sm1=AodiREqWmJVkKVEok4mb4G5mQ@mail.gmail.com>
	(Jiang Xin's message of "Fri, 18 Apr 2014 14:03:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C7AA744E-C719-11E3-8480-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246474>

Jiang Xin <worldhello.net@gmail.com> writes:

>> I am not very happy with this change, as it would force us to
>> special case "Translators" comment to follow a non-standard
>> multi-line comment formatting convention.  Is there a way to tell
>> xgettext to accept both of these forms?
>>
>>         /* TRANSLATORS: this is a short comment to help you */
>>         _("foo bar");
>>
>>         /*
>>          * TRANSLATORS: this comment is to help you, but it is
>>          * a lot longer to fit on just a single line.
>>          */
>>         _("bar baz");
>>
>
> We can not provide multiple `--add-comments=TAG` options to xgettext,
> because xgettext holds the tag in one string, not in a list:
>
>         /* Tag used in comment of prevailing domain.  */
>         static char *comment_tag;
>
> So if we won't change our multi-line comments for translators, must
> hack gettext in some ways.
>
> There maybe 3 ways to hack gettext:
> ...
> I CC this mail to the gettext mailing list. Full thread see:
>
>  * http://thread.gmane.org/gmane.comp.version-control.git/246390/focus=246431

This is one of these times when I find myself very fortunate for
being surrounded by competent contributors with good tastes, which I
may not deserve ;-)

Thanks for being thorough.

Having said that, it is only just a single comment, and it is too
much hassle to even think about what to do in the meantime while we
wait until such a change happens and an updated version of gettext
reaches everybody.  Let's take 2/3 as-is.

Documentation/CodingGuidelines may want to have a sentence of two to
explain this, though.

 Documentation/CodingGuidelines | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index dab5c61..b367a85 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -159,10 +159,19 @@ For C programs:
  - Multi-line comments include their delimiters on separate lines from
    the text.  E.g.
 
 	/*
 	 * A very long
 	 * multi-line comment.
 	 */
 
+   Note however that a multi-line comment that explains a translatable
+   string to translators uses a different convention of starting with a
+   magic token "TRANSLATORS: " immediately after the opening delimiter,
+   and without an asterisk at the beginning of each line.  E.g.
+
+	/* TRANSLATORS: here is a comment that explains the string
+	   to be translated, that follows immediately after it */
+	_("Here is a translatable string explained by the above.");
+
  - Double negation is often harder to understand than no negation
    at all.
