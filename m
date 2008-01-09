From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 09 Jan 2008 13:52:59 +0000
Message-ID: <C3AA823B.10C50%jefferis@gmail.com>
References: <04EF2652-9AA8-4976-903F-DBE4E7AA13D7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 14:53:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCbNF-0000f8-05
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 14:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbYAINxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 08:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYAINxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 08:53:09 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:55725 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbYAINxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 08:53:07 -0500
Received: by mu-out-0910.google.com with SMTP id w8so35895mue.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 05:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=oIRrjtJ9tc0PISwQKQlmYGgJ/JlTG9bnUmu96pNKC10=;
        b=Mo+5EoJtdqbD4Ak/ihGtfIPEuoE2shH+H1qNVsKfNiVfi4+ShB8HP5flK5OJuiM5Q2cGTW3XRGjrCrkf+SKaim4iT1P10mNWGP7sHwi68ZSGfIirE+jJmrBGrQkWqEj6z3dUgvuK+PiAhrULJtsahRszDrxCwyTZYbeGdCqdkn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=WMlmdccVMNiPpVXG1yZA1pUrIBJVFdhn44HVcBrOXMM+QIzEAhwrucOwRrYEQsp27tA3OI62BtDIXUFADXF+J0gGOuM9gZfRdiRE2qMot+3ncyRJQAAPxY9sgi7L7BegLiZ95CUjDsXmv4mDUbiMeNPxmrYJaH5x74JycbuNgRc=
Received: by 10.78.162.4 with SMTP id k4mr575715hue.66.1199886785236;
        Wed, 09 Jan 2008 05:53:05 -0800 (PST)
Received: from ?81.98.250.69? ( [81.98.250.69])
        by mx.google.com with ESMTPS id d23sm214727nfh.24.2008.01.09.05.53.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Jan 2008 05:53:04 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: CRLF problems with Git on Win32
Thread-Index: AchSxvGSMFcBUb66EdyK5wAUURoPUg==
In-Reply-To: <04EF2652-9AA8-4976-903F-DBE4E7AA13D7@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69992>

On 9/1/08 12:41, "Steffen Prohaska" <prohaska@zib.de> wrote:

> I'll further think about "crlf=safe" (see another mail in this
> thread). I like the idea of safe because it guarantees that data
> will never be corrupted.  But I have no time to think about it
> immediately.

crlf=safe [i.e. munging CRLFs only if there are no bare LFs] sounds
appealing to me as well because it looks like munging that is always
reversible.  However there could still be problems at checkout.  To be
really safe, it seems to me that it must be 1) reversible in practice and 2)
ALWAYS reversed unless we explicitly ask for no gnuming at checkout.  Why?

Re point (1) to be reversible in practice, we need to know who we've munged.
Otherwise when gnuming blindly at checkout we might damage some innocent
bystander file that only ever had LFs in the first place.  So it seems we
would have to keep track of who was munged.  But do we want to store this in
the repository?

Re (2) well if we happen to munge a file on checkin that is actually binary,
it must be gnumed on the way out otherwise it will be broken for the user.
