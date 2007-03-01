From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 1 Mar 2007 08:40:50 +0000
Message-ID: <200703010840.54377.andyparkins@gmail.com>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net> <200702281301.58026.andyparkins@gmail.com> <46a038f90702281540o520cc214xa929a3e3c4e70883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 09:41:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMgqa-0005ya-Cg
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120AbXCAIlE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933121AbXCAIlE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:41:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:19899 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120AbXCAIlB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:41:01 -0500
Received: by nf-out-0910.google.com with SMTP id o25so825137nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 00:41:00 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aDISXWSqRPpO6DBQXgvzO3fDX3zBWAdTojauNyTVMXspf501T8J9GLRf2zlQwBYXBwNGAVr83E/CosSCl5LuC/eGfog0BIRHLA/zqWEdcw4oxojWkGFIQcklLR1fNJWWMPpQV/kzJrJCWlgvDUz3lQAA8Ek2pD1yGmcSx/MuH9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hUgxpSwXtq4+2jOGCc/uWo/U1RQiabTeU4ShhThDqnu9mrhu3KSqqwl+ZdgExsRN2RsWOhztWWzvFY/t0axxJVBASxMBjNP8Vhdka0+mEX1yPiqEOSfadZ3b2oNjgvHa2a5cH2VJFYTrlSrbXy3agXoMo0CkwzGrle7L70rsBrQ=
Received: by 10.48.202.11 with SMTP id z11mr5289334nff.1172738460397;
        Thu, 01 Mar 2007 00:41:00 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id l38sm8361548nfc.2007.03.01.00.40.57;
        Thu, 01 Mar 2007 00:40:57 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <46a038f90702281540o520cc214xa929a3e3c4e70883@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41053>

On Wednesday 2007 February 28 23:40, Martin Langhoff wrote:

> I guess what I mean is that the common case on windows is going to be
> for users who want their binary files un-corrupted, and their text
> files newline-converted.

Given that windows editors/tools generally cope quite well with UNIX line 
endings, the common case could well be that no one cares that the new line 
conversion isn't happening (it's certainly the case for me).

> In fact, I think we should have it set to default to binary -- which

Me too.  However, I didn't want to change existing behaviour.  That die has 
been cast unfortunately.

> does the best job of preserving data. And override that based on file
> extension (configurable) or  check the "head" of the file cheaply for
> binary-ness before we update the file on the client side.

You're right in theory, but I really don't like the idea of auto-detection; 
things like that /always/ go wrong and when they do there isn't a way to undo 
what it's done.  Douglas Adams had it right when he said:

"The major difference between a thing that might go wrong and a thing that 
cannot possibly go wrong is that when a thing that cannot possibly go wrong 
goes wrong it usually turns out to be impossible to get at or repair."

> I agree with the idea of doing something smart with -kb flags, but
> this is not a good move. For the common case among Windows TortoiseCVS
> users, the switch proposed introduces the ability to switch between
> one broken mode to another broken mode.

I don't understand.  What is broken about it?  As far as I can tell the -kb 
flag doesn't do anything smart, it /disables/ the smartness and tells the 
client that the file is binary.  As you say - both modes are broken, so 
supplying a switch isn't crazy because one broken mode might suit better than 
another.  I agree that neither is ideal, but until the "ideal" is 
implemented, it's better to have the option than not have it.

I think I'm missing something that you are worrying about and that I haven't 
noticed.  Does -kb do something that I'm not aware of?  Is there a more 
correct way of telling the client that a file is binary?

> (And in terms of temporary workarounds, TortoiseCVS has a switch in
> itself to disable newline conversion.)

I'd prefer if the configuration is kept on the server side as much as 
possible.  Disabling newline conversion in the client is exactly the same 
solution as putting -kb everywhere in the server, except in the server it 
only needs doing once; and when a better method is eventually found the 
clients can continue without having to change anything.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
