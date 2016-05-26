From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/22] i18n: rebase-interactive: mark strings for translation
Date: Thu, 26 May 2016 15:36:27 -0700
Message-ID: <xmqqpos8tpjo.fsf@gitster.mtv.corp.google.com>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
	<1464031661-18988-15-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 27 00:36:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b63tL-0001Nl-NM
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 00:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbcEZWgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 18:36:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755225AbcEZWgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 18:36:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2B5E1F443;
	Thu, 26 May 2016 18:36:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=6RK/qVglcqvQgscwnmz5MfsRGRw=; b=CWDqfXBLDDqastqThvsj
	b5r/Yb/GfugvJNYXDHuFU0m/kua8K+cN+Q0ehZpGNLeMWU8gOYpsk2lrfO0rCeDA
	OCvMSVe+2E35Ffmzq2AI/MlI0ZNt2UBt7PEeZlSBs1YRhu1nj+P96nB5YmCqEYkq
	pCLJIGvz3A34LR0OkNVr0rQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=EADNX4Y4hnHdTHyRXVzESBdloiNkfH/ahiUvxhtcMlB7iD
	JcLyxcGDQfjgkN08hphVc8CtX6ZaAMj9V8zY60VjV0gZ0O6tQqemL2UgCnifR/Ei
	uuIOXqCUMCRXkRUwa+00MQcJ/ZxtcV/iuPU3aI2Ipz353dLBXGRs5HoOVTd14=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA2BC1F442;
	Thu, 26 May 2016 18:36:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 438351F43F;
	Thu, 26 May 2016 18:36:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49DEBBB0-2392-11E6-A9E3-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295701>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> @@ -222,9 +223,10 @@ has_action () {
>  }
>  
>  is_empty_commit() {
> -	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
> -		die "$1: not a commit that can be picked")
> -	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
> +	sha1=$1
> +	tree=$(git rev-parse -q --verify "$sha1"^{tree} 2>/dev/null ||
> +		die "$(eval_gettext "\$sha1: not a commit that can be picked")")
> +	ptree=$(git rev-parse -q --verify "$sha1"^^{tree} 2>/dev/null ||
>  		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
>  	test "$tree" = "$ptree"
>  }

Both of the two callsites of this function use the variable $sha1,
and at least one of them uses that variable after this function
returns, but they pass it as the first parameter to this function,
so the assignment added by this patch does not break them, which is
good.
