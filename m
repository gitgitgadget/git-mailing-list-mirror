From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 06 Jul 2015 09:57:46 -0700
Message-ID: <xmqq615x2ph1.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
	<xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
	<CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
	<xmqqegkl2qu2.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:57:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC9iL-0003U9-Vf
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbbGFQ5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:57:49 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36244 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbbGFQ5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 12:57:48 -0400
Received: by iecvh10 with SMTP id vh10so117552118iec.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n8PyT+Szw4fa8Ft5wnP8Jey3Ng0/1w086iHL35ABNxY=;
        b=YREqWmzTSwXTYiL1rJp3dOIuaNhBNlHoUnmVwhK863PVX9SHiA8r8ogPyManicHvVC
         bzm6Q26M34Wrnc8JFA+99tEmENmMqZpRjhph/bfuJqPJqoYoWfceg8n1Hcrsc0z4QNM7
         be33Bt6BoQRN6j9ODALl3Ai8MskrXeGqFxNrfcPCLZ0M30ctMGANqJxs4+V6haKc0WXN
         O80FbWSGTuDRJhfQR0WARz9k3CD4ygzpyc2JKmACnkFoFtvvx9YUv9CvTX3Q6/Ss6Ysw
         /fl8c5yYGXKFv5WUNbxtpsFSd00jmc4I4NQ2zpeYrXMdUSRNgBqHhBhP192+O4pXHiKV
         OsuQ==
X-Received: by 10.107.32.73 with SMTP id g70mr77099692iog.23.1436201868036;
        Mon, 06 Jul 2015 09:57:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id g81sm12794971ioi.20.2015.07.06.09.57.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 09:57:47 -0700 (PDT)
In-Reply-To: <CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 6 Jul 2015 12:38:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273405>

Dave Borowitz <dborowitz@google.com> writes:

> The server can munge pkt-lines and reinsert LFs, but it _must_ have
> some way of reconstructing the payload that the client signed in order
> to verify the signature. If we just naively insert LFs where missing,
> we lose the ability to verify the signature.

I still do not understand this part.

There is no way to "naively" insert, is there?  You have an array of
lines (each of which you have already stripped its terminating LF at
its end).  How else other than adding one LF at the end of each
element do you reconstruct the original multi-line string the client
signed?  Are there other ways that makes the result ambiguous??

> If we say the payload the client signs MUST have LFs only in certain
> places, then that gives the server enough information to reconstruct
> the payload and verify the signature.
>
> But if we say the signed payload MUST have LFs and the wire payload
> MAY have LFs, then now we have two completely different formats, only
> one of which is documented.

I thought that was what I was saying.  The wire protocol sends the
contents of each line (both what is signed and the signature) on a
separate packet.  When I say "contents of a line", I do not include
the terminating LF as part of the line (iow, LF is not even
optional; the terminating LF is not considered as part of "the
contents of a line").  It becomes irrelevant that a pkt-line may or
may not have a trailing optional LF.  If there is LF at the end of a
packet between "push-cert" and "push-cert-end" packets, that LF by
definition cannot be part of the "contents of a line" in a
certificate.

It is just a pkt-line framing artifact you can and should remove if
you are doing a "split to array, join with LF" implementation to
recover the original string.

And that is very much consistent with the way we send other things
with pkt-line protocol.  Each packet up to the first flush is
expected to have <object name> and <refname> as ref advertisement.
The pkt-line framing may or may not add a trailing LF, but LF is not
part of <refname>.  It is not even part of the payload; merely an
artifact of pkt-line framing.
