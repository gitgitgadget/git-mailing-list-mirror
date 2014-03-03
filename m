From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] commit.c: Use skip_prefix() instead of starts_with()
Date: Mon, 03 Mar 2014 15:45:34 -0800
Message-ID: <xmqqbnxmn8wx.fsf@gitster.dls.corp.google.com>
References: <1393862398-2989-1-git-send-email-tanayabh@gmail.com>
	<xmqqiorvoyoo.fsf@gitster.dls.corp.google.com>
	<176A3D83-AFFB-4EF4-A1CB-3A953F692166@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:45:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcYJ-0002DM-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbaCCXpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:45:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005AbaCCXpi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:45:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE8AD554A0;
	Mon,  3 Mar 2014 18:45:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N572GsF6qAhmaonj3lqqEcfBXX0=; b=uaC1G2
	/Udbcky/TIpfH6w1ZWClfoo7N0AcxkmcOwTS6UNS4dn7Hj3pqeYwYKtn70V9y37m
	CEKXzvgISNTlMcOIcDVEvPGHu6dUI1SWeh6c/TFg3daUp7aT/jKJ3Mjlx+yzvFrS
	KIvRLFD4LNRPrq1nXSXTzQf4llYl7f/jsKmmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hcwk5+PzSD85RadaxprbtLqvfJUGzbVC
	G350+e7Ww6e/+I5Uq1pPmBW5BQtLFq64gw9Dt+n8LrwbnagU9ZYKO1jpI4ToeK9C
	6rFIR05RwyprmopCPHAbPHaxQjEFTU3zenluftjc87o+KKiyNJONqSXFKFXagKqC
	6q977s/XfMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A75B15549E;
	Mon,  3 Mar 2014 18:45:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB3265549D;
	Mon,  3 Mar 2014 18:45:36 -0500 (EST)
In-Reply-To: <176A3D83-AFFB-4EF4-A1CB-3A953F692166@quendi.de> (Max Horn's
	message of "Mon, 3 Mar 2014 23:59:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EB60EB9E-A32D-11E3-B668-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243313>

Max Horn <max@quendi.de> writes:

> On 03.03.2014, at 20:43, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> @@ -1193,9 +1194,9 @@ static void parse_gpg_output(struct signature_check *sigc)
>>> 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>>> 		const char *found, *next;
>>> 
>>> -		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
>>> +		if (found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1)) {
>>> 			/* At the very beginning of the buffer */
>>> -			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
>>> +			;
>>> 		} else {
>>> 			found = strstr(buf, sigcheck_gpg_status[i].check);
>>> 			if (!found)
>> 
>> This hunk looks good.  It can be a separate patch but they are both
>> minor changes so it is OK to have it in a single patch.
>
> Hm, but that hunk also introduces an assignment in a conditional,
> and introduces an empty block. Maybe like this?

Much better.

If we anticipate that we may add _more_ ways to find the thing
later, then I would say this code structure is better:

	/* Is it at the beginning of the buffer? */
	found = skip_prefix(...);
        if (!found) {
		/* Oh, maybe it is on the second or later line? */
        	found = ... find it on a later line...
	}
	if (!found)
        	continue;

but I do not think that is the case for this particular one.  We
either try to find it at the very beginning (i.e. no leading
newline), or we have some other lines before it (i.e. require
leading newline), and there will be no future extension, so what you
suggested below looks sensible.

> diff --git a/commit.c b/commit.c
> index 6bf4fe0..0ee0725 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1193,10 +1193,8 @@ static void parse_gpg_output(struct signature_check *sigc)
>         for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>                 const char *found, *next;
>
> -               if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> -                       /* At the very beginning of the buffer */
> -                       found = buf + strlen(sigcheck_gpg_status[i].check + 1);
> -               } else {
> +               found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
> +               if (!found) {
>                         found = strstr(buf, sigcheck_gpg_status[i].check);
>                         if (!found)
>                                 continue;
