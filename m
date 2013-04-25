From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Thu, 25 Apr 2013 16:19:32 -0700
Message-ID: <7v4neu19mj.fsf@alter.siamese.dyndns.org>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
	<1366663435-13598-1-git-send-email-gitster@pobox.com>
	<7vhaiu1a89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 01:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVVS7-000209-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759690Ab3DYXTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:19:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759684Ab3DYXTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:19:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9119219354;
	Thu, 25 Apr 2013 23:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e2Rgj0mlXcztlEUugk8XYYLUdPg=; b=wI35h0
	spDu2HXQL8aXJ0cIGmpU/tgJuBb+R5sk8U1dceacY4Kpe40vAcXbQJQZwJ2UtNX7
	+ZF+agyKj5lv1rXRs+sJ5QfxCWi9PJnbi0pO061xQ92JdGWDwLY/6G8dPTPkRhDJ
	ooPlUhELS+aahG6LBGsaWbA69x431KMgAZbzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t4ZwtUv6HYTZ3mlVDw5soxBRvASK3pCp
	j54WUWBfiJUz+7dj+1RSh74nk8+TTeDNDS3cSLZxMzv2PcKMQ4OqFWqfxbD6wfUh
	ep8jHNW9jhsUm8qy22AMFSlIdhUXB2AzDygsnNumBe0Md4xmYVA8ZzbtzGCaedoR
	VGBLgAnRDVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87B8B19353;
	Thu, 25 Apr 2013 23:19:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B14A19352;
	Thu, 25 Apr 2013 23:19:40 +0000 (UTC)
In-Reply-To: <7vhaiu1a89.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 25 Apr 2013 16:06:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B22B254-ADFE-11E2-9005-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222462>

Junio C Hamano <gitster@pobox.com> writes:

> One thing I noticed about Jonathan's warn_pathless_add() thing is
> that even though it knows for which path we would behave differently
> between the current version and Git 2.0, the warning message does
> not say which path outside the current directory would be added if
> not restricted with an explicit ".", and leaves the reader in
> suspense.
>
> We may want to fix it by tweaking the end of the message, perhaps?

Hmph, bad idea.

At the point of calling warn_pathless_add(), it seems that we are
triggering this for paths that are not necessarily modified when run
with "add -n -u".
