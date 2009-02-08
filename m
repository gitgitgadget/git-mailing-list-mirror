From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 11:47:49 +0100
Message-ID: <2c6b72b30902080247n31e5c532m31006fcb07ca95da@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
	 <20090206191511.GD19494@coredump.intra.peff.net>
	 <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
	 <20090207071056.GB14856@coredump.intra.peff.net>
	 <7vprhuzoxm.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0902070050490.8086@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Feb 08 11:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW7Fw-0004bY-J8
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbZBHKry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbZBHKrx
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:47:53 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:47946 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbZBHKrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:47:51 -0500
Received: by fxm13 with SMTP id 13so2076105fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 02:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=opH4PjwgfJ9Aj/65gDdt0rWUQLiyiU4knJ3PT6PYyNA=;
        b=vPUv8/hLYP0aHqACs1vtWQQev/RBUTYmi+3226i7TC8ReVZbPjSH+/0JzqfNswjsJZ
         YO+uV1gpVsyPzL8kxK4sEEMX6O9f8gbcm9zZN/9XXzrE6+WoSUo3MNvEwY6A5ukhcnfX
         d+Yh3LuJCz4p1l4GJ8UjusU6evSxoDfiqGvI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ISlVJvId/U/yOCtejC75iOj9zWuVjV087eerWcFcILp4uUSlvbezEhwotkGOYsVt9k
         4K/OkbTko3gMLyigvpGRUakbl3IBlZYb20RfKHfOkN0TeNPi1aJMYo3hX1hPJCvTtNNf
         l4VrHEIh8GgEPy6E3YzlFrQU/xsiTyYsxy/3I=
Received: by 10.181.144.11 with SMTP id w11mr21037bkn.27.1234090069601; Sun, 
	08 Feb 2009 02:47:49 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0902070050490.8086@asgard.lang.hm>
X-Google-Sender-Auth: 534fc30cc12ad7b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108951>

On Sat, Feb 7, 2009 at 09:55,  <david@lang.hm> wrote:
> On Fri, 6 Feb 2009, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>> My impression is that tig is currently doing (1).  I think (2) will
>>> suffer from the same problem, but in practice the margin of error will
>>> be much smaller because your are rewinding through fewer changes. So if
>>> that is what you were suggesting, I think it is probably worth trying.

Tig wasn't using the line number or even the filename, this has now been fixed.

>> It has been quite a while since I did the "show previous" feature of
>> "git-blame --porcelain" that has been forever queued in 'next'; if I
>> remember correctly, it implemented (2).
>>
>> The reason why it never graduated from 'next' is exactly this issue.  By
>> definition, there is no "previous" line number (if there were such a thing
>> that says "This line was at line N in the parent of the blamed commit",
>> then the commit wouldn't have taken the blame but would have passed it
>> down to the parent), and we need to come up with a reasonable heuristics.

So it ist somewhat safe to assume that the line didn't originate from
a different file, since git-blame would have picked that up?

> this sounds like the same basic problem I was having around the begninning
> of the year (thread subject 'how to track the history of a line in a file')
> what I ended up doing was to use git blame to go back and find the commit
> where a line was introduced, then use git diff to find the changes, then
> find the hunk of the diff that introduced the line, then find the lines that
> were removed and trace them back (repeating the process)

I've tried to implement something like this by using the output of
"git-diff-tree -U0". One problem it does not yet handle is the
cut'n'paste within the same file where the deleted line ends up in a
different hunk. So it won't jump to the correct place if you try to
trace back for example the origin of the parse_options function in
tig.c since at some point I moved it down in the file. However, it
does work quite well for tracing back the origin of for example the
DATE_COLS macro which was rewritten a few times.

I guess it comes down to what you can assume about the features or
"uniqueness" of the line (or lines) that are being traced back and
whether the history and commits are well organized.

-- 
Jonas Fonseca
