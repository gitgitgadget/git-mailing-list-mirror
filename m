From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Wed, 19 Mar 2014 10:19:38 -0700
Message-ID: <xmqqbnx25cnp.fsf@gitster.dls.corp.google.com>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
	<1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
	<1395136856-17225-4-git-send-email-benoit.pierre@gmail.com>
	<53294808.8030106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Pierre <benoit.pierre@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:19:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQK9a-0007jy-Td
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759388AbaCSRTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2014 13:19:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbaCSRTl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 13:19:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29135743BD;
	Wed, 19 Mar 2014 13:19:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EVurS96pP7B/
	WCBlUiXVB6WygwQ=; b=WLl8KbmSjDWDtjMpRjO9w7kAgYCeXK8GMOmRtD1cxMmv
	pdeK5TgBh2BUWffDhuF7KN1t2i3KG2BkOYVX/QvJHkXRjkSkodB58nsawrjohpt5
	3vzBglFMkxSL3nGsrQ3yaQHZyRZ9kv8r0mTG81jSYUhOmmRFw4ULSrh18qvBw2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WMbhYw
	DuW8jb4bjre/gdF/89yLfar4BVFx3ipMCPXA0SFZWBCtDw/KFCb5yaaF1RuYbLzN
	W/6Jb6VTCu3g7xRdu4hB/QlsDnTqQQz5gxt1CyhYbxRxDNNXpKJoSv2GadpMiNe6
	rPSFGU3AHHfF/gakOxb8/gp8+6ZDmWT+AbVLo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 122EF743BB;
	Wed, 19 Mar 2014 13:19:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D2A0743BA;
	Wed, 19 Mar 2014 13:19:40 -0400 (EDT)
In-Reply-To: <53294808.8030106@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 19 Mar 2014 08:32:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A7A0A19C-AF8A-11E3-A620-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244462>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +int run_hook_with_custom_index(const char *index_file, const char *=
name, ...)
>> +{
>> +	const char *hook_env[3] =3D  { NULL };
>> +	char index[PATH_MAX];
> Sorry being late with the review.
>
> Recently some effort has been put to replace the
>  "PATH_MAX/snprintf() combo" with code using strbuf.
>
> So I think for new developed code it could make sense to avoid
> PATH_MAX from the start.

Yes but because this is a compatibility wrapper for an existing
function that does the string[PATH_MAX] thing already, it would be
clearer to have such a conversion as a separate step.
