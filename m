From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 18/19] Add tracing to measure where most of the time is spent
Date: Thu, 05 May 2016 15:48:26 -0700
Message-ID: <xmqqoa8k86kl.fsf@gitster.mtv.corp.google.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
	<1462484831-13643-19-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 00:48:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayS4O-0001DK-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032AbcEEWsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 18:48:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757420AbcEEWs3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2016 18:48:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F5B1902E;
	Thu,  5 May 2016 18:48:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=us5oxotSUY1k
	7c57P23skffWojA=; b=xhXbVP6WZT9PvuhHR0uHGuXCN4WoK4f86u+dIjX5fFn2
	nhX6SZ3dX466T2NJxQEaQvuYOjpf8xRQknmdAzwUp9hOAqZw2eaxvU5Q6tvvUU4L
	Ou9XAT8D+x3Xqx7I11+ZahHly7957aLtgeZ41CScgmnZAszhu8oev43578LxZlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kdkt4+
	7W9lwhUWPBYGIg6xuQUnvE5JvzS6j9H94j6uEigz7TFpfv2pB6MBGdXsKxzltXl5
	ntJHyi1gClw4T0e+Y09rn6Npxp42isSXG2yIeNzslNHFvg7ec9i8LbQKHUIqWThP
	6yV/SoN9aieuDLs4xDxe+oFWsUI/HaPWtCnhE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 530D81902D;
	Thu,  5 May 2016 18:48:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C55611902A;
	Thu,  5 May 2016 18:48:27 -0400 (EDT)
In-Reply-To: <1462484831-13643-19-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 5 May 2016 17:47:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7B792D52-1313-11E6-8308-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293717>

David Turner <dturner@twopensource.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Subject: Re: [PATCH v8 18/19] Add tracing to measure where most of th=
e time is spent

trace: measure where the time is spent in the index-heavy operations
