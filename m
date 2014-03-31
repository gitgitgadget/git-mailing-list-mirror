From: Junio C Hamano <gitster@pobox.com>
Subject: Re: socket_perror() "bug"?
Date: Mon, 31 Mar 2014 13:50:43 -0700
Message-ID: <xmqqy4zq3xek.fsf@gitster.dls.corp.google.com>
References: <CACnwZYc2py4dxehg2=gnnPLxwJaRqXYTLQvC1O7YuoqAWsZ0Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 22:50:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjAU-0005Uv-3C
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 22:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaCaUut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 16:50:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbaCaUuq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 16:50:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D5487985E;
	Mon, 31 Mar 2014 16:50:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hYYoMJFwNfwfzXxazNNpBrtkfuk=; b=BFxrpm
	mxriIRevuPJks6Lk3olEZA6w+f4VNEHBxx6ZernsHGwJqaLtiEkTE165DLWBNhKi
	OmIa/BD2sQFyySAFLgFohLsXybY8PnNrZr3LMDVR6WTrTOn8jEQPbvYSo0JiXxLU
	jBl57RWEuFIqlMciCRSGRitCMrqOHcSV+1eUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LpUlNb5wajdfD02FSO2tO50ZO8M+Z0wr
	95inWbAxaBa0B3RgjgO/auwCWadu8WH0bUrqfl20Hhc1PPZcGI/0KN1slV/HgVrl
	UAz24tZ1j14zp/K3Z15RI+gz18YD1XcgpowwNvJZIuJc1DztrNdnMp7rbxtaeG1C
	mvvINVxzrDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07F937985B;
	Mon, 31 Mar 2014 16:50:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5770479859;
	Mon, 31 Mar 2014 16:50:45 -0400 (EDT)
In-Reply-To: <CACnwZYc2py4dxehg2=gnnPLxwJaRqXYTLQvC1O7YuoqAWsZ0Tg@mail.gmail.com>
	(Thiago Farina's message of "Sun, 30 Mar 2014 16:32:54 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 217F9FA6-B916-11E3-90D3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245527>

Thiago Farina <tfransosi@gmail.com> writes:

> In imap-send.c:socket_perror() we pass |func| as a parameter, which I
> think it is the name of the function that "called" socket_perror, or
> the name of the function which generated an error.
>
> But at line 184 and 187 it always assume it was SSL_connect.
>
> Should we instead call perror() and ssl_socket_error() with func?

Looks that way to me, at least from a cursory look.
