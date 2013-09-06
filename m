From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn  connections
Date: Fri, 6 Sep 2013 05:44:07 -0700
Message-ID: <9D2EC674-887A-479B-B8FB-3EFEAC391435@gmail.com>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106> <xmqqli3bhzop.fsf@gitster.dls.corp.google.com> <A46AD76E-56FA-4555-8811-6141284300DD@gmail.com> <07b9b270090d6b42515c5dc3dfb8ab4f.squirrel@83.236.132.106>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Uli Heller <uli.heller@daemons-point.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 14:44:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHvOa-0002Aq-KZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 14:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab3IFMoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 08:44:12 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:37288 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab3IFMoL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 08:44:11 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so3158655pbc.21
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=ubdm/nFDxc2svkgKFaqjE/DnZAr+Lmp7wMWM+JiQXhs=;
        b=w3nVYvUKobQf19M9gmarF1wfm43wpt6IGefrfJY48Xj3ZUJz0W56EUdNRZxq5IuIq6
         Aiy7+tkTQ/LI+5NbHQFXFa5rLv7OPq7FwLIA0NCf7ExShu8LrYHPINFA3/DHFKvjNNmL
         VvD93uMHKfSaUznamC3upwvbteT+mYlyEcayO3Mbl6MBeD5szNjFflOUSNcZl7uLCHLF
         HDbjZPmxlR/PoNM7T7LiwNvQeS++oAB3HjDTkLy9Ewfn6DSBTIDbJ7UbDFzIbcYJvvpn
         Bkzi9LlNo4j+lDj5DmAt6RJQEzC8QSR4XHMm65uRefYYUql25VoJFH04UPNjTK42DCxz
         VEHQ==
X-Received: by 10.68.224.161 with SMTP id rd1mr2684045pbc.121.1378471450359;
        Fri, 06 Sep 2013 05:44:10 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id bu4sm3696530pbc.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 05:44:09 -0700 (PDT)
In-Reply-To: <07b9b270090d6b42515c5dc3dfb8ab4f.squirrel@83.236.132.106>
X-Priority: 3 (Normal)
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234043>

On Sep 6, 2013, at 05:06, Uli Heller wrote:
>> I'm using Git built from master (57e4c1783).  I see the same behavior
>> both with and without the SVN/Ra.pm patch (and using both bulk  
>> updates
>> and skelta mode).  Does the problem not happen on a git svn clone?  I
>> can force serf back to version 1.2.1 and try that version just to  
>> see,
>> but I would like to have an example of a known failing git svn  
>> command
>> for testing purposes.  Thanks.
>
> I think this command should produce the error:
>
>  git svn clone --stdlayout https://github.com/uli-heller/uli-javawrapper
>
> You can use any other svn repo as well, you only have to specify an  
> HTTPS
> url.

Yes, that does it.  Interesting that cloning from "https://github.com/uli-heller/uli-javawrapper 
" core dumps while cloning from "http://github.com/uli-heller/uli-javawrapper 
" does not even though the latter redirects to "https://github.com/uli-heller/uli-javawrapper 
".

In any case, I can now reproduce the problem (serf 1.3.1 still breaks  
since it does not yet contain the fix and it is the most recent serf  
release available).

And the Git/SVN/Ra.pm fix does eliminate the problem for me (both with  
bulk updates and with skelta updates -- the crash occurs with either).
