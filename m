From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 08:19:56 -0700
Message-ID: <7v1u84ra77.fsf@alter.siamese.dyndns.org>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
	<1371196058-23948-2-git-send-email-artagnon@gmail.com>
	<7vhah0raps.fsf@alter.siamese.dyndns.org>
	<CALkWK0m6r4yRfCLb3dejdY+1KJgdOHPfrvPXbftNucApXFx+0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:20:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVnJ-0005up-9H
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab3FNPT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:19:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40959 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab3FNPT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:19:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98583259DE;
	Fri, 14 Jun 2013 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=csFfdhWrZ1jmKfa3dF6vbpj49sg=; b=rXlY05
	x8CL+IxKhhsv+pkeTFyD+GeNarxAjh4uyujv4VNbSD89JEAlZq/D6JDxtAVXNA8a
	zeL53QygIykSl0t451J2H/DxXgNQ7jaqKs4TQNEqGOyhQOff5XrhfCCYJUrEBc/G
	s49+uFqsuo5VWBTaoQ5a7Zy8YSqSOkLGQA+sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u3xC2IAfao9HXLDJqrX1EQQjHg6tfuCD
	AGkYaQQ/FP1nkqdbDTRlwoZJ5qdK/DiwyJau4CMvKN99W5CYrBVh++Ca1SFeLg8z
	ffGdDy9MUO+HxKaNPbMM0DpZKhVF3OEkpi/tlt/4ll3iTKkQWWWkhw4ZJEx7Xf6u
	+p/L4SS/97I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D92B259DD;
	Fri, 14 Jun 2013 15:19:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E802259DB;
	Fri, 14 Jun 2013 15:19:57 +0000 (UTC)
In-Reply-To: <CALkWK0m6r4yRfCLb3dejdY+1KJgdOHPfrvPXbftNucApXFx+0A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 20:41:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFCAA302-D505-11E2-BB68-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227886>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> $dotest, or \$dotest?
>
> Works fine for me like this.  Why do we escape the dollar in the other strings?

The reason would become clear once you think what string you are
feeding eval_gettext with if you do not escape.  The translators
translate a fixed string (possibly with placeholders) to a fixed
translated string (possibly with placeholders).

	eval_gettext "Stray $dotest directory found. ..."

would allow the shell to expand $dotest before eval_gettext sees it,
which would mean the string is no longer a constant.
