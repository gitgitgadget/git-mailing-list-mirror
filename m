From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Sat, 20 Apr 2013 23:35:50 -0700
Message-ID: <20130421063550.GC10429@elie.Belkin>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
 <1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
 <516F95D1.5070209@viscovery.net>
 <7v38un93br.fsf@alter.siamese.dyndns.org>
 <5170DA96.9000300@viscovery.net>
 <7vr4i632fp.fsf@alter.siamese.dyndns.org>
 <51719F18.3020508@kdbg.org>
 <7va9ouz04y.fsf@alter.siamese.dyndns.org>
 <20130421000522.GB10043@elie.Belkin>
 <517385A6.8020908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 08:36:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTnsc-00042N-0v
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 08:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab3DUGgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 02:36:00 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:55281 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab3DUGf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 02:35:59 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj1so1059472pad.20
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FfxPQM2cDo8NGFLdhjVqmSpVQ4aTdLOWYMkTggSQ8hA=;
        b=j6KUgX2BcTd+8W0TpwYDAwJo18s4Kan15fGFTLsDLeVBQ+PaJAdfbOf/KqUDfEsV4p
         PdGYYcKfjOM8nNlPInC6uOYKiT9+kIded9e9oz4HXqHOb4A6MkGaFJjWww7VjF9CabDY
         3lOYHzyp7R22kmteXIXpfcPdw1eRlmddlo4ZgbvpBzA9/v4XvTtrU0/Q0HCwqSnHduqQ
         /MaEJT5h431Sa+3ARxKLujEwWrRDEiC8d63+pSKWGMg2FK3C1rLQOIFDS3o1JyPeHTyO
         YuvWayi4mxxNahpfPQxAJwDyitzIs0zXRMPVV9h0Eo8h2RvGgdizTf/VGx5uaakOhbpN
         20CA==
X-Received: by 10.67.1.4 with SMTP id bc4mr6373571pad.109.1366526159399;
        Sat, 20 Apr 2013 23:35:59 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ba10sm19910580pbd.21.2013.04.20.23.35.57
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 23:35:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <517385A6.8020908@kdbg.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221896>

Johannes Sixt wrote:
> Am 21.04.2013 02:05, schrieb Jonathan Nieder:
>> Junio C Hamano wrote:

>>> But a _real user_ who wants to use a slash there has no way of doing
>>> so.
>>
>> Doesn't foo=// do that in the msys world?  If I am reading
>> mingw/msys/rt/src/winsup/cygwin/path.cc correctly then the way to pass
>> a true double-slash is foo=///.
>
> That would be totally unexpected.

There is an exception to the path mangling for //unc/paths, if that's
what you mean.

>From [1]:

  if (path[0] == '/' && path[1] == '/')
    {
      int tidx = 2;
      while (spath[tidx] && spath[tidx] == '/')
	  tidx++;
      if (strchr (&spath[tidx], '/'))
	{
	  retpathcpy (spath);
	}
      else
	{
	  retpathcpy (&spath[1]);
	}
      return ScrubRetpath (retpath);
    }

I haven't tested, since I don't have easy access to a Windows test
setup.

Regards,
Jonathan

[1] http://mingw.cvs.sourceforge.net/viewvc/mingw/msys/rt/src/winsup/cygwin/path.cc?content-type=text%2Fplain
