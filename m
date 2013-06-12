From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] [submodule] Replace perl-code with sh
Date: Wed, 12 Jun 2013 14:08:43 -0700
Message-ID: <7vli6f11gk.fsf@alter.siamese.dyndns.org>
References: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
	<1370991854-1414-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 23:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmsHn-0007BR-FN
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 23:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565Ab3FLVIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 17:08:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab3FLVIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 17:08:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2519A275A0;
	Wed, 12 Jun 2013 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bx8kwZAQQ5zsBb+kc9Lc17hrS9A=; b=Qg79gh
	MEIg0llkK4ptuSJks2yjP8YOCfzIuIa2aiFH4qmpx52psM4C+w+P1eSBIDq+9asp
	YVOBX/ubdHPuklBr1jwstWspPk+agztUVMtrwhIH+krOkOpRo4dPEwHGckZkwhzp
	1akCK+xQl2GiS0d6IARaJRAq2zZyIBVJ35w1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sngx+B9c+tz1MUqPnu0HJkFkSxjos3RS
	NuOVq0H2efVolr6X0Ji3xGDvhQG9MxdK6GDLnwIh6/MuJQG/+WoB6OlhJXg9kWR9
	ZD2lw8t0vqqMIemeaeLAEdienGJA/K8sh28y5kDxx/4PNvZxbzF2bWHRIBa+kHST
	YVqGzOJFiUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18A232759D;
	Wed, 12 Jun 2013 21:08:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7480427598;
	Wed, 12 Jun 2013 21:08:44 +0000 (UTC)
In-Reply-To: <1370991854-1414-3-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Wed, 12 Jun 2013 01:04:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44150932-D3A4-11E2-B317-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227680>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> This is a work built on
> http://thread.gmane.org/gmane.comp.version-control.git/198873/focus=198930
>
> Basically git-submodule.sh needs to use something else than sh to handle
> newline in filenames (and therefore needs to use a language that accepts
> \0 in strings).

Have you considered "git -c core.quotepath=false ls-files"?  You
won't be able to handle paths with LF or dq '"' in them, but that
feels much less worse than doing

	sed -e 's/\x00/\n/'
