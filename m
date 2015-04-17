From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Fri, 17 Apr 2015 10:09:34 -0700
Message-ID: <xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:37:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjB8d-0004qc-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 20:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbbDQShK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 14:37:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932390AbbDQShH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 14:37:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BEA14A86B;
	Fri, 17 Apr 2015 14:37:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z4u/AwMvB60+feFs2LMph/5QAKA=; b=nq0Joa
	7OJKUWXIc6ejxu6FDmv3nPxQW1GtkXlSEhCCATSA3xDDl5SLvZ7HkMbgk5qyzFDy
	jerRUTliEGkQ3eodi0TwF+I7bsTTY6pmTSjXdfS9C8xKZQs04OT91wcjyaWnPtPK
	FADDDcb434KUDpnWkUPcphgRBsVrrvwHI0vhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mpAmRR9HV1Dtimj4rQvYuXrQJVLfxEth
	7MAGmnkmca5CNKrbESBCUFGfkRaK1Y7ck9Jx9BGknTa+KSDJ3IAcoaGizSvi3VPO
	K/ccXkiTTex9ZS9jSxoK9GP4y4TEcIgPkCVOsEjmZny4BvJXv3Gtg5UWVBEEx2v3
	beyls6UYvxo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60EBB4A86A;
	Fri, 17 Apr 2015 14:37:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35183485D5;
	Fri, 17 Apr 2015 13:09:36 -0400 (EDT)
In-Reply-To: <1429226259-21622-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 16 Apr 2015 16:17:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8646DC0C-E524-11E4-A41F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267374>

Stefan Beller <sbeller@google.com> writes:

> * We keep the speed on small transactions 
>   (no close and reopen of fds in small transactions)
>
> * No refactoring for refs included, only minimally invasive to the refs.c code
>
> * applies on top of origin/sb/remove-fd-from-ref-lock replacing the last
>   commit there (I reworded the commit message of the last patch of that tip,
>   being the first patch in this series)
>   
> * another approach would be to move the fd counting into the lock file api,
>   I think that's not worth it for now.

I agree that it is a good direction to go to limit the number of
open file descriptors.  Overall it looked good to me.


>
>
> Stefan Beller (3):
>   refs.c: remove lock_fd from struct ref_lock
>   Move unsigned int get_max_fd_limit(void) to git_compat_util.h
>   refs.c: enable large transactions
>
>  git-compat-util.h     |  1 +
>  refs.c                | 28 ++++++++++++++++++----------
>  sha1_file.c           | 41 -----------------------------------------
>  t/t1400-update-ref.sh |  4 ++--
>  wrapper.c             | 41 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 62 insertions(+), 53 deletions(-)
