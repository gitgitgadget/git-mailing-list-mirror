From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] diff: turn skip_stat_unmatch on selectively
Date: Mon, 27 Jan 2014 15:45:52 -0800
Message-ID: <xmqqd2jdm1jj.fsf@gitster.dls.corp.google.com>
References: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
	<1390863568-22656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 00:46:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7vsO-0008Ca-9h
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 00:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbaA0Xp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jan 2014 18:45:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141AbaA0Xpz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jan 2014 18:45:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCF0767402;
	Mon, 27 Jan 2014 18:45:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=z2Hk6eMf1ujX
	oATa9W8VyZ3DN08=; b=FpBElKbWGMTMA4+csDXVxDkzhp0chDSlX0wTrHZZeiAs
	GoykVHV3Tsd/qu5r4Az6NmIHKEa3dJtGIId/ZZDXOLwV28mGX0GCzXV71LQEax+Q
	nPTNdIzJJ3lz5GjpZhmfnFf1k65qpbaixXk+TjRjkd/UAklIkcv4Aot3bym+eAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=P18Gbk
	Pl1OeBrDrIqfdWDUiLVZQfGzPF4SWXM0PqkTEXWrw66YHVPl/dTX4/7jCY4Mzplc
	PLFdAiYckpKR+gdAkEnjI2xcdGhyijS4oDz6J5YlMKQMp+ZJHZwSqTi81TcfmpFO
	bmkZqPF7EouEBeXVnAIAiE55HOqSwrX9rrbdg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFA2667400;
	Mon, 27 Jan 2014 18:45:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C96A673FD;
	Mon, 27 Jan 2014 18:45:54 -0500 (EST)
In-Reply-To: <1390863568-22656-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28
 Jan 2014 05:59:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29428FC2-87AD-11E3-B136-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241169>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> skip_stat_unmatch flag is added in fb13227 (git-diff: squelch "empty"
> diffs - 2007-08-03) to ignore empty diffs caused by stat-only
> dirtiness. In some diff case, stat is not involved at all. While
> the code is written in a way that no expensive I/O is done, we still
> need to move all file pairs from the old queue to the new queue in
> diffcore_skip_stat_unmatch().
>
> Only enable it when worktree is involved: "diff" and "diff <rev>".
> This should help track down how skip_stat_unmatch is actually used
> when bugs occur.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This replaces 'diff: turn off skip_stat_unmatch on "diff --cached"'
>  The previous patch obviously leaves skip_stat_unmatch on in "diff
>  <rev> <rev>" and maybe other cases.

Oops, I lost track.  Sorry.
