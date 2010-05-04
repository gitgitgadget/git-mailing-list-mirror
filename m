From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/5] gitweb: Use nonlocal jump instead of 'exit' in die_error
Date: Tue, 4 May 2010 13:39:23 +0200
Message-ID: <201005041339.26192.jnareb@gmail.com>
References: <20100424132255.30511.98829.stgit@localhost.localdomain> <20100424135334.30511.26522.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 13:39:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9GTX-0004jp-Uc
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 13:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282Ab0EDLji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 07:39:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:45636 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256Ab0EDLjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 07:39:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1319738fgg.1
        for <git@vger.kernel.org>; Tue, 04 May 2010 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=f97wdhY5FMM7iuK/qbHMl0XXkf/MTBI02KcgEAmfM68=;
        b=mAEsLhSEkvnh65SaAZvLwHTBGLVnUm9Se0IiAazoPDsxMMZziGXCfNsmh6ed+JeqYA
         d5tY/wjL3RyD4S6Ha4B83XM10v52NsMopYQ16gvbeFP/ARaigz0L1mWjo8SxytSdS0bC
         jF62G1OxXi15kmAa/vuST5vU6Hd+lxBVbAwno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=FhzpgUCaSu0jbnE4BS2ouZGe2P+LgRMZQ5uws+3HaQ2w5Ue8sx7WlK6iBChEhfJ67+
         56JwctuvuN7b17qTgEE8yaGbsTukqsgz6l/71OAFkI+mEtM2zv4Ub5ehnpyfn8ImI6lx
         PfGKbj6cS3FZ3n6e2Y8QxjjV9Thj+xPvtfibs=
Received: by 10.87.53.28 with SMTP id f28mr12483136fgk.70.1272973176137;
        Tue, 04 May 2010 04:39:36 -0700 (PDT)
Received: from [192.168.1.13] (abrz91.neoplus.adsl.tpnet.pl [83.8.119.91])
        by mx.google.com with ESMTPS id d8sm17324036fga.21.2010.05.04.04.39.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 04:39:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100424135334.30511.26522.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146309>

On Sat, 24 Apr 2010, Jakub Narebski wrote:

> Use 'goto DONE' in place of 'exit' to end request processing in
> die_error() subroutine.  While at it, do not end gitweb with 'exit'.
> 
> This would make it easier in the future to add support or improve
> support for persistent environments such as FastCGI and mod_perl.
> It would also make it easier to make use of die_error() as an error
> handler (for fatalsToBrowser).
> 
> Perl 5 allows non-local jumps; the restriction is that you cannot jump
> into a scope.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This patch is most independent of introducing caching support to
> gitweb, and I think it would be good to have nevertheless.

>From *very preliminary* benchmarks it looks like this change improves 
gitweb performance for multiple connections when served from mod_perl.

The results of "ab -n 10 -c <X> <URL>", where X = 1, 2, 5, degrades
less with the number of concurrent requests when this patch is applied 
than without this patch.

-- 
Jakub Narebski
Poland
