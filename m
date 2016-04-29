From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/19] index-helper: new daemon for caching index and related stuff
Date: Fri, 29 Apr 2016 13:47:55 -0700
Message-ID: <xmqq60v0xhtw.fsf@gitster.mtv.corp.google.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
	<1461787481-877-4-git-send-email-dturner@twopensource.com>
	<xmqq60v15zmq.fsf@gitster.mtv.corp.google.com>
	<1461955617.4123.37.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:48:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awFKV-0005KB-DA
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 22:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbcD2Ur7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 16:47:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752763AbcD2Ur7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 16:47:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFBC1180EF;
	Fri, 29 Apr 2016 16:47:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ckjVxTic/eUQMDQipjqbS5i6eSk=; b=gdxsnb
	EPB7x82KdslfTqk5voPJQTZ1CYi6W/ihlXOFamBdLph6bstZwbZuo5mFc8ioVrFh
	momOnzN+1VVDx+GqiUWPEVpzjZlTDcH8AF1BHLfrqfxtcIhc7zoXQx/Ih9hCJOhx
	UMPAY80D3jEXF/FNsugR90DuRX3HFVKdsEngo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b2Z6hhdNm5RGSNLl8W/38ukrSeeyYOY9
	1zoicKLXnYuYg7ebbQ+oGVrg4I4dWEekSx/cDpwx5JOsiEEfa98FW2LCv5PmpxLh
	CT7KjH9t6r2X2E6pwlVebGhDMJVhrrDUTbEID3pDX3YxjbMDcPx23i3ENyHpUpch
	GzvZ5IhZFVA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6C33180EE;
	Fri, 29 Apr 2016 16:47:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14F95180ED;
	Fri, 29 Apr 2016 16:47:57 -0400 (EDT)
In-Reply-To: <1461955617.4123.37.camel@twopensource.com> (David Turner's
	message of "Fri, 29 Apr 2016 14:46:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7263318-0E4B-11E6-BBBE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293054>

David Turner <dturner@twopensource.com> writes:

> Per working tree/repository, yes (not quite per-index because working
> trees with split indexes have two).

Heh, I consider "split index" merely an implementation detail of a
(logical) single index file that happens to be represented with two
physical files.

Anyway, thanks for clarification.

> Why do we try to avoid select(2)?  It seems marginally less efficient
> for small numbers of fds, and might not scale to large numbers of fds,
> but we're not using it in a performance-critical way, and we only care
> about one fd at a time.

Just that having to deal with two APIs that do very similar things
is less preferrable than just using one that was designed later by
those who learned lessons while using the older one.
