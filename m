From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 11:51:24 -0700
Message-ID: <7v61zvsfkj.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org> <51645EC6.407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:51:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPddv-0001Vz-Da
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935605Ab3DISv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 14:51:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934538Ab3DISv1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 14:51:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DE3F151C9;
	Tue,  9 Apr 2013 18:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9vxSfzCJU6OC
	LYP4OXXse24uBHs=; b=v0Er0SR7ZrvQOwsdLUpIWBenGV03WWYUeXbcJckkdFiY
	e+zX/hdN3ddCUZuYuSkFv5w+OdDCeRqhWLrIqfBsXgsCMWFhaDhBW0nmlXySTgdu
	zNGY+0kc3oi2UAe33JNgMAt2VjRgjl5paXme/V3VX3tFYAx17dB11Uey5RzpypM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S/V9Jb
	TwDhqec8yZsD5HJyc8HykvEfFGUHMXPcaJUHmzW9SL4hacVnellEN/x06AYPOGk6
	eCFWjx7eHwE0zE+KYH3lJ39YAs44h2bvtOs0FOqsKXqY0ZBg3rf4+OowvpwVzwUv
	lfUbyT7WD4hGfxV3reBdrCVvXlvUD0UrS84bY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 054A0151C8;
	Tue,  9 Apr 2013 18:51:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CDF0151C6; Tue,  9 Apr
 2013 18:51:26 +0000 (UTC)
In-Reply-To: <51645EC6.407@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski=22's?=
 message of "Tue, 09 Apr 2013 20:32:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B5AFC66-A146-11E2-9665-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220614>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 09.04.2013 19:34, Junio C Hamano pisze:
>
>> -	if (has_symlink_leading_path(path, len))
>> -		return error("'%s' is beyond a symbolic link", path);
>> +	if (path_outside_our_project(path, len))
>> +		return error("'%s' is outside our working tree", path);
>> =20
>
> Don't we lose important information here?  Or we shouldn't care?

What important information is it?
