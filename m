From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save' is omitted
Date: Wed, 19 Aug 2009 09:14:05 +0200
Message-ID: <vpqzl9wz35u.fsf@bauges.imag.fr>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr>
	<vpqws51l1hb.fsf@bauges.imag.fr>
	<20090818174509.GA27518@coredump.intra.peff.net>
	<alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de>
	<vpqtz0423jk.fsf@bauges.imag.fr>
	<alpine.DEB.1.00.0908190035140.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 09:15:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdfO9-0004Wy-79
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 09:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbZHSHOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 03:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbZHSHOT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 03:14:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56718 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbZHSHOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 03:14:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7J7BKv7021504
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Aug 2009 09:11:20 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdfMz-0001Oc-MO; Wed, 19 Aug 2009 09:14:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdfMz-0000bx-L4; Wed, 19 Aug 2009 09:14:05 +0200
In-Reply-To: <alpine.DEB.1.00.0908190035140.8306@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Wed\, 19 Aug 2009 00\:37\:20 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Aug 2009 09:11:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7J7BKv7021504
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251270680.59685@6OBMuV1XVR64eoVhp9gGDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126509>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 18 Aug 2009, Matthieu Moy wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > But it is sloppy, in that it blindly accepts options that might be 
>> > valid for several subcommands, not just "save".
>> 
>> I wouldn't call that sloppy. 'save' is the default command, if you don't 
>> provide any command, then 'save' will be used.
>
> 'save' might be the default command, but we don't trigger it with _any_ 
> crap, for a very good reason.  Read the commit log for git-stash.sh to 
> know why.

The good reason was people doing a typo when typing a command, like
'git stash aply' or so. And yes, I did find this annoying. The
question of someone omitting the subcommand is very different to me.
On can hardly type 'git stash -q' and claim he explicitely wanted to
run 'pop'.

Your proposal will almost certainly trigger complains from users:

git stash -k => works
git stash -k -q => doesn't work
git stash -k "name of stash" => doesn't work
git stash save -k "name of stash" => works
git stash -p => works with another patch merged in next
git stash -q => doesn't work
git stash --patch --no-keep-index => works
git stash --no-keep-index --patch => doesn't work

You'll have a hard time explaining that to bare mortals.

Look at what's the code's becomming:

+       0,,|1,-k,|1,--keep-index,|1,-p,|1,--patch,|2,-p,--no-keep-index|2,--patch,--no-keep-index)

when the code starts having to enumerate so many possibilities instead
of having a simple logic, something's going wrong.

-- 
Matthieu
