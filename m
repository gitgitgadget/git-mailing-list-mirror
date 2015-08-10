From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file.c: rename move_temp_to_file() to finalize_temp_file()
Date: Mon, 10 Aug 2015 10:32:56 -0700
Message-ID: <xmqqmvxzujzr.fsf@gitster.dls.corp.google.com>
References: <xmqqh9oawrsy.fsf@gitster.dls.corp.google.com>
	<20150808091222.GA24707@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:33:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOqwZ-0000vV-80
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbbHJRc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:32:59 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33970 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbbHJRc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:32:58 -0400
Received: by pdbfa8 with SMTP id fa8so33575384pdb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2KeRDqvO0c0xIcWqYwKxtc2URRyUihqNMcItMK61Coc=;
        b=ug0Bv3jMdu69lSESiSfeP9yDYuWoVo8sK0W5Md+iOT0QkaSZQIpdYGFJlk5J72rX64
         wjDnVOIwtUBLmlDUw3jD+2HaxU9mwMpqBd+NGqcfekcuqss+Y0qPbrZXDFm+XBEpvEKa
         DsEh73SwV9GVRvbsbiFAX8Llrk9K1bK2jaO79as4xthlBqWy7ZaJonrAsKLXeccNo2FD
         Q+cN10OAKszZUfIEu/iiw1y+kwy95eAfDx7bOWxs1pgjVjtkQxpvapQH3mfZ8XyBtgU1
         02wO3uB5qd1bjiOgSAnytu863gR6hXcj0ZolraZEKyjUfd4er8QfZ4Bepj6a3k8ilIsI
         MeLQ==
X-Received: by 10.70.126.193 with SMTP id na1mr47183220pdb.26.1439227977843;
        Mon, 10 Aug 2015 10:32:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id w11sm8847465pbs.55.2015.08.10.10.32.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 10:32:57 -0700 (PDT)
In-Reply-To: <20150808091222.GA24707@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 8 Aug 2015 05:12:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275639>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 07, 2015 at 05:24:29PM -0700, Junio C Hamano wrote:
>
>> Since 5a688fe4 ("core.sharedrepository = 0mode" should set, not
>> loosen, 2009-03-25), we kept reminding ourselves:
>> 
>>     NEEDSWORK: this should be renamed to finalize_temp_file() as
>>     "moving" is only a part of what it does, when no patch between
>>     master to pu changes the call sites of this function.
>> 
>> without doing anything about it.  Let's do so.
>> 
>> The purpose of this function was not to move but to finalize.  The
>> detail of the primarily implementation of finalizing was to link the
>> temporary file to its final name and then to unlink, which wasn't
>> even "moving".  The alternative implementation did "move" by calling
>> rename(2), which is a fun tangent.
>
> This is definitely a better name. But while we are touching the area, my
> other pet peeve about this function is that it is really specific to
> moving _object_ temp files around. It started life as static-local to
> sha1-file.c, so not mentioning objects is OK, but when it became a
> global, it's a bit confusing.
>
> Maybe finalize_object_file() would be a better name?
>
> -Peff

OK, will fix.
