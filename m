From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove redundant close_ref function
Date: Tue, 08 Apr 2014 14:32:13 -0700
Message-ID: <xmqqioqj33tu.fsf@gitster.dls.corp.google.com>
References: <1396991830-20938-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 23:32:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXdd0-0002DS-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 23:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757590AbaDHVcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 17:32:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757536AbaDHVcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 17:32:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF8A2795C4;
	Tue,  8 Apr 2014 17:32:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B90DEzI51ObLF/p+1wGvD6wV5nk=; b=vRHidU
	9inlS6vVZ011xBy/7DFabV6l3+PBht0aieslKTOMMm8clkXc3RbPyBzSY+YuFKPh
	8ZGUc3BLzuTofkiREpcmlhRHjgPC63s9lQFPIP7mJ4VJviigsZKLBwTfeGVJ8A3T
	1P15YlI0BXMvIgMcXnD5SKPqXfoCCQFqGwWB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2HoKARibEMuhv0pO9WnBbKKyHmOKD+f
	ivuioPgh6lO/eRd1KSNckZdCYZYUQGmzPx3Gfi0dVNL3fHYjxJ1GlkiNJDnqbbvi
	1dZLsBtgPHy40ia3740Lv6ubSgHOV4MC0oW7bszUopVKMPOqSwKEyQ6PX7NC7lfA
	r0BfHZdKkgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9AFA795C3;
	Tue,  8 Apr 2014 17:32:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8D86795C0;
	Tue,  8 Apr 2014 17:32:14 -0400 (EDT)
In-Reply-To: <1396991830-20938-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 8 Apr 2014 14:17:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40A3D014-BF65-11E3-8F7C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245961>

Ronnie Sahlberg <sahlberg@google.com> writes:

> List,
>
> This is a trivial patch that removes the function close_ref() from refs.c.
> This function was only called from two codepaths and can be removed since both codepaths shortly afterwards
> both call unlock_ref() which implicitely closes the file anyway.
>
> By removing this function we simplify the api to refs slightly.
> This also means that the lifetime of the filedescriptor becomes the same as the lifetime for the 'struct ref_lock' object.
> The filedescriptor is opened at the same time ref_lock is allocated and the descriptor is closed when ref_lock is released.
>
>
> regards
> ronnie sahlberg

Thanks.  A few tips:

 - wrap your lines at around 72 columns.

 - "git format-patch --cover-letter" will give you a skeletal
   message with "Subject: [PATCH 0/n]" with list of individual
   patches and diffstat to show the overall damage, with two
   placeholders "*** SUBJECT HERE ***" and "*** BLURB HERE ***"
   for you to fill in the remainder.

 - For a short/single patch, you do not have to add a cover letter
   (it is not a crime to add one, though).
