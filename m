From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/9] gitweb: Convert output to using indirect file handle
Date: Mon, 25 Jan 2010 22:48:14 +0100
Message-ID: <201001252248.14874.jnareb@gmail.com>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net> <201001250247.13101.jnareb@gmail.com> <4B5E03AD.1020404@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:48:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZWnL-00053B-VC
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 22:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab0AYVsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 16:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777Ab0AYVsX
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 16:48:23 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53919 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab0AYVsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 16:48:22 -0500
Received: by ewy19 with SMTP id 19so249307ewy.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 13:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pp8bF0G+VvNYZ1iciRQ1y9r12aQomMhugP9SodfTU2o=;
        b=A040qDyGEzdXBOt1/GaNU2dENR8kHGbUwCf3d/cwzgf1Op+NgN3P/zXoPABY6gSDGM
         65O7pwOtaFQso1eZ8epBGh1NsfTd27N/2MupwLQEWdOnrFaqw12KGS865a+jzix7s7i6
         r/mAwNHry4nzNBxnc8czN6n9Ya4aLpPCfq848=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hxM9Ua2EuIs60T8Cpe7lWQgYbNjSy8QUXU46vfnIHkLlhAW3+8Rt6SwQqfOdugw48W
         /3w78LWNGWcoQy4G6h6RmvNB+PcDY82E8OJkQirOLbRiOlFTlR9L17hpAMwReK3BWOEk
         4fy9u95E5xRkKZi3YfKVwFDQ9vf45oOID7e3c=
Received: by 10.213.1.18 with SMTP id 18mr252587ebd.17.1264456101246;
        Mon, 25 Jan 2010 13:48:21 -0800 (PST)
Received: from ?192.168.1.13? (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id 10sm9155460eyd.5.2010.01.25.13.48.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 13:48:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B5E03AD.1020404@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137998>

On Mon, 25 Jan 2010, J.H. wrote:

> > So there is a bit of rule of preservation of difficulty at work.  Either
> > we have large patch adding explicit filehandle to all print statements
> > 'print <sth> -> print $out <sth>' but simple code, or have smaller patch
> > but complicated *STDOUT manipulation, or have small patch but rely on 
> > non-core CPAN modules present.
> 
> I think depending in non-core CPAN modules is a really bad idea, and
> will cause some concern and consternation with mainline distributions,
> besides making it more complicated for users to get this up and running
> quickly and easily.  

Note: the modules in question are Capture::Tiny or PerlIO::Util.
Capture::Tiny is available as perl-Capture-Tiny RPM module for Fedora Core
up from FC11 and in DAG repository, at least. 


First, installing non-core CPAN modules locally for user is very simple
thanks to local::lib.  After setup it is simply 'cpan -i PerlIO::Util',
and PerlIO::Util gets installed locally, by default inside ~/perl5.

Second, we can go the route that Git.pm did, namely include sources for
extra modules (private-Error.pm in case of Git.pm) and install it if 
needed.  With proper build system (Module::Install, Module::Build) it is
even simpler with inc or inc::latest.  And there is always PAR[1] if you
want to have everything in one file.

[1]: http://par.perl.org

>                     While I agree there are other ways of handling this 
> I think just adding the filehandle to the print statements provides the
> easiest cross section of usability and functionality for everything
> involved.

Well, manipulating *STDOUT shouldn't be, I think, much harder, although
I guess it would need more care (so that e.g. "Generating..." page gets
written to real STDOUT).

-- 
Jakub Narebski
Poland
