From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Tue, 8 Jul 2008 00:58:54 +0200
Message-ID: <200807080058.56346.jnareb@gmail.com>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <m3tzf1e3ze.fsf@localhost.localdomain> <7vk5fx1g0a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 01:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFzgn-0000UK-BN
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 01:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758326AbYGGW7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbYGGW7I
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 18:59:08 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:52584 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758303AbYGGW7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 18:59:06 -0400
Received: by gv-out-0910.google.com with SMTP id e6so371507gvc.37
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FOkGCijzxncVIEVC9XmVINNQDJT2yqECdw51oIISBoA=;
        b=oTrZ7cTN8htMqDqrZcwJjDQkiEh7iKDI/jU2gkwqSRI2PYlfwLJ6l2A1JEDtCbeaXr
         S5M2M81J9h8n/1Rt7z6Rkz39I7SUhe9VLbzlqwV5Lg4rsCGj4hEmE5iaHAeCbHRjq515
         P3wTVZvdyMkNQeqkFu1HRD32dwjFMZKAmJsNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rR/OzdDhG6Uy77bKiKNGy6dBbIoQO9+FuhKN5C7fmMUqv1SAEvBkctsnRpvsriZoJb
         wbZIu/CUJ7r9lRylrb7imab7mrOarGlZHrt/31o1Vj2j/tX8BW1v/TPr3lqP55nFegd+
         dcusVLkQbtWnoew1YMeE8Jsr/h04Wp7OT+R7Y=
Received: by 10.103.175.8 with SMTP id c8mr2655027mup.26.1215471544083;
        Mon, 07 Jul 2008 15:59:04 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.206.62])
        by mx.google.com with ESMTPS id y6sm19029228mug.15.2008.07.07.15.59.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 15:59:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk5fx1g0a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87665>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> @@ -289,10 +299,10 @@ notation is used.  E.g. "`{caret}r1 r2`" means commits reachable
>>>  from `r2` but exclude the ones reachable from `r1`.
>>>  
>>>  This set operation appears so often that there is a shorthand
>>> -for it.  "`r1..r2`" is equivalent to "`{caret}r1 r2`".  It is
>>> -the difference of two sets (subtract the set of commits
>>> -reachable from `r1` from the set of commits reachable from
>>> -`r2`).
>>> +for it.  When you have two commits `r1` and `r2` (named according
>>> +to the syntax explained in SPECIFYING REVISIONS above), you can ask
>>> +for commits that are reachable from r2 but not from r1 by
>>> +"`{caret}r1 r2`" and it can be written as "`r1..r2`".
>>
>> I'm not sure if the last part is improvement, and it wouldn't be better
>> to say rather than r1..r2 / ^r1 r2 are "commits that are reachable from
>> r2, excluding those commits which are reachable from r1" (which translates
>> into set difference / subtracting set of commits.
> 
> I tried to make it easier to understand by people without having to know
> what a set difference is, and that was the reason I did not use "subtract"
> nor "difference", as I saw somebody was quoting the above part in #git was
> wondering what it was talking about.

I understand, and the replacement you proposed is better, as it does
not require understanding of [mathematical] set operations.  I just
think that "commits that are reachable from r2, excluding those commits
which are reachable from r1" could be better than "commits that are
reachable from r2 but not from r1".

-- 
Jakub Narebski
Poland
