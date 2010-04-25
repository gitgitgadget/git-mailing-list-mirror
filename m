From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'commit -a' safety
Date: Sun, 25 Apr 2010 02:16:18 +0200
Message-ID: <201004250216.18660.jnareb@gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <201004241226.34884.jnareb@gmail.com> <alpine.LFD.2.00.1004241413030.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Apr 25 02:16:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5pWd-00046L-C2
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 02:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab0DYAQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 20:16:25 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49682 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab0DYAQY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 20:16:24 -0400
Received: by bwz19 with SMTP id 19so430397bwz.21
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 17:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BI0cbV5pLyAH6En4FhvP5GF/7uldAvRuCQ9BILWwB5Y=;
        b=S/AXTTazX9Vu12rBO/+xSt6GO6Vjij9OB0x8B2B12CzWq9Zau4j5pb6/JKNTLUsy8T
         7EAnNZF+lPWGt7VOtdz+Jv3DW6FeaOJQhP5BVmv3qamW0VM0pvRWoWn5q+ON7rurWHQn
         lOZ1uigYx6cv6DgiViXzU7Dy4YWZt0iHF1ZjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vKgTNYiPss3GPPyEMgmuM4N3eDhpdQ1Axolfx5SW03OxaA+3CKdCAbVXFdwVA8Vhmw
         /g3smJ/lIPKJ1CwwZZZAH2EJd+xVbcM7mHpI3NMS9RAUrAEdNxxIeY+47YJqBqE9Wpfg
         U47n7cFj77QMwqPJAL0C5KK158e1KIG7QXuuE=
Received: by 10.204.19.141 with SMTP id a13mr1263121bkb.107.1272154582991;
        Sat, 24 Apr 2010 17:16:22 -0700 (PDT)
Received: from [192.168.1.13] (abvs189.neoplus.adsl.tpnet.pl [83.8.216.189])
        by mx.google.com with ESMTPS id 15sm969927bwz.0.2010.04.24.17.16.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 17:16:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.1004241413030.7232@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145712>

On Sat, 24 Apr 2010, Nicolas Pitre wrote:
> On Sat, 24 Apr 2010, Jakub Narebski wrote:
> 
> > First, this is to be optional safety, by default turned off.  So if you
> > do not have problems with situation where you accidentally use 
> > 'git commit -a' instead of 'git commit', committing not what you wanted
> > and prepared, you simply do not turn it on.
> 
> In which case it is worthless.  No one will turn this feature on if they 
> don't fully understand what it entails, and those who do understand it 
> are probably not the people who would actually benefit from it.

One would turn it after losing carefully prepared index by running 
"git commit -a" when one meant "git commit" ;-)

More seriously, it could be made default if it is not too annoying.

> > Second, to be more exact the safety would be triggered only if staged
> > change _differs_ from what is in working area.  Therefore
> > 
> >   $ git add file
> >   $ git commit -a
> > 
> > would not trigger this safety, while
> > 
> >   $ git add file
> >   $ edit file
> >   $ git commit -a
> >   fatal: There are staged changes
> > 
> > would trigger it.
> 
> Much better yet would be a warning at the top of the summary message in 
> the commit text editor.  This way you won't introduce an incompatible 
> and potentially annoying behavior that no one is likely to opt-in for, 
> and the warning will give a hint that you might be losing some 
> intermediate state if you don't abort the commit.

As Petr Baudis said, this actually work *if* you use editor to generate
commit message, and you have chance to see commit message template.
Also the information was considered not visible enought, hence patch
at the beginning of the series.

-- 
Jakub Narebski
Poland
