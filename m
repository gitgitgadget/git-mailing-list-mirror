From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status merge: guarentee space between msg and path
Date: Wed, 12 Mar 2014 12:28:07 -0700
Message-ID: <xmqqmwgvkyig.fsf@gitster.dls.corp.google.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<1394580211-13383-1-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Sandy Carter <sandy.carter@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:28:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNop7-0007Jv-Am
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbaCLT2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 15:28:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbaCLT2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2014 15:28:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F072E71896;
	Wed, 12 Mar 2014 15:28:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KaTXucXKQV/O
	fd6dIAOifBoX5+Q=; b=QwpYzZxKIkW4HEKCV6T7DebbBjyNvVaPEULoOBNLpozw
	/xXzYXM/uE5QmwMy80BUgyqpqGpGjUJRHkPSnnPL0l91EfAPL1I6bZm2gM/xNl5Z
	PwZIbud4plmO3iLBnYSZXJmeMy+XIk5mZMnRyqopSSUWJ2Y67GOMWrdBs/SIybE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m+//9h
	TtuU9C/oAFydGglpQzp8jkFwcB6O3SiqLc7HzHZVQQ0noBT7D0lcL7aNHUfcLPYp
	oJmVC4N06+pbt5J5IqJgBf3idaRXbk+W7WeQXmXm4IKYu+FrHygFACCx1yfwS2kE
	OakyHr3NK+IaOTwwJHoMMZ7yUcZd/daHhmDG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D9B71895;
	Wed, 12 Mar 2014 15:28:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EE4571891;
	Wed, 12 Mar 2014 15:28:11 -0400 (EDT)
In-Reply-To: <1394580211-13383-1-git-send-email-sandy.carter@savoirfairelinux.com>
	(Sandy Carter's message of "Tue, 11 Mar 2014 19:23:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 72BC85EA-AA1C-11E3-8309-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243969>

Sandy Carter <sandy.carter@savoirfairelinux.com> writes:

> Add space between how and one when printing status of unmerged data.
> This fixes an appending of the how message when it is longer than 20,
> such  is the case in some translations such as the french one where t=
he
> colon gets appended to the file:
>     supprim=C3=A9 par nous :wt-status.c
>     modifi=C3=A9 des deux c=C3=B4t=C3=A9s :wt-status.h
> Additionally, having a space makes the file in question easier to sel=
ect
> in console to quickly address the problem. Without the space, the col=
on
> (and, sometimes the last word) of the message is selected along with =
the
> file.
>
> The previous french example should now print as, which is more proper=
:
>     supprim=C3=A9 par nous :      wt-status.c
>     modifi=C3=A9 des deux c=C3=B4t=C3=A9s : wt-status.h
>
> try 2:
> Add function so wt_status_print_unmerged_data() and
> wt_status_print_change_data() make use of the same padding technique
> defined as wt_status_status_padding_string()
>
> This has the additionnal advantage of aligning unmerged paths with pa=
ths
> of regular statuses.
>
> Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
> ---
>  t/t7060-wtstatus.sh         |  16 +++----
>  t/t7506-status-submodule.sh |  18 ++++----
>  t/t7508-status.sh           |  94 +++++++++++++++++++---------------=
-----
>  t/t7512-status-help.sh      |  30 ++++++-------

This is too noisy a patch to be reviewed.  I tried to resurrect
Jonathan's fix from Dec 2013 and posted it elsewhere---does it work
for you?
