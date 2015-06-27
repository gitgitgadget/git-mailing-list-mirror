From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git error in tag ...: unterminated header
Date: Sat, 27 Jun 2015 11:36:48 -0700
Message-ID: <xmqqd20hf16n.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
	<xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
	<2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
	<xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
	<xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
	<d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
	<20150626155248.GB30273@peff.net>
	<xmqqh9puv0a8.fsf@gitster.dls.corp.google.com>
	<5bf3e78138813d8667f4761cc7bc23a3@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:37:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8uyI-0004UT-Kf
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 20:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbbF0Sgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 14:36:53 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35550 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbbF0Sgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 14:36:51 -0400
Received: by iebrt9 with SMTP id rt9so93698726ieb.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YmCM9jPFLihStmQxKMM4jX0MWPsj2cP2JZ9Wi0wNWNY=;
        b=YE3r3pzVkmzXPpCS5dvxLBQ88pqjAKVmdmK9NPAXi1FiLFwybiEbUuT6kGYklBixAz
         px/RUBX4lxx11eVq0ywmmTIYFZSLCya1nxWBnpDeKLoPtVkWp6EvDjd8BUdAnh5NEdbD
         7b22yqZ9OeoA3JSvOtwm1WeacANIZno6dwCE+Ki+brXAo4bEKMQ/f7oVWvkDVBPHGjZ4
         yWLdinj0rBtx1PZAvXLNM/8ItM3TTT/7Ez3TmTU2zDwFWuzDFopW/AdMFvYMdoltLtnl
         Es4lVwFsWpvP7orpKGYztOYlSsekgCYaSedWfe/nTzDBsakLjt9eBZ2VnuN4j5I1B/TA
         Ki0g==
X-Received: by 10.107.137.210 with SMTP id t79mr5574915ioi.16.1435430210386;
        Sat, 27 Jun 2015 11:36:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:205e:4a52:83c1:a37f])
        by mx.google.com with ESMTPSA id rr5sm1675106igb.7.2015.06.27.11.36.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Jun 2015 11:36:49 -0700 (PDT)
In-Reply-To: <5bf3e78138813d8667f4761cc7bc23a3@www.dscho.org> (Johannes
	Schindelin's message of "Sat, 27 Jun 2015 10:57:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272859>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On 2015-06-26 19:37, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>>> On Fri, Jun 26, 2015 at 10:06:20AM +0200, Johannes Schindelin wrote:
>>>
>>>> I understood what you were saying, but it still appears too fragile to
>>>> me to mix functions that assume NUL-terminated strings with an ad-hoc
>>>> counted string check.
>>>
>>> Yeah, I agree. It is not that you cannot make it safe, but that it is
>>> simply a fragile maintenance burden in the future. I thought we dealt
>>> with this already with a1e920a (index-pack: terminate object buffers
>>> with NUL, 2014-12-08), though.
>> 
>> Hmph, that is an interesting point.
>> 
>> It would mean that the require_eoh() can be reduced a bit further.
>> ...
>> That would mean the name of the helper needs to change, though.
>
> You mean in addition to your changes to read new lines only when we're
> still inside the buffer?

I think what Peff meant was that we always have the NUL at the end
of the buffer in a world with with a1e920a0 (index-pack: terminate
object buffers with NUL, 2014-12-08).

That means that we can replace require-eoh with verify-headers in
the message you are responding to and update the callers to call the
new function without doing anything else.

It might be tempting to say that require-eoh is not necessary, but I
think verify-headers still has its values. The running fsck may not
know some of the new headers the version of Git that produced the
object being verified knows; hence it is given that the line-by-line
verification does not check all the header lines individually.  But
at least we know that we know the header part of the object must be
terminated with LF and does not contain a NUL even for any new
header that will be invented in the future.  I.e. an object without
a body and ends with an incomplete line as the last line of the
header will not be allowed, ever.  And the only sane way to verify
that is by scanning the object upfront before we verify the known
ones line-by-line, just like we did with require-eoh.

As long as the code verifies line-by-line (which by the way the
"demotable error level" also depends on to allow it to re-sync to
the next header line after seeing an error in one header line; I do
not expect the line-by-line nature of verification to change in the
future for this reason), "make sure that the header part ends with
LF and before starting to read each header line to verify, make sure
we still have data to read" is not as fragile as you made it sound
in your past few messages, simply because there is no valid reason
to use start_with() with a string that has LF in the actual
verification code.  That would be only necessary if we have a known
header line that consists of a fixed token without any variable data
on it before the terminating LF, but in the context of talking about
Git object header, having such a header line is absurd in the first
place.

But with NUL termination guaranteed, we no longer need "before
starting to read each header, the size says we still have something
to read".  That is why I think updating require-eoh to verify-headers
is the only thing we need to do.
