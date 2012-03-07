From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Wed, 7 Mar 2012 19:03:01 +0100
Message-ID: <201203071903.02373.jnareb@gmail.com>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch> <m31up5tnjw.fsf@localhost.localdomain> <877gywy40l.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 07 19:03:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5LCm-00088s-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 19:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758962Ab2CGSDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 13:03:12 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61758 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850Ab2CGSDL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 13:03:11 -0500
Received: by eaaq12 with SMTP id q12so2340607eaa.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=7w+3Ik97++mA2EvJJgyr7xUwZGOMYgp8KUbHpp/mH10=;
        b=BpnptWDXP8J6vV636fzbmAPBCICZH94lxSgPEYLq21SAHtqxG76P7x0/SEtLwUyN43
         PX3/LK5n0vaVRQtkLb9BcmPki8ynhU1ejE4P+U1G8enMUvkztwzYIOIFhfLWcGKEKU6L
         7+Vf9b7WBiB+lqTpdGBt/hAYbCY7KPbtDLrYQw3BfQcw3/1933DSaUlMJwE0u7xIQTRu
         sjdyvTdD0xzdDRNKvQrq28JO4tiPIZdJpC6uRTgXVM6RM5ae+4n0TUql7R2eQOUEnnJO
         urkvwa/6Lx+gFOu7cv/eB9xWj9vjbxV/ST22YLfVetrRefESgZmgGd4J86SYpu2vYKgS
         T2rw==
Received: by 10.213.5.6 with SMTP id 6mr751683ebt.88.1331143390205;
        Wed, 07 Mar 2012 10:03:10 -0800 (PST)
Received: from [192.168.1.13] (abwo250.neoplus.adsl.tpnet.pl. [83.8.238.250])
        by mx.google.com with ESMTPS id o49sm89636700eeb.7.2012.03.07.10.03.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 10:03:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <877gywy40l.fsf@thomas.inf.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192468>

Thomas Rast wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > Junio C Hamano <gitster@pobox.com> writes:
> >> 
> >> But of course, this from a command line would not work:
> >> 
> >> 	$ perl -MGit
> >> 
> >> I do not expect it to, and for the ease of testing new versions, I
> >> prefer it not to work.
> >> 
> >> In any case, you should be able to do anything under t/ _before_
> >> installing, so relying on having Git.pm in normal @INC is a double
> >> no-no.
> >
> > Thomas, take a look at how it is solved in 't/t9700/test.pl', used by
> > 't/t9700-perl-git.sh':
> >
> >   use lib (split(/:/, $ENV{GITPERLLIB}));
> 
> Hum.  The problem is that the user may invoke aggregate.perl manually,
> and GITPERLLIB won't be set in that case.
> 
> Is there a better solution than duplicating the logic that sets
> GITPERLLIB in test-lib.sh within aggregate.perl?

Beside extracting logic that sets GITPERLLIB into separate file like
in Junio proposal?  You can always assume that it is fixed relative
to perl/Git.pm, and use __DIR__ or $FindBin to make "use lib", e.g.

  use FindBin;
  use lib "$FindBin::Bin/../../perl";

-- 
Jakub Narebski
Poland
