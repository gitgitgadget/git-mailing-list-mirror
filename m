From: "Eric Raible" <raible@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Sun, 15 Jun 2008 20:33:27 -0700
Message-ID: <279b37b20806152033o58350d77v77f859542b4542b3@mail.gmail.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
	 <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>
	 <7vlk1az8aa.fsf@gitster.siamese.dyndns.org>
	 <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com>
	 <alpine.DEB.1.00.0806130551200.6439@racer>
	 <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
	 <alpine.DEB.1.00.0806132239490.6439@racer>
	 <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
	 <200806142359.m5ENxsBI028758@mi0.bluebottle.com>
	 <7vabhne15k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-2022-JP?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?=" 
	<nanako3@bluebottle.com>, "Wincent Colaiuta" <win@wincent.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 05:34:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K85U8-000544-23
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 05:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbYFPDda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 23:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbYFPDd3
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 23:33:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:28774 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbYFPDd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 23:33:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5020773wfd.4
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 20:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=n3/yjl81k2+3WWtmohjWUfC/p7juBwC2+M/FGMwI524=;
        b=aNy8eGtxlkPL7yOaAHfOKwB30+Bt4pAaprQ85HwYSZzlqTZix/UfZXSe+5RfrLbw57
         3iPfiDJDpuB5sbBCiGhbAsTN3j2ytFxqLcq4nd3lhc2wqncf0ik/OvkmLyLkIU+LfnNO
         XG4uMmOsWzhJY+2KweRVNO3X4M4MSaI9N4Jcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Pww4obOphhGiyXP6jAkrkYXvi78lQF5QfUln5H5m8SOJmczgyxbwwHGiFa2IMOeVnk
         E54lOWJttxOBTZdrcm/AYl2+fajJpFBTDzD4cPQbbzNPWTQZcx4cYrwMXBuTpEsw9CMy
         xBUS2AxbiKcGpsdCesDYnT5F65xSVFmcPRvXc=
Received: by 10.142.213.9 with SMTP id l9mr2155755wfg.2.1213587207552;
        Sun, 15 Jun 2008 20:33:27 -0700 (PDT)
Received: by 10.142.177.12 with HTTP; Sun, 15 Jun 2008 20:33:27 -0700 (PDT)
In-Reply-To: <7vabhne15k.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85161>

2008/6/14 Junio C Hamano <gitster@pobox.com>:
> I think the steps from here on would be:
>
>  - Apply the patch in your message I am responding to, so that a stash
>   that is kept forever will not pin the unnecessary history behind it in
>   the repository.  As you said there is no reason to make the base commit
>   (H) actually the same as the commit in the true history --- the only
>   thing we care about it is its tree object;
>
>  - Design and decide the way to tell git to make stash entries unexpirable
>   (or maybe have very long expiration period).  I am leaning toward a
>   configuration option that lets you specify expiration period per ref,
>   rather than marking individual reflog entries as I suggested earlier;
>
>  - Make the default for new repositories' stash reflog expiry period
>   "never", by setting the above configuration upon "git init".
>
> None of the above should obviously be in 1.5.6, but I think even the third
> step to the change the default would be acceptable in the next 1.6.0
> release.

In addition, how about a new stash option "expire", as in:
git stash expire --before=2.weeks.ago

The default for expire should probably be default expiration period;
if set to "never" then a usage message could be printed.

I for one would choose "never", so the above would be a simple
way of cleaning up if/when too much cruft accumulates.

- Eric
