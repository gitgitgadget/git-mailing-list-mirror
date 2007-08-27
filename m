From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: .gitignore, .gitattributes, .gitmodules, .gitprecious?,.gitacls? etc.
Date: Mon, 27 Aug 2007 13:27:48 -0700
Message-ID: <a1bbc6950708271327x4dd948d4m8e9e35f757a7d92e@mail.gmail.com>
References: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org>
	 <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
	 <20070826100647.GH1219@pasky.or.cz>
	 <4C603F7C51884DF8AFAEC3F6E263798D@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 27 22:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPlCL-0006U7-HW
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 22:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763521AbXH0U1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 16:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763519AbXH0U1v
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 16:27:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:38995 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763511AbXH0U1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 16:27:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1192785nze
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 13:27:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XCV84uYPokFsO9oroOO/H7zlkKlnruvW930HejYilHcd3pqwwhipBdEqihUGVZZjIx5J8PCdwSxrSKsBmhcqE2lP0B7eXZKoA7kgml83AJkrerLlw7Iv28eH+ybjQRhZHhQGmAMm8KpnkVF/uo6oEsrPodD2KxrA23O81zojq2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MyH/cIVlnlEFQKkifo78K0gWmL0Kv4dZ0Y/iXlNjoPxo2Ng0Ly+h+NvwI/tuu0azEAgujPKVfc2uhU5R2MyyK5x1XFLysHkmz8L0A7ulCWe9X0YvMz12YHOi2d7Zz9NSQy66WG+4qnAumso8ISYYaHgGtt/Y5Bz1D/WuE/bGMVY=
Received: by 10.140.144.4 with SMTP id r4mr3024725rvd.1188246468786;
        Mon, 27 Aug 2007 13:27:48 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Mon, 27 Aug 2007 13:27:48 -0700 (PDT)
In-Reply-To: <4C603F7C51884DF8AFAEC3F6E263798D@ntdev.corp.microsoft.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56877>

----- Original Message -----
From: "Petr Baudis" <pasky@suse.cz>
> On Sun, Aug 26, 2007 at 10:02:50AM CEST, Dmitry Kakurin wrote:
>>>> My knowledge of Git internals is quite limited, but if *I* were to do
>>>> it right now, I'd introduce a META entry in every TREE object that
>>>> would point to a BLOB that contains combined content of
>>>> .gitattributes, .gitignore etc.
>>> A tree that has .gitattributes (and I am assuming in the longer
>>> term you can use "ignore" and "precious" in .gitattributes
>>> instead of using .gitignore) POINTS TO A BLOB already, so what
>>> you are saying does not add anything to what we already have,
>>> other than that you are renaming .gitattributes to "META ENTRY".
>>
>> Almost true! The difference is: META BLOBS are not created as files in the
>> workspace (not during checkout, not ever).
>> In order to edit it you'd have to use 'git meta' command.
>> So once again, there is only one place to check for metadata - the index.
>
> It's still not clear to me how this would help anything, though I didn't
> watch late Git development. Can you explain some particular scenario
> where this would improve the current situation?

Here is the problem: we need to apply crlf attributes to a file. We
could have .gitattributes both in the index and in the worktree.
Which one do we use?
In general .gitattributes file could be (U)nchanged, (C)hanged, (NP)
NotPresent in each place.
This gives us 3x3 matrix = 9 special cases to handle. When you think
about this a little more you realize that even that
is not enough and we need to take into account direction of data
movement (index -> filesystem or vice versa).
This doubles the matrix to 18 cases. Even if we come up with a very
good choice for every case (which is doubtful)
there is no way this could be *easily* explained to end user, or even memorized.
This leads to a simple idea that mostly works:
1. when files are moved from index to filesystem, then only
.gitattributes in the index is used, if it's not there == no special
attributes.
2. when files are moved from filesystem to index, then only
.gitattributes in filesystem is used, again if it's not there == no
special attributes.

Then, in any operation, only one .gitattributes is taken into account.
We could stop here, but to me this redundancy still has some room for
confusion and looks unnecessary.
Plus there is still room for unintentional abuse (by mistake).

That's why I think it's a good idea to always have only one .gitattributes.

- Dmitry
