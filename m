From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: "clean" filter breaks git-svn
Date: Fri, 30 Jul 2010 15:31:11 -0500
Message-ID: <20100730203111.GD2448@burratino>
References: <AANLkTikp6PgHyj2ujbuD52884ny88hMyxR1CpsbNAVCJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matt Wozniski <godlygeek@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 22:32:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OewFv-0001fr-17
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 22:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab0G3Uc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 16:32:29 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59908 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab0G3Uc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 16:32:28 -0400
Received: by qwh6 with SMTP id 6so372278qwh.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wlQqF5zWXZvVc7gIjgmui/JR5cI5ZoxTCYhWoXSazhQ=;
        b=UqGTklfE1DivuEEc5X85or7p/k2djpwTiwuRGBHHg4GqtL6Yz/alCmA8TCbHRUZQGB
         I78UfhYKmrHmGFwXhhlciztoV5vtSHSDgoUaaDgYzLm7LmxIo6Zl+H0UGyfpXk1LqugC
         o1+TRB7x5BllO/TxLddjCp+zYle++rind0zFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aOKJItEtC3x4nke/8r9vO2iW03pvv3AjkYYTvRHt8XVl3VFUdVHPRU51ryRRjE9g/K
         mj9IL9GqgSdDSnghHu0nYvUTOWo1HwS4dlENnkyjgB+tWxhYBcZX8Eyfu8CPElsPOq0b
         Nlz7o7Q1fKuKaK+UMZGT0fxgwYFCg/KbSBC6o=
Received: by 10.220.187.5 with SMTP id cu5mr2037918vcb.0.1280521947028;
        Fri, 30 Jul 2010 13:32:27 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v11sm1430806vbb.12.2010.07.30.13.32.25
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 13:32:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikp6PgHyj2ujbuD52884ny88hMyxR1CpsbNAVCJ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152266>

Hi Matt,

Matt Wozniski wrote:

>                                              When trying to fetch
> commits A and B from the SVN repos, it will fetch A, and then clean(A=
)
> is committed to my repository.  Then when it tries to fetch B, it is
> horribly confused - it complains of a checksum mismatch, since the
> md5sums of the files in A in the SVN repos don't match up with the
> md5sums of the files in the clean(A) commit in git land.

Interesting.  Yeah, that sounds like a bug.

I am not convinced cleaning fetched files is the right thing to do in
the first place (why not just trust the SVN repo?), but I assume
people with workflows involving such filters could make a better call.

> Is this a
> known problem?

There is no test for it in git.git, so in that sense no.

>                                    Could git-svn be made to accept th=
e
> md5sum of *either* A or clean(A) instead?

I don=E2=80=99t think that would be right.  It=E2=80=99s not just the m=
d5sums not
matching that is the problem; it is that in these situations git-svn
and the SVN server do not agree about the file=E2=80=99s current conten=
t.

Once the code makes the semantics clear, I assume it should Just
Work=E2=84=A2.

Good luck,
Jonathan
