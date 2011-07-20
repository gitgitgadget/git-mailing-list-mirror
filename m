From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: pre-commit not working at server side push
Date: Wed, 20 Jul 2011 10:30:17 +0300
Message-ID: <20110720073017.GA10465@LK-Perkele-VI.localdomain>
References: <20110720121356.4dc21f6b@shiva.selfip.org>
 <20110720124538.482628e3@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Wed Jul 20 09:28:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjRD6-0003sB-Cg
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 09:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184Ab1GTH2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 03:28:43 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:57511 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab1GTH2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 03:28:43 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id E0D6918D292;
	Wed, 20 Jul 2011 10:28:40 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A021AAA279E; Wed, 20 Jul 2011 10:28:40 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 69DE427D84;
	Wed, 20 Jul 2011 10:28:38 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20110720124538.482628e3@shiva.selfip.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177524>

On Wed, Jul 20, 2011 at 12:45:38PM +0530, J. Bakshi wrote:
> On Wed, 20 Jul 2011 12:13:56 +0530
> "J. Bakshi" <joydeep@infoservices.in> wrote:
> 
> > Hello list,
> > 
> > I have this bash script to check php syntax error and prevent the commit if there is any
> > 
> > ```````````````````
> > #!/bin/sh
> > 
> > ##php_syntax_check
> > 
> >   for i in $(git diff-index --name-only --cached HEAD -- | grep -E '\.(php|engine|theme|install|inc>
> >         if [ -f $i ]; then
> >                 output=$(/usr/bin/php5 -l $i)
> >                 if [ "$output" == "No syntax errors detected in $i" ];
> >                 then
> >                         echo "PHP syntax check for $i: OK"
> >                 else
> >                         echo "=====================================================================>
> >                         echo "Pause $i for the commit due to PHP parse errors:"
> >                         echo "$output"
> >                         exit 1
> >                 fi
> >         fi
> >     done
> > 
> > ```````````````````

> seems it should be pre-receive hook at the server. So done accordingly but still not working 

Pre-receive runs after objects have been received but before branches are updated. So
it can inspect the newly arrived commits but the branches retain their old values.

- Firstly, the server does not have index, so diff-index does not do anything sane.
- Secondly, HEAD does not point to anything newly arrived (the hook gets list of update 
instructions via stdin).
- Thirdly, this hook must be prepared for multiple commits in multiple branches appearing at
once.

I think githooks(5) documents what these hooks receive and what they do.

-Ilari
