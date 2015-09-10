From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 11:25:09 -0700
Message-ID: <xmqq4mj23zei.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
	<xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
	<vpqio7inrc5.fsf@scolette.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:25:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za6X8-0006BC-1F
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbbIJSZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:25:13 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32881 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbIJSZM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:25:12 -0400
Received: by pacex6 with SMTP id ex6so50054053pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ot1l1lq+mHH8Ow9b/3d7wDkgvy+/InmH3/BwNWBg9sw=;
        b=n8hdBymtA0MsGZX4GbQlwPzL3XfQ3ItOUivqB+UkfHi40Bstu2lG/E2OfdoArKungi
         rUnONG6lH2wG7yuNxpD2RBDNjT7N4+2sAqC1YEvPoVLTTjsKszii1hTNcXUs/3aWrf7M
         YOeYFpZ+i7bEv37GV4F8/il5clje0XwwJikib4V7yPI2zYRDltVv9MGIpmDcobDdoefU
         TMdc/gvh36SyrcsWxExtOSCa3DQmDkJu7H1ZWh9v7RCjWMGFy+56zTU5pAv98xOaxf2/
         WNpqbWA3W9u+mYcoPXbbkmcOJovloIfqIZL0LkMpDGKHknQYaSsC+Zjfz3dIpZ2C4GJr
         Ek4g==
X-Received: by 10.66.122.97 with SMTP id lr1mr76000185pab.76.1441909511471;
        Thu, 10 Sep 2015 11:25:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id dh1sm13309062pbd.49.2015.09.10.11.25.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 11:25:10 -0700 (PDT)
In-Reply-To: <vpqio7inrc5.fsf@scolette.imag.fr> (Matthieu Moy's message of
	"Thu, 10 Sep 2015 18:59:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277621>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> -		} else if (starts_with(name, "color:")) {
>>> +		} else if (match_atom_name(name, "color", &valp)) {
>>
>> Why use the helper only for this one?  Aren't existing calls to
>> starts_with() in the same if/else if/... cascade all potential bugs
>> that the new helper function is meant to help fixing?  For example,
>> the very fist one in the cascade:
>>
>> 	if (starts_with(name, "refname"))
>>         	refname = ref->refname;
>>
>> is correct *ONLY* when name is "refname" or "refname:" followed by
>> something, and it should skip "refnamex" when such a new atom is
>> added to valid_atom[] list, i.e. a bug waiting to happen.  I think
>> the new helper is designed to prevent such a bug from happening.
>
> I fully agree, but I also think that this should be a separate topic.

Yeah, it can be a separate topic.  I am neutral (i.e. I certainly
would not insist that the existing one should be fixed with the
helper in the series, but I cannot quite say that I prefer the fix
to be made outside this topic, either).

Thanks.
