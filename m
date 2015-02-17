From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate fails
Date: Tue, 17 Feb 2015 15:36:54 -0800
Message-ID: <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
	<1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
	<7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
	<xmqqk30hyock.fsf@gitster.dls.corp.google.com>
	<CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "Dan Langille \(dalangil\)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:37:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNrhN-0003tt-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 00:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbbBQXg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 18:36:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752134AbbBQXg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 18:36:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A121C39D03;
	Tue, 17 Feb 2015 18:36:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iFYCmSBaF0CiMvsdK2Z5E/v8L88=; b=O9526P
	y8ax+bErOJJnv1x+NDlKRZKmRRu0Kd6lsJaLOIypPG1HF5CmV4Mj06O35UQEWQcQ
	4+GpiaBXgN+gQJDeqcBRVHr4rvQfiYUU8cN3kYHOHgUQJghNcbY8lUdtt+tNDDbH
	6DTfPm2i3BtHHy5Kl6k423kjxzMEEo/8LB43Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JRSwJfYtXwNalkkzpF+pC5ckqp9dzRJ0
	DJLJJ0D3m+pC2elI4WEqjUPMN8tRu5jQk2dgz3VL5ETeoztSGc7Cl/BG/MSq/Uaw
	HrffNhcU5NB00PuWyqQAqH0X5LI1B2za4D/WE7B0aVo3Nc3fPNjqaqnGdxSNNuDy
	6U/P2MJeuv4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9754339D02;
	Tue, 17 Feb 2015 18:36:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D6CA39D01;
	Tue, 17 Feb 2015 18:36:56 -0500 (EST)
In-Reply-To: <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com> (Dan Langille's
	message of "Tue, 17 Feb 2015 23:05:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DBF705AA-B6FD-11E4-9C7E-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264001>

"Dan Langille (dalangil)" <dalangil@cisco.com> writes:

>> On Jan 20, 2015, at 7:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> "Dan Langille (dalangil)" <dalangil@cisco.com> writes:
>> 
>>> I did not test this patch.  Is that holding up a commit?
>> 
>> I am hoping that you rebuilt the Git you use with this patch by the
>> time you wrote the message I am responding to and have been using it
>> for your daily Git needs ;-)
>> 
>> I believe it is queued on the 'next' branch so that others like you
>> who need the change can verify the improvements, and others unlike
>> you who do not need the change can make sure the change does not
>> cause unintended consequences.
>
> Is this the patch in question?
>
>  https://github.com/git/git/commit/4dbe66464b4fd695c5989cc272fa0edd6475037c
>
> I ask because previous versions of the patch acted against http.h as
> well and my failure with it.
>
> Could I expect that patch work against 2.3.0?
>
> It applies cleanly, compiles, but cores when I try a ‘git clone’.
> Unmatched 2.3.0 succeeds.

It already is in 'master', so please holler if things break with
that version.

Thanks.
