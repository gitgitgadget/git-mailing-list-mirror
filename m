From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/10] Stop starting pager recursively
Date: Tue, 28 Feb 2012 20:51:29 -0800
Message-ID: <7vaa42w8by.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-3-git-send-email-pclouds@gmail.com>
 <7v4nua25cz.fsf@alter.siamese.dyndns.org>
 <7vipiqzsd8.fsf@alter.siamese.dyndns.org>
 <CACsJy8DJM5hwWnTs2rkhCa7a=vKRRsLMjZGBotmDDpAaGG+Sxw@mail.gmail.com>
 <7vr4xewbrz.fsf@alter.siamese.dyndns.org>
 <CACsJy8BfBP9m8rdEY3mk6g4G7n5LyFPvvNgNK2bkwC6L7qTDCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 05:51:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2bVp-0006rE-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 05:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966006Ab2B2Evc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 23:51:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965942Ab2B2Evc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 23:51:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 676D375D5;
	Tue, 28 Feb 2012 23:51:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JUosxsnOXzNXPJ4eJJeEFDUbuMc=; b=qmaXzU
	v/blHCSt9s4LwALR+JP29d2AnT3jxzeaWcoFMmEYJmsVVvwTiti/s4pwecbutB/B
	KpyXv0h0vH+GOwXZ+eqnY00ZImZkHRtthW7GZ5ystKgaR81GC1xhm5ue8c27eFle
	lMus+ZwVzpKXT/u5z1GofqMrxWOF2V2XhCVkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w3HCuKpcxjMLtr0A22M7aMfDWOaVzaz+
	Q9lHTTZTGBewlKv2bGKlJ5FBQ6SHe/iq7pwrNZKSmW0ckFpM8WiE3t4aLcEprTcu
	8siikYLhYlCaNrXV+hT96t6KgtyaGe/bLieNgVB5FGeb85+hDh941PK06qai0UnZ
	xvSE7z+bNUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E9B675D4;
	Tue, 28 Feb 2012 23:51:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E593075D3; Tue, 28 Feb 2012
 23:51:30 -0500 (EST)
In-Reply-To: <CACsJy8BfBP9m8rdEY3mk6g4G7n5LyFPvvNgNK2bkwC6L7qTDCg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 29 Feb 2012 10:40:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C08F39E-6291-11E1-8D5D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191810>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Feb 29, 2012 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> It does improve that situation, or at least it stops git from forking
>>> frantically.
>>
>> That "at least" sounds suspicious ;-) Do you mean that there is other
>> breakages in that mode of operation?
>
> Well, "shortlog -p" did not run $PAGER (i.e. less). I haven't had time
> to dig further.

Ok. for that matter,

    $ GIT_PAGER="git -p column" git tag --list

does not seem to use pager, either, so that may not be limited to
shortlog, but in any case, I can see how the current code without your
patch can fall into a fork loop, and your patch is an improvement, even if
it may not yet be the whole solution.
