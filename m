From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] submodule: fix relative url parsing for scp-style origin
Date: Mon, 10 Jan 2011 11:22:27 -0600
Message-ID: <20110110172227.GA7882@burratino>
References: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch>
 <20110110164801.GA7714@burratino>
 <201101101805.13251.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 10 18:22:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcLS6-0000dS-QX
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 18:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab1AJRWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 12:22:38 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61859 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab1AJRWh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 12:22:37 -0500
Received: by qwa26 with SMTP id 26so19998386qwa.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 09:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vCi7RI0wK9fOzmskOiG9qWzksJNJBHk+q2pyfHQQKnY=;
        b=RzOcdIsCO0tX12SMwrzDYeFL1aymYMTSEJe755VutE9RYEjG3IaLeXI/HuiPXb3IFO
         WEfhdOzql+fZLH5miw1Bm2v3/nKHMSGabgdc4/9T9bM6tF9SsW0Vuzy0lWibbeZxDb8C
         6tL7ptUCVOAlzzR5WIeBHbgzq65N2+i1+3KDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=s9RLcPMJz5qlN3UyMzxH+HNfcnvDEOOeTkmKkRz/l9oJL/6VVIzjxi1ZK9SOIlo0Z0
         2Cx0vbOdyYMIKT7TYkzUTCKuUmpeTWAonLWKmkjcf8UDubBYe0RxBvkZDCHg/zEQ6cGz
         AI3o1DxQob655bpdF/SQCSeHBF9XWIth5sUGg=
Received: by 10.224.54.85 with SMTP id p21mr26891367qag.147.1294680157349;
        Mon, 10 Jan 2011 09:22:37 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id e29sm17587060qck.15.2011.01.10.09.22.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 09:22:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201101101805.13251.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164886>

Thomas Rast wrote:
> Jonathan Nieder wrote:

>> 	url = /local/path/with/a/colon:in:it
>> 	url = git://example.com/path/with/a/colon:in:it
>
> These work fine because the first case arm is "do we still have a
> slash?", and thus takes precedence over the colon splitting.

Ah, nice (sorry I missed that).  So this can't create a regression
and for what it's worth

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

>> 	url = simple.subdir.of.cwd
>
> That's caught by the outer 'case':

I meant if remoteurl is not fully qualified.  For what it's worth,
the answer seems to be that

	git clone repo newdir

replaces "repo" with the absolute path "$(pwd)/repo" and manually
using a relative path as in

	git remote add origin subdir

creates a remote that is not usable, perhaps because different parts
of the code treat it as relative to different directories (.git or the
toplevel).

Sorry for the laziness --- I should have just checked.
