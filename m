From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix support for repository directories with spaces
Date: Wed, 18 Jun 2008 00:27:47 +0200
Message-ID: <200806180027.47810.jnareb@gmail.com>
References: <1213664977-23964-1-git-send-email-LeWiemann@gmail.com> <m3k5goon7v.fsf@localhost.localdomain> <48583584.6030906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:29:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8jfb-0004S7-IE
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758538AbYFQW17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758510AbYFQW17
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:27:59 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:3737 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010AbYFQW14 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:27:56 -0400
Received: by an-out-0708.google.com with SMTP id d40so1362805and.103
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xTkfhiPRhT56VVMagRkuYW3yriA9dJc8y+bBtffHiQM=;
        b=sTim31j262Y7av+Pbpir8q6yOialKCxFF+YG2zkysqsw7eqC+NHSA6pDx0yMmQDbDa
         fOWIR6i9yw/EcwxA/ENiJY1E9lBVSgpyjbmMT1WCrdCvYjyMvybIfmCA61jdDSgV1lfo
         LJrM59xmHeAmXD0Rn50K+aqNvMxZvzHRpBB98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Fr9FwYr7ktLEZTHV6VhoJDa82n2qDe1Wz2yH641BmtXVuEoASOr/vCWhME2MJYFTvP
         73Mj64uH/+95iE65dibSf1l9oTNpwc8XMhRooxw7HZQMD9NEu/lihRNNl+6mdUtuBRc4
         OhKyX95+sgJhVne057sSkx2Tnz+Pc2l3eqCA8=
Received: by 10.100.251.11 with SMTP id y11mr11660222anh.114.1213741675294;
        Tue, 17 Jun 2008 15:27:55 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.204.69])
        by mx.google.com with ESMTPS id c39sm3591776anc.29.2008.06.17.15.27.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 15:27:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48583584.6030906@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85334>

Lea Wiemann wrote:
> Jakub Narebski wrote:
> > I'd like to do away with need for git_cmd_str(), but unfortunately it
> > is needed in a place where git has to form pipeline, namely in
> > creating externally compressed snapshot (in git_snapshot), and to
> > redirect stderr to /dev/null in git_object.
> 
> git_objects's use of 2> /dev/null won't be necessary since the Git::Repo 
> API uses cat-file --batch-check, which doesn't (well, shouldn't) write 
> on stderr.

Even without Git::Repo using git-cat-file new '--batch-check' option
would be good replacement.

> If the use of shell command lines in git_snapshot bothers us enough, we 
> can (a) create the pipe ourselves and just have it not work on Windows, 
> (b) create it ourselves and spend a lot of time working around Windows' 
> horribly borked API, or (c) use Perl's Zlib/Bzip2/LZO libraries.  If 
> anything I'm in favor of (c), though it makes installation harder if you 
> want compressed tarballs.  I'm fine with leaving it as is.

Please remember that gitweb is to be installed also in tightly
controlled server installations, where anything outside default
packages, or extras package repository, or at least trusted contrib
packages repository is out of the question.  Installing from CPAN
is not an option.

That is why I'd rather avoid dependencies on modules which are not
distributed with Perl by default.

And there is another solution, (d) add gzip/bzip2 compression support
to git-archive ;-P
-- 
Jakub Narebski
Poland
