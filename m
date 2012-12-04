From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Mon, 03 Dec 2012 16:23:26 -0800
Message-ID: <7vsj7moebl.fsf@alter.siamese.dyndns.org>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-2-git-send-email-kusmabite@gmail.com>
 <7vfw3oka68.fsf@alter.siamese.dyndns.org>
 <CABPQNSb2NQesbjKc8LUT0TL4=xrnw2A_sJyjX72j9Je_zX1sQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysgit@googlegroups.com,  peff@peff.net
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBAUF6WCQKGQEVZCAJ5Q@googlegroups.com Tue Dec 04 01:23:44 2012
Return-path: <msysgit+bncBCG77UMM3EJRBAUF6WCQKGQEVZCAJ5Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBAUF6WCQKGQEVZCAJ5Q@googlegroups.com>)
	id 1TfgIZ-0008Qb-Ok
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 01:23:43 +0100
Received: by mail-gh0-f186.google.com with SMTP id f11sf2827264ghb.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 03 Dec 2012 16:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=00fV2n+KD62Cwz5H380KPoR0QnRd+Im5j8FXn74HF/A=;
        b=ZUmJ9t2KUqDG/ZXEsOqqFp1XHDuKQ9Og8Cc1U8fVF5h8dpyXHPxTVm1kQS40D1CUlW
         5B0nBEoOGy/O0QYuBfXy8Uhgl3Wx0y15VbwT3O19sOC9lKdD5HqvgvkPz9rjn/N7PQow
         TW1A5+qpkOsY0LyqQRc6tJllvazhKvIQYmJSBthdAYQ4850XZ68w8yJvRuHOrNOU/DDA
         34Na9pEdZmCTF+Mzq5rck4Rr5nrYlFhqSvkNhtYaXt933UFm/9JrkCg3ZSDrOA1ivja6
         OAY12z3oRUBBivYQgAttveZ+Eq83c2eCvnuXujiEsuy5My9wnck1tqyl6sPJ3XVahEz 
Received: by 10.49.72.169 with SMTP id e9mr2707393qev.3.1354580611440;
        Mon, 03 Dec 2012 16:23:31 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.82.112 with SMTP id h16ls2211697qey.0.gmail; Mon, 03 Dec
 2012 16:23:29 -0800 (PST)
Received: by 10.58.127.226 with SMTP id nj2mr4047368veb.3.1354580609570;
        Mon, 03 Dec 2012 16:23:29 -0800 (PST)
Received: by 10.58.127.226 with SMTP id nj2mr4047367veb.3.1354580609560;
        Mon, 03 Dec 2012 16:23:29 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id h20si4465924vdg.3.2012.12.03.16.23.29;
        Mon, 03 Dec 2012 16:23:29 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D790A278;
	Mon,  3 Dec 2012 19:23:29 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08C1FA277;
	Mon,  3 Dec 2012 19:23:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BE36A276; Mon,  3 Dec 2012
 19:23:28 -0500 (EST)
In-Reply-To: <CABPQNSb2NQesbjKc8LUT0TL4=xrnw2A_sJyjX72j9Je_zX1sQw@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 4 Dec 2012 00:29:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3683600-3DA8-11E2-B478-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211065>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> That patch corrected the exit-code for our SIGALRM's SIG_DFL routine;
> the old code did "die("Alarm");", but the new one does "fputs("Alarm
> clock\n", stderr); exit(128 + SIGALRM)"
>
>> Please double check the result when I push out the 'pu'
>> branch.
>
> The resolution is fine; you effectively got the two commits squashed.
> I'll send out a new version with the extra patch added, and your
> signature-fixup squashed in, OK?

Sure; thanks for a prompt response.

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
