From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Thu, 6 Aug 2009 19:39:58 +0200
Message-ID: <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private>
	 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
	 <4A7AEFA8.5010001@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 06 19:40:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6wg-0008T3-7G
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408AbZHFRj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbZHFRj6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:39:58 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:36048 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615AbZHFRj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:39:58 -0400
Received: by ewy10 with SMTP id 10so967802ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dxY4vhepoW2RPl3mmKJ8e4BqOxfLXcGe9y3UUX8G8J4=;
        b=w5CRA1+sisveJbpBpJXte58Hvix6GX5y7x8BBnPn5XvkMzSpdl/ZKWW1ScWtStBI4D
         TaZ0F9ffxGPMd947B3YF2mImjXU1O/8f29Twelwzfi0Kl9bhQnVt4ohVZ/DPQZ6gUpuy
         fE0y57WYqMblVxuVFctQqNNIA7RAd4fY7Iv9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bwa2FFZc8RgGKZz7/JghqF3K6SNj+CuaAwyH4skupzxjehE9vwUB99nP6PsEj0+pfZ
         F+eilu9NThPTNA2ZHQs5FRAG5sMxT0dAf3W+wWDY7Fx48BCy0dN3Gr4wxJ/DnP12sGFF
         XRTJ9pf7YK2ROFU2X8fY23ySGFP2Z7pubB1vo=
Received: by 10.216.73.193 with SMTP id v43mr24087wed.157.1249580398110; Thu, 
	06 Aug 2009 10:39:58 -0700 (PDT)
In-Reply-To: <4A7AEFA8.5010001@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125099>

Hi there,

> Sorry, I forgot the details, could you quickly remind me why these caches
> are not in the pack index files?

Er, I'm not sure what you mean.  Are you asking why these revision
caches are required if we have a pack index, or why they aren't in the
pack index, or something different?  I'm thinking probably the second:
the short answer is that cache slices are totally independant of pack
files.

It might be possible to somehow merge revision cache slices with pack
indexes, but I don't think it'd be a very suitable modification.  The
rev-cache slices are meant to act almost like topo-relation pack
files: new slices are simply new files, seperate slice files can be
fused ("repacked") into a larger one, the index is a (recreatable)
single file associating file (positions) with objects.  The format was
geared to reducing potential cache/data loss and preventing overly
large cache slices.

>> Hmpf.
>>
>> We got rid of the last Python script in Git a long time ago, but now two
>> different patch series try to sneak that dependency (at least for testing)
>> back in.
>>
>> That's all the worse because we cannot use Python in msysGit, and Windows
>> should be a platform benefitting dramatically from your work.
>
> In fact, the test the script performs could be easily rephrased with
> "sort", "uniq" and "comm".
> OTOH: If the walker is supposed to return the exact same orderd list of
> commits you can just use test_cmp.

The language that script is written in isn't important.  I originally
wrote it in python because I wanted something quick and wasn't much of
a sh guru (sorry :-/ ).  As Micheal said I've no doubt it can easily
be converted to shell script -- in fact, I'll try to get a shell
version working today.

 - Nick
