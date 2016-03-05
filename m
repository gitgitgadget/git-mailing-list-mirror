From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Sat, 05 Mar 2016 13:18:21 -0800
Message-ID: <xmqqr3fotyhu.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
	<1455207366-24892-1-git-send-email-tboegi@web.de>
	<xmqqy4arw089.fsf@gitster.mtv.corp.google.com>
	<56DA896A.3050201@web.de>
	<xmqqtwklwdrh.fsf@gitster.mtv.corp.google.com>
	<56DA986B.6040003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 05 22:18:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acJao-00071s-Ni
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 22:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbcCEVS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2016 16:18:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750832AbcCEVSZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2016 16:18:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD78A48D72;
	Sat,  5 Mar 2016 16:18:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hJlHsIxD7CJV
	mtvAw9t825oEwKM=; b=U6ATpsPEwsyI0gBl9ValUqqhtR+OvVzSR+XG3zlLNluN
	spE8HhSfORojG5EjMNDvg+TI9pliHniq6Lb/u40TFcilw+wLdm/1gKX8ov4UxLpn
	/GYPeiE+fg9JijQ9lHbfc1y11MT7YoJretQu4UzXCTwObfgGPsT8PFe6H0T8LjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CJsAu7
	pQfXKHHfxRJTgPhMBZZ/yCR4YJ88tBhaejgMT6ANKMo9F3CozAQ9EplIeFqthFDp
	vId0HI7SBOAS8rIssib7Tr8JMSgozsmsquB3H6cMyrd9n0lFf0YbGGR84QPkAKcJ
	jX7uLcXGzaoU8EgVth9uTsbYbjCr3ZnYACWE8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2D7348D71;
	Sat,  5 Mar 2016 16:18:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8B2A48D70;
	Sat,  5 Mar 2016 16:18:22 -0500 (EST)
In-Reply-To: <56DA986B.6040003@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 5 Mar 2016 09:27:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAA6FE76-E317-11E5-84E9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288327>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> When the user has CRLF data in the index and the user tell the
>> attribute system so that the next "add" would result in "fixing" the
>> indexed lines to be terminated with LF, "diff-files" _should_ show
>> that correction as a change, I think.
> Fair enough.
> There are 2 users here:
> User 1 commits files with CRLF into the index, and later decides
> to set the "text eol=3Dcrlf" attribute on it, without normalizing the=
 repo.
>
> User 2 does a simple "git clone", which includes checkout.
> Running "git diff" tells user 2, that his work tree is dirty.
>
> My conclusion is, that we could suppress the normalization for text f=
iles,
> (as we do it for core.autocrlf with the new safer CRLF handling)
> meaning that "git diff" and "git status" is clean and that files stay=
 with CRLF
> in the index.
> Does this make sense ?

Your example is for these two users to have conflicting settings on
the line ending, but if user 1 commits files in latin-1 to a project
where in-project data is expected to be UTF-8 and working tree files
can be in latin-1, with necessary conversion done via clean/smudge
filter, the user 2 would see a very similar symptom, wouldn't s/he?

So I am not sure how your example supports a hack that treats CRLF
conversion as something special among other conversions, without
doing anything about clean/smudge filter.

Besides, it is OK if your status and diff says your worktree is
dirty immediately after cloning in such a broken situation, I would
think.  In fact, it may even be preferable to do so, in order to
indicate that there is something unusual going on.
