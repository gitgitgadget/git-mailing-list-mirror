From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PULL svn-fe] vcs-svn: simplifications, error handling
 improvements
Date: Sat, 26 Mar 2011 01:42:39 -0500
Message-ID: <20110326064220.GB20529@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
 <20110323003240.GA4949@elie>
 <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <7vbp12gyqk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 07:42:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3ND3-0007yl-Cx
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 07:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab1CZGmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 02:42:47 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63223 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab1CZGmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 02:42:46 -0400
Received: by iyb14 with SMTP id 14so1246117iyb.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PTV4Zm5dhHsV9aXQpJ5VktWZjETzSzBl9Q5KvvUDjVg=;
        b=BUIzjMadK723gRZW8/6JnyUd+jmv1jGl6TXGaN600LjZx4rhxl0i+S5fAzkuHKFnI7
         8YevgZznFrD0gdy2K5Bspc5qrBRM6g7h0Jn8AojqIoiNzyJm0sM0cY/ACnTjOlZy74RD
         UTz/K1TmgzmlyjMHXEh/LvShlSBdNcu8uFSoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PooJO0I/JgwUpJ3Hup9Q/Bb/RgXGBOy8KSm312taOPZEviw2Odzam8jL4Phob/WF3O
         v/1pBouRgEKwuWxT95qXZuwmcF1/r2imdskHEj3VyBe3n5Dj93WOArRu6q5eByG4J6/v
         SdlMvpTz7jEsc5LfA3n2kUWc9zcOBzq+xg+fs=
Received: by 10.42.82.75 with SMTP id c11mr88463icl.92.1301121766115;
        Fri, 25 Mar 2011 23:42:46 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.ameritech.net [68.255.102.141])
        by mx.google.com with ESMTPS id d10sm1186040ibb.0.2011.03.25.23.42.44
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 23:42:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbp12gyqk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170041>

Junio C Hamano wrote:

> A bit more datapoint.  The first one works just fine, while the second one
> gets stuck:
>
>     $ cd t && make T=t0081-line-buffer.sh test
>     $ cd t && make T=t0081-line-buffer.sh prove
>
> I notice that [sh] spawned from prove is orphaned.
>
> 21643 pts/9    Ss     0:00      \_ bash
> 17149 pts/9    S+     0:00      |   \_ make T=t0081-line-buffer.sh prove
> 17155 pts/9    S+     0:00      |       \_ /bin/sh -c echo "*** prove ***"; GIT_CONFIG=.git/
> 17156 pts/9    S+     0:00      |           \_ /usr/bin/perl /usr/bin/prove --exec /bin/sh t
> 17157 pts/9    Z+     0:00      |               \_ [sh] <defunct>

Hmm, looks like the "kill $!" is not working like it is supposed to.
What is your /bin/sh?  How far does

	make T=0081-line-buffer.sh prove SHELL_PATH_SH='/bin/sh -x'

get before the lull?
