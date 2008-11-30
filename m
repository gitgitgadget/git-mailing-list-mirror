From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 1/2] gitweb: fixes to gitweb feature check code
Date: Sun, 30 Nov 2008 01:31:12 +0100
Message-ID: <200811300131.16787.jnareb@gmail.com>
References: <1227904793-1821-1-git-send-email-giuseppe.bilotta@gmail.com> <1227904793-1821-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 01:33:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6aF6-0000CK-5J
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 01:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbYK3Ab2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 19:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbYK3Ab2
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 19:31:28 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:33799 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYK3Ab1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 19:31:27 -0500
Received: by ey-out-2122.google.com with SMTP id 6so825463eyi.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 16:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jbdQ1tcSmN5MqOMInaaKCISIIOqw2HsyZMvtcmMC6l0=;
        b=iXa+Zg5Q4j4nIq+AEmhJ/6Vzg0ioLnzt80NJyL45OTPAi1ETGlJ7ZfIjzkUpFfIKYI
         wBYT33up3ZVmVtfDJojGZnK7DhL4Zt9jXz3WzmMuyi92puaT6MZ/paIN0I8lQNdIuGGN
         x8zk77fddg0jEejlEopAporyLDZjPsIPCTf7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EvStCjHEbYhAV8+dsTEkC5CQ0dE1ffUQgKDPtOEgfOazgjcmhqSLSm3EYkYrqIdJ2j
         Fb6MHUwq8L2NFjRrP3qjvESOHJD1149S5gd/g1k+X/wMxRNj3fEVcf9uoZwMRi4krMxo
         C5+A2xyira9R6W+MhpHDdQHoFPJwdG5G60AfI=
Received: by 10.210.90.10 with SMTP id n10mr10853615ebb.9.1228005085698;
        Sat, 29 Nov 2008 16:31:25 -0800 (PST)
Received: from ?192.168.1.11? (abvs96.neoplus.adsl.tpnet.pl [83.8.216.96])
        by mx.google.com with ESMTPS id z34sm2687893ikz.10.2008.11.29.16.31.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 16:31:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1227904793-1821-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101940>

On Fri, 28 Nov 2008, Giuseppe Bilotta wrote:

> The gitweb_check_feature routine was being used for two different
> purposes: retrieving the actual feature value (such as the list of
> snapshot formats or the list of additional actions), and to check if a
> feature was enabled.
> 
> For the latter use, since all features return an array, it led to either
> clumsy code or subtle bugs, with disabled features appearing enabled
> because (0) evaluates to 1.
> 
> We fix these bugs, and simplify the code, by separating feature (list)
> value retrieval (gitweb_get_feature) from boolean feature check (i.e.
> retrieving the first/only item in the feature value list). Usage of
> gitweb_check_feature is replaced by gitweb_get_feature where
> appropriate.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I like the idea of futureproofing gitweb code to avoid further bugs
with checking if feature is enabled. So from me this patch gets Ack.

I have thought at first that perhaps this patch could also remove
requirement that 'default' field is array (reference), replacing a bit
cumbersome
  $feature{'blame'}{'default'} = [1];
with simpler
  $feature{'blame'}{'default'} = 1;

But now I think that is separate issue, and if we think it is worth
having (in spite of its disadvantages in form of more complicated code
dealing among others with legacy configuration), it should be put in
separate patch.

-- 
Jakub Narebski
Poland
