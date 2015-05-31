From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] commit: fix ending newline for template files
Date: Sat, 30 May 2015 22:21:53 -0400
Message-ID: <CAPig+cTd9OjXkJY3=gQ5b8ZJqLEubhBEN_xm_i1g6CNUxNo1CQ@mail.gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
	<CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
	<xmqqpp5kh8a0.fsf@gitster.dls.corp.google.com>
	<CAPig+cR=Mrgb+-ZZcM6m7AcL25gXYtmEVpO3c23k_UKXPgyQnA@mail.gmail.com>
	<xmqqwpzrb0kb.fsf@gitster.dls.corp.google.com>
	<CAPig+cTrW9f1TGvpr4KH+EcOsy=FWvGRj6ZQM6nsFyXc15c4qg@mail.gmail.com>
	<CAJfL8+RtR+w+NQeFGJ7GPsPYgcn59XvWw8eXL12ph9EHwc14ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Patryk Obara <patryk.obara@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 04:35:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yyt5t-0002Vx-An
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 04:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbbEaCV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 22:21:56 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38332 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbbEaCVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 22:21:54 -0400
Received: by igbjd9 with SMTP id jd9so39583863igb.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 19:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KjTxR6FploF5VNXzOavi7e6i0/9CuApyXKMSDr8nAXw=;
        b=Yybz7OjVWlCn1xGcFH5cgsr3w1zf20VilsEBADkiXvGaEkf/ekCPrRzdkWhS+EtAog
         ilC9KOc+Z8emJEV1ZvCAxLLRc1CdCk5Zdwbcd71H4zf0ZQLSZM2FaprgxY0VN5xHLEcZ
         +WF3AdlcAqjrNwXrYy+oNH1cUnSz6OyM+1hVdDXzURB5ZJjkeA3ieuSyot/3NrjZ+mkn
         J5p+gSPuJMluquTb350iZExZgtbKUUZmqjLxLirEiFSlHF9Eb+wyjvRqV59kkbJgZSyV
         wjCr0oUqOG+NuEa+CeVCcaHmK9Q6uY9neeOJr9jBUHMTwYMhYOkuzWe27POYj5P0/Km0
         ZjEQ==
X-Received: by 10.107.151.75 with SMTP id z72mr18765888iod.46.1433038913913;
 Sat, 30 May 2015 19:21:53 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 30 May 2015 19:21:53 -0700 (PDT)
In-Reply-To: <CAJfL8+RtR+w+NQeFGJ7GPsPYgcn59XvWw8eXL12ph9EHwc14ww@mail.gmail.com>
X-Google-Sender-Auth: Y9Zz7nNuKIulKJ6ggu1lVRAknyI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270310>

On Sat, May 30, 2015 at 7:29 AM, Patryk Obara <patryk.obara@gmail.com> wrote:
> On Thu, May 28, 2015 at 4:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Did you consider the alternate approach of handling newline processing
>> immediately upon loading 'logfile' and 'template_file', rather than
>> delaying processing until this point? Doing it that way would involve
>> a bit of code repetition but might be easier to reason about since it
>> would occur before possible interactions in following code (such as
>> --signoff handling).
>
> Yes. I opted to place it in here, because newline was appended previously
> also in "if (use_editor)" block. But I agree, appending this newline after
> loading file will be cleaner - and code repetition may be avoided, if I'll
> separate file loading code into new function.

A need for this sort of functionality has come up before, so it might
be reasonable to introduce a new strbuf function for appending a
character if missing. In addition to the 'newline' case, appending '/'
to a pathname is also somewhat common.

> On Sat, May 30, 2015 at 12:25 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> If the user specified with the --cleanup option not to
>> clean-up the result coming back from the editor, then the commented
>> material needs to be removed in the editor by the user *anyway*.

You misattributed this statement. It was from Junio, not I.

> Why? Is it not ok to leave lines starting with hash in commit object?
> --cleanup=whitespace|verbatim suggests, that it's a valid usecase.
