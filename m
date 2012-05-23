From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 07:54:41 -0700
Message-ID: <7v4nr72bim.fsf@alter.siamese.dyndns.org>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <4FBC0019.6030702@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed May 23 16:55:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXCxh-0006wd-4L
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274Ab2EWOyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 10:54:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759620Ab2EWOyq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 10:54:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88A6A86F4;
	Wed, 23 May 2012 10:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UaTLRvfY34On
	JLeZt3jShJLY9I8=; b=Anp3q6ooAgZHmvNq4hCJG910Dxr3HrNeRPerRJuhgy7Z
	WWt74I6wDUgtyoK50c43Vs5V/qxCpuvwQLQoylQtsswWg8P2Agq4dOwTmARRYdrd
	yryNFuJWzRZZuuEh8dDeCC0Rz+fOLZN1SXQMGvr9B8YrFQxVnR8z6Gb1VLJG7Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xnVA7P
	xFGqOo/VzD0iOdbfniyZE9joE1zUROxrAucqPpaXQegp9tDnUKOZzC/F/8OLmnJM
	qvy2UKbK5d/cnR3lpgNzmTAHwssnuOgPE+hfLLzupiOwdKjiZd2lqBowm4FsgVuH
	U0t9sDxg1CT3ftCIbG2bmONREBPTXcBLnUCGo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CDB686F2;
	Wed, 23 May 2012 10:54:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A7B086F0; Wed, 23 May 2012
 10:54:42 -0400 (EDT)
In-Reply-To: <4FBC0019.6030702@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Tue, 22 May 2012 23:07:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AEBE8FE-A4E7-11E1-AD03-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198293>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> On 05/22/2012 10:46 PM, Felipe Contreras wrote:
>>  contrib/completion/git-completion.bash |  257 +--------------------=
-------
>>  contrib/completion/git-prompt.sh       |  287 +++++++++++++++++++++=
+++++++++++
>>  t/t9903-bash-prompt.sh                 |    2 +-
>>  3 files changed, 290 insertions(+), 256 deletions(-)
>>  create mode 100644 contrib/completion/git-prompt.sh
> Hi,
> since git-prompt is not completion related anymore, should a differen=
t
> directory be used?

I am not sure if that is worth it.  These two share/duplicate some shel=
l
functions and we may end up refactoring them (a way to do so may be to
dot-source git-prompt from git-completion and drop duplicated definitio=
ns
from the latter), for example.
