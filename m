From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/13] column: add API to print items in columns
Date: Fri, 03 Feb 2012 14:55:32 -0800
Message-ID: <7vehubmsrf.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtS2e-00013N-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770Ab2BCWzf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 17:55:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab2BCWze convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 17:55:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E09C669F9;
	Fri,  3 Feb 2012 17:55:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6M2QYJtuOZt8
	NOOAICMPVABbkZs=; b=ctstAvbEXC8yeF82HFacn9Nlvcff26SvYlEPb7ZSVDZ+
	UjO2j6S7OWweJZudNCZXawMRWTWTbiprGavek9mQEm8JB5NGC+Xx/oEZgFv1Zsyh
	pR0tctap7Y153rgJNi2kjwq6sIHYyox3b1i+dOwbq5tfcmHATH3kcw9Xg+1YF3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Acl8Om
	6OkaSSXLbbkQIX6ngCkwF8eEBDm7DR0FSuwgfscQf0UMMeArVUg4C5KQneOE2coV
	Kse1KSswv1cpjgbwCHnQ7UCegTb0tVutUXdhylilROQ/x05qTzL0/d47BGJxpdih
	DCX7oJviwjn4bWNrVw/NZmMVrm/z70WAGpUmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D79F369F8;
	Fri,  3 Feb 2012 17:55:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B92669F7; Fri,  3 Feb 2012
 17:55:33 -0500 (EST)
In-Reply-To: <1328276078-27955-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 Feb
 2012 20:34:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DA5361A-4EBA-11E1-8BA1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189819>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +struct string_list_item *add_cell_to_list(struct string_list *list,
> +					  int mode,
> +					  const char *string)
> +{
> +	if (mode & COL_ENABLED)
> +		return string_list_append(list, string);
> +	return NULL;
> +}
> +
> +void print_cell(struct string_list *list, int mode, const char *stri=
ng)
> +{
> +	if (!add_cell_to_list(list, mode, string))
> +		printf("%s\n", string);
> +}

I find these two functions showing an extremely bad taste in the code
design. "If we for some reason fail to add the string to the list, we
fallback to print it straight away" is the natural reading of this code=
,
but that is absolutly not the impression the author of this piece of
crap^Wcode wanted to give to its readers.

Am I being too ascestically perfectionist?
