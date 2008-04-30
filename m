From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [regression?] "git status -a" reports modified for empty submodule directory
Date: Wed, 30 Apr 2008 23:56:29 +0800
Message-ID: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
	 <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
	 <7v4p9k7326.fsf@gitster.siamese.dyndns.org>
	 <4818143C.6050206@viscovery.net>
	 <7vej8n3imp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 17:57:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrEgL-0001v2-8Q
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 17:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbYD3P4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 11:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbYD3P4b
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 11:56:31 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:54610 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303AbYD3P4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 11:56:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so120457and.103
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=L2s18F5KupXKwWvBMmd3FslzC79aEsVg5jlnN+VoY38=;
        b=cH4l2EuXztT8pYbQzixBvNTqdmXRd9hp7/XFk82wcaRsODIbgg9pYpVUTpGmuJAC5jTkJHYbShb9/hPREUTc6dp29FjdRt5DuyGEfQY8OTvWj29vuRHz6XO6pOOvLgxrf2Q0WkvYL2MlXUuS76XbqZZ7x5Sl/tIqQknkTGCQ9uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=adXHjYuonzFWEzZb3fss/1HV5BTqPR1rS5k1m2cOS4f+6QcbFYGIzc3cU5kjKjWciFMujBL8sFCe5wQFpLtD71QYh1W8YaG3PtE6/wiwBQL6PTnjGLdd00K+h70ssSHvKj15hG3r/J00GcYINGtUcStr+TSqv/uCykYvGPo9jjM=
Received: by 10.100.194.17 with SMTP id r17mr1484233anf.127.1209570989686;
        Wed, 30 Apr 2008 08:56:29 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 30 Apr 2008 08:56:29 -0700 (PDT)
In-Reply-To: <7vej8n3imp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80841>

On Wed, Apr 30, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>
>  For example, it has long been known ever since submodules were introduced
>  that if you work inside a sparsely checked out supermodule you have to use
>  "commit -a" with care, because the command notices missing submodule, and
>  there is no way for it to differenciate between the case you _want to_
>  remove it and the case you did not care about it,

If i am not misunderstood, there is one way now (although broken now,
it used this kind of behaviour before git-status became built-in):
empty directory to denote that the submodule is not checked out and
unaware, and deleted directory to denote that the submodule is
deleted.

Actually, i don't like the empty directory trick, since it will leave
so many empty directories in a repository with many submodules
unchecked out.

>
>  That quirk was something people could live with while submodule support
>  was merely a newly invented curiosity.  But I do not think a command at
>  high level (iow Porcelain) such as commit and status should be left
>  unaware of the Policy that equate missing submodule and unmodified one
>  forever.  We should actively enforce the policy, so that unless you
>  explicitly ask nicely, the command should consider a missing submodule
>  just as unmodified, e.g. "commit -a" should not remove unchecked out
>  submodules.
>
>  But then you would need a way to ask nicely.  How?  Perhaps using "git rm",
>  and low level "update-index --remove".  Do we even need "commit -A"?  I
>  doubt it --- you do not remove submodules every day.
>
>  We'd like to keep the lowest-level unaware of the Policy, which means that
>  "diff-files" and "diff-index" should report unchecked out submodules.
>  Otherwise script writers will be left with no way to differenciate missing
>  and removed submodules.

Good point.

>
>  Once we start doing this, I think "git diff" Porcelain should fall into
>  Policy-aware category.
>

Agree this pilicy.

If this change needs a long way. Should we fix the regression first?
Anyway, 'git status' and 'git status -a' should behave the same for
submodules unchecked out. I have tried but i failed. I just found this
regression was introduced on the first day of built-in status

-- 
Ping Yin
