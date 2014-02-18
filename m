From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make the git codebase thread-safe
Date: Tue, 18 Feb 2014 09:55:07 -0800
Message-ID: <xmqqlhx8fgqs.fsf@gitster.dls.corp.google.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com> <loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
	<CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
	<52FE68C9.3060403@gmail.com>
	<CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
	<CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
	<CACsJy8Dzj5iyaUseNyU76ojG1C0VYR=v7xsc=6TSGxTh=Xh3Ag@mail.gmail.com>
	<CAHOQ7J-gGbnADQ+3TGy6b6LJSLH8jvAbdTrc20Ybh=p0D2FmsQ@mail.gmail.com>
	<CACsJy8AQNmmW40R-H7kz1dmwiaSKVgu+GP=Jt1qTKgfbZoMkMA@mail.gmail.com>
	<CAAErz9gO3NrAF5Zhu277NLqBv-4otQVWGBP6fX00x2OJ3v0_fg@mail.gmail.com>
	<CACsJy8BdRd8yLjtYqGqQd2b1f550GLq6duZCD3JNiTO+K3GK6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zachary Turner <zturner@chromium.org>,
	Stefan Zager <szager@google.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 18:55:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFotL-0005ZX-EI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 18:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbaBRRz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 12:55:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754445AbaBRRzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 12:55:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7456D6B782;
	Tue, 18 Feb 2014 12:55:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ulXbskeu/wlt2j6TnF/bKrr6mcw=; b=gDrkA9
	KhozHdg/0xYUvOB9nEZY2Is5tZ0tuxIlQCmBEtL0DSVyh8W9b1PCGvBl3uzX4cDe
	VHAcClOr4H5zWKab/ZtP3q5QZi8e18/0FD7c3ABJ+WJIyeY98ykQpf1y56v8BOBm
	dBGeMSWN091bnTOeaceHpGNemPMUmPJUJVcI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nHTs/dT+HT/3hr9Xvx2lBYM6+CrExin/
	GmOfEd0heUSviibUjzpEBsx02YZZYXCTswMhE+grqr0JA5nCfnSjijs79b24HGqG
	y8eG3u6JolYBa9kyofVY0WgCw+fbcavc383oTuEFxAe5s4g4TvZzvy7zIXLX3SDT
	ANl2mFGx0WE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 604556B781;
	Tue, 18 Feb 2014 12:55:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84A0A6B77F;
	Tue, 18 Feb 2014 12:55:14 -0500 (EST)
In-Reply-To: <CACsJy8BdRd8yLjtYqGqQd2b1f550GLq6duZCD3JNiTO+K3GK6w@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 15 Feb 2014 08:39:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1B53334-98C5-11E3-9883-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242334>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Feb 15, 2014 at 8:15 AM, Zachary Turner <zturner@chromium.org> wrote:
> ...
>> 2) Use TLS as you suggest and have one fd per pack thread.  Probably
>> the most complicated code change (at least for me, being a first-time
>> contributor)
>
> It's not so complicated. I suggested a patch [1] before (surprise!).
> ...
> [1] http://article.gmane.org/gmane.comp.version-control.git/196042

That message is at the tail end of the discussion. I wonder why
nothing came out of it back then.

While I do not see anything glaringly wrong with the change from a
quick glance over it, it would be nice to hear how well it performs
on their platform from Windows folks.

Thanks.
