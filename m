From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not 
	author
Date: Wed, 11 Feb 2009 10:54:46 +0100
Message-ID: <cb7bb73a0902110154h325ed146h4d1161d4a8dcb1ca@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <86d4c5e00902101910k5512efel2c9165f75d61ba53@mail.gmail.com>
	 <cb7bb73a0902110102k5b7e5a21vd7d0932c6b6ba20e@mail.gmail.com>
	 <200902111018.39699.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Deskin Miller <deskinm@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBpQ-0003dM-MX
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbZBKJyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 04:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbZBKJyu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:54:50 -0500
Received: from mail-ew0-f26.google.com ([209.85.219.26]:45281 "EHLO
	mail-ew0-f26.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbZBKJys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:54:48 -0500
Received: by ewy7 with SMTP id 7so33434ewy.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=537BFpYNNTAg3L6NoooW5YTm5pizuz0/XId2vaXSJC0=;
        b=fR2vgGacFf8CjChUwi2hxuknGvcmBMPQ4vIob2XYuWbD5iiThCfK1OuEJdlfg1OguI
         +tcjB6eWbUC9Vb/ZMFGh6MClIgOLyT4K9+BG7WRzI4x3/lcKwvgdDSglWmU+tthvq/rk
         IQL4anjZvZ3jWQnBTjGvjqCjaNj3vfYx9ykA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=InEn9lid578RXW6pP6FJauzhww9KTjytbhjkzXR3ultJm/B7pRxMqtLMUMcaVC6el+
         GkwrGQAV0AYH4l44od9IJZx4vmVQRGaEdouj7AKOVIMCr9/3tqjCGJzvASpF09MuNMJg
         WickUIfvbdGO+r1wlRHWtMunDfgUl0CmIe/2w=
Received: by 10.210.39.8 with SMTP id m8mr1727951ebm.154.1234346086893; Wed, 
	11 Feb 2009 01:54:46 -0800 (PST)
In-Reply-To: <200902111018.39699.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109394>

On Wed, Feb 11, 2009 at 10:18 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 11 Feb 2009, Giuseppe Bilotta wrote:
>> On Wed, Feb 11, 2009 at 4:10 AM, Deskin Miller <deskinm@gmail.com> wrote:
>>> git reflog?
>>>
>>> Seems like one could find the oldest time the commit appears in the
>>> reflog, for the branch one is interested in.  You can use the commit
>>> time to limit the search through the reflog, but there would be clock
>>> skew concerns.
>>
>> Bingo! Thanks a lot
>>
>> oblomov@rbot ~ $ GIT_DIR=/var/git/rbot.git/ git reflog show
>> --since="two days ago" master | cat
>> 7324b32... master@{0}: push
>> e2dc08d... master@{1}: push
>> oblomov@rbot ~ $ GIT_DIR=/var/git/rbot.git/ git reflog show
>> --since="yesterday" master | cat
>> oblomov@rbot ~ $
>>
>> I'll try to work it in the next review for this patchset.
>
> Assuming that you have reflog enabled (yes, it is default now)...
> So you would have to provide fallback in the case there is no reflog.
>
> BTW. "git reflog" is porcelain; it would be better to parse reflog
> directly, I think.

Does disabling reflog remove old reflogs? IOW, can I check if reflog
is enabled just by opening the reflog file and assuming reflog isn't
enabled if it's not there? Falling back to the commit date would still
work decently.

Since we're only interested in the last reflog date, what we can do is
to read the last line and get the unix time which is held two places
before the tab separating the metadata from the log message. Correct?


-- 
Giuseppe "Oblomov" Bilotta
