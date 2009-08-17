From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 18:01:58 +0200
Message-ID: <200908171802.00588.jnareb@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4YH-0008UM-KC
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 17:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270AbZHQPzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 11:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbZHQPzD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 11:55:03 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:64050 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbZHQPzB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 11:55:01 -0400
Received: by qyk34 with SMTP id 34so2228581qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YcFT0DXZsz5aYWW/VCPCpI4SMAkATcIf+fOupbEx084=;
        b=fZ4cxf097t62ygqYmkw+X7rY75EaJ+hK2y+u9LTDZd6T2weg6uy1VYl5EWDhIrTG3s
         EWIy1Ttz19HN1700KgazvhDkQcMFGHsrmPAz+TK+flEaPbf/Y8NBj0CbLx+niC2WsApG
         iNQsDSPA/++AkfuoZziQi379SYCOfHEuzqRio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HatdFp+wX4Q04/2f9vrUe7tEqmge+iYIWP93X/Yeg+2/PryVqJQy7lv7M/CDQFZGu4
         esmf5XsbXNO8UoXvYc4hmv3qZ4EJSgtMh1m6P2uC28N6Kn+O23v3385jrS5rfZy9WuCw
         t3dzqkW4pyQHZAVLt2gQJaI9n2CmXKSqe01jw=
Received: by 10.224.94.78 with SMTP id y14mr4321851qam.216.1250524502179;
        Mon, 17 Aug 2009 08:55:02 -0700 (PDT)
Received: from ?192.168.1.13? ([72.14.241.5])
        by mx.google.com with ESMTPS id 7sm8455206qwb.14.2009.08.17.08.54.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 08:55:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126197>

On Sun, 16 Aug 2009, Johannes Schindelin wrote:
> On Sun, 16 Aug 2009, Jakub Narebski wrote:
>> On Sat, 15 Aug 2009, Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>> 
>>>>>> Hmmm... this looks like either argument for introducing --full 
>>>>>> option to git-checkout (ignore CE_VALID bit, checkout everything, 
>>>>>> and clean CE_VALID (?))...
>>>>>>
>>>>>>  ...or for going with _separate_ bit for partial checkout, like in 
>>>>>>  the very first version of this series, which otherwise functions 
>>>>>>  like CE_VALID, or is just used to mark that CE_VALID was set using 
>>>>>>  sparse.
>>> 
>>> How would a separate bit help?  Just like you need to clear CE_VALID 
>>> bit to revert the index into a normal (or "non sparse") state somehow, 
>>> you would need to have a way to clear that separate bit anyway.
>>> 
>>> A separate bit would help only if you want to handle assume-unchanged 
>>> and sparse checkout independently. But my impression was that the 
>>> recent lstat reduction effort addressed the issue assume-unchanged 
>>> were invented to work around in the first place.
>> 
>> Well, if we assume that we don't need (don't want) to handle 
>> assume-unchanged and sparse checkout independently, then of course the 
>> idea of having separate or additional bit for sparse doesn't make sense.
> 
> For the shallow/graft issue, we had a similar discussion.  Back then, I 
> was convinced that shallow commits and grafted commits were something 
> fundamentally different, and my recent patch to pack-objects shows that: 
> shallow commits do not have the real parents in the current repository, 
> and that makes them different from other grafted commits.
> 
> Now, if you want to say that assume-unchanged and sparse are two 
> fundamentally different things, I would be interested in some equally 
> convincing argument as for the shallow/graft issue.
> 
> There is a fundamental difference, I grant you that: the working directory 
> does not contain the "sparse'd away" files while the same is not true for 
> assume-unchanged files.
> 
> But does that matter?  The corresponding files are still in the index and 
> the repository.
> 
> IOW under what circumstances would you want to be able to discern between 
> assume-unchanged and "sparse'd away" files in the working directory?

>From what I understand it, assume-unchanged is performance optimization.
Sparse checkout is about files which are (assumed to) not be in working
directory, which means that they have to be assume-unchanged for git to
not try to access working area version of files which aren't there.

$GIT_DIR/info/sparse (or how it would be named; the name 'sparse' 
doesn't tell us whether patterns are about the files that are checked
out, or are about files which are not present in working directory)
is about specifying which files to checkout with "git checkout --sparse"
(or core.sparse / checkout.sparse = true).

> I could _imagine_ that you'd want a tool that allows you to change the 
> focus of the sparse checkout together with the working directory.  
> Example: you have a sparse checkout of Documentation/ and now you want to 
> have t/, too.  Just changing .git/info/sparse will not be enough.
> 
> The question is if the tool to change the "sparseness" [*1*] should not 
> change .git/info/sparse itself; if it does not, it would be good to be 
> able to discern between the "assume-unchanged" and "sparse'd away" files.
> 
> Although it might be enough to traverse the index and check the presence 
> of the assume-unchanged files in the working directory to determine which 
> files are sparse, and which ones are merely assume-unchanged.

There are quite a few possibilities: file can be marked "sparse" in
index (which also implies also marking it "assume-unchanged", if 
"assume-unchanged" doesn't work alone as "sparse" index bit) or not,
file can match 'no-checkout' pattern in $GIT_DIR/info/sparse or not,
file can be present in working directory or not:

 * match no-checkout
   - assume-unchanged
     + present in working directory
     + absent from working directory
   - no assume-unchanged
     + present
     + absent
 * doesn't match no-checkout
   - assume-unchanged
     + present
     + absent
   - no assume-unchanged
     + present
     + absent

> Footnote [*1*]: I think we need some nice and clear nomenclature here.  
> Any English wizards with a good taste of naming things?
 
English is not my native language, but what about:

 $GIT_DIR/info/
    no-checkout
    exclude-checkout
    workdir-exclude
    ignore-change
    assume-unchanged
    ghosts
  
-- 
Jakub Narebski
Poland
