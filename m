From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 02/11] strbuf: add non-variadic function 
	strbuf_vaddf()
Date: Thu, 26 Nov 2009 11:38:49 +0100
Message-ID: <40aa078e0911260238rd0c90cag126709d1de5f50de@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
	 <7vskc2ksnn.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	dotzenlabs@gmail.com, Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 11:38:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDbkW-0003Zj-92
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 11:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760284AbZKZKip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 05:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760267AbZKZKio
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 05:38:44 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48694 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759392AbZKZKin convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 05:38:43 -0500
Received: by ewy19 with SMTP id 19so290294ewy.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j2UKjsJD76jMwwvJMXL3LU65Qi/sKvTvqiK4Rmqe0U0=;
        b=Fhnxxc0devGAwv5EerZKmkDRnehXvxXRNHlEMmNcTgMgeGLJyz47n5lDk9dAvw9MCt
         RCxEA1qMc4ZraDu3QXR6uFBJoO4b3HlhygCIl44A3RgVtNt//IKPMtnFO7vVvWq+IOaV
         jFgX9SpakCMUf6E3GKhv5USdn/gd9+xFflZls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=kR/saIo4hw2fU4T3Uy69Lsir5Xun/yAjDqW8VBLO21rM81ZtU+e6VKWEyuyVrpYzAj
         sRAQpjpF1fLnYUpU5lZ3AkOX+daLmV+NamMP6Ms6/rIPOwiU6nn50/xaHVxBR1z+WwSk
         CrQ26bi+fPjidJex/Dbp96hPDhpuSIxLXB3yQ=
Received: by 10.216.88.68 with SMTP id z46mr542796wee.27.1259231929263; Thu, 
	26 Nov 2009 02:38:49 -0800 (PST)
In-Reply-To: <7vskc2ksnn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133780>

On Thu, Nov 26, 2009 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>
>> +void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
>> =A0{
>> =A0 =A0 =A0 int len;
>>
>> =A0 =A0 =A0 if (!strbuf_avail(sb))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_grow(sb, 64);
>> =A0 =A0 =A0 len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len=
, fmt, ap);
>> =A0 =A0 =A0 if (len < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("your vsnprintf is broken");
>> =A0 =A0 =A0 if (len > strbuf_avail(sb)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_grow(sb, len);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D vsnprintf(sb->buf + sb->len, sb-=
>alloc - sb->len, fmt, ap);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len > strbuf_avail(sb)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("this should not hap=
pen, your snprintf is broken");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Hmm, I would have expected to see va_copy() somewhere in the patch te=
xt.
> Is it safe to reuse ap like this in two separate invocations of
> vsnprintf()?
>

I think your expectation is well justified, this seems to be a
portability-bug waiting to happen. Sorry for missing this prior to
sending out - on Windows this is known to work, and this function is
currently only used from the Windows implementation of syslog.

How kosher is it to use va_copy in the git-core, considering that it's
C99? A quick grep reveals only one occurrence of va_copy in the
source, and that's in compat/winansi.c. Searching the history of next
reveals that Alex Riesen (CC'd) already removed one occurrence
(4bf5383), so I'm starting to get slightly scared it might not be OK.

In practice it seems that something like the following works
portably-enough for many applications, dunno if it's something we'll
be happy with:
#ifndef va_copy
#define va_copy(a,b) ((a) =3D (b))
#endif

--=20
Erik "kusma" Faye-Lund
