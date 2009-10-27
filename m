From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: more fancy ignoring of files ('if' in .gitignore?)
Date: Tue, 27 Oct 2009 11:00:27 +0100
Message-ID: <4AE6C4BB.5060403@gnu.org>
References: <200910271030.54571.schubert.seb@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schubert <schubert.seb@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 11:00:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2iqy-0006gS-I4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 11:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbZJ0KA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 06:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbZJ0KA0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 06:00:26 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:44094 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbZJ0KAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 06:00:25 -0400
Received: by ewy4 with SMTP id 4so4451258ewy.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=YIZa15W7gc/YdRw1DU21jXU19TyHaNVkomYctsBvIH4=;
        b=dMKiAFQEafKbjKEfXhyD5fJn33X1VdpxENIYZpvAnJYX/6ylslZgIEpFroPNunqDZL
         g4H0hUtnN/zaTkYAWV0nDHwxbzdiT4E3tv/xr5bWoMc6aBew0yFSS6RMZcq+zYPbNhBc
         v9hqwTqlnJ9/f1nrATlgLx4RtxIKMIjSHN7HE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=RxRulrkzqfCflYZxcyzgJ9FArTdIi1DkCK8gV/fPU+5nWkS5RwbsCI8EQnWMS2bZjO
         r5Ogx3jgVxhLwQGBIONMiz1nuo/FnLbh5DW7vchPd/j5/ZkdhYzKWuur5DQNuQdQ3zVN
         +f4G+dZgR6xUX1JhTbk+zDM4juWnMFmOBl9Rg=
Received: by 10.210.7.16 with SMTP id 16mr17529038ebg.14.1256637629614;
        Tue, 27 Oct 2009 03:00:29 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 28sm908060eye.23.2009.10.27.03.00.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 03:00:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200910271030.54571.schubert.seb@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131320>

On 10/27/2009 10:30 AM, Sebastian Schubert wrote:
> Hi,
>
> I would like to ignore files if certain other files are present. In my
> special case, I want to ignore foo.pdf and foo.eps if foo.fig is
> present (both pdf and eps are generated on the fly but don't belong
> into repository). In general, I do NOT want to ignore pdf or eps. There
> are a lot of foos so I would like to have a general solution.
>
> Is this possible?

I suggesting adding to your makefile a rule like

.gitignore: $(wildcard *.fig)
	(grep -ve \.pdf$ \.eps$ .gitignore;
	for i in $^; do echo $i; done | \
		sed -n 's/fig$/eps/p; s/eps$/pdf/p') > .gitignore.tmp
	mv .gitignore.tmp .gitignore

Paolo
