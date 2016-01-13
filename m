From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/21] refs: resolve symbolic refs first
Date: Tue, 12 Jan 2016 16:19:22 -0800
Message-ID: <xmqqmvsaqqk5.fsf@gitster.mtv.corp.google.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	<1452561740-8668-14-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 01:19:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ99u-0004Ze-5f
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 01:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbcAMATZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 19:19:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753076AbcAMATY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 19:19:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36B213BF28;
	Tue, 12 Jan 2016 19:19:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=+khX7yIb2NEuxDnKHkdZtOAxVzc=; b=LUgOiIWaHxQ4q1JRjN4m
	Q4SMfktNyHUCK7p7mCVwwFZ+w3p1g+1IMFk6U/HL9bXz/1QoR+vhavjpL1gws9AH
	LKE4VJE7jGrg2ZoatomTvmDh8xyeGGNG1p/PbcVI60CNDcv4aWgySP6fs+IPsGhn
	vlxyasQwRF7s5EHMlV7EJNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YpmHBIieo9cUxhek61+bqxFuSXKPxL6B11hZizKUlJmTJu
	cTBrO0wGxO9chUFNy8ZakB1gaY/5eS9qUWbXXPS5UFvsOIA9W5hnTjA9OSbcN5ie
	hUqdnuRWgdwSvF+WqyLZlaawxNKg2HxE8HoM2NoxdMJOSD3B1BmObWf6Rf5Ms=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25CDD3BF26;
	Tue, 12 Jan 2016 19:19:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 943AC3BF25;
	Tue, 12 Jan 2016 19:19:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C4A3544-B98B-11E5-9376-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283860>

David Turner <dturner@twopensource.com> writes:

> +static int dereference_symrefs(struct ref_transaction *transaction,
> +			       struct strbuf *err)
> +{
> +	int i;
> +	int nr = transaction->nr;
> +
> +	for (i = 0; i < nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> +		const char *resolved;
> +		unsigned char sha1[20];
> +		int resolve_flags = 0;
> +		int mustexist = (update->old_sha1 &&
> +				 !is_null_sha1(update->old_sha1));
> +		int deleting = (update->flags & REF_HAVE_NEW) &&
> +			is_null_sha1(update->new_sha1);
> +		struct ref_update *new_update;

This variable is never used (at least at the end of the series after
applying up to 21/21).
