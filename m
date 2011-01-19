From: "Aaron S. Meurer" <asmeurer@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Wed, 19 Jan 2011 12:44:57 -0700
Message-ID: <0253BAE3-90F7-492C-ADF5-8B16DFFA1E44@gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com> <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com> <54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com> <AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:45:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfdxv-0007VT-L8
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab1ASTpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:45:09 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:64208 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab1ASTpF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 14:45:05 -0500
Received: by pxi15 with SMTP id 15so222029pxi.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=wobt0NGJIwHBuG5vR6Ylzzojqm5z1D5G7IJ/jcX0N3w=;
        b=QBvwj0sYgJ8PZK4C+z4oeXt4aGXZJUnSl5xRMSWSNNTdMVkDUdaNYV8zssMLI+sjmw
         Z+4Zhv5Ho9Dpx8/1A+yJJAQPJs7chHMpsu06NThCkFviNsDTtfrbvcaxmtLNc0E22Dnz
         4PkxnM1jnfwbecBRgqRgJ7uKKsmHubTnoSLzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=LEtEzyL3QqO3kFbc9YYqDUlpCxQPic8OIm1JWYIhuCKBnI5YdVqD2rx7734O+ghpMI
         uoE1o4j0mVVKAXTvS3OMmIDB5zqEAbGf0WCKnSjgV3M7Gm6KbSL6oPYUaiD7X0rS/4S6
         fzZPttBhu7yr/GbYqu43Psyta3n77U5954Frg=
Received: by 10.142.133.21 with SMTP id g21mr1117845wfd.425.1295466304972;
        Wed, 19 Jan 2011 11:45:04 -0800 (PST)
Received: from [192.168.2.3] (dhcp-baca-230.resnet.nmt.edu [129.138.31.230])
        by mx.google.com with ESMTPS id o1sm10009591wfl.2.2011.01.19.11.45.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:45:02 -0800 (PST)
In-Reply-To: <AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165285>

>>> Yeah, many people find it difficult to reverse the meaning of "bad"
>>> and "good" when looking for a fix. There were some suggestions at some
>>> points to do something about it. Some of the suggestions were to use
>>> some aliases for "good" and "bad", but there was no agreement. Other
>>> suggestions had a patch attached but the patch was not good enough or
>>> something.
>>> 
>>> Anyway, the restriction is that the "bad" commit cannot be an ancestor
>>> of a "good" commit. But the "good" commits need not be all ancestors
>>> of the "bad" commit. For example if you have a "master" branch and a
>>> "dev" branch that was forked from the "master" branch at one point,
>>> like that:
>>> 
>>> A-B-C-D-E <-- master
>>>     \F-G <-- dev
>>> 
>> 
>> I don't understand how this can only be one way?  Isn't this symmetric?  In
>> other words, how is it different from
>> 
>> A-B-C-D-E <-- dev
>>    \F-G <-- master
>> 
>> as far as bisect is concerned? Or maybe I am not entirely clear on what you
>> are saying.
> 
> Yes, it is symmetric, so we cannot just automatically reverse the
> meanning because there is no "after" or "before" relationship between
> "dev" and "master".
> 
> Best regards,
> Christian.


I think I understand.  What if something works in A, gets broken in C, stays broken in E, but gets fixed in G?  Should it maybe be implied by whichever one is marked as good first, A or G, if you trying to find the fix or the break?

If no, I think --reverse is actually a suitable fix.

Aaron Meurer