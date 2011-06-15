From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 16:14:05 +0200
Message-ID: <201106151614.06529.jnareb@gmail.com>
References: <4DF87B42.1020004@st.com> <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com> <4DF89F56.3060200@st.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "kusmabite@gmail.com" <kusmabite@gmail.com>, ae@op5.se,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 16:14:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWqrf-0005gd-PO
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 16:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab1FOOOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 10:14:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57594 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab1FOOOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 10:14:16 -0400
Received: by bwz15 with SMTP id 15so489958bwz.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=5rj4wL16033765ZGecuj2SIGDt3xq4gJhFCe6y+MQ6w=;
        b=aEDImQ9v1DEkn+LeHVu1tNpSvxh8Zr92j8Do7/WRYLqceprAh0QMCIrFW0lwT82zX8
         4oT/LBxfiQqVaFOloTdmK4j/4xHcft5oREoMFrhrfQQONytlDs30qzDTmKRH76RjrAxO
         v9EPVuKhPJmAgZ+DmL9XQYEcLzsajdAYBpYMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Z4jYhuZg8b14nsGps5xK+JCR/EUGbpCkF9x5KxjN5HaVpeElificmQhyOKQTVrcLdj
         5HIqUbfsDt/Z3WsFbe+JHXsKwEczxqkrMWyIegf/pRPNDEelpJ1j319Hf8XvFIUlrTef
         iaqGYwFIVcGZM+Y96YXtuPTz1Sa/o7jcJ8Jwk=
Received: by 10.204.14.208 with SMTP id h16mr590679bka.35.1308147254678;
        Wed, 15 Jun 2011 07:14:14 -0700 (PDT)
Received: from [192.168.1.15] (abwp5.neoplus.adsl.tpnet.pl [83.8.239.5])
        by mx.google.com with ESMTPS id k16sm491097bks.13.2011.06.15.07.14.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 07:14:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF89F56.3060200@st.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175834>

On Wed, 15.06.2011, viresh kumar wrote:
> On 06/15/2011 04:59 PM, Jakub Narebski wrote:

> > Ah. This is caused by the fact that FAT doesn't store executable
> > permission.
> > 
> > So beside setting `core.symlinks` to false, you would have also set
> > `core.filemode` to false (and perhaps also `core.ignorecase` to true).
  
> [...], but there is one more issue, as pointed out by
> Andreas. There are few files in kernel with same file name but in different _cases_ (one in caps 
> and another in small.) and so i am getting issues with these now.
> 
> And don't have any idea how to get rid of that?

core.ignorecase::
        If true, this option enables various workarounds to enable
        git to work better on filesystems that are not case sensitive,
        like FAT. For example, if a directory listing finds
        "makefile" when git expects "Makefile", git will assume
        it is really the same file, and continue to remember it as
        "Makefile".

	The default is false

But that wouldn't unfortunately help when there are two files which
filename differs only in case.

You would have to do tricks with `git update-index` and its 
--assume-unchanged bit (though perhaps `core.ignorecase` would be
enough) and `--cacheinfo <mode> <object> <path>` together with
`git hash-object -w`... 

Or perhaps delete file which you have in working area, checkout
one file, add it, checkout other file, add it, use 'git commit'
and not 'git commit -a'.

But that are only possible solutions; I have sane filesystem.

Can't you work on NTFS, and use USB stick only for transport of
either tarred repository, or bundle?

> And why does kernel have such file names at all? 

That I don't know.

-- 
Jakub Narebski
Poland
