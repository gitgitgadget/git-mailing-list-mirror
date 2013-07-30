From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/3] revert most of the http_options() change
Date: Tue, 30 Jul 2013 14:09:37 -0700
Message-ID: <7vy58nvjou.fsf@alter.siamese.dyndns.org>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
	<1375138150-19520-1-git-send-email-gitster@pobox.com>
	<7v7gg8ztvk.fsf_-_@alter.siamese.dyndns.org>
	<7v1u6gztf1.fsf_-_@alter.siamese.dyndns.org>
	<CC3A0EB0-79FE-40C2-B1AC-E3B9683A3ED6@gmail.com>
	<3C93D9D6-8FC3-4D94-AE6E-37150202314A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 23:09:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4HAy-0000dc-U8
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 23:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027Ab3G3VJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 17:09:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757852Ab3G3VJm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 17:09:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 708F735E2E;
	Tue, 30 Jul 2013 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yyHtfCerL5C3rUavQD3MYv4i5w4=; b=KPjg78
	3WEHH6wtZoi5oPKImbmxorxZq8t/sNiYkFxn+/6hiCDHbpUE/kFmK+JwjDlifEU4
	V//LTPREDKAKBT6jJtdbPhVl9mY+91PJibc6U1O2/jqrlI1B/msr2+ZUHHq3krtT
	jTW6rfnBxp1uMYD/z6kAmVsudFluJZnXme9iU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j+TFDXINPe016OWejDq5LsmLM7MjvpYs
	l1tUIF8WoZiwQkt34rQ72lSxtgbhjJv+VG/EuqFYlyhAZ0ROv9RHP/sFKNWoTIrZ
	69X3kuyKPUevCYx8ltbQDknUKpQ3p3tqKbh21X5Z4LneqZRoTAGSXOEmpdtAb9rM
	U0CBVziRG4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36D5435E2D;
	Tue, 30 Jul 2013 21:09:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5243935E27;
	Tue, 30 Jul 2013 21:09:39 +0000 (UTC)
In-Reply-To: <3C93D9D6-8FC3-4D94-AE6E-37150202314A@gmail.com> (Kyle J. McKay's
	message of "Tue, 30 Jul 2013 12:41:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58AED4F8-F95C-11E2-A750-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231390>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> And now all the t5200-url-normalize tests pass again.
>
> FYI, I couldn't get the patches to apply against next or pu without
> some minor tweaks that were just conflict resolutions having to do
> with git_config_with_options changing its signature.

Thanks.

I built these five patches directly on top of your series, i.e. on
top of cea9928d (docs: update http.<url>.* options documentation,
2013-07-25).

I'll rebuild the series with your fixes and I may even queue it to
'pu', but with some random thoughts:

 * "url-match.[ch]" are ugly names.  I'd be happier with
   "urlmatch.[ch]".

 * In the end result, http_options() looks mostly identical to that
   of the 'master', but it got an extra "void *matched", only to
   support "git config --get-urlmatch".  I however do not have to,
   if I do a few things:

   - Instead of implementing urlmatch_config_item that extends
     urlmatch_item, have a separate string_list, keyed by the
     variable names, and point the string_list with the generic cb
     pointer I already have in urlmatch_config.  The fn() on the
     "git config" side has to index this second string_list with the
     variable and keep track of the value from the best candidate we
     have seen so far.

   - The above allows us to lose item_alloc and item_clear callback
     functions from urlmatch_config, as we will not be doing the
     structure inheritance to extend urlmatch_item.

   - We still need cascade_fn callback, though.

 * With the above, http_options() does not have to change in the
   series.  We could restructure the series perhaps this way:

   - http.sslCertPasswordProtected parsing fix.

   - Add urlmatch.[ch], which would be your "config: improve support
     for http.<url>.* settings" and yesterday's "url-match: split
     out URL matching logic out of http.c", and a half of
     "url-match: generalize configuration collection logic".

   - Update http.c to use urlmatch.[ch] to make http.c match the
     result of the endgame patch [5/3], and add necessary end user
     documentation to Documentation/config.txt.

   - Add test-url-normalize and t/t5200

   - Update builtin/config.c for "--get-urlmatch", to make
     builtin/config.c match the result of the endgame patch [5/3],
     add end user documentation to Documentation/git-config.txt.

   - Add some tests for "git config --get-urlmatch".
