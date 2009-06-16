From: John Bito <jwbito@gmail.com>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 10:16:39 -0700
Message-ID: <3ae83b000906161016k4927a91cke86d6c4aa087a590@mail.gmail.com>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
	 <20090616114726.GA4343@coredump.intra.peff.net>
	 <7v3aa0dsvn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGcHA-0006IH-MP
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 19:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759410AbZFPRQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 13:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758707AbZFPRQi
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 13:16:38 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:44092 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbZFPRQh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 13:16:37 -0400
Received: by an-out-0708.google.com with SMTP id d40so10299798and.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rybtr8HsMnUYskfhecWJP9Hc3Md1TDyepSlQXPNAv00=;
        b=JR6vke6OytaiVZoaFiuBwTbsVm9te3e1T8kQGY4jzuL6aUHOc+WYGabGWZ4pzoFJaz
         V8gAF8myv5SZBo1KmiR4h5xK/ywQEmmbYEn9KatjL17uzu6GwpjhqVCQV1voenzAuq91
         izYbHNh/eKGgMkwe2l5icFl0ZJeTaHFNmlBbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JfAt4tXgeLdeHzkDEHsJ4ZiNhYM7vMZpx1mfnvb8YxaO4HDpG+LRu9JCkm7jBuwjKu
         YAIPzPIIuYelGeXLQi2xlCWbrTNEYIDjXnEaT4BCwnVGcQM1ozyn4Md1N1DHyT9pYBZe
         KFpV4Oq0LsghkP2Q1RD3ZRQieu8P/xE3+lWG4=
Received: by 10.100.110.19 with SMTP id i19mr10807410anc.1.1245172600027; Tue, 
	16 Jun 2009 10:16:40 -0700 (PDT)
In-Reply-To: <7v3aa0dsvn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121690>

The Solaris 10 server here isn't set up to build git.  git/Makefile
isn't compatible with /usr/ccs/bin/make. Is it desired to have a
Makefile that's portable to the Sun tools?

I was going to test Jeff's patch, but I probably won't install GNU
make on this machine unless I find I more compelling need to build git
on Solaris.

If it would help folks out, I'd be willing to try to create a Makefile
patch that works with the Sun tools, but I don't currently have a
Linux machine that I can easily use to verify compatibility.


On Tue, Jun 16, 2009 at 9:51 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Jeff King <peff@peff.net> writes:
>
>> I can reproduce the problem on Solaris 8 using git v1.6.3. It seems =
to
>> be caused by a horribly slow system regex implementation; it really
>> chokes on the regex we use to find the "funcname" line for java file=
s.
>
> Hmm. =A0Is running under LC_ALL=3DC LANG=3DC _with_ the slow system r=
egex help?
>
>> I tried building against the code in compat/regex; it completes in a
>> reasonable amount of time, though it is still noticeably slow. With
>> system regex, the diff given above doesn't complete in less than 90
>> seconds (at which I get bored and kill it). With compat/regex, it
>> completes in about 2.2 seconds. Disabling the xfuncname, it complete=
s in
>> 0.14 seconds.
>
> In this particular case it is clear that a good way to fix the proble=
m is
> to replace Solaris's dumb regex implemention with what comes in compa=
t/,
> but I at the same time have to wonder if that funcname pattern for ja=
va
> can somehow be simplified, so that it does not to require so sophisti=
cated
> implementation of regexp?
>
