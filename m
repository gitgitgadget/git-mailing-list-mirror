From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: checking sha1's of files
Date: Sun, 8 Feb 2009 05:53:31 -0500
Message-ID: <81bfc67a0902080253x5082201co7da3319b8237f5a0@mail.gmail.com>
References: <81bfc67a0902080139j1331d967g34bfc18f4068e443@mail.gmail.com>
	 <7veiy9z1v8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW7JW-0005X7-Pf
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbZBHKxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbZBHKxe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:53:34 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:34074 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbZBHKxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:53:33 -0500
Received: by qyk4 with SMTP id 4so2070550qyk.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 02:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q23lDWCdIhInLhfNBynUYOBICHuTB3LJKX4f5D+nQbI=;
        b=C107Zcs8XTGywlbr8xRDOADSS09Ksjgo6gDBqVWpTWb0oXxDVOj+c+KRXPtkX+ixuV
         VPq4VcVnuSfVsENjl/W295e4YjYGtrBMJksAspewoFreUjeHkCa5qwckw7EHg1P8h+GS
         qMWatC6R7EIVnWgntzyYkY0PN4wfD4bgPZUhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H88daXuyDnkny4ocKUFn95RlV9UBQ4nLBWartikKAVxQouwDV4up/5CDNHCnGrJig4
         x84Nwdstde5m+cInCGXcMOIDB50U/Y2+4HWcZhmusmXrkyNKSWisct/LELVPUqIUPQt1
         yRYJWZgAKKmdoMlKYIG2TMuNIkw/eEXgwvDgA=
Received: by 10.229.100.7 with SMTP id w7mr998163qcn.5.1234090411629; Sun, 08 
	Feb 2009 02:53:31 -0800 (PST)
In-Reply-To: <7veiy9z1v8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108952>

On Sun, Feb 8, 2009 at 4:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Caleb Cushing <xenoterracide@gmail.com> writes:
>
>> I need to check the hashes of specific files in the repo in an
>> automated fashion, in another tool.
>
> What "hash" are you talking about?  sha1?  md5?  crc?

just at at a vague glance currently sha1, sha256, and rmd160 if I'm
reading the manifest file correct.

> I *think* you are trying to say that gentoo has a tool to compute some
> sort of hash for regular files in their source tree by:
>
>        "gentoo's portage tree has manifests for each file"
>
> but without knowing what kind of hash they use, I cannot tell you if you
> can reuse some part of git to compute their hash without using their tools
> (it also is unclear why you are not using their tool to compute their hash
> and instead are expecting git to know about the specific hash function
> used by them).

I think you misunderstand. I'm not trying to use git to compute their
hash, I'm trying to replace their hash with git. Once I've figured out
how to validate the git hash with 'emerge' (said tool) I will be
removing their hash's.

> For exammple,
>
>        "sha1sum Makefile"
>
> would give you the SHA-1 checksum of the contents of the Makefile.  Is
> that what gentoo's tools expect?

I'm honestly not sure how all it's calculated, only that the gentoo
tool will have to be modified, only part of the Manifest file that
will be left is the check that is used to validate files not in the
tree (e.g. our distfiles, package tarballs)

> If that is the case, that is different
> from the blob object name git will give to the contents of that Makefile,
> so you cannot reuse much of git.
>

git has it's own internal integrity check right? on the blob's.

I don't intend to make git fit gentoo's system, I intend to make
gentoo (or regen2 rather) use git's integrity system. but integrity
checks are only a small part of the larger tool. I have the feeling
that I will have to write code on both ends to make it work. Gentoo
uses rsync and no git repository, so to validate integrity they use
files with recorded hashes in them. as I understand it git hashes the
files (blobs) internally, so now that we've imported the rsync tree
and started using the 'git' protocol we're really doing the same thing
twice, and recording it more than that.

has this explanation helped?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
