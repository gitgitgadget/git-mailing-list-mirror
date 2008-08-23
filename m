From: Thomas Harning <harningt@gmail.com>
Subject: Re: Best method of detecting if list of commit refs is a parent
Date: Fri, 22 Aug 2008 22:24:44 -0400
Message-ID: <85B8045C-A137-4D6C-A724-AA9A281620CD@gmail.com>
References: <e47324780808171924j237688faj9e13740f89e75fdf@mail.gmail.com> <7vfxp3ndec.fsf@gitster.siamese.dyndns.org> <17B524E9-FDF9-4585-AFBD-A5304E3A4AA6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 04:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWipt-0005fx-GQ
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 04:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbYHWCYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 22:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYHWCYt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 22:24:49 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:54267 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbYHWCYs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 22:24:48 -0400
Received: by py-out-1112.google.com with SMTP id p76so520547pyb.10
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=xQ8E3FIyJGrNcFin3PA9YfbbHoxND1Lo88Gv1Azq2h8=;
        b=ajkIs+Fh78yUmoYQjd2OEK8vldU4lXf2oJdJk2DYrwFLxindiiecPmZzneU7St8VsL
         whPr1ZLdEyiiv7xCzAvzBfK8eXxmo4rYMDVHI+3AcRppSMjK7MFD9526PU/w37kv0d83
         NGv3fQB4L9qOTLJMyojpiQpv2Myx4gl6B7GNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=v0REDWEpEribbsyYO0AmA3omxUqCTamH2X1V4CGBvl1MrWZyIhVLJUuOwibsAQEToY
         o5AIQat6a1mkNdfbr85zYqrg2ya9fdyE15MNcDSkLtT2J+Xh4sj3BcEyTJdduJxpP+sN
         N40I8gfeLdibSX3uT7T7LQrFoas64SOElsh/g=
Received: by 10.65.242.7 with SMTP id u7mr2429760qbr.51.1219458286496;
        Fri, 22 Aug 2008 19:24:46 -0700 (PDT)
Received: from ?192.168.1.203? ( [69.245.237.85])
        by mx.google.com with ESMTPS id k7sm3428857qba.3.2008.08.22.19.24.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 19:24:46 -0700 (PDT)
In-Reply-To: <17B524E9-FDF9-4585-AFBD-A5304E3A4AA6@gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93414>


On Aug 18, 2008, at 9:37 AM, Thomas Harning wrote:

> On Aug 18, 2008, at 12:41 AM, Junio C Hamano wrote:
>>
>> If you have bunch of commits A B C D E F and if you would want to  
>> know
>> which one of them is reachable from X, you could of course run  
>> merge-base
>> once for each of A..F.  Another way to do this would be to run:
>>
>> 	git rev-list A B C D E F ^X
>>
>> and look at the output.  The ones among A..F that appear in the  
>> output are
>> not reachable from X.  The ones that are reachable from X do not  
>> appear in
>> the output.
>>
>> This is because "rev-list" outputs everything reachable from the  
>> given
>> commits without ^ prefix, excluding the ones that are reacahble  
>> from the
>> ones prefixed with ^.
> Perfect!  Now... is there built-in way to invert this to list those  
> that 'are' reachable..... Or would the inverse really end up  
> calculating the difference between input list and output list?
>
Hmm... looking at this, git rev-list will also spit out tons of  
'unimportant' commits so bulk handling could be messy.

Given the following general feature/function specifications.. perhaps  
new functionality to git needs to be coded.... or somehow external  
code linking into git needs to be coded (best way to do this?...)

1) Given list of X references, which are in the ancestry of Y?
2) Given list of X references, which are in the ancestry of set Y  
references? (multi-map X->Y)
3) Given reference X, which of set Y are descendants?


Example tree:

          B--o--F
         /
  A--o--O--C--o--o
         \        \
          D--o--o--E

1) X = (A B C D E F)
    Y = F
    OUTPUT: A B F
    Y = E
    OUTPUT: A C D E

2) X = (A B C D E F)
    Y = (A B C D E F)
    OUTPUT:
    A->A
    B->A, B
    C->A, C
    D->A, D
    E->A, C, D, E
    F->A, B, F
3) X = A
    Y = (A B C D E F)
    OUTPUT:
     A B C D E F
    X = C
    OUTPUT:
    C E

It looks like one could calculate these using git rev-list.. but the  
path list could either get quite full of items to handle..
You could also calculate M*N  git rev-list/merge-base to check  
ancestry/decendency...
