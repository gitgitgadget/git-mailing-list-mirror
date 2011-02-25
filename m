From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/73] Makefile: "pot" target to extract messages
 marked for translation
Date: Fri, 25 Feb 2011 13:36:53 -0800
Message-ID: <7vsjvb94p6.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-5-git-send-email-avarab@gmail.com>
 <20110225072212.GC23037@elie>
 <AANLkTim72p3H5zrELsApN8EM1CAU1H=FdjaoL+s=cJzH@mail.gmail.com>
 <20110225212010.GC4580@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 22:37:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt5Ld-0003R1-HM
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 22:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527Ab1BYVhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 16:37:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab1BYVhG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 16:37:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C2343923;
	Fri, 25 Feb 2011 16:38:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TEwVPnTFLh8qOxnK9nn3oYSkdHk=; b=RcyUFs
	gyc8YLq+6Blm6+6YCgvmGwb+wvsamIxdPN2EAnDePoOakg/0nT9ndspLGnLFxds5
	Q2CWTtZ8Zh93R+xXqC7fCqpijA/YzOCo8cdRBTJueGrdUSeiDDlG4p3u3hJw4j0a
	BB3SKOdnRQ0RfC/x2iQcaLbXkdQm50bai1m4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KRo94Ct2bqijXFommPb9bCuP+KA+jUpd
	PM4uH8E2M3buxfVbL10D8Stn8a79l2ShJeWv1VJOrtL/PWVm4J62UBdfsayiX8u/
	ut2LxvveXWOY4rHnFoASwQGG5k12HAZEy/Gm8+rKn4s+OYrD9HmRY1vJ3evwaRO1
	reo1e43RcH0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5AB2C3922;
	Fri, 25 Feb 2011 16:38:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C0FA2391D; Fri, 25 Feb 2011
 16:38:10 -0500 (EST)
In-Reply-To: <20110225212010.GC4580@elie> (Jonathan Nieder's message of
 "Fri\, 25 Feb 2011 15\:20\:10 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E03C112-4127-11E0-BD95-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167945>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hmm, I had been wondering where that message came from.  Maybe the
> following would help?
> ...
>  po/git.pot: $(LOCALIZED_C)
> -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C) && \
> -	mv $@+ $@
> +	$(QUIET_XGETTEXT)$(XGETTEXT) -ogit-tmp.pot $(XGETTEXT_FLAGS_C) $(LOCALIZED_C) && \
> +	mv git-tmp.pot $@

Yeah, or "tmp-$@".

In either case, I'd prefer to see the above removed the temporary and the
target before running the command, following the idiom:

	rm -f $@+ $@ && \
        $(command that does not remove its output when killed) -o $@+ && \
        mv $@+ $@

Does xgettext leave output file specified with -o when it gets killed?  If
not, we don't have to use a temporary.  Makefiles in gitk and git-gui do
not seem to protect against it either.
