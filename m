From: Christian Holtje <docwhat@gmail.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 19:25:40 -0400
Message-ID: <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site> <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com> <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:26:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHuO-00008I-GT
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbYFXXZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbYFXXZr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:25:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:37045 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbYFXXZq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:25:46 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2349465wri.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=eUB6/jPlmzugzkr1veKOsa+x+n+ZGeTnagUy8F4S8XU=;
        b=ePg8cBi48ljTHzhsBuaLCYSn3jISQ8Z4pb28LmEzWvBTh+uBWWP9iqsUIQvdmP4p6Y
         wFVzv/c8Rm5haEaSM9M3r1/k0JC+xigrQeLicYnf5Lt2WbfOZoKuxRyEwSld2AQOZ5mg
         e4KCSPDVv6rHUnY2IzgjZl15yO7M+d+BSVqGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=yGhBl1i/sloIFUZstrUQNNbe+NETxMOigRAqaaIfwuK/iXuK3JZUIPSpiGVqk3721+
         ZvivOhyj0xLhkFJvyW5yQvGMLQFPXWfEtNht+OGRDc+Y484LwKiI5tbZ/HXnkcwFWK1s
         sJWNQ+ziP//WYbsslhkM/3RGTzmhe6BFmzhV0=
Received: by 10.90.92.14 with SMTP id p14mr12607111agb.28.1214349943438;
        Tue, 24 Jun 2008 16:25:43 -0700 (PDT)
Received: from quicksilver-wifi.gerf.org ( [69.17.59.111])
        by mx.google.com with ESMTPS id p60sm6312841hsa.14.2008.06.24.16.25.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 16:25:42 -0700 (PDT)
In-Reply-To: <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86179>


On Jun 24, 2008, at 6:31 PM, Junio C Hamano wrote:

> Christian Holtje <docwhat@gmail.com> writes:
>
>> The code is checking for \r$ and then doing a different space check
>> depending on that, not one after another.
>>
>> Thanks for the feedback. I'll put up v2 in a second.
>
> Please don't.
>
> It's an ancient sample hook that is not be enabled by default.  I do  
> not
> want people to be wasting too much time on the relic

Part of the reason I'm fixing this is because it *is* enabled by  
default in windows.  I don't know why, but cygwin always marks it with  
executable.

> However, if this sample is to be changed at all, please do it right.
>
> If somebody suddenly adds CR at the end of an existing file that  
> ought to
> have LF line endings, we _DO_ want to catch that as a breakage.  So  
> the
> title of the commit "should ignore carriage returns at EOL" is  
> WRONG.  It
> shouldn't, in general.
>
> One thing the hook could and probably should do these days is if the  
> file
> type says you _ought to_ have CRLF line endings, actively make sure  
> your
> lines do end with CRLF (this is a much stronger and better check than
> blindly ignoring CR before LF for such files).  And on the other  
> hand, if
> the file should end with LF, do make sure it does not have CR before  
> it.
>
> The person who did the sample hook you are looking at couldn't do so
> because there weren't autocrlf nor gitattributes(5) facility back  
> then.
> But you can use them now to rewrite this properly.

How can I detect if a file should have CRLF vs. LF?  I didn't do a  
better check because I didn't know how.

> I wonder if "git diff --check" can be used for most if not all of the
> checking, without the big Perl script you are touching in your patch.
> That facility did not exist when the current sample hook was written,
> either.

I like that better.  Ditching the whole perl script in a shell script  
seems better.

I wrote a test case for what you describe above (a crlf file with an  
lf line or a lf file with a crlf) but "git diff --check" doesn't catch  
that.

Based on the information about core.whitespace doesn't git do this  
already?  Maybe we should just delete the pre-commit hook or make it  
empty with a note saying what you can do with it?

Ciao!
