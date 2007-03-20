From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/4] update-hook: parse the tag header in preparation to use the tag type
Date: Tue, 20 Mar 2007 15:24:03 +0000
Message-ID: <200703201524.04282.andyparkins@gmail.com>
References: <200703201058.42753.andyparkins@gmail.com> <20070320143844.GA1750@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 16:24:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTgCA-0007vk-AH
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 16:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933753AbXCTPYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933779AbXCTPYM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 11:24:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:33555 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933753AbXCTPYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 11:24:10 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1650254uga
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 08:24:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h1VfWUS70dyfzu80i00ydRfHAwmxjGihewb5pdkEaezfdTx3yblJ00pJrYlTnyguMvFItt/xF8STL0zdJ8K5Tt7u+xy+8cZGlrhPwUDpgJSL1CtBQ4TO1P1uWUfPnJ0bUdWB1yYOM8B82J05ELJI5INDbxw46U0ir6bV0mnLYVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sFrVFWHzlK3AmT+TGc/p4c1ZJiWE1a3G3g4rMzagzy3RIDx1jTEkiVuBAatR7sv+sgLF7RFEfjfG2VNgz8w3MjIbQliv7jNycTRqYKpb2q77dTqK+vZYsP7eww0366pY5uVU40EOrtJA9uHzSjRkNm+qTKiEZN7AKSNUdUBt3GM=
Received: by 10.65.204.7 with SMTP id g7mr1713500qbq.1174404249088;
        Tue, 20 Mar 2007 08:24:09 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id i1sm2397336nfe.2007.03.20.08.24.08;
        Tue, 20 Mar 2007 08:24:08 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <20070320143844.GA1750@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42744>

On Tuesday 2007 March 20 14:38, Shawn O. Pearce wrote:

> The problem of course is the update hook is running before a ref
> is created to point at the tag.  If you used post-receive hook
> on the other hand...  Oh, right, that has its own problems too!

I've obviously not described the problem very well; as I don't understand how 
your comment relates to this patch.

All I'm doing is pulling the individual fields out of

 $ git cat-file -p v1.5.0
 object 437b1b20df4b356c9342dac8d38849f24ef44f27
 type commit
 tag v1.5.0
 tagger Junio C Hamano <junkio@cox.net> Wed Feb 14 00:00:00 2007 +0000

And putting them in their own variables.  I'm not sure how for-each-ref or in 
fact, any ref-based tool would help me do this.  At this point it's nothing 
to do with git, it's a standard shell script problem.

 git cat-file -p $newrev | while read field value
 do
   variable = "found"
 done
 echo $variable

Doesn't work, because the right half of the pipe is run in its own process and 
so setting "variable" has no effect once the while loop is over.

I found that "<<<" heredoc thing in the bash manual, which is almost like 
having a reverse pipe and allows the while loop to run in the main process.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
