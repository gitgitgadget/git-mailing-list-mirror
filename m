From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] receive-pack: hint that the user can stop "git push" at auto gc time
Date: Tue, 04 Feb 2014 10:32:30 -0800
Message-ID: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
References: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com>
	<1391496765-29564-1-git-send-email-pclouds@gmail.com>
	<1391496765-29564-2-git-send-email-pclouds@gmail.com>
	<xmqqha8eag6c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jugg@hotmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 19:32:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAknn-0004TN-6e
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 19:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbaBDScu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 13:32:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbaBDScs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 13:32:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC836828C;
	Tue,  4 Feb 2014 13:32:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=URolxrW4ZIjZ
	VFUoZicqBgeT3mk=; b=anR6y4DlfsFqBOCHLH68OlHYfu5bJOwjzd193zsotUC9
	KfwBV4b4aAjmqmaz4redgP0epKicOIqfkuHtrwiQnU764s3R00srOKAlCtaMnYfC
	QBJvv1mVtRgzkDWfHwgaucrwLkGXOBuFQM/brihi35ze/PxXbkeSVYwl8oSJeLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xue+jw
	LofQXTDXoxcZcVGw5MRACtPZAtCOVbeOxZKxAtbpCSAibRQSTE8Pa/GleHqsH8Zt
	2kA8NBu/U1izbef3jbkNKiHSN9//nx5D6s8aiQWQJYZS5uGrAfHO1QPrP4cQoQuu
	y8qwwWYEo5MzQ4CXIvawuqDveVI9VXM74eJs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF1056828A;
	Tue,  4 Feb 2014 13:32:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA1F668288;
	Tue,  4 Feb 2014 13:32:31 -0500 (EST)
In-Reply-To: <xmqqha8eag6c.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Feb 2014 10:25:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B57325A6-8DCA-11E3-B739-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241536>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Housekeeping jobs like auto gc generally should not get in the way.
>> Users who are pushing may not want to wait until auto gc is done on
>> the server. Give a hint for those users that it's safe now to break
>> "git push" and stop waiting.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  This bandage patch may be a good compromise between running auto gc
>>  and not annoying users much.
>> =20
>>  If I'm not mistaken, when ^C on "git push" this way, gc will still =
be
>>  running until it needs to print something out (which it should not
>>  normally because of --quiet). The user won't see gc errors, but the
>>  user generally can't do much anyway.
>
> If you are over local transport, I would think you would kill the
> both ends.  Also, wouldn't killing "git push" before it is done
> talking with the receive-pack stop it before it has a chance to
> update the remote tracking refs to pretend as if it fetched from
> there immediately after a push?
>
> So, no. I do not think we should ever encourage "if this bothers
> you, you can ^C it".  Making it not to bother is fine, though.

Instead of adding a boolean --break-ok that is hidden, why not
adding an exposed boolean --daemonize, and let auto-gc run in the
background?  With the recent "do not let more than one gc run at the
same time", that should give a lot more pleasant end user
experience, no?
