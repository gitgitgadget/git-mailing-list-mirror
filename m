From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Sat, 24 Jan 2009 09:44:35 +0100
Message-ID: <8c5c35580901240044y452b465fj94df82fc2b8f7ee9@mail.gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-4-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
	 <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
	 <alpine.DEB.1.00.0901232054360.21467@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 09:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQe9T-0000KF-Le
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 09:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbZAXIoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 03:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbZAXIoh
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 03:44:37 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:49574 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbZAXIog (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 03:44:36 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5096945rvb.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C9o/PvJJXb0H4jlPfQdMoqZqjzrXhqy7FoKXDK594pI=;
        b=sSQmQaf4GNhG7tMLyFNHgcQ5tOBtPblR8MzNb7ydr5++UZ1VZeheAZsoRZc+7QJUt1
         BLZ5NBCGbeDBiyH7mZKlyjSWFbZdt3XuI2yk6Uccxvpeb1JMD7+LH6g65mFbmtOXWwC6
         3QbwJgu/5CDPmUiG+c4VOsKuBCa9TqFo3TABQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ce0s18E4g5uIOUqD0V3NLh5ahN920NT+Rq2Ds+d4cKPJOADXJEe89No1u2kKuDOmtU
         /mHTjjEomEvcFOUYuVOgdbgnK6xvSQe9+4i7mXs0vLd4rD4yaaFd7l1XrDTbTv7lIEq/
         nltn3eRb6lHZkGtGOErXzD2EzC5xXo/mmWXNY=
Received: by 10.115.46.10 with SMTP id y10mr695997waj.33.1232786675200; Sat, 
	24 Jan 2009 00:44:35 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901232054360.21467@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106959>

On Fri, Jan 23, 2009 at 20:57, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Fri, 23 Jan 2009, Lars Hjemli wrote:
>>
>> That's too bad, I hoped on some feedback from you on the part of the
>> commit message which you didn't quote:
>
> Well, you ignored my comments,

I might have misunderstood your comments, but I certainly didn't
ignore them. I actually tried to come up with a solution that would
solve your concerns about which submodules to include in the archive
(which is why I hoped for some feedback on that proposal).


> so what do you expect me to do?  Be happy?
>
> There are two issues there:
>
> - presence of a specific commit object being present in the repository
>  does not necessarily mean that it is reachable by any ref, and therefore
>  can mean that the tree/blob objects are not reachable, because it could
>  be an interrupted fetch;

This part I agree with.


>  in all of Git, we try to assume that only
>  reachable objects are valid objects.

I don't think this is true (most git commands accepts their arguments
as valid objects without verifying if they are reachable from a ref).
Do you feel it is necessary to perform a reachability check of the
gitlink'd commit before traversing into a submodule tree?


> - presence of a specific commit in the supermodule is a _lousy_ indicator
>  that the user wants to include that submodule in the archive.

This is the issue I tried to address with my
`--submodules=[a|c|r][g:<name>]` proposal in the commit message for
this patch. I hoped you would find it interesting, given your comments
in http://thread.gmane.org/gmane.comp.version-control.git/106167/focus=106235
(i.e. my 'a' flag would match your 'look-in-superprojects-odb', while
the 'c', 'r' and 'g' options would address your issues about how to
select the correct set of submodules).

--
larsh
