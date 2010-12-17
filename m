From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 18:51:32 -0800 (PST)
Message-ID: <m3lj4sll39.fsf@localhost.localdomain>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
	<201012170254.13005.trast@student.ethz.ch>
	<9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Ken Brownfield <krb@irridia.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 03:57:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTQVh-0001M6-LG
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 03:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab0LQC52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 21:57:28 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:65450 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab0LQC52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 21:57:28 -0500
Received: by bwz16 with SMTP id 16so569474bwz.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 18:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lntNsk2qtJkTQ69JpIVbt4GBtg12vvAlaHDzFQD7qRA=;
        b=EtIjVbf+AAApo/NtcTMDhqleFiQbBzAsW9N38WBl14a5TbCvU+VzT8ibb2mtS9ViHD
         RIDPeNZDIsEw7LWE3EPEPdpW8H+2Fh7TCgcAV8IBs9I6IT3FYTPL+u8/+CoSez6oKQzr
         7SlTSGy4sw2+cuOX8cNamhxS+Q42+HYDIdbz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ooFoyGj/pB/Zzddka0v6goAXBW+jz5aSzGxj7foRdd2s1wqXeUKXz+z/SazxMYEKeB
         ltHdXg5t/33MEEaDcfaiKPe805dctvOCfjv2TYz3kZHq5sR1je7TbslJeO7fp6pfvyCz
         /1QOjQTip6xZ2yZJVnCxp09g+03w8trxgWeWw=
Received: by 10.204.98.201 with SMTP id r9mr189242bkn.37.1292554293925;
        Thu, 16 Dec 2010 18:51:33 -0800 (PST)
Received: from localhost.localdomain (aeho46.neoplus.adsl.tpnet.pl [79.186.196.46])
        by mx.google.com with ESMTPS id q18sm1541809bka.3.2010.12.16.18.51.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 18:51:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAH2oqYc018831;
	Wed, 17 Nov 2010 03:51:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAH2oYqW018826;
	Wed, 17 Nov 2010 03:50:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163854>

Please do not toppost.

Ken Brownfield <krb@irridia.com> writes:

> I had considered this approach (and the one mentioned by Jonathan)
> but there are no git tools to actually perform the filter I wanted
> on the export in this form.  I could (and will) parse fast-export
> and make an attempt a filtering files/directories... my concern is
> that I won't do it right, and will introduce subtle corruption.  But
> if there's no existing tool, I'll take a crack at it. :-)

You can try ESR's reposurgeon:

  http://www.catb.org/~esr/reposurgeon/

It's limitation is that it loads structure of DAG of revisions (but
not blobs i.e. contents of file) to memory.  IIRC.  It is not
streaming, but "DOM" based, otherwise some commands would not work.


By the way, git-filter-branch documentation recomments to use
index-filter with git-update-index instead of tree-filter with git-rm,
and if tree-filter is needed, to use some fast filesystem, e.g. RAM
one.

But probably you know all that.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
