From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] entry.c: convert write_entry to use strbuf
Date: Thu, 24 Oct 2013 12:49:30 -0700
Message-ID: <xmqq8uxio3ed.fsf@gitster.dls.corp.google.com>
References: <20131021193223.GC29681@sigill.intra.peff.net>
	<1382532907-30561-1-git-send-email-pclouds@gmail.com>
	<1382532907-30561-2-git-send-email-pclouds@gmail.com>
	<xmqqeh7bri1h.fsf@gitster.dls.corp.google.com>
	<CACsJy8Ap005pUBZH0k=7F9nON9Vb5SoO-1McPAwRkLCC0YoPMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Git Mailing List <git@vger.kernel.org>,  Erik Faye-Lund
 <kusmabite@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Antoine Pelisse
 <apelisse@gmail.com>,  Torsten =?utf-8?Q?B=C3=83=C2=B6gershausen?=
 <tboegi@web.de>,  Wataru Noguchi <wnoguchi.0727@gmail.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  =?utf-8?B?UmVuw4PCqQ==?= Scharfe
 <l.s.r@web.de>,  msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBTHTUWJQKGQEVQX32TY@googlegroups.com Thu Oct 24 21:49:36 2013
Return-path: <msysgit+bncBCG77UMM3EJRBTHTUWJQKGQEVQX32TY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f184.google.com ([209.85.192.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBTHTUWJQKGQEVQX32TY@googlegroups.com>)
	id 1VZQuV-0008Ve-UN
	for gcvm-msysgit@m.gmane.org; Thu, 24 Oct 2013 21:49:36 +0200
Received: by mail-pd0-f184.google.com with SMTP id g10sf572963pdj.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 24 Oct 2013 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=8f3/4TACOOdc8DUof042Vzt1k/wqJmpWPpCItJ35WHY=;
        b=LkHIHrVuiYTk9D93VZS9ClsCf1fPjP7qB4b0BzddaWAwL5LkvoEpUvGdXBKbCCZfcE
         uAN/EFx0R3E0/WY6M7SgieBhH0wc0QL6/ZibJrWZ9INMfSlI17CVel1mYh2U8kgMRwup
         a1GtEdagNp3G2sJGho4qXP3pusf3i6O+tHtKU/JSDftUGsOT7gbm7jKJ7NFXiIDa22sB
         apcvzBmkhEQKlAC44crWuT8ikpGmFnQvzyfOAVjkMMr+AcY23jp+CCk4+gb6Bx2Ttfx/
         H8aBZGipxr6Dim0wJaksT060jFxF2lQgjH6HJqVL8ZZMYKTloDaTjQZ+CpUkeaI3NgOX
         fSZQ==
X-Received: by 10.182.44.163 with SMTP id f3mr44880obm.34.1382644174813;
        Thu, 24 Oct 2013 12:49:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.128.103 with SMTP id nn7ls606477obb.63.gmail; Thu, 24 Oct
 2013 12:49:32 -0700 (PDT)
X-Received: by 10.182.66.193 with SMTP id h1mr1200779obt.47.1382644172711;
        Thu, 24 Oct 2013 12:49:32 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id f7si315611vdi.3.2013.10.24.12.49.32
        for <msysgit@googlegroups.com>;
        Thu, 24 Oct 2013 12:49:32 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E47E4D2E1;
	Thu, 24 Oct 2013 19:49:32 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 603EE4D2E0;
	Thu, 24 Oct 2013 19:49:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF9CE4D2D9;
	Thu, 24 Oct 2013 19:49:31 +0000 (UTC)
In-Reply-To: <CACsJy8Ap005pUBZH0k=7F9nON9Vb5SoO-1McPAwRkLCC0YoPMQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 24 Oct 2013 08:23:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 669EAA8A-3CE5-11E3-BA73-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236613>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Oct 24, 2013 at 12:52 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>>
>>> The strcpy call in open_output_fd() implies that the output buffer
>>> must be at least 25 chars long.
>>
>> Hmph, where does that 25 come from?
>>
>> [snipped]
>
> Much better. Thanks.

So where does that 25 come from?

We strcpy ".merge_link_XXXXXX" or ".merge_file_XXXXXX" into path[]
and run mkstemp() on it, and these templates are 18 bytes long, so I
am puzzled.

Is 25 "just a small random number that is surely longer than these
templates--did not bother to count how long the templates are"?
That's fine by me; I am just trying to make sure I am not missing
anything that turns these templates into a longer filename.

Thanks.

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
