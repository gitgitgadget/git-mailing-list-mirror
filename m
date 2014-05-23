From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE costruct
Date: Fri, 23 May 2014 14:56:26 -0700
Message-ID: <xmqqtx8ggnw5.fsf@gitster.dls.corp.google.com>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqmwe8jr44.fsf@gitster.dls.corp.google.com>
	<20140523184405.GE12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	tboegi@web.de, dak@gnu.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 23:56:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnxS8-0005Da-1p
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 23:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbaEWV4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 17:56:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62892 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaEWV4b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 17:56:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FBD11AA68;
	Fri, 23 May 2014 17:56:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Udb3hQ/mWk/o8sXY8PdWU3mpd+4=; b=DGRQBP
	5dd8JG59sHxnqBjSh/iDWkOMnTqsAvlLnswE8ixu0UCPDfSixZRJezHGZwfYtLsM
	8PDsvDpAmZYZPrzqQJx3nUmVsucNSYlj9oliM7zggmKvZvFzOhcPD7JZ3i/d35b3
	8i0sDjylYSqmT4odYlcZXIu4PKxXaOAYkLmV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bBWBrpv+07fflXMuuKreYyG92U7+fBvB
	uLhXwRTrpkSqVz8s4E649iR84KK8d71pDp68itTImBNpBYLXr1XtSkXLlXiIwP/6
	+YhIncxcpMjlPpRCg9CkqmURFoLEvXc75BhSBZAyqbOz/nm8c6fECLXhkHEajQn6
	pPxG15hYuB4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14D531AA66;
	Fri, 23 May 2014 17:56:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C59761AA63;
	Fri, 23 May 2014 17:56:27 -0400 (EDT)
In-Reply-To: <20140523184405.GE12314@google.com> (Jonathan Nieder's message of
	"Fri, 23 May 2014 11:44:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1746B7E4-E2C5-11E3-82C5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250038>

Jonathan Nieder <jrnieder@gmail.com> writes:

> -	/^\s*export\s+[^=]*=/ and err '"export FOO=bar" is not por...
> +	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is n...

I see you also tightened what the "variable" to be assigned should
look like, which is a good change to avoid false positives.

Because the inter-word dash is taken as a word "\b"oundary, that
change incidentally prevents a false positive from triggering on
something like:

	git fast-export --option=value

;-)
