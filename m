From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 7 Feb 2010 15:32:05 +1100
Message-ID: <2cfc40321002062032g1e0afd66la7ac4a26295bd817@mail.gmail.com>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
	 <201002070236.12711.johan@herland.net>
	 <2cfc40321002061927m522f0c3aj7d727c47a2f0cb22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 05:38:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdyuM-0000sM-59
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 05:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab0BGEcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 23:32:09 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:56359 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0BGEcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 23:32:06 -0500
Received: by pzk17 with SMTP id 17so1090915pzk.4
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 20:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KoW5iiRf13tI4aWoUg6onQne1fSeDf9sTh346azWeCM=;
        b=NeoZj3G/kOTWjoX9XBdrDTP0LqR9+rcN3g4r5aYZeCUCIpBNuMyDBBUMGuW1TXZcLO
         dKBbTns+kb/VxBKLb7GROv+rmP0RVAqaHfDOmFEMS4ISjcr56yGrlP2CcahZzHSZE/ZE
         7m/B76q0xKUc642kLVm3Q65lQNxZ6ozzyAfG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ctqSDzCkK8oNQ9xG7Qg6fJ9eD9u1fa1ow+h6J0KcJ1AghrCVqlTr17BH7WRfikCbOZ
         EAfCgyMPHakF547qp9jdzKWecr88Op3G4iesSrZFrjHnxW0ziAjR81cNzUFXjay9DNls
         QPoLWlUNl84LvvU+sH89ZDjXUaYDoLvuDEKFs=
Received: by 10.114.70.3 with SMTP id s3mr3220372waa.83.1265517125504; Sat, 06 
	Feb 2010 20:32:05 -0800 (PST)
In-Reply-To: <2cfc40321002061927m522f0c3aj7d727c47a2f0cb22@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139215>

Another use case could be to store the contents of the man and html
trees of git, which are currently published as separate branches.

With the metadata concept, the man and html trees for each release
could be stored as metadata paths (/man, /html) of the associated
commit for each release, providing a trivial way to address and access
these trees.

jon.

On Sun, Feb 7, 2010 at 2:27 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
>> I still don't see why this provides anything that isn't already supp=
orted by
>> either using 'git tag', or by implementing support for notes-as-tree=
s in the
>> notes feature.
>>
>
> The intent of the metadata facility is to associate derivatives of
> sha1 with the sha1 itself. If I have calculated a derivative of sha1
> in the past, then let me reference that derivative using a metadata
> path which I can look up knowing only the sha1 of the input and
> nothing more. Yes, =A0I could create tags of the form
> ${sha1}/metadata-path for all my derived results but really, this
> seems an abuse of the tag facility.
>
> Here's another motivating example:
>
> Suppose git-svn wrote the SVN id it was synched with into structured
> metadata associated with a commit, instead of into the commit message=
,
> the equivalent of:
>
> =A0 =A0echo ${svn-id} | git metadata write-blob ${sha1} svn-id
>
> Which means: for the specified sha1, read a blob from stdin and creat=
e
> a metadata item with a metadata path called svn-id
>
> To get it out again, you would write:
>
> =A0 =A0git metadata read-blob ${sha1} svn-id
>
> Which says, for the given object ${sha1}, read the blob from the
> metadata tree at path svn-id and write its contents to stdout.
>
> This would avoid cluttering the commit message with the svn-id, avoid
> cluttering the tag space with the info and allow any commit to be
> tagged in this way.
>
> Admittedly similar function could be achieved a little more clumsily
> now with appropriate use of GIT_NOTES_REF or with note subtrees, but =
I
> share Junio's =A0reservations about trying to generalize notes from
> blobs to trees, given way notes are currently used by the rest of
> infrastructure.
>
> jon.
>
