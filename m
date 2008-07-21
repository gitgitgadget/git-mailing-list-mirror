From: Tim Harper <timcharper@gmail.com>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 21 Jul 2008 16:53:55 -0600
Message-ID: <E301C92A-8794-4E90-9C85-D73B94A2648C@gmail.com>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 00:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL4Hc-0005yk-6Y
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 00:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbYGUWyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 18:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbYGUWyG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 18:54:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:53733 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbYGUWyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 18:54:03 -0400
Received: by yw-out-2324.google.com with SMTP id 9so634696ywe.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=wbdaXAbN2qniEPiNzYZFQqyE4oV10WwDU66/jEPp25Y=;
        b=p55QYH9EfQcbbiXT8vLBhwA7SvvlWbTJa6OMfiqovzgGLHa7CMhL3b+tIRzinGkrFx
         vT4PzZgnBm9mbTqQv2BS+prwAEFR3j4XbmbefKAqD3Ekfpkiep4jB4Et6AINzd+oJcQR
         13sx3xhI7tX+B6LmmiQcmjkPo+Ko2x4qZoEqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=U8INrJEriRq8pu+U3d1BgbiPkfJ4OkAlVJCfENs7lE7L2G193HKPyEw2kPgfkELih5
         ETQdMt04hQEDPi5Mn4jGJGTASW0ExiiRSgxPVIgnFcU34fEIMb7YP3E4qgkwhDLOyypv
         MR0PPrdFq5JBT/3PIn8qHwItywMIv193fp2tE=
Received: by 10.115.106.7 with SMTP id i7mr3139266wam.131.1216680841758;
        Mon, 21 Jul 2008 15:54:01 -0700 (PDT)
Received: from ?10.1.1.135? ( [66.182.89.5])
        by mx.google.com with ESMTPS id n37sm8504098wag.43.2008.07.21.15.53.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 15:53:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89413>


On Jul 21, 2008, at 2:37 PM, Linus Torvalds wrote:

>
>
> On Mon, 21 Jul 2008, Tim Harper wrote:
>>
>> Anyone run into this before?  Any idea what might have caused it?   
>> We're a bit
>> concerned about this because if we don't know how to avoid this, we  
>> no longer
>> can feel certain that when something is committed, it will make it  
>> out in our
>> release.
>
> Read up on '--full-history'.
>
> By default, git simplifies the history for logs that have path
> simplification: only walking down the side of a merge that all the  
> data
> came from (ie the unchanged side). So it only leaves merges around if
> there was changes from _all_ parents.
>
> So without --full-history, if any parent matches the state, it just
> removes the merge and picks that parent that contained all the state.
> Obviously, any changes to that file can be sufficiently explained by
> walking just that limited history, because they must have changed in
> _that_ history too!
>
> That default behaviour leads to a *much* simpler history, and is  
> usually
> what you want - it avoids unnecessary duplication when something was
> changed trivially the same way in both branches - 'git log' will  
> just pick
> the first branch.
>

Agreed - this was an insightful decision.

> So, if you had two (or more) commits that both fixed the same bug in
> different branches, and thus both branches actually ended up with  
> the same
> contents, it does mean that "git log <filename>" will only show  
> _one_ of
> the fixes.
>
> In this case, it apparently showed another version than the one you  
> were
> looking for.
>
> 				Linus

Git has made me feel stupid on various occasions.  This is no  
exception as the problem turned out being in the chair, not in git.

After running through git bisect, and ran the command Alex Riesen  
suggested, it made it pretty crystal clear where things went wrong.   
It turned out to be a bad merge that was from a conflict related to  
white-space issues, and the wrong resolution was chosen (a resolution  
that also consequently turned out to be no change).

Another false impression I had is a merge conflict resolution would  
always be displayed in a merge commit.  However, after running over  
the merges again, if you pick the right or left, discarding the one or  
the other, nothing is shown in "git log -p" for the merge commit.  Is  
there a way to see what was chosen for a conflict resolution?  Seeing  
that in the merge commit would have made things a little more clear.

Thank you for articulating git branch's behavior - all is clear as mud  
now :)

Tim
