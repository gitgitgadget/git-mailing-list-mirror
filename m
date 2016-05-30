From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add without whitespace
Date: Mon, 30 May 2016 12:06:05 -0700
Message-ID: <xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
References: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 21:06:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7SVx-0006iw-TL
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 21:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161790AbcE3TGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 15:06:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161631AbcE3TGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 15:06:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D16E20E01;
	Mon, 30 May 2016 15:06:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYH3PkIKdh/lrxyWYFT4kg60lWw=; b=RQ7oDk
	eQ0mTZgAsO6eEW4UDWpfnaVyZHtz3VRjEmswanUxcWuxV4Hzd07GvpjP1PwouBfm
	PXyvpaF7VR5mtdcZkYXXQLwNPxOZf/AhZdaKOYUQOfAaXkR5MwKPw6WOaAHFEpyU
	e8hEOH4VIsehKwdGGUT1TPEhtkmPgySJCA3Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kzKDEVqpQVOYmrjf0SvhbOxE3TAZ0YzG
	UxfXD3RKK8fWr3n9cUWaKI4y6e0VpDdIt3ZFSXjNpNWN7FyuEAt8r/+OaAYdSc5u
	xt3YSt/cwJkvKWeL0iGdeUk7M+O3xfYurss8m0u+aPJt6v7/WgnUErbyCxMSbRKT
	H1vbJuMUWCk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4602620E00;
	Mon, 30 May 2016 15:06:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C180120DFF;
	Mon, 30 May 2016 15:06:06 -0400 (EDT)
In-Reply-To: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
	(Robert Dailey's message of "Mon, 30 May 2016 10:26:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8FEFA34E-2699-11E6-A21E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295927>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> $ git diff -U0 -w --no-color | git apply --cached --ignore-whitespace
> --unidiff-zero
>
> This command explicitly leaves out context because it can sometimes
> cause the patch to fail to apply, I think due to whitespace being in
> it, but I'm not completely sure myself.

I have had this in my ~/.gitconfig for a long time.

[alias]
	wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached --whitespace=fix;\
		git co -- ${1-.} \"$@\"' -"

That is, "take what's different from the _index_ and the working
tree, apply that difference while correcting whitespace errors to
the index, and check the result out to the working tree".  This
would _not_ touch existing whitespace-damaged lines that you are not
touching, and honours the customized definition of what is
considered whitespace breakage for each paths (which you set up with
the attributes system).
