From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 22:52:06 +0200
Message-ID: <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>
	 <4797095F.9020602@op5.se>
	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
	 <4797518A.3040704@op5.se>
	 <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
	 <4798B633.8040606@op5.se>
	 <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
	 <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIVXX-0003Oe-Fs
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 21:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbYAYUwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 15:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbYAYUwL
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 15:52:11 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:47410 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYAYUwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 15:52:09 -0500
Received: by fk-out-0910.google.com with SMTP id z23so758768fkz.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ohoQAnofjLQu05UkBSoA68iX8KbUctBjsDyHsACafoA=;
        b=Oe6EPuV+QX+5JaGrpK1dOpI18brBuPHmhs+LAVXLhP2JLF/hFxnwvWBaNdzTPNO1ZAar+OjQMJiQd7mgRNLcQ2BcPCZ2woMc8o8ayzdErauokwb85j5JgQHRJobFDjigYFNjF1oSbIHYDuwpQxLM2PKnIUBuelxpvdEuXhHiUnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pMglNiHoY0q7omc/QQGn7B1xj/sNXcacCHalH19chUYaAyEHolPLZQltxToWTqMfCKWw9CKRlHYcVhP+NeFMiJ7K9/QFLOI1xvr98RnjMZatrvCFNB4zr3VcSNIK8+ivFL9+XVZNgVNHouaCwajE5mUyfTU1Nm2RbGGv715Qj1g=
Received: by 10.78.190.10 with SMTP id n10mr3746949huf.37.1201294326692;
        Fri, 25 Jan 2008 12:52:06 -0800 (PST)
Received: by 10.78.200.6 with HTTP; Fri, 25 Jan 2008 12:52:06 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71737>

On 1/24/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> You can do a perfectly fine 8-bytes-at-a-time hash for almost 100% of all
> source code projects in UTF-8, without *ever* doing any format changes at
> all. Admittedly, it's a lot easier if the hash is a pure in-memory one (ie
> we don't care about byte-order or size of integers or anything like that),
> but that's the common case for most hashes that aren't used for BTree
> lookup on disk or something like that.
>
> Here, let me show you:
>
>         unsigned int name_hash(const char *name, int size)

Well, although this is very clever approach, I suggest against it.
You'll end up with complex code that gives out substandard results.

I think its better to have separate case-folding function (or several),
that copies string to temp buffer and then run proper optimized hash
function on that buffer.

That way you can use already tested building blocks and can optimize
both sides separately.  Eg. the folding-only function can  aswell be
optimized to load 4 or 8-byte at-a-time.  This also isolates hashing
from exact details how folding happens to access the input string which
seem to be the weak point in your approach.  (In both collision and
complexity sense.)

Such temp buffer happens to fits my lookup3_memcpy also better (heh).
Its weak point is that on platforms that do not allow unaligned access,
it degenerates to byte-by-byte loading.  But if know you always
have aligned buffer, you can notify gcc to do 4-byte fetch there too.
It should be as simple as tagging data pointer as uint32_t *.

Anyway, now you dont need to worry about folding when picking hash.

> Basically, it's almost always a stupid thing to actually normalize a whole
> string. You do those things character-by-character, and only lazily when
> you actually need to!

If your input strings are over kilobyte on average then I'd
agree with you, but if you process 20-30 bytes on average,
is the additional complexity worth it?

-- 
marko
