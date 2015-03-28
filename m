From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-p4: Fix copy detection test
Date: Sat, 28 Mar 2015 09:12:59 -0700
Message-ID: <xmqq619lyub8.fsf@gitster.dls.corp.google.com>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
	<1427418269-3263-3-git-send-email-vitor.hda@gmail.com>
	<xmqq619mw04r.fsf@gitster.dls.corp.google.com>
	<20150327235902.25ebf380@pt-vhugo> <20150328003636.07930f83@pt-vhugo>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Karsten Blees <karsten.blees@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 17:13:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbtMH-0002ic-55
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 17:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbbC1QNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 12:13:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752306AbbC1QNC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 12:13:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9369D41D4B;
	Sat, 28 Mar 2015 12:13:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gH5CEcX1SQbSUM9Ry1DW+5ICJmo=; b=dFikXD
	Cn/SsHNLdCbtHwNmKh0jer1Ek8+rWpHHhHZ9aH4z0NW7uJ9LL4HCec5oPExtaDPY
	t7stV/E+yGqwPoanVI51q2dMg37Kh9b5IX6/1c79cm8ehiJY2ES+JdkJVSXyDPw9
	TnP/HSVTB5RDDzsHjbgwspE/HYi8LGAoznocU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J8oWZwqC9m4wuiiRfSDI4cAlmndstlqM
	MnIQ/ScSnC29By89fcgsO/yPtTKArHaJ7hnOBi+4J75mIpC0a2XJkENeCR7KDBYa
	n+WckQPmYTjlYN+86ZY+HWVzNx5NDXynZYEHLy6jVHrE5wrYMbVZCaaQEKdXVl3d
	Qo8L+VtYD/w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C65F41D4A;
	Sat, 28 Mar 2015 12:13:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0243341D48;
	Sat, 28 Mar 2015 12:13:00 -0400 (EDT)
In-Reply-To: <20150328003636.07930f83@pt-vhugo> (Vitor Antunes's message of
	"Sat, 28 Mar 2015 00:36:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E507A20-D565-11E4-B541-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266419>

Vitor Antunes <vitor.hda@gmail.com> writes:

> Vitor Antunes <vitor.hda@gmail.com> wrote:
>
>>Junio C Hamano <gitster@pobox.com> wrote:
>>>Pete, these tests blame to your 9b6513ac (git p4 test: split up big
>>>t9800 test, 2012-06-27).  I presume that you tested the result of
>>>this splitting, but do you happen to know if we did something to
>>>cause the test to break recently?
>>
>>I also worked on these tests at that time and they were passing before and
>>after the reorganization. I'll prepare a bisect script and will try to find the
>>commit that started making this test fail.
>
> According to bisect, this is the first commit that makes the test fail:
>
> 7c85f8acb2282e3ed108c46b59fd5daa78bf17db
>
> Does this make sense to you?

Yeah, as the blamed commit changes the way the hashtable is used
record and choose the rename source candidates, it is not surprising
if it changes how two or more candidates with the same rename score
are tie-broken.

Thanks.
