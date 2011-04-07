From: David Aguilar <davvid@gmail.com>
Subject: Re: p4Merge bundled command and the behaviour with files (same
 name) added on different branches.
Date: Thu, 7 Apr 2011 02:43:49 -0700
Message-ID: <20110407094347.GB7593@gmail.com>
References: <BANLkTimpsg=26C0mq=feVT7mt0nwZBoBUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ciaran <ciaranj@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 11:44:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7lkv-0000bg-UQ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 11:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab1DGJn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 05:43:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55848 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab1DGJnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 05:43:55 -0400
Received: by iyb14 with SMTP id 14so2281142iyb.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+SZJcJ3eMCPW/EwgU5g9oEQE3YGsbuwpt1J/UoWlctk=;
        b=jnhRfMdvru2qLJfdawIQm9w1MVWoqPSB+ojJ+0pDV7Rz/G6YVxNRJu4eV+0peYLV1n
         Ip7J3J47mkXR5pdHIyh5NIhHjfUtgpJWlKIoYLK25y7Bs1J+SgjUapF7DO7XyS2WyUs4
         n1synJtkOxGdvaa1nMtTYMeTr7vGN6Wahra4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PrBmojba9Lqc7e3sUj5+X4MggpCzxu0qWCHoIcpShSgsPjsL0y1I+5tYDv+kxgoSZh
         KMJwMk3KK0rJKFjrbJvezC3UDPPVMmnv40X1Vm2Khj9TogfDMU4Op0AgExZcU2xDtZmf
         ugvn/WJaqAXn8VRvwY3oteF4Q7uK2v5vcM/RI=
Received: by 10.42.5.81 with SMTP id 17mr1062031icv.130.1302169435064;
        Thu, 07 Apr 2011 02:43:55 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id xg14sm931787icb.7.2011.04.07.02.43.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 02:43:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimpsg=26C0mq=feVT7mt0nwZBoBUA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171049>

On Mon, Apr 04, 2011 at 09:55:41AM +0100, Ciaran wrote:
> [...]
> We would expect a 'both added' merge conflict (both the other branch,
> and the master branch added the file named bar.txt, but with different
> content.)  This is all good and right.  So in a system configured to
> use p4merge as the mergetool, one fires up with 'git mergetool'
> 
> What happens now is p4merge starts and tells us:
> 
> Base: bar.txt.LOCAL.<num1>.txt
> Left: bar.txt.LOCAL.<num1>.txt Differences from base: 0
> Right: bar.txt.LOCAL.<num2>.txt Differences from base: 1
> Merge: bar.txt Conflicts:0
> 
> Presenting the left + right options on top of each other in the result
> window (which may be correct) and leaving the save button disabled
> (grayed out)
> 
> If at this point one closes the window without editing the presented
> (apparently merged) file, then nothing will be saved to disk and we
> will see:
> 
> bar.txt seems unchanged.
> Was the merge successful? [y/n]
> 
> In the console.  Which Git wise is correct, that is exactly right, the
> p4merge tool hasn't made any actual changes to the underlying file.
> 
> This behaviour seems confusing to me (the p4merge client behaviour,
> *not* Git's)   I believe it is because in the case where there is no
> logical base between two files the local one is arbritrarily chosen,
> and p4merge *thinks* that this is equal to the merge result and has
> nothing to persist.
> 
> I have attached a patch that resolves the issue for me (e.g.
> introduces the behaviour I expect) by passing a reference to an empty
> file in the case where there is no meaningful base.  Unfortunately I
> don't understand enough to say whether this change is correct or not
> and would value feedback on it.
> 
> Many thanks
>  - Cj.

Thanks.  If this patch were for actual consideration you would
inline the patch instead of sending an attachment as described
in Documentation/SubmittingPatches.  Marking the subject line
with "[RFC PATCH]" lets us know that you're interested in
feedback.  I have a few questions below.

> index fb3f52b..3e486dc 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -262,7 +262,9 @@ run_merge_tool () {
>  			if $base_present; then
>  				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
>  			else
> -				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
> +				touch ".empty"
> +				"$merge_tool_path" ".empty" "$LOCAL" "$REMOTE" "$MERGED"
> +				rm ".empty"
>  			fi
>  			check_unchanged
>  		else
> -- 

What if the user has a file called '.empty' in their repository?

What if the user Ctrl-C's out of mergetool -- does a stale
.empty file get left behind?

Does it work if we pass /dev/null instead?
Is such a strategy portable to Windows?

If /dev/null doesn't work, would it be better if the
empty file were given a different name?
Maybe something like foo.EMPTY.<num>.txt?
-- 
		David
