From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] combine-diff: coalesce lost lines optimally
Date: Sun, 17 Mar 2013 15:37:51 -0700
Message-ID: <7vhak9ps8w.fsf@alter.siamese.dyndns.org>
References: <7vboalw6lt.fsf@alter.siamese.dyndns.org>
 <1363525436-21667-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 23:38:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHMDe-0000LZ-Cj
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 23:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587Ab3CQWhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 18:37:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757Ab3CQWhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 18:37:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 162DFA45E;
	Sun, 17 Mar 2013 18:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F7mrhrDIsUCAW9ownt3m04wyBzY=; b=Aa9vbf
	u8DZ5Jk41ZuUX5fbURknIV905y/NPWt0S24mqk/0UIZ/IFFKT/zq45hs8rrGJ+1M
	/PKW/s3+Fc2JPW/kYRb0jeqzda32MV32jCb6Hz8Co3b5Wg7ynE4I1laQT2wutezi
	7OZC079ouFsL/ut9IGHq335dRvQt4kQalup2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vRJXh2FKPbxQaH0FyHsBhqCyVKGL1mCn
	TVcBVq76//5Vf7yC8kgST5mXmxPEB8KI/IMH/DI4CjW+fEHGV977yXaJWLTOOdvI
	0rWqC1wNCUZZ87Dj7TqvwJ1sHflP4g0PxgrugmDyadWq8+8JySAfhe9BJGkVzeHF
	Cq0mHpE6jk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A07CA45D;
	Sun, 17 Mar 2013 18:37:54 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73CA8A45B; Sun, 17 Mar 2013
 18:37:53 -0400 (EDT)
In-Reply-To: <1363525436-21667-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sun, 17 Mar 2013 14:03:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E64C57A-8F53-11E2-B5DD-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218381>

Antoine Pelisse <apelisse@gmail.com> writes:

> +/* Coalesce new lines into base by finding LCS */
> +static struct lline *coalesce_lines(struct lline *base, int *lenbase,
> +				    struct lline *new, int lennew,
> +				    unsigned long parent)
> +{

Don't you want to pass flags so that you can use match_string_spaces()
at places like this:

> +	for (i = 1, baseend = base; i < origbaselen + 1; i++) {
> +		for (j = 1, newend = new; j < lennew + 1; j++) {
> +			if (baseend->len == newend->len &&
> +			    !memcmp(baseend->line, newend->line, baseend->len)) {

IOW, it looks to me that this wants to be rebuilt on top of
fa04ae0be8cc (Allow combined diff to ignore white-spaces,
2013-03-14).
