From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] remotes-hg: bugfix for fetching non local remotes
Date: Thu, 25 Jul 2013 18:30:29 -0700
Message-ID: <7vd2q63y6i.fsf@alter.siamese.dyndns.org>
References: <1374712977-3215-1-git-send-email-dev@joernhees.de>
	<CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com>
	<CALWbr2wN6k8JBCwLFC=TjTC_sg7Uh8AEsMOBKfH9aBxDEcV4oQ@mail.gmail.com>
	<CAMP44s2v+CF7x+S6_47CiPb6RMXu+iy06gqWNjus4vff5J8z3g@mail.gmail.com>
	<CALWbr2x9fG=diZPN-Wkq+-7bstoVmN_pnXN0EPi=4MZQVRuYXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Joern Hees <dev@joernhees.de>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 03:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Wrh-00043j-9x
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 03:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095Ab3GZBaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 21:30:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757898Ab3GZBac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 21:30:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA2B27CB1;
	Fri, 26 Jul 2013 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rIK/r2Y4xwtVbU86CfWaM3oCeIQ=; b=aAzYmY
	YY+E6ztW47zglyCXCdgYUIzOy7Xhpk76a7YLlKspfpL9G9tCaOmT0UurJl+RGMAI
	Pdj6YjWtcTS+Nkc5kFRtpq3E3R5m/X5rXBpkKk7L0B9vIcU6tpqMwARskajFRNpJ
	fhluB+/7GFOar4DxjyoyyIuUN9szu5BITOWz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQAlObLu5u1/aVG2/nU8aDrO9w/Nl6Vu
	QKDu/fy+xWjvL8AtPDdfhI5t4TaDg3PvVTHS/l7opqLY30vi0+G77bcYcoFGfke6
	JQ9s7ipmHsvrnnSNLIGUOWo/tPB4eR61VOKMTC9GAWdOHlqD1Uu5TdDQg0e/OcYM
	N2MzmfQBIRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96CFE27CB0;
	Fri, 26 Jul 2013 01:30:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC5E127CAE;
	Fri, 26 Jul 2013 01:30:30 +0000 (UTC)
In-Reply-To: <CALWbr2x9fG=diZPN-Wkq+-7bstoVmN_pnXN0EPi=4MZQVRuYXg@mail.gmail.com>
	(Antoine Pelisse's message of "Thu, 25 Jul 2013 23:10:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5A47394-F592-11E2-8365-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231157>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Thu, Jul 25, 2013 at 10:40 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> That's true. Maybe something like:
>>
>> for x in repos:
>>   local_hg = os.path.join(shared_path, x, 'clone', '.hg')
>>   if os.path.exists(local_hg):
>>     shutil.copytree(local_hg, hg_path)
>>     break
>
> I think that would work, but I think the patch from Joern Hees would
> have to be reverted first (as it's merged in next)

The expectation is that not all things in 'next' today will be in
1.8.4 anyway, so it is perfectly OK to revert it as needed.

Thanks.
