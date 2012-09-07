X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] advice: extract function to print messages with
 prefix
Date: Fri, 07 Sep 2012 14:16:55 -0700
Message-ID: <7vbohhwn20.fsf@alter.siamese.dyndns.org>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
 <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
 <1347044705-17268-2-git-send-email-ralf.thielow@gmail.com>
 <7v1uidy6ga.fsf@alter.siamese.dyndns.org>
 <CAN0XMOK5QnNn8471RF4y7u_X0rfda=-J-KrCtyMsgCGHXNrwVw@mail.gmail.com>
 <7vfw6two6o.fsf@alter.siamese.dyndns.org>
 <CAN0XMO+jbZeO=2NHisPizHfNwR62ebkC06KVZ8xOhgmRoAT4nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 7 Sep 2012 21:17:14 +0000 (UTC)
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jiywfeLkqOpouhNkip6g6KT3Meg=; b=gu46hB
	FrfLwdv7GaAO6VRGx+1k1tTr1hnJ5AMBld6tTX9eDI1mqOXab8ALwZLmSU4l0v4S
	F15Bt0iQkDUKM/wmlIThuEZxch8OvNsaszge4e6qH3JciI6eJrQWQoxtMGTV7wV8
	fhPXobysg+Qt9D+8FlSlaQJYJFZzhp8C2t3S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MLSkhl8EYHuNwtFRiySSygalXTX1zjXt
	c7X4UNBiOw9iW2CppxZtG1rBOTC4yn4FRd1+RbPiU89jtx68XM47vJQpJpRVVgyf
	D5wt+i3lJh0hwGmfuifvkT97Q55WymWssKAdXipryOmjy48oeGDo6BLTMJRs585e
	b+f8E/ekrjg=
In-Reply-To: <CAN0XMO+jbZeO=2NHisPizHfNwR62ebkC06KVZ8xOhgmRoAT4nw@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 7 Sep 2012 23:09:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AE9ACC4-F931-11E1-A151-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1TA5vG-0000T5-Ct for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 23:17:06
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757638Ab2IGVQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012
 17:16:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44427 "EHLO
 smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1757177Ab2IGVQ6 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012
 17:16:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAFC484EF; Fri,  7 Sep 2012
 17:16:57 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id C62AB84EE; Fri,  7 Sep 2012
 17:16:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29ECA84ED; Fri,  7 Sep 2012
 17:16:57 -0400 (EDT)
Sender: git-owner@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> On Fri, Sep 7, 2012 at 10:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>
>>> On Fri, Sep 7, 2012 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>>> -             fprintf(stderr, _("hint: %.*s\n"), (int)(np - cp), cp);
>>>>> +             fprintf(stderr,  "%s %.*s\n", prefix, (int)(np - cp), cp);
>>>>
>>>> Hrm, naively, printf("%s: %.*s\n", _("hint"), ...) might look more
>>>> natural, but I vaguely recall that the current code places _()
>>>> around the entire "hint: %.*s\n" on purpose.  IIRC, it was to allow
>>>> translations that flow from RTL e.g. ".siht od t'nod :tnih".
>>>>
>>>> Doesn't this patch break it?
>>>
>>> Sorry but I don't know what you mean with "translations that flow
>>> from RTL e.g. ".siht od t'nod :tnih"." so I can't check this.
>>> As far as I can see the callers only put a simple message in it,
>>> e.g. advise(_("Commit your changes or stash them to proceed."));
>>> So I don't think that this patch would break anything.
>>
>> Your patch would not allow target languages that want to put the
>> _("hint") at the *tail* end of each line of the message.  With the
>> original, with something like this:
>>
>>         msgid "hint: %.*s\n"
>>         msgstr "%.*s :tnih\n"
>>
>> you could do that if you wanted to.
>
> Is there a need actually?
> It's easy to add a "_(...)" around this string, but then we'll have a
> msgid in "git.pot" without ever having a sensible translation. Not?

As I said "vaguely recall", even though I don't have a first-hand
experience in such a language, I know I was talked into doing it
this way when we did 23cb5bf (i18n of multi-line advice messages,
