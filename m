From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] test-lib.sh: set PERL5LIB instead of GITPERLLIB
Date: Mon, 02 Jun 2008 16:08:34 +0200
Message-ID: <4843FEE2.1070708@gmail.com>
References: <7vy75oalh7.fsf@gitster.siamese.dyndns.org> <1212358587-15948-1-git-send-email-LeWiemann@gmail.com> <7vfxrwa008.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 16:09:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Aj5-0003zd-AZ
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 16:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbYFBOIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 10:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754259AbYFBOIf
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 10:08:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:1029 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbYFBOIe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 10:08:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so744882fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=A92Ik9+QnhobXHLvsT8Q1dgslLEXkVCwZwJaQ2HpLuc=;
        b=Y1Xn+qjBIBsyC1C+0utgYNOaMaJWi1Q5/bNbvmgqXub87+kqY6dnMS7cP+O3HD18ykckkSorfNb/qojPXxmgOe5p0m4gSHQWtQlNuHTyp3YzVhI66uCyIhH1qgyT1bE/19JAoK3+TQnNQjmQm08mPnolZ51CgXX1Flj1lrguRPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Wjk+YvHospH3Vg93g4Cp41V2Nse4dEwRf7pSxRdOxWH5Elc7c4g0/RgDE2SZgiv+/1MGe5Dfxo+q4idB0+Xhko4gYqQeVQQJoNoLrgjCdYDukNmSMIyjqGCAYbVLLUn3uHLS5xRbiZAZ5sssUCM2i5sbkM0v8oRvm5wJq3Ltr2c=
Received: by 10.86.23.17 with SMTP id 17mr3597813fgw.32.1212415712896;
        Mon, 02 Jun 2008 07:08:32 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.205.25])
        by mx.google.com with ESMTPS id g28sm10332816fkg.1.2008.06.02.07.08.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 07:08:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7vfxrwa008.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83524>

Junio C Hamano wrote:
> the primary Makefile has this rule to munge our perl scripts:
> 
>                     -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
> 
> The real fix to the issue [is] to fix the build procedure of
> gitweb/gitweb.perl so that the above script rewriting is also applied to it.

I see -- in that case, gitweb.perl should indeed be fixed.

Still however, for the Perl tests (t/t9700/test.pl in my branch) we 
don't have a Makefile, so the only way for them to pick up the right 
Git.pm module is modifying PERL5LIB in test-lib.sh. [1]  I just realized 
that we not only don't need to set GITPERLLIB in this case, but we 
should actually unset it so that user-set paths don't cause a wrong 
version of Git.pm to be loaded.  I'll send a new patch.

-- Lea

[1] Or alternatively adding some (lengthy and cwd-dependent) "use lib 
..." statement at the top of every Perl test file, but that doesn't seem 
preferable given that we can solve this centrally in test-lib.sh.
