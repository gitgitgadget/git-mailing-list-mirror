From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: describe fails on tagless branch
Date: Wed, 7 Feb 2007 12:01:16 +0000
Message-ID: <200702071201.16931.andyparkins@gmail.com>
References: <eqb660$ft7$1@sea.gmane.org> <200702070922.57163.andyparkins@gmail.com> <7vy7na8f2t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 13:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HElUT-0006ON-LV
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 13:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbXBGMBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 07:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbXBGMBa
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 07:01:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:55045 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161244AbXBGMB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 07:01:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so497962nfa
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 04:01:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=PHIswLyugMkhKZ+KOu00877PPwEhiJO4/Og361m/WRijgIst3rENFj/IyP6p6zeyMdmqtpkSmqBpo/ADEc6BIrALReYXt8hlZGPUb1w0PeEh78lwRXxtOhteDDounpCBnno9eJu0liw5NGhOHflG4pmd1sj9SMeFevOTDu5e7bU=
Received: by 10.82.186.5 with SMTP id j5mr1125544buf.1170849679963;
        Wed, 07 Feb 2007 04:01:19 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id e1sm1083900ugf.2007.02.07.04.01.17;
        Wed, 07 Feb 2007 04:01:18 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vy7na8f2t.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38916>

On Wednesday 2007 February 07 09:58, Junio C Hamano wrote:

> > Agreed - the "nearest tag" mode (--abbrev=0) would be broken in that it
> > git-describe would return a tag that doesn't exist.
>
> "describe" is about giving a short name for public communication
> to a commit in terms of well known tags.  If there is no tag,
> then it is natural to say that the commit is indescribable.
>
> In the case of "git-describe --abbrev=0 $indescribable", it
> could return an empty string, since there is no nearest tag
> after all.  But that would not apply to non --abbrev=0 case.

Absolutely.  I agree entirely.  The /only/ valid thing to return when 
git-describe is asked "what is the nearest tag" when there is no tag is 
nothing.  I don't see how it could be otherwise.  If there were a way to 
return NULL instead of "" then I'd vote for that (actually we could argue 
that the return code tells you it's NULL); however that's moot since it's not 
possible to have empty tags.

git-describe returns an empty string whatever the --abbrev when there is no 
tag.  To my mind it's working perfectly.  Every case is both handled and 
detectable.  What more could it do?

Slight aside: The only thing that has ever crossed my mind as an improvement 
to git-describe would be to get at its revision counting mechanism.  Just for 
fun really as I don't think it's that useful in the real world.  Wouldn't it 
be interesting if you could say:

 $ git-describe --revisions-per-tag HEAD
 30% v1.0.0
 20% v1.1.0
 15% v1.2.0
 13% v1.3.0
 12% v1.4.0
 4%  v1.5.0
 1%  (indescribable)
 
However, I think I'm just being silly :-)

> It might not be a bad idea to give '-q' option to make it silent
> when it fails because the commit is indescribable.

I don't think it's worth it.  The "-q" be used only in scripts, and in a 
script you would do the whole "2> /dev/null || echo 'No tag found'" thing 
anyway.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
