From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] Read (but not write) from XDG configuration, XDG
 attributes and XDG ignore files
Date: Mon, 04 Jun 2012 11:41:50 -0700
Message-ID: <7v62b6udg1.fsf@alter.siamese.dyndns.org>
References: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <4FCCF63B.8070609@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nguyenhu@ensibm.imag.fr, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jun 04 20:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbcE2-0000jO-UA
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 20:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab2FDSly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 14:41:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647Ab2FDSlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 14:41:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB80682A0;
	Mon,  4 Jun 2012 14:41:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nn8hPe3jVoFun5IumWl1KzY7RR8=; b=f9ubCp
	YELRuK/G6M3ysLxRpG81oK7D+rmW/Vmh9vCbhfz1uJeeDtnqS3NHy3jGltMgTrJq
	9HJDna+ZG2hm/7fz0lL7RwAhXeOpG24mG21xbwzfi7G9/yiUpPaZzQ2H0a69j73o
	eKlHVnpfNqacjtxS+ATn/bM2S+gTY3Ml34+XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rYgl38j4fgTlijS+QB0llgKlEvNhgt4O
	egF1hxpLv5cL+3myUPoy4C8fIGJoOZ34PGmBan5xVlUNlOcGWms7a70IIxv+qwO9
	5Cka+pM+5Y1LhtENJVg4iCa/N/QDbD3vpp6Bdvp4fJG8n7P8VNsncEJERNy1Bo5Q
	EDONyNgsiOg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C171B829F;
	Mon,  4 Jun 2012 14:41:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47C71829D; Mon,  4 Jun 2012
 14:41:52 -0400 (EDT)
In-Reply-To: <4FCCF63B.8070609@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Mon, 04 Jun 2012 18:54:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F38E809C-AE74-11E1-B448-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199167>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Subject: [PATCH] path.c: Fix a static buffer overwrite bug by avoiding mkpath()
>
> In order to fix the bug, we introduce a new variation of the mkpath()
> function, mkpathdup(), which avoids the use of the internal static
> buffers.

Shouldn't we aim a bit higher to also avoid the use of bounded
buffer?  Instead of returning bad_path, retry with lengthened buffer
until we succeed, or something.

Better yet, internally use strbuf_vaddf().
