From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Mon, 28 Jan 2013 12:36:12 -0800
Message-ID: <7vham1vydf.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
 <20130128193700.GB7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzvRV-0002q1-7J
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab3A1UgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 15:36:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab3A1UgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 15:36:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3B65C30B;
	Mon, 28 Jan 2013 15:36:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xV3bUDtthaEupbOxoJq6hYxza6g=; b=JoOoun
	Mq1quhzfv4JG96N+v9JuD2eQG7h09xeByipmnEcI+zXdSto9I+SGwIXc3j77bbcL
	YuXEzvcy14LQKGRp8Ax1TXqXwLvqV72phj+MpyIt2zf9GCtnhMQL6Gs6/5gQKC5s
	x0wrhmjejpeTNoHne/fSSVgpXrU6HINh3wReY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fM8OYJcslewX5jKa37hKRW/MrmStTT7A
	BJWR9+xljDjz//FLyRfxcZ/r8nUyjWu5J7HtThLSBrnFEihOU/YLEcEyJZMlBX9U
	X3d78A3kavq/x2MTAyeFX2b05s7Zyyxiv+T4u8pnMmvJhaU1UkXBALyxKDmLYt+t
	brtPVuTDlUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8B95C309;
	Mon, 28 Jan 2013 15:36:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3746CC308; Mon, 28 Jan 2013
 15:36:14 -0500 (EST)
In-Reply-To: <20130128193700.GB7498@serenity.lan> (John Keeping's message of
 "Mon, 28 Jan 2013 19:37:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BDFEA20-698A-11E2-9E0A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214866>

John Keeping <john@keeping.me.uk> writes:

>> +			printf "%s%s\n" "$per_line_prefix" "$tool"
>
> This needs to be:
>
>     printf "$per_line_prefix%s\n" "$tool"
>
> since $per_line_prefix is usually '\t\t' which isn't expanded if we
> format it with %s - an alternative would be to change the value passed
> in to '$TAB$TAB' with literal tabs.

I would prefer the latter, actually.  I do understand the
convenience of being able to write backslash-t, but I do not think
it outweighs the potential risk of mistakingly passing a string with
per-cent in it.
