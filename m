From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] refs.c: split delete_ref_loose() into a separate flag-for-deletion and commit phase
Date: Fri, 11 Apr 2014 14:51:33 -0700
Message-ID: <xmqqa9brr0uy.fsf@gitster.dls.corp.google.com>
References: <1397248790-10403-1-git-send-email-sahlberg@google.com>
	<1397248790-10403-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 23:51:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYjMY-0005pq-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 23:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbaDKVvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 17:51:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133AbaDKVvh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 17:51:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B6987C5CA;
	Fri, 11 Apr 2014 17:51:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Ebl6wl1znMD8zSeOBVmeiEZOpg=; b=kvCnnC
	OcJcOEbx5mD6oJX8MRzPH5DuDR1eOV3pCWZOL2K/VIB6zi5/HcdeaW6WQ/XQ1vsB
	7HnWPGKqc6tTnC5F2wiRYKE8CxUEch3qUrx8OM0i/ZfyjM7fdbKm6XW+2rrTFU9k
	2r2MfQuZTwe8XIA3KKCrRganFovrQB9u2+FDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GMoh7Vu/gwdF2VzxYBv+YBjf3cG6VPcD
	EscgIXyIlK4Wb9B2vZyqRdatfb87GHcXP1CIXlC5q1RGTWdZuU4ii6G/ie5LUrkf
	JGY917ztnmOZeEu20JEK9NEERF4//Qz7IH0RAMKM8JmU4OYGUgbYzPx81hXtblDD
	q/CQGI7tyQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6456E7C5C8;
	Fri, 11 Apr 2014 17:51:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D96327C5C5;
	Fri, 11 Apr 2014 17:51:34 -0400 (EDT)
In-Reply-To: <1397248790-10403-3-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Fri, 11 Apr 2014 13:39:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 73566DEA-C1C3-11E3-968E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246151>

Ronnie Sahlberg <sahlberg@google.com> writes:

>  int commit_ref_lock(struct ref_lock *lock)
>  {
> +	if (lock->delete_ref) {
> +		int flag = lock->delete_flag;
> +
> +		if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
> +			/* loose */
> +			int err, i = strlen(lock->lk->filename) - 5; /* .lock */
> +
> +			lock->lk->filename[i] = 0;
> +			err = unlink_or_warn(lock->lk->filename);
> +			lock->lk->filename[i] = '.';
> +			if (err && errno != ENOENT)
> +				return 1;
> +		}
> +	} else
>          if (!lock->skipped_write && commit_ref(lock)) {

	} else if (...) {

Also the previous patch indents the above "if" line in the context
with spaces; please use a tab.
