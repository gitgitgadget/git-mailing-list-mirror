From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Wed, 26 Jun 2013 16:48:57 -0700
Message-ID: <7vd2r8v3fa.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
	<7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
	<8738shi2ht.fsf@linux-k42r.v.cablecom.net>
	<7vwqpshkxj.fsf@alter.siamese.dyndns.org>
	<1372190294-sup-1398@pimlott.net>
	<7v61x127bw.fsf@alter.siamese.dyndns.org>
	<1372198415-sup-2114@pimlott.net> <1372283778-sup-5704@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 01:49:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrzSV-0000KW-5p
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 01:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab3FZXtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 19:49:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab3FZXtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 19:49:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F1C32CA76;
	Wed, 26 Jun 2013 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xFmpB1r1jQ1vKmq6l4TB7nTNyoU=; b=sDCp1k
	4qM3nJkwEDqTz0I8MvTh5N3kDYt9gCHYvkLcsCvEdpXb1D42LizvNQAaq0m5Upq4
	lom/xRPAeen1FZ9uzeGQN2TsaWaC1IUdPqLLnUelaclGL3ypYOlFeFOSBLCTOyHq
	SEq2Fs5eAO6fWEnd2ApYWfit1SqvHY5tTSSAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=id7sQy2sCName1aORVV2lEBoyfvJcPxA
	KJHd4lAOjIYljC+Z7kdqlsdTeJWhhjCPcnBiMi5Mbvr8bH58j8Vv0AP5hN+o+28E
	8sPRWPDNHfosBDYY+OBcd2N00kdG160CztkCCBRoxZfgwIjpJposwtgaULVjsLre
	FFzOZmmtIu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72A372CA74;
	Wed, 26 Jun 2013 23:49:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF20F2CA73;
	Wed, 26 Jun 2013 23:48:59 +0000 (UTC)
In-Reply-To: <1372283778-sup-5704@pimlott.net> (Andrew Pimlott's message of
	"Wed, 26 Jun 2013 15:00:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F913084A-DEBA-11E2-94E9-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229073>

Andrew Pimlott <andrew@pimlott.net> writes:

> In order to test this, I wrote a helper function to dump the rebase -i
> todo list.  Would you like this introduced in its own patch, or
> combined?  See below.

Depends on how involved the addition of the tests that actually use
the helper, but in general it would be a good idea to add it in the
first patch that actually uses it.  Unused code added in a separate
patch will not point at that patch when bisecting, if that unused
code was broken from the beginning (not that I see anything
immediately broken in the code the following adds).


> ---8<---
> Subject: [PATCH] lib-rebase: set_cat_todo_editor
>
> Add a helper for testing rebase -i todo lists.  This can be used to verify
> the expected user experience, even for todo list changes that do not affect
> the outcome of rebase.
>
> Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
> ---
>  t/lib-rebase.sh |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 4b74ae4..d118dd6 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -66,6 +66,19 @@ EOF
>  	chmod a+x fake-editor.sh
>  }
>  
> +# After set_cat_todo_editor, rebase -i will write the todo list (ignoring
> +# blank lines and comments) to stdout, and exit failure.
> +
> +set_cat_todo_editor () {
> +	echo "#!$SHELL_PATH" >fake-editor.sh
> +	cat >> fake-editor.sh <<\EOF
> +grep "^[^#]" "$1"
> +exit 1
> +EOF
> +	chmod a+x fake-editor.sh

These days we should use write_script to do this kind of thing, I
think.

> +	test_set_editor "$(pwd)/fake-editor.sh"
> +}
> +
>  # checks that the revisions in "$2" represent a linear range with the
>  # subjects in "$1"
>  test_linear_range () {
