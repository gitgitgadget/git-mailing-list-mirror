From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/6] worktree: add "lock" command
Date: Tue, 31 May 2016 11:28:42 -0700
Message-ID: <xmqqr3ci3wv9.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-6-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:28:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7oPK-0003XE-3s
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 20:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839AbcEaS2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 14:28:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755563AbcEaS2p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 14:28:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A6C31FA92;
	Tue, 31 May 2016 14:28:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rvOuWY/hOh7n
	nmqcHvBSvv5N5OM=; b=mb2YDjcg86WxRGu/F/HAH0Yo5KHAYnidPErzPDH8rl55
	Z2mhlGlQOUuSl507xSOMsxrcei1ZqQpZuvj74hW5djpx38NC8eE4gFkWDcciiWxu
	BQ30EnTAb8qAY+Hc232G7bimpyidXIGfJV8Wrr1caeEPJ1uvEG8MDl8LAGNEB7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OmkWHs
	9usUYDaS8bfQiKmcVaLTnQ6bfpC76BS8OB0IWuge+cLmq1jl4hf/yJC6mrVI9Gzs
	osD+U7x08l6JtsleIQxtE3AMvksS8vM2VgOWp5ODuc0jp08qSn7uPRciqcpwqYoT
	6bLhy71Q4SDYnuLTjzueyA8sHAREOwfcRzTqk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 427EA1FA8F;
	Tue, 31 May 2016 14:28:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFCA21FA8E;
	Tue, 31 May 2016 14:28:43 -0400 (EDT)
In-Reply-To: <20160530104939.28407-6-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Mon, 30 May 2016 17:49:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 817246D6-275D-11E6-87CD-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296005>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <p=
ath> [<branch>]
>  'git worktree list' [--porcelain]
> +'git worktree lock' [--reason <string>] <worktree>
>  'git worktree prune' [-n] [-v] [--expire <expire>]

This seems to be based on an unseen version that lists 'list' before
'prune' here and other places.  I'd appreciate it if you either make
sure a series that introduces a new feature applies cleanly to my
tree before sending it out, or clarify to what state the series is
designed to apply, when you send a patch series next time.

> @@ -110,6 +118,15 @@ OPTIONS
>  --expire <time>::
>  	With `prune`, only expire unused working trees older than <time>.
> =20
> +--reason <string>:

Double-colon, I think (locally fixable).
