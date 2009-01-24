From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Sat, 24 Jan 2009 20:26:05 +0100
Message-ID: <8c5c35580901241126q2da83f50m1472ed017b92c982@mail.gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-4-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
	 <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
	 <alpine.DEB.1.00.0901232054360.21467@intel-tinevez-2-302>
	 <8c5c35580901240044y452b465fj94df82fc2b8f7ee9@mail.gmail.com>
	 <alpine.DEB.1.00.0901241443270.13232@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 20:27:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQoAH-0008Sx-4J
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbZAXT0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZAXT0J
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:26:09 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:30938 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbZAXT0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:26:07 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5248523rvb.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 11:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zzk3Umc/ClD9vAWTBYL1Oxjos4MlcuEonCrGzEi9GG0=;
        b=eL93nXGRa7lxHD1LAzhRLNxZQgDX+vnSfWoFsi/U1aeSbx5wc88G3noOO3ZzqgVcdt
         PoUTZajXJmsz0FtPZmNdemh7XJN7kk2gehgvKnGWAsgR5vBIWW0SU/OxnIgRJHQPnvUJ
         LzpmzhT2AgFnFEMHYZq1hsc0DiiCP8wj+FC4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wJy797PQ6z6AlUeLhajPHv/yNSxyWB1i7HxEdz2mQZ571GErELggG1gpC1DHr5VIfz
         BCVVFq4Xt2xZCWL7TugYWxYdChApoR7W97kBuFyAz7vlQhu2JGKABh3bJR2i1H/4RILr
         euhgZJTdp66o+7FlfBUMY9e568iTxel3fTSSE=
Received: by 10.115.16.14 with SMTP id t14mr65985wai.185.1232825165936; Sat, 
	24 Jan 2009 11:26:05 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901241443270.13232@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106994>

On Sat, Jan 24, 2009 at 14:51, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Now, there is still a problem when your submodule is missing the objects
> for the commit your superproject is referring to.
>
> IMO that is a serious issue, as it just asks for confused users.

This made me finally understand your concern (sorry for being slow):
you want the command to behave in a predictable/consistent way while
my implementation would end up making an archive with basically random
content.


>> > - presence of a specific commit in the supermodule is a _lousy_
>> >   indicator that the user wants to include that submodule in the
>> >   archive.
>>
>> This is the issue I tried to address with my
>> `--submodules=[a|c|r][g:<name>]` proposal in the commit message for
>> this patch.
>
> Nope, doing this "in the future" does not please me one bit.
>
> Besides, I find the semantics, uhm, "interesting".  (The other word would
> be "unintuitive".  Why do you have to be so cryptic that I have to read
> the proposal to understand what the heck "c" is about?)

I thought it would be nifty to be able to combine different flags
which would affect the behaviour/semantics of the command, but given
the comments from you and Junio, I think I'll end up with something
like this:

$ git archive --submodules <tree-ish>: Create an archive which
includes the trees of all gitlink entries in <tree-ish>, fail unless
all the required objects are available.

$ git archive --submodules=<group>: Same as above, but only traverse
submodules in the specified group (as defined in $GIT_CONFIG).

--
larsh
