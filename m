From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7.1 3/4] gitweb: File based caching layer (from git.kernel.org)
Date: Tue, 30 Nov 2010 00:54:45 +0100
Message-ID: <201011300054.47312.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <AANLkTinX9Phu+SuOyEWtAsMz182VkfVkJva1ep==V-zQ@mail.gmail.com> <AANLkTim5V_50Er8OiNTWDHNzvqJ3J+biOwuqnBdnR4jH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 00:59:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNDcg-0006mp-Gc
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 00:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab0K2Xy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 18:54:57 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54104 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0K2Xy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 18:54:57 -0500
Received: by bwz15 with SMTP id 15so4470228bwz.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 15:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KC20KSbBo7kIdAYnAZM0v/4lKdGAz0WvBlmOfew2A3E=;
        b=bZX9SbbaZZSs1/KVxBtLenzOpePUC+PSENQe+cNVSQMpTEDvbyBcsuZZlLi7PadKZ0
         ygMimhfuQ8jcLkr3tD2VXIWT6nR+UXmOdWFhKYy3bZoHBs/cVKqyGvB5HX9XTUy/NVWd
         N4JMpGjncxg7lrG2zncHoK3E2OIDW075QlhUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XOOD8EYGVXSE1YQ76ibu7U2pbNFQX/7813tJdIxMaxOnWfOFCFK9UiqNaIMmRMQdxH
         e+9xBNKsTNWDMZ3mDz+h5VSAq/TPDkAqvALAPFppar1MeualdBVFgp7Jik4/JuZe/6J6
         gwd+hXhrAcIO/GtIb+rvmKN6wEtFj5jjPz4LU=
Received: by 10.204.62.201 with SMTP id y9mr1853256bkh.30.1291074894083;
        Mon, 29 Nov 2010 15:54:54 -0800 (PST)
Received: from [192.168.1.13] (abvn170.neoplus.adsl.tpnet.pl [83.8.211.170])
        by mx.google.com with ESMTPS id t10sm2363599bkj.4.2010.11.29.15.54.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 15:54:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTim5V_50Er8OiNTWDHNzvqJ3J+biOwuqnBdnR4jH@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162453>

On Tue, 30 Nov 2010, demerphq wrote:
> On 30 November 2010 00:07, demerphq <demerphq@gmail.com> wrote:
> > 2010/11/13 Jakub Narebski <jnareb@gmail.com>:

> 
> Also in this code:
> 
> 2010/11/28 Jakub Narebski <jnareb@gmail.com>:
> > +#
> > +# Includes
> > +#
> > +if (!exists $INC{'cache.pl'}) {
> > +       my $return = do 'cache.pl';
> > +       die $@ if $@;
> > +       die "Couldn't read 'cache.pl': $!" if (!defined $return);
> > +}
> 
> Why is that preferred to:
> 
>    require 'cache.pl';
> 
> And why is this thing even a .pl file? Why isnt it called
> lib/GitWeb/Cache.pm or something like that?

Because it is not a Perl module; in particular 'cache.pl' uses global 
variables from gitweb.perl (like $my_url, or $cachedir, or %action)
and subroutines from gitweb.perl (like change_output() and 
reset_output()).  That is why it needs to be injected via do, rather
than included in its owne namespace with package/require.


P.S. This is not my code, this is patch by J.H. (John Hawley); I did
only *minimal* fixups.

P.P.S. My rewrite can be found in 'gitweb/cache-kernel-pu' branch in
my repository (links are to web interface)
  http://repo.or.cz/w/git/jnareb-git.git
  https://github.com/jnareb/git
Sent in http://thread.gmane.org/gmane.comp.version-control.git/158313

-- 
Jakub Narebski
Poland
