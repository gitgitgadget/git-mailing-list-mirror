From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reproducible unexpected behavior for 'git reset'
Date: Mon, 11 Jul 2011 14:54:43 -0700
Message-ID: <7vwrfoa3fg.fsf@alter.siamese.dyndns.org>
References: <75BBC138-2BD7-41F9-9D84-CEFF23CDC235@johnnowak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Nowak <john@johnnowak.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:54:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgORH-0002ZS-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326Ab1GKVyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:54:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1GKVyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:54:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CAF646D82;
	Mon, 11 Jul 2011 17:54:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9pWoTrgzqP42eaLUo4ZMPmj9/f8=; b=SwntBi
	BKoLKmLv/CG/Re/pcymdEQ9PtOcP+h73dyGDopdQatgnWdHiB/3gLG1ZBTQIfS6o
	cVvABWCRWktj6VdZ7He4cCoe84EwaOuyc9TubZLD1IQBxkZj+MzbexrVzBjrH2Ql
	qtwkMHWwztuWx4A1csUZZQ7BnKSwFXiYytoaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cfYdQBH0mTHnCfkOWPeboKIv7n2m4Cxe
	0YGEuepVUncgSU7MYh7cjE0bXQqhYUATk7qpl1aNISJKq3XVHfoixjbNXt+R5QRo
	MnkbxK2RfdTWUyJY77BJcv0BilTIHnBLqXPjLR8izu9l28lEU4pUxzLxf4BpXu3X
	recUbuPAvCI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A7EB6D81;
	Mon, 11 Jul 2011 17:54:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE1866D80; Mon, 11 Jul 2011
 17:54:44 -0400 (EDT)
In-Reply-To: <75BBC138-2BD7-41F9-9D84-CEFF23CDC235@johnnowak.com> (John
 Nowak's message of "Sun, 10 Jul 2011 18:30:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 635D1A3E-AC08-11E0-8544-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176902>

John Nowak <john@johnnowak.com> writes:

> I am able to reproduce a scenario where, after a 'commit' and a 'stash
> pop' that results in a merge conflict, I need to 'reset' a file twice in
> order to get the index back to HEAD.

Thanks, you found a bug in "git reset [<commit>] -- path" codepath, it
seems, when dealing with an unmerged path.
