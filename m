From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Wed, 23 Apr 2014 09:52:09 -0700
Message-ID: <xmqqppk80z0m.fsf@gitster.dls.corp.google.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
	<1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
	<20140422045951.GA60610@gmail.com>
	<xmqqbnvt703s.fsf@gitster.dls.corp.google.com>
	<CAJDDKr5P7crudFiAa7Lu4CYmDWgZ-drdkiOfusFHioTF9co2Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 18:53:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd0QQ-0003BD-0I
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 18:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbaDWQx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 12:53:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbaDWQx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 12:53:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89EC47DFD8;
	Wed, 23 Apr 2014 12:53:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fq3Gs9TMxuo+YYR0PwOC55/Cyss=; b=a6a403
	IJoE/m1uzoeEn0DoYSFwS0lbTRuysA2eelxVQ4v4C54X6oejt9pQDXRcmP5cfyLp
	6cfH7SBu2RKnammaC5ebbe1DczGGxpk4Ldo1//R+eP9hQsXxDvtG2HhnBJyy1WFQ
	XKn6PDD4YlRusMZziAB6IlF8e3lfEmSZfcImk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LEJ1MqLkTzdD9DMDljSztLFvRdv+pv54
	RJmJkUWQIwYUSOcQqa0K9SNM5Ps+WXHjm4RpwaSjZO1GycTyaOfSH8BXujsQX5e+
	2Pa6GF+GrjPX3RWnruN3NQW0TVDPO9zEIah6sdM46RH/mEY2kkOHym2jujkVudWk
	xFe+U4wMZHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E2537DFD7;
	Wed, 23 Apr 2014 12:53:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3165E7DF60;
	Wed, 23 Apr 2014 12:52:11 -0400 (EDT)
In-Reply-To: <CAJDDKr5P7crudFiAa7Lu4CYmDWgZ-drdkiOfusFHioTF9co2Nw@mail.gmail.com>
	(David Aguilar's message of "Wed, 23 Apr 2014 00:58:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D1D6DFC-CB07-11E3-AA91-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246850>

David Aguilar <davvid@gmail.com> writes:

> On Tue, Apr 22, 2014 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Thanks for CC'ing Charles, by the way.  I think his point about
>> mentioning the change of default somewhere in the documentation
>> has some merits, and it can be done in a follow-up patch on top.
>
> Another thing that crossed my mind is that we have -y for --no-prompt
> because --prompt was the original default. Maybe a -i (?) shortcut for
> the interactive --prompt can be added to make the "need to skip some
> when resolving" use case easier to activate.

Hmm, perhaps, but is "do we prompt to give a chance to the user to
say 'no, I am not interested in running the tool to that path'" the
only interactivity in the overall end-user experience in using the
mergetool?  To end-users, both interaction with the mergetool
front-end and interaction with individual back-end taken together
would comprise the whole end-user experience, so "--interactive"
option that is implied by "-i" short-cut may make them expect a
behaviour from the backend that is more interactive than without,
which would not be the case, so....
