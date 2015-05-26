From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 08/11] transport: connect_setup appends protocol
 version number
Date: Tue, 26 May 2015 15:31:12 -0700
Message-ID: <CAGZ79kY=hZ=6pUbpVHUW8rU3AEMx2TwkBYDsDsZ+bPH_QnsYzA@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-9-git-send-email-sbeller@google.com>
	<xmqq1ti3j7ym.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 00:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxNNW-00076W-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbbEZWbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:31:14 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36705 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbbEZWbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:31:13 -0400
Received: by qgf2 with SMTP id 2so38247735qgf.3
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tall20jAZCDSBIR71w+jj1VmGoZ0mSegeaB2HVqzVRE=;
        b=pnUsHybEZHJu6WGgi2Mxx1wzKvfmTUPycAzwTrUv7WEYEXojAXF+VFvmbl6NDXQUZ1
         odg9iQOeTYS7Re6OyI6xF2lGLqrjEK9VUBLT+417vCuVjgEom/FaDLIVjQPYTHDyJMZX
         dQQwG9ASMjMiF5+lYdtj6tDYrl/WIrYn9RxR6nW3RV8GaoZpM+7lWZccrMC6tYkTxjlh
         DApuLcRqe33p3ydgT/86sYOToeEMJ23kll7f/8YNRIqZ++8JeXkuVsOihE2+cq9L+yn3
         xJTIy2GXwrzcCLuZk7SFaaGHvFzPhdV8jMTCR4pawZSFcd28wMQcvQNeqJtuOnpbyacL
         3e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Tall20jAZCDSBIR71w+jj1VmGoZ0mSegeaB2HVqzVRE=;
        b=Hx0U02sZ3QMTX3o5fcmDZABGGXArwwV3o9qociEZgALawfKYfx2L0asDRsJ/rLWURL
         FVqdugiC0ilCIShEFH0X+VRTn750PeOeUTLMzqaUWJYrve0W8/TNcMQGrlOl83f7XH8W
         H+ZP615q0OMssChy2uT00j8z+ZJlq3lGcbJC5mhTEK6C1Nu+GJ9esu4y0hMYuAW7RCjg
         /iweAhhmaILGqtSAIBv6vTdksRXEuBDvcsUdz49zy9vtdxEJsgMwQyDrLLYnu/Y4KPM5
         gT168svhBIZqnVtvnWgl3cBVUp+GdCkxJqSGvzIcBiJGkrbnxsTJ1MwWnB+Md9IkhlcJ
         jSGQ==
X-Gm-Message-State: ALoCoQlyyaOOxMiEsejYgcVviF4HOVRlsBtxH5zqtLeNmP1oIoN6LbFJDtKNXWaJbWSImIH1esSJ
X-Received: by 10.55.19.197 with SMTP id 66mr61128922qkt.24.1432679472900;
 Tue, 26 May 2015 15:31:12 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 26 May 2015 15:31:12 -0700 (PDT)
In-Reply-To: <xmqq1ti3j7ym.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270004>

On Tue, May 26, 2015 at 3:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +     if (transport->smart_options
>> +         && transport->smart_options->transport_version) {
>> +             buf = xmalloc(strlen(remote_program) + 12);
>> +             sprintf(buf, "%s-%d", remote_program,
>> +                     transport->smart_options->transport_version);
>> +             remote_program = buf;
>> +     }
>
> Bikeshedding: so the versioning scheme is that the current one is
> zero, and the next one is two?  I would have expected that there
> would be something like

I think currently we have version 1. But we don't advertise it, so
I'll call it 0
(the default or unadvertised or however you name it. 0 as in "unsure" maybe)

I thought about future proofing this version a bit. Say version 2 is bad because
I don't have the experience of 10 years Git nor of maintaining large
projects and
you want to make a version 3 soon. And this would support that just fine.

The meaning being: Any version except 0 should have a dedicated
extension -${version}
The 0 is left out for backwards compatibility.

So in a later patch where we want to introduce force-using of old
versions  you could
configure upload-pack to be explicit upload-pack-1. The upload-pack-1
version is not
yet there with this series though.

>
>         if (...->version < 2) {
>                 ... append "-%d" ...
>         }
>
> involved.

Oh! I see here you would count the current one as 1, which has no
number extension,
and any further would have a -${version}. That would transport the
intention much better
I guess.
