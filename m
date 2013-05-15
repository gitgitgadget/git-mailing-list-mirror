From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] make color.ui default to 'auto'
Date: Wed, 15 May 2013 10:30:13 -0700
Message-ID: <7vd2sscfru.fsf@alter.siamese.dyndns.org>
References: <CALKQrgdVf_rfsLu1NnXGk+LCTV34T-4doJ+2yyi69ZER8vTAfg@mail.gmail.com>
	<1368624095-15738-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxm4cjil.fsf@alter.siamese.dyndns.org>
	<vpq61ykfang.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 15 19:30:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcfWx-0000AQ-0u
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759768Ab3EORaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:30:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759672Ab3EORaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:30:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64FE91F10F;
	Wed, 15 May 2013 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Myr7STafWW+fs7Q5whq58qZ9WO4=; b=r4s3tN
	PDht8gRsV42hvmqzq/p4GDeFf0bBWuaYqq8k8F4mD4H9DbtNo+wYinLbWMfu/21/
	eCWA3mr0FgXSfychbHnGiR2JlXs7zyfelLOQtvVf9ZMSXV3fwufMdiWETNvyR5Bv
	Vb8m96nh3IIKfJnV+0OsetFbc3cqBvVULhBuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NO61lY7q0DQQRjKJhXkywp9oOdQteuxj
	fb/TeYNyu/QimFTqKOUjFzecYIzSCuEWX4G+HibMyGLE5TnKJJ5kj6+SpWopqLjr
	+veHT3Uc15+vfB9+mhPHGwZp12PQP74pqFF3mIyCNkYE9u0w7Rqb3E/r85a93x3m
	wXpAVOprWBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A8DB1F10E;
	Wed, 15 May 2013 17:30:15 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF1631F10C;
	Wed, 15 May 2013 17:30:14 +0000 (UTC)
In-Reply-To: <vpq61ykfang.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 15 May 2013 18:52:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A7D7EC2-BD85-11E2-997C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224428>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> diff --git a/builtin/config.c b/builtin/config.c
>>> index 000d27c..ecfceca 100644
>>> --- a/builtin/config.c
>>> +++ b/builtin/config.c
>>> @@ -316,7 +316,7 @@ static void get_color(const char *def_color)
>>>  
>>>  static int get_colorbool_found;
>>>  static int get_diff_color_found;
>>> -static int get_color_ui_found;
>>> +static int get_color_ui_found = GIT_COLOR_AUTO;
>>
>> It is curious to notice that we have these three and only one is
>> initialized to the new default value, while the other two get -1
>> at the beginning of get_colorbool().
>
> Right. The meaning of the _found suffix is clear for the first two, but
> not the last.
>
>> I wonder if it would be cleaner to statically initialize all three
>> to -1 here, drop the assignment of -1 to two of them from the
>> beginning of get_colorbool(), and then have a final fallback inside
>> the want_color() call itself, i.e.
>
> I've left the assignments within the function (I like the initialisation
> right before usage, I don't have to worry about how many times the
> function is called then), but I've added a patch that initializes
> get_color_ui_found to -1 like the others, and does essentially this:
>
>> 	get_colorbool_found = want_color(get_colorbool_found < 0
>>         				? GIT_COLOR_AUTO
>>                                         : get_colorbool_found);
>
> Except I've made it a separate if statement. Then PATCH 2/2 is really
> crystal clear.

Yeah, sounds good.

> Reroll comming, with an improved commit message that should adress the
> points in the other message.

Hmm, I don't see much improvement in the message, though.  It seems
to talk about "may not discover", "live with", "a few people", and
"they can easily", none of which should be there.
