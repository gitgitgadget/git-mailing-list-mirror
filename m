From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 18:03:57 +0100
Message-ID: <200704171803.58940.andyparkins@gmail.com>
References: <200704171041.46176.andyparkins@gmail.com> <200704171235.34793.andyparkins@gmail.com> <Pine.LNX.4.64.0704170847380.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 19:04:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdr6H-0007sZ-BX
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 19:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031193AbXDQREO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 13:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031206AbXDQREO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 13:04:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:13086 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031193AbXDQREN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 13:04:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so219208uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 10:04:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XqnhRz++fOVi4DtrCy3fLDIyubafwHSVlqzhma2MJ7k3cgta9uKIA20Khau8xDJ5oIqO5+1OVOpeRZvA8oGFeq/K9I709Mb4coN4MCHLpMMzUfpcEge1Q0n1clN4seCmQaulFusZ3zWMGT8RIMpmz3kSkzw/n7UHEw5NyDcN7Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TNlm6PVMvFqpIo3Q7YcW2rXPFXPYYPzEqMI+vOQiKzTMAgxze30fL0XwVSSZKV/yhy8Bdtlh5c5DW/v2VDXGqc6wgn6RSaUadxmIBZ/+D7FvPcSVkT1GGTz/QSfnsntbYjDiw2NWDjvqlfZdI+QdH8l9lY+ji8icFoH2rScHFj4=
Received: by 10.67.50.7 with SMTP id c7mr591216ugk.1176829452107;
        Tue, 17 Apr 2007 10:04:12 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id j1sm1407712ugf.2007.04.17.10.04.10;
        Tue, 17 Apr 2007 10:04:11 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704170847380.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44799>

On Tuesday 2007, April 17, Linus Torvalds wrote:

> Try this:
>
>  - File-A in revision 1:
>
> 	$ID: some random crap about rev1 $
> 	Line 2
>
>  - same file in revision 2:
> 	$ID: some other random crap about rev2 $
> 	Line 2 got modified
>
> and think about it. Your diff will be something like
>
> 	@@ -1,2 +1,2 @@
> 	 $ID:$
> 	-Line 2
> 	+Line 2 got modified
>
> and the diff WON'T EVEN APPLY!

Why on earth would it not apply?  It's being applied using git-apply, 
which will unexpand the keywords as it goes - as I keep saying.  When 
the apply engine is looking for the context it's going to collapse the 
keyword, so the context will match and the diff WILL EVEN APPLY.

As Junio said in his reply, git-apply doesn't currently call 
convert_to_git(), but that's easily implemented.

> In other words, there's no way in hell you can make this work. You'll

You keep saying these sweepingly general things.  It can be made to 
work.

> end up always having to edit the keywords parts of diffs to make them
> apply if they are part of the context.

No I don't.  If I had to then the keyword code would be broken.  No one 
in their right mind would think that was an acceptable thing to do.

> (This, btw, is something that a CVS person says "so what?" about.
> They're _used_ to having to do it. It's how you do merges in CVS.
> Really. How many people have actually *worked* with branches in CVS

That's because CVS is rubbish.  What has that got to do with it?

> on any complex project with any nontrivial work happening on the
> branch? I have. I hated CVS for many reasons. Keywords was just a
> small small detail in that hate relationship, but it was one of
> them!)

You really can stop trying to persuade me that CVS is no good for 
version control - I agree, a thousand times I agree.  There are a lot 
of things that CVS does in a broken manner, that doesn't mean that git 
does the same thing in a broken manner.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
