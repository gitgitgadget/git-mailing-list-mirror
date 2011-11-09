From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] post-receive-email: explicitly set Content-Type
 header
Date: Wed, 09 Nov 2011 06:11:00 -0800
Message-ID: <7vy5vpv11n.fsf@alter.siamese.dyndns.org>
References: <20111007201932.GC29712@elie.hsd1.il.comcast.net>
 <1320836458-24088-1-git-send-email-Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 15:11:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO8ru-0006mE-P7
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 15:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab1KIOLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 09:11:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab1KIOLE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 09:11:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CEF54E4A;
	Wed,  9 Nov 2011 09:11:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3oZGJKaqJNxghEnRwA1rFLKTBsE=; b=SdXdwC
	QvNgMsuOwHUcYfpJeZmm8EreRzyAB5mV2qZU5TUK+aPdSY8Pnbu4vgtFiFKszNzo
	svPLusQ8uGzuuGY1s9iJsOUy6lfzDTP+6N7JADCaI9BC5Mg40ZylYHu0KXYoNt7B
	Ldj28Kv98+Rmv606myMybpIoB+Rxiqa5ghgGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JjF2prYTBdMvXQbQc68V5qNjfFNVl5HP
	dmh99GD6mqyzuuPduPrxK4GVnkJqZn9jtCouc/g+kW0ibtVg9lDhuVg/KPv50Doa
	+M0D2XvfEUevHkiLsMkmAhBmD/AhKHVTfLaLdUIIgipaSYyzhv/broYHQhomv7ue
	B/p1QFAG2+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 543B94E49;
	Wed,  9 Nov 2011 09:11:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2DC94E48; Wed,  9 Nov 2011
 09:11:02 -0500 (EST)
In-Reply-To: <1320836458-24088-1-git-send-email-Alex.Crezoff@gmail.com>
 (Alexey Shumkin's message of "Wed, 9 Nov 2011 15:00:58 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A813D89C-0ADC-11E1-964E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185159>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> Some email clients (e.g. claws-mail) incorrectly display
> message body when there is no Content-Type header and charset
> explicitly defined.
> So, set explicitly Content-Type header. Its charset
> can be defined with hooks.emailcharset config variable.
>
> NB: This above-mentioned charset may differ from i18n.logOutputEncoding,
> because e.g. gitweb expects (for now) i18n.logOutputEncoding set to UTF-8
> to display logs correctly.
>
> Also, introduce hooks.gitopts config variable
> with the default '-c core.quotepath=false'.
> This takes into account that we want to see pretty email-message
> with well-looking messages and list of changed filenames.
> And usually non-ASCII filenames are in the same
> encoding that commit messages are.

(style) Why such an extremely ragged looking line-wrap of paragraphs?

> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> ---

In this space, please describe what happened during v1 and v2, and how is
this round different to help reviewers. Pointers to list archive, e.g.
http://thread.gmane.org/gmane.comp.version-control.git/181737, would be
helpful.

People involved in v1/v2 discussion are missing from the Cc: line. Please
do not give a false impression that you are hiding from them.

> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index ba077c1..913be89 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -65,6 +65,14 @@
>  #   Default is "--stat --summary --find-copies-harder". Add -p to those
>  #   options to include a unified diff of changes in addition to the usual
>  #   summary output.
> +# hooks.gitopts
> +#   git options for the git diff-tree invocation that shows changes.
> +#   Default is '-c core.quotepath=false' to be able to see non-ASCII filenames
> +#   used in a project.

We do not particularly appreciate a patch that does two unrelated things
("they are both related to post-receive-email" is not an argument).
Wouldn't this be useful even if the change to add hooks.emailcharset
turned out to be unwanted, or vice versa?

> +# hooks.emailcharset
> +#   The charset used in Content-Type header. UTF-8, if not specified.
> +#   It can differ from i18n.logOutputEncoding (not to mess-up with gitweb
> +#   which expects i18n.logOutputEncoding to be set to UTF-8)

Why "UTF-8" instead of "i18n.logoutputencoding" if not specified?

> @@ -234,6 +242,9 @@ generate_email_header()
>  	cat <<-EOF
>  	To: $recipients
>  	Subject: ${emailprefix}$projectdesc $refname_type $short_refname ${change_type}d. $describe
> +	MIME-Version: 1.0
> +	Content-Type: text/plain; charset=$emailcharset
> +	Content-Transfer-Encoding: 8bit
>  	X-Git-Refname: $refname
>  	X-Git-Reftype: $refname_type
>  	X-Git-Oldrev: $oldrev
> ...
> @@ -730,6 +734,19 @@ custom_showrev=$(git config hooks.showrev)
>  maxlines=$(git config hooks.emailmaxlines)
>  diffopts=$(git config hooks.diffopts)
>  : ${diffopts:="--stat --summary --find-copies-harder"}
> +gitopts=$(git config hooks.gitopts || echo '-c core.quotepath=false')
> +emailcharset=$(git config hooks.emailcharset || echo 'UTF-8')
> +
> +projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
> +# Check if the description is unchanged from it's default, and shorten it to
> +# a more manageable length if it is
> +if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> +then
> +	projectdesc="UNNAMED PROJECT"
> +fi
> +# Leave description in UTF-8 to be used in the Subject header
> +# But convert it to an hooks.emailcharset encoding to be used in a message body
> +projectdesc_e=$(echo $projectdesc | iconv -f UTF-8 -t $emailcharset 2>/dev/null)

Hmm, this generates a piece of e-mail whose subject line is in UTF-8
(without B/Q quoting) and message body is in totally different encoding.
Is it what mailers really want to see?

It almost seems backwards; converting the payload to UTF-8 and always
sending UTF-8 would be a simpler approach, methinks.
