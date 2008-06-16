From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Implement a new patch identification scheme and id command
Date: Mon, 16 Jun 2008 14:30:32 +0100
Message-ID: <b0943d9e0806160630m12f5bc7x39053e6c81d983c0@mail.gmail.com>
References: <20080614072833.7899.91460.stgit@localhost.localdomain>
	 <20080614094714.GC14282@diana.vm.bytemark.co.uk>
	 <b0943d9e0806160300q55dde16fg90de0fa12e3d5dc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 15:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Enx-0002yg-Hv
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 15:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbYFPNae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2008 09:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbYFPNae
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 09:30:34 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:23275 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbYFPNad convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 09:30:33 -0400
Received: by py-out-1112.google.com with SMTP id p76so1993097pyb.10
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oehXpd9QnnH1+mvkGF+O1wNFvvOo3mWgc4ja0j1FvF4=;
        b=hMWGUdZbxGhW4aG1YKkw0FYAfYXYjFbOZk3vcaTicIgJAsiL/AJBnypqVanFEtarDk
         /jL5I0soE61u8o8/lHNDGlZh0R3FUCqaJwnUZ6lMFhwejVYHYGrMaPpSAO+RgRwr1p73
         +JhmNeq5YkpgC5QSbsAI2W3gOrqraa5Fgv308=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nLAXWKYfbuZLdJ61tAWsnc4WaOPRfJS7ykMXOn0HgOrUVX8kPIKXOdy7yNygIs7Ona
         KjnnBbHCAhlbd4fIzsF1vmq9kA/PuTR1YkNxQEnLt9dnczfIN7xKrsnL8FspTUdcBrCK
         54bBt76ktdaAvqU1DGyaIWTwL1OcyO6RTRTJI=
Received: by 10.114.170.1 with SMTP id s1mr6151566wae.133.1213623032224;
        Mon, 16 Jun 2008 06:30:32 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Mon, 16 Jun 2008 06:30:32 -0700 (PDT)
In-Reply-To: <b0943d9e0806160300q55dde16fg90de0fa12e3d5dc0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85188>

2008/6/16 Catalin Marinas <catalin.marinas@gmail.com>:
> 2008/6/14 Karl Hasselstr=F6m <kha@treskal.com>:
>> On 2008-06-14 08:28:33 +0100, Catalin Marinas wrote:
>> You don't remove the old parse_rev() and git_id(), and particularly
>> the latter has a lot of callers. Meaning that the rest of StGit stil=
l
>> speaks the old syntax.
>
> I thought about removing them when we convert the commands to the new
> infrastructure. In the meantime, I can rewrite git_id to use
> git_commit directly. The parse_rev is only used by the 'pick' command
> (and git_id). I'll have a look at these functions.

Done that - git_id/parse_rev now use the new id mechanism. Eventually
we'll drop git_id once all the commands are converted.

>>> -directory =3D DirectoryHasRepository()
>>> +directory =3D common.DirectoryHasRepositoryLib()
>>>  options =3D [make_option('-b', '--branch',
>>>                         help =3D 'use BRANCH instead of the default=
 one')]
>>
>> Couldn't we kill this option? (And in the process, the branch argume=
nt
>> to git_sha1.)
>
> No problem with the option but I would like to keep the branch
> argument to git_sha1. There might be cases where it is used like
> picking multiple patches and I only specify one -B option to 'pick'.

What about supporting patch ranges with the new id format, something li=
ke:

  branch:patch1..patch2,patch3

or

  branch:patch1..patch2 branch:patch3

The following can be valid as well but patch3 may be on a different bra=
nch:

  branch:patch1..patch2 patch3

This way we could get rid of many --branch options.

--=20
Catalin
