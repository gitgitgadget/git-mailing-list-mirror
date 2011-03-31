From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 195b7ca6 breaks t9010 at current master
Date: Thu, 31 Mar 2011 16:14:43 -0500
Message-ID: <20110331211443.GC19932@elie>
References: <AANLkTik0CNXY9bKGOa9Xmai_OPQgExfLsFs1yN2pCVr8@mail.gmail.com>
 <20110329042446.GB25693@elie>
 <YHiIPkNCiU3RcX-PxtGuaAPfpIMSLtDzcuGX-pUHbb_4SC5aAQu_WQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
	git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:15:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5PCj-0005IC-Kf
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 23:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758309Ab1CaVOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 17:14:54 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62450 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914Ab1CaVOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 17:14:52 -0400
Received: by qwk3 with SMTP id 3so1780263qwk.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Thz64NlG8D1EuiizAnTANtjZRd8zeIMoOIQwTj57lJg=;
        b=pUE0J4EKYrm+uUfrBEw+LIxG6+vRGiv957eRD2uZ8omxo3nGCNC1rVhGqEdC6FgFC6
         krF/hPI9bMaihecR1QAEUr9L9fNM52vrfieE3dlCbP+2Qbrv+tL82I7e2eTKLCyxN6vc
         QHjMA2dANNHL0sqjxq5O2iS+I/0bKUKqzU1WM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B0Q4GZ+bzz08KNSQBPZUx20zNybixPN4xpFjxXsQskq9vUzjpPSW1X9z65Mw/YBUmZ
         DpYVvVVSAIicUhOlvEv01Jci3aXfb+j7PY2KcOBA5DPTGps9UY9nKTSKFUjNCbamb4//
         4GjtSG0/ntW6ds8CJ/s0RkFwB0QYLKosx832g=
Received: by 10.224.216.133 with SMTP id hi5mr2503590qab.383.1301606090886;
        Thu, 31 Mar 2011 14:14:50 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id c27sm1051691qck.46.2011.03.31.14.14.47
        (version=SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 14:14:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <YHiIPkNCiU3RcX-PxtGuaAPfpIMSLtDzcuGX-pUHbb_4SC5aAQu_WQ@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170530>

Hi,

Brandon Casey wrote:

> I was just about to send a patch for this, when I noticed it has
> already been worked around in master by the above.
>
> I'll still share my one-liner for informational purposes which uses perl
> and in my opinion is a little simpler:
>
> --- a/t/t9010-svn-fe.sh
> +++ b/t/t9010-svn-fe.sh
> @@ -465,7 +465,7 @@ test_expect_success 'NUL in log message, file content, and property name' '
>                 git diff-tree --root --stdin |
>                 sed "s/$_x40/OBJID/g"
>         } >actual &&
> -       git cat-file commit HEAD | nul_to_q | sed -ne "/^\$/,\$ p" >actual.message &&
> +       git cat-file commit HEAD | nul_to_q | perl -ne "print if (/^$/..eof())" >actual.message &&
>         git cat-file blob HEAD^:greeting | nul_to_q >actual.hello1 &&
>         git cat-file blob HEAD:greeting | nul_to_q >actual.hello2 &&
>         test_cmp expect actual &&

Thanks.  I'll definitely use that idiom the next time this sed gotcha
comes up.

Also if you're interested, I'd be happy to take a patch on top to
make it so as a cleanup (probably splitting the line at the same time,
since it's getting pretty long).
