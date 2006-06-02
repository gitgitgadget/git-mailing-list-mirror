From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] A Perforce importer for git.
Date: Fri, 2 Jun 2006 15:09:45 +0200
Message-ID: <81b0412b0606020609o24ee34b4p7b1bcd013136d49a@mail.gmail.com>
References: <BAYC1-PASMTP117796558F3B42B2C18DBCAE980@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 15:09:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm9PT-0007vt-1S
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 15:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWFBNJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 09:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWFBNJr
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 09:09:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:20843 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751367AbWFBNJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 09:09:46 -0400
Received: by wr-out-0506.google.com with SMTP id 36so583859wra
        for <git@vger.kernel.org>; Fri, 02 Jun 2006 06:09:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GCEdjisL+ZhM7012MeWj+zc2Le3JQNXGiXBhHOCvKdC41eM1RVBUALgcLUNvEhDLHU0/PEcJRQm5TIAqUQl5oXiC0/p75wzTYD+26bpE1ApWnU4osn4kJqkeyj6PEZqzqZxhAFjDsR6W6LdTdKEc9bjwr0I5tZUdvZM29vZbS6M=
Received: by 10.54.76.12 with SMTP id y12mr1811573wra;
        Fri, 02 Jun 2006 06:09:45 -0700 (PDT)
Received: by 10.54.67.11 with HTTP; Fri, 2 Jun 2006 06:09:45 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP117796558F3B42B2C18DBCAE980@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21156>

On 5/25/06, Sean <seanlkml@sympatico.ca> wrote:
>
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
> ---
>  Documentation/git-p4import.txt |  165 ++++++++++++++++++
>  git-p4import.py                |  357 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 522 insertions(+), 0 deletions(-)

BTW, can I suggest to import the _currently_ synced state?

The reason is that because of the way how Perforce is done
its working directories (views, aka clients) are often a
horrible mix of occasionally synced files to some random
versions. No one actually uses "p4 sync" for whole project here
where I work, because it is absolutely useless at this level
(updated files have abolutely no relevance at head revision,
which is what you get by syncing without strictly specifying
a revision). So a working state is stitched together from
a lot of "mappings": perforce path to local path -> revision.
That state can be actually worked on (up until you have
to commit something, that is not possible except on head).

That is why I actually can't sync before importing, but have
to use the method Junio described for CVS:
p4 sync files...#revisions
git add new-files...
git commit -a
(simplified. There are problems with case-sensitivity and that
stupid read-only attribute perfoce uses as sync marker).
