From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [GSoC] Google Summer of Code 2009 - new ideas
Date: Sat, 7 Mar 2009 10:56:39 +0800
Message-ID: <be6fef0d0903061856s21fdb4c4q9d52957dade96e94@mail.gmail.com>
References: <200903070144.17457.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 03:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfmjr-0002kQ-Bn
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 03:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbZCGC4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 21:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbZCGC4n
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 21:56:43 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:10187 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbZCGC4m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 21:56:42 -0500
Received: by wa-out-1112.google.com with SMTP id v33so436326wah.21
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 18:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VMFOzMcIMS5BjqgRGoMMhNLoMH4XgCqCe8HtGJR1cPM=;
        b=Mph5uyRZhhnsQ3aHRciqOn4bp6j1TIP23tNrfAyoR2l8s8FFtDXlIr9OOAv3RGxuiF
         Obk+aFf0F6rLG1bnHHsMZXYmw4TYs2/IA3Je+9HD2jPT0okKjldGU23ln3QDWn+ne7t0
         9C1GSzgUFXogFEqiJBBIiz4rhO+x4qtg9ebq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n3Gq/AXIDh12rJIxHyqL2ltvtrxvy09W8IVmwfKgSm6ipywgRkWH2VftHwbv8Wg6xk
         pRqvt9LvmcxAw4A1Gc5OYN6UVuoKIobLTwB1LZ4ejBD3T8Q2zp2fu+VCUAlgLFc6d9FO
         rukO/dnvL5QRnBg0ahWVB3YelsGR/S7L6RVUo=
Received: by 10.114.94.12 with SMTP id r12mr1923937wab.229.1236394599273; Fri, 
	06 Mar 2009 18:56:39 -0800 (PST)
In-Reply-To: <200903070144.17457.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112509>

Hi,

On 3/7/09, Jakub Narebski <jnareb@gmail.com> wrote:
> == Single credentials ==
>
> Currently if you don't save your username and password in plain-text
> `.netrc` file (for HTTP transport), or avoid need for interactive
> credentials using public key / private key pair (for SSH), you need to
> repeat credentials many times during single git-fetch or git-clone
> command.  The goal is to reuse existing connections if possible, so the
> whole transaction occurs using single connection and single
> credentials; if that is not possible cache credentials (in secure way)
> so user need to provide username and password at most once.
>
> '''Goal:''' git-fetch and git-clone over HTTPS and git://
>             requiring providing username and password at most once
> '''Language:''' C (perhaps also shell script)

Perhaps you might want to look at this:

http://marc.info/?l=git&m=123599968929476&w=4

At that time, I was thinking more of removing git's reliance on curl's
multi interface so that it could use older versions of libcurl. But,
on this point, Daniel convinced me otherwise. In fact, it doesn't make
sense if you could have a up-to-date git, but not an up-to-date curl.

I didn't really get a reply on my point of "minimized credential
prompting", though, and I think this GSoC proposal kinda gives support
to it.

>From a learning standpoint, I don't think this project would be too
challenging, nor can it sustain for a whole summer -- the basic
strategy to allow non-curl multi usage (ie. single connections) would
be to "fork" the current http slot methods and make them
non-curl_multi, then finding and replacing instances of them
throughout the code base.

I already have a patch series that does that, plus a --persistent
option for push. I'm fairly sure that it takes place on a single
connection (I'm relying on my firewall log though I'm doubting it's
reliability on this issue).

-- 
Cheers,
Ray Chuan
