From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: core.autocrlf considered half-assed
Date: Tue, 9 Mar 2010 10:24:12 +0300
Message-ID: <20100309072412.GF31105@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de>
 <20100307092701.GC31105@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1003081225280.14277@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	torvalds@linux-foundation.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:29:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyVy-0001Do-R7
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0CIHYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 02:24:19 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:43589 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab0CIHYR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 02:24:17 -0500
Received: by fxm19 with SMTP id 19so7149309fxm.21
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 23:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zUJXI8fJEq77gbgunJMz5+GuTWGjo8e4vCJTTJGBw6k=;
        b=KMbTHRUDaUcFSS7L1UqY+94/iRdXes/dPooVAqNmQehBR6hqGq9tQGWnRfbdJri0Lk
         lctlAJAqcn9vtpGsCasnzKkTY1C6Vu9dl44atOizV04b0AMU4sICvfcET8KN6o/F46BD
         nRuRvISoOx23t2cDsnyeC3Mia5mkSjAJTcFPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q67EjehW5P/7CnfQFg57LwUXcarVvIZ5NNjg451daEUqL7FL9Wb4KeJFP4adz9fGw5
         3VvuueBjj5z0RxqecD4IdMSBuYFHV1wukKQDtJu6UTlPTJ4ZNMXqss57wFfAEVDwyjdF
         GbjbD7u1gN4DhacaHPrLl5+sySW/RLIoRkbJ0=
Received: by 10.102.16.13 with SMTP id 13mr4333437mup.62.1268119455585;
        Mon, 08 Mar 2010 23:24:15 -0800 (PST)
Received: from localhost (ppp91-78-51-61.pppoe.mtu-net.ru [91.78.51.61])
        by mx.google.com with ESMTPS id j9sm28298068mue.17.2010.03.08.23.24.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Mar 2010 23:24:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1003081225280.14277@intel-tinevez-2-302>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141804>

On Mon, Mar 08, 2010 at 12:29:01PM +0100, Johannes Schindelin wrote:
> 
> Easiest example:
> 
> $ git clone -n git://repo.or.cz/git.git html-docs
> $ cd html-docs/
> $ git config core.autocrlf true
> $ git checkout -t origin/html
> $ git status

As Junio explained in another mail, it was intentional to have all HTML
files with CRLF, because they are supposed to have that ending on all
platforms. What is missing, however, is .gitattributes, which would tell
to Git that we do not want to autocrlf conversion for HTML files. This
can be done by adding .gitattributes:

$ cat >> .gitattributes <<EOF
*.html -crlf
EOF

I've just noticed that user-manual.html differs from other HTML files in
that it uses LF ending. I think it is a mistake, and this file should be
converted to have CRLF, but if you want to have all HTML files except
user-manual.html to have CRLF then you can do that too:

$ cat > .gitattributes <<EOF
*.html -crlf
user-manual.html crlf
EOF

I hope Junio will add the right version of .gitattributes, so users with
autocrlf=true will not suffer.


Dmitry
