From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: fix support for repository directories with spaces
Date: Wed, 18 Jun 2008 00:07:00 +0200
Message-ID: <48583584.6030906@gmail.com>
References: <1213664977-23964-1-git-send-email-LeWiemann@gmail.com> <m3k5goon7v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8jLr-0004li-VN
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761206AbYFQWHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760537AbYFQWHL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:07:11 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:31439 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760273AbYFQWHG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:07:06 -0400
Received: by fk-out-0910.google.com with SMTP id 18so4062173fkq.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=ZdPYSqSHUNZqv2YjQC2x7IO9QEhZ32iuO7FDJBMiBnk=;
        b=Og62XWMp6Ij3gd9xVDI5mmh63LISgpLJaWxrRc+UTsavjE9+KlNTS/HPVVwDgrK/lL
         hk/7M1NjmKq0k45e4N4fsOrvyAYZuuk+8ERfcGl/pO/5MXLyWH2Itc8wJp4wNTKI6qLG
         skHRAnyKYbnHyRay+UexHmGwPzvBJhdrLEBWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=ZW0+ZiDrmKpNNJZg1IAcGe8DIfp/nWe6vnw250Kkh61EOeoMGpeAkix1x3aFbNAFvm
         crodaWOHW/MZzn+lBrvOs5C8BSjNIfeWIt+7YNfGq0ZDuAqaqUMDzPVtjT/Pqj5jlw44
         hjjZQPbhrsW3VnU8IdQsj1Uk/rXOD7w8WoyeM=
Received: by 10.78.183.20 with SMTP id g20mr3350047huf.31.1213740421927;
        Tue, 17 Jun 2008 15:07:01 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.241.48])
        by mx.google.com with ESMTPS id v30sm5107948hub.39.2008.06.17.15.07.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 15:07:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <m3k5goon7v.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85331>

Jakub Narebski wrote:
> I'd like to do away with need for git_cmd_str(), but unfortunately it
> is needed in a place where git has to form pipeline, namely in
> creating externally compressed snapshot (in git_snapshot), and to
> redirect stderr to /dev/null in git_object.

git_objects's use of 2> /dev/null won't be necessary since the Git::Repo 
API uses cat-file --batch-check, which doesn't (well, shouldn't) write 
on stderr.

If the use of shell command lines in git_snapshot bothers us enough, we 
can (a) create the pipe ourselves and just have it not work on Windows, 
(b) create it ourselves and spend a lot of time working around Windows' 
horribly borked API, or (c) use Perl's Zlib/Bzip2/LZO libraries.  If 
anything I'm in favor of (c), though it makes installation harder if you 
want compressed tarballs.  I'm fine with leaving it as is.

-- Lea
