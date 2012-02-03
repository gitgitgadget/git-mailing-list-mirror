From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/13] column: add API to print items in columns
Date: Fri, 03 Feb 2012 15:16:29 -0800
Message-ID: <7vsjirld82.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:16:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSMy-0002al-2S
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084Ab2BCXQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:16:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab2BCXQe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:16:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7ED86D51;
	Fri,  3 Feb 2012 18:16:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UMM4dghlNeiL
	of7iSQxJebRVOKA=; b=ON0cr7SnV2srC70HrkikgO87A030fl8cqVBx31lpeCXh
	a+enkqI3pg0wJmqm53mAkUkyK7aqdDx6eFMPK68CmTIGPCqEjyqWxD8e+/CuDQVE
	AMBSiUt2AhO7rzb3KMyH70LMgXiRMhjF0vM3xiCoZGuvlS8gxFv1ku5XzCE5aqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dJcxJR
	PYIUGrpdolD+ffYQJDWfbUEih0tYT2+6EzASvSv1f8lXfB2aZjrhVCQTmU0zuxaF
	eDjn6T085w7tXKay5bbPiRi7c58q7T2Zc4qAo+NT06dHOoOK/ugL0LLLOV8wFVwJ
	6hOg4Cd53d/7A6i80t3Dv6Lq8OvXxPAeChc7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF21F6D50;
	Fri,  3 Feb 2012 18:16:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 747B96D4E; Fri,  3 Feb 2012
 18:16:31 -0500 (EST)
In-Reply-To: <1328276078-27955-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 Feb
 2012 20:34:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B7E4F8C-4EBD-11E1-A6B2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189827>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +#define MODE(mode) ((mode) & COL_MODE)
> + ...
> +void print_columns(const struct string_list *list, int mode,
> +		   struct column_options *opts)
> +{
> +	const char *indent =3D "", *nl =3D "\n";
> +	int padding =3D 1, width =3D term_columns();
> +
> +	if (!list->nr)
> +		return;
> +	if (opts) {
> +		if (opts->indent)
> +			indent =3D opts->indent;
> +		if (opts->nl)
> +			nl =3D opts->nl;
> +		if (opts->width)
> +			width =3D opts->width;
> +		padding =3D opts->padding;
> +	}
> +	if (width <=3D 1 || !(mode & COL_ENABLED)) {

Unless there is a compelling reason not to, make a flag word used as
collection of bitfields an unsigned, i.e. not "int mode".
