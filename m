From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Individual file snapshots
Date: Sat, 13 Feb 2010 10:13:45 -0500
Message-ID: <ca433831002130713i5b015686k9f53911954858845@mail.gmail.com>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> 
	<ron1-519083.13253112022010@news.gmane.org> <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com> 
	<ron1-62D136.13570812022010@news.gmane.org> <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com> 
	<ron1-5EFFD7.14390512022010@news.gmane.org> <ca433831002121633j5b96049bs71e539c96397aff4@mail.gmail.com> 
	<7v6362c672.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ron Garret <ron1@flownet.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 16:14:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgJhM-00064K-9R
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 16:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320Ab0BMPOJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 10:14:09 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:43587 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab0BMPOG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 10:14:06 -0500
Received: by yxe34 with SMTP id 34so1451039yxe.15
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 07:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3qJ+Aj3mPJQ8kNWOetr5dw8DJnFSh5P++OWn/z+EWjM=;
        b=Ar23U3VUVaRCQns63qgfDPl9k7RS5nA2H/CF06rLjcPNIU65ckWkfc9pMiAIwdpc+j
         RzDaGrEcqjnmV8GaJZrHa02HZJyAjKA5aviYYO09pLf9x9VBb/IWBU0zwxZQWBObtc9H
         PfMAgSFJ1BMxS+EhQafeVA/ezpeRzgPVhe4MU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CKOtL+qTRiu3f9ozqIsnpI8gOPjQeJjaZDikK4R/7NN/ZSD78vzkf3dn5Mq47mqydl
         gDdX8wbg8BXCdfSzQhq84Km4pwHDKp2Ma6dBAbkkLpP6BQEuv4C0IqVEi7HUZBIw+Wg2
         gMHPIblEzN0bZ4yVYz1J0whLpHOd4PFTXgUjE=
Received: by 10.150.209.11 with SMTP id h11mr1317584ybg.300.1266074045422; 
	Sat, 13 Feb 2010 07:14:05 -0800 (PST)
In-Reply-To: <7v6362c672.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139806>

On Fri, Feb 12, 2010 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> The basic steps are:
>>
>> backup .git/index
>> git add -a
>> git write-tree
>> git commit-tree
>> restore .git/index
>
> Instead of doing that, you might want to consider
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_INDEX_FILE=3D...some-temporary-file...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0export GIT_INDEX_FILE
>
> and run everything as if that is the index throughout your script. =C2=
=A0That
> way, if your script ever failed in the middle, you won't have to worr=
y
> about a broken index file.

In the actual script, I copied the index file back if any error
occured.  Still, your idea sounds better, so I just updated it to use
this variable instead.  I still remove the temporary file on error,
but if something goes wrong, at least the index won't be hosed.


On Sat, Feb 13, 2010 at 2:01 AM, Ron Garret <ron1@flownet.com> wrote:
> Moving the index around seems kinda hacky.  You probably want git-mkt=
ree.

git-mktree is way too complicated.  I would have to parse the index
and call git-mktree for each directory.  There is already a program to
do this: git-write-tree :)  Besides, using GIT_INDEX_FILE as suggested
by Junio allows me to leave the original index file intact.

--
Mark
