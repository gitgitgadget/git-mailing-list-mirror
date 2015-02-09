From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 09 Feb 2015 13:17:05 -0800
Message-ID: <xmqqtwyuaipa.fsf@gitster.dls.corp.google.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
	<xmqq386eby6w.fsf@gitster.dls.corp.google.com>
	<20150209211021.GB4166@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mingo@kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:17:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvhi-0004He-EO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761293AbbBIVRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:17:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761277AbbBIVRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:17:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E355835A24;
	Mon,  9 Feb 2015 16:17:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=192P/kGngtaa4XPE0xKHm68+a7E=; b=i0d7mP
	ow6dHoVgitfNBDlp6o89LvZXy/YTiYxCgwO8NZM/l+VpIyrnsJSDtKpwxEWcBk7i
	9mKy8240BtekdanJXW9iwpATrR8hyWsj5cJjDO9bSlxeMYjRzfhs40LnWKgE9mim
	Hkatfytf10C0wQ3Wmie2gHeoXi9W9XFbVGyz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xf2opzhVvl2xWAOMgJLAK5TIM1ZseFre
	i3zK2BuBPSXI+YrL3vwCMtGIjt7rvFT9S2bOXXjW40s/1KLeSzoeVlhEvHkPyyOj
	aNo/tgX1Z4s5tbs4AQ9rOejtNnUZfZ8Xbx/QiMGoa+/yjDkrsfX3N3a1cWLwWss0
	6OvoVWOSXD4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D27DD35A23;
	Mon,  9 Feb 2015 16:17:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4937735A1C;
	Mon,  9 Feb 2015 16:17:07 -0500 (EST)
In-Reply-To: <20150209211021.GB4166@linux.vnet.ibm.com> (Paul E. McKenney's
	message of "Mon, 9 Feb 2015 13:10:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0087BDF0-B0A1-11E4-A843-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263602>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

> On Mon, Feb 09, 2015 at 12:57:11PM -0800, Junio C Hamano wrote:
>> No, I do not think we have a way to blacklist certain recipient
>> addresses from getting passed to the MTA, and I do not object to
>> addition of such a mechanism if there is a valid need to do so.
>> 
>> It feels a bit too convoluted to say "Cc: to this address" in the
>> log message and then "nonono, I do not want to send there", though.
>> Why do you want to have Cc: in the log message if you do not want to
>> send e-mail to that address in the first place?  Allowing the
>> behaviour you are asking for would mean that those who see that the
>> commit appeared on a branch would not be able to assume that the
>> patch has already been sent to the stable review address, no?
>
> I could see where it might seem a bit strange.  ;-)
>
> The reason behind this is that you are not supposed to actually send
> email to the stable lists until after the patch has been accepted into
> mainline.  One way to make this work is of course to leave the stable
> Cc tags out of the commit log, and to manually send an email when the
> commit has been accepted.  However, this is subject to human error,
> and more specifically in this case, -my- human error.
>
> Hence the desire to have a Cc that doesn't actually send any email,
> but that is visible in mainline for the benefit of the scripts that
> handle the stable workflow.

So a configuration variable that you can set once and forget, e.g.

    [sendemail]
	blacklistedRecipients = stable@vger.kernel.org

would not cut it, as you would _later_ want to send the e-mail once
the commit hits the mainline.  Am I reading you correctly?

Or is it that nobody actually sends to stable@vger.kernel.org address
manually, but some automated process scans new commits that hit the
mainline and the string "Cc: stable@vger.kernel.org" is used as a cue
for that process to pick them up?
