From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Question about --tree-filter
Date: Wed, 04 Feb 2009 21:42:46 +0100
Message-ID: <4989FDC6.2080404@gmail.com>
References: <loom.20090204T155824-858@post.gmane.org> <4989C437.4070401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 21:44:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUobn-0003my-GP
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbZBDUmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbZBDUmu
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:42:50 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:45276 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbZBDUms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:42:48 -0500
Received: by ewy14 with SMTP id 14so3877944ewy.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hbx7jxyuKbRga8zC7MnGeWO0Gm/uf56bHEgkcDTJYPM=;
        b=Xbin0nIqis2o13IcKyeEOCZWAOpPG7dqkfkTgJogo/IHqv7ynL1kqc2JkeZydn8kEc
         3/OgVmRXhe1hT2D+Ps/Dac4+wYfQf1BpC8lQh+Su+YfioPUOa/wKMD6Nq68SLOuXpyMt
         3n7jOaLOQQFAOvqqh63GbBG4BdV5HaFPHE6wM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=PzCVFLA1xDjl3Qr0+xz2Uy2zjW6l0AZ8nMaTqZZzEuPvCj2AsZ7EEnHLVVCziRE4Fa
         xChoiInPLyFU+1sA2cJNkzErSigsjdiTXoha/fr6bmX4jtw4+HYCoD7Ca8X/aaGIeTus
         dTWYF19zzjv6tLv7tp/NSFjgn2fCRtbE3MaDc=
Received: by 10.103.251.3 with SMTP id d3mr3175604mus.72.1233780166428;
        Wed, 04 Feb 2009 12:42:46 -0800 (PST)
Received: from ?10.143.20.193? (mars-fw.arces.unibo.it [137.204.143.2])
        by mx.google.com with ESMTPS id 23sm2770537mum.7.2009.02.04.12.42.45
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 12:42:45 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <4989C437.4070401@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108429>

Johannes Sixt wrote:
> Sergio Callegari schrieb:
>   
>> in working with the "rezip" filter for the efficient git management of
>> openoffice, zip and docx files, I am encountering the following problem.
>>
>> Suppose that you have an existing repository and that you want to convert it
>> into a repository using the rezip filters: git filter-branch should be the tool
>> to do the conversion.
>>
>> Initially I believed that once set up the appropriate .git/config filter entries
>> and a .git/info/attributes file tying the filter to the appropriate file types,
>> it would have been enough to
>>
>> git filter-branch --tree-filter true tag-name-filter cat
>>
>> to do the conversion.
>> This is also what I suggested in my original post about the rezip script.
>>
>> Unfortunately, this does not seem to work as expected.  Not all files get
>> rewritten as filtered blobs.
>>     
>
> Before the tree-filter runs, the files are checked out (and smudged by
> rezip). But they are marked as unchanged (because they were checked out
> moments ago). Since your tree-filter doesn't do anything, no new blobs are
> added to the index, and none of your files are cleaned by rezip.
>
> I think your brute-force tree-filter should be
>
>    rm -f "$GIT_INDEX_FILE"
>
> assuming that a .gitattributes file is already in all revisions.
>
> -- Hannes
>   
Sorry, it still is not completely clear to me... I would be very glad if
you could detail better what happens when I tree-filter.  From what you
say I get the impression that no file should get a new blob.  As a
matter of fact, most do (and that is why at the very beginning I thought
that --tree-filter true would have been sufficient)... only a few do not
get the new blob.

And if I experiment filter-branch again, with exactly the same
parameters, apparently some of the files that did not get the new blob
in the beginning do...  which looks completely weird.

The attributes are in the info subdir of .git, so the brute force
approach should be fine.  I guess that it does not make any difference
wrt to a

    find ./ -type f -exec touch \{\} \;

apart from looking slightly more aggressive to the index (and faster) or
does it?

Sergio
