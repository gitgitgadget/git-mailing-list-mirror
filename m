From: Stefan Zager <szager@chromium.org>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Wed, 19 Mar 2014 12:15:41 -0700
Message-ID: <CAHOQ7J9sJv-L2xeKOiq1YvG5HhUP_XWCEdrtJogfZW6-NaDmWA@mail.gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
	<CACsJy8BOZa6vJU_s9sxYrtSdpL-4PDTpbo6r6TC8z2LD1GtkMQ@mail.gmail.com>
	<CAHOQ7J_Wmjo6AJRQra2UDWX3WRboD+-4SaGCHYOUgRR+NyUX4A@mail.gmail.com>
	<CACsJy8A7ESSjfHqr96_yYjNsE-A1Sf=8+rmRfGrjML0+fCWTTg@mail.gmail.com>
	<CAHOQ7J9c_ZfzYEmO861Oa64YZeArQQBMnah1yWAkChME7dA+TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:16:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLy2-00065s-AA
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbaCSTPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:15:44 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:39983 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbaCSTPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:15:42 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so8700209obb.32
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 12:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5AyZH3bGRlmLFHPR3UhAJX9TYVLbxb25vEElUpFpyDU=;
        b=EDhbCS41nVcDPi3B5j3fOU8pZlS0R/gbw1j7oJMfh7h+cR5gEA68J2iwQIxLrzFvE+
         xWTREnc03/awPdG+jBgKPxL7REmm4bMYjKu6BYM0zer4JN/bNftre5WeWxDwHPEHmofE
         qJaABAQV1Pq8L5bKeqGmCax9lwG1E5bdthbm0hrAQQ5bet/44srCqCF5VtXdmSHLHivI
         uhH6rrVKDDEc3PXmsP1AZqsWJsv6FJTw6CvQguO6hW+QKE2RQIJ+OjmT0S4GpiwOSnx7
         CaJB3UIQFUlS1ayrZU+XJ+d8rqHo77U4MtYdXEXbiCoUZ2jVrWcpFE4dbTPD1Vjg+FPm
         0s4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5AyZH3bGRlmLFHPR3UhAJX9TYVLbxb25vEElUpFpyDU=;
        b=POkWI7WYjMwpD6HkP3/rtEf7PrihQXs77po/WqHJkJWzrhMuZh4ttSu0Da3/njUjpq
         NVqx3tKaNzn7HscRNNJ55HIA2OfjRMxk40hdakTkcg/GBppVFLNpc/J1Yudfz/OXBo1d
         OJnk642CBEeZy4u+NYjuoSiigqrSqs3MXUghU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5AyZH3bGRlmLFHPR3UhAJX9TYVLbxb25vEElUpFpyDU=;
        b=XQlJe5+rsSWZ330yk/RSNCxLNBzjsecSAkD/hhxTsvsc1qTDRcFQvu+b0yuhweVKDS
         eNJDmbgErobrb8e7Xwy65LDvnUTJOPZwZchV2IFPKVxYZW64DQ4eXXoNsmBAp18J1dmb
         zX+0S2cAZcooUICc+STuLRqlaUpAklGGAwt+9cmc6wydhCd32BpFeq71c3GQItJt9fLF
         AdCQ/2xP0aHL3R1zuyCpDkgnhjvM1if2Ww0H4CKJYqrV7Vot1oEs1FzMqJoPMxOgpc2U
         pembGRzrdx+sl5ZoodKGEvZ6pwIFRgioPcUXa+IHEI8m5DUpQ5j4C7llQuEVmZj+3qDr
         yzZw==
X-Gm-Message-State: ALoCoQmZ3rMIXsfcH9w96DnbkvpdureAP25w4URuB6+Wptiwzt+eFGk0oBWyLf+sJjwh/rreiE7LAGjjqopsMLLXzCQe9ZloVH25KRS5AQo7dsqw/ekp1fHpY7FnegGbUIw0iiVs4l78ZntKFdxfxx7+l8b8GdSphwZkAMZb2Byyb4wDHZLG6woGW+sl46NZWEYET8QTUkwG
X-Received: by 10.182.149.168 with SMTP id ub8mr2039164obb.74.1395256541388;
 Wed, 19 Mar 2014 12:15:41 -0700 (PDT)
Received: by 10.182.233.201 with HTTP; Wed, 19 Mar 2014 12:15:41 -0700 (PDT)
In-Reply-To: <CAHOQ7J9c_ZfzYEmO861Oa64YZeArQQBMnah1yWAkChME7dA+TA@mail.gmail.com>
X-Google-Sender-Auth: JWQhKEBoCSO1HJmdbWUlsVrh2p0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244480>

On Wed, Mar 19, 2014 at 9:57 AM, Stefan Zager <szager@chromium.org> wrote:
>>
>> I still don't understand how compat/pread.c does not work with pack_fd
>> per thread. I don't have Windows to test, but I forced compat/pread.c
>> on on Linux with similar pack_fd changes and it worked fine, helgrind
>> only complained about progress.c.
>>
>> A pread() implementation that is thread-safe with condition sounds
>> like an invite for trouble later. And I don't think converting read()
>> to pread() is a good idea. Platforms that rely on pread() will hit
>> first because of more use of compat/pread.c. read() seeks while
>> pread() does not, so we have to audit more code..
>
> Using one fd per thread is all well and good for something like
> index-pack, which only accesses a single pack file.  But using that
> heuristic to add threading elsewhere is probably not going to work.
> For example, I have a patch in progress to add threading to checkout,
> and another one planned to add threading to status.  In both cases, we
> would need one fd per thread per pack file, which is pretty
> ridiculous.
>
> There really aren't very many calls to read() in the code.  I don't
> think it would be very difficult to eliminate the remaining ones.  The
> more interesting question, I think is: what platforms still don't have
> a thread-safe pread implementation?

I don't want to go too deep down the rabbit hole here.  We don't have
to solve the read() vs. pread() issue once for all right now; that can
wait for another day.  The pread() implementation in this patch is
certainly no worse than the one in compat/pread.c.

Stefan
