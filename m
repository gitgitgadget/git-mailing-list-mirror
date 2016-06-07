From: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Subject: Re: [RFC/PATCH v2] pull: add --set-upstream
Date: Tue, 7 Jun 2016 15:42:34 +0200
Message-ID: <eb423083-2574-45a7-ed78-4ebb75363141@grenoble-inp.org>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
 <20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
 <2DE0829216C940168DCD804378CD18CC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jordan.de-gea@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org, gitster@pobox.com,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 15:43:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAHHH-0008Vd-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 15:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbcFGNmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 09:42:38 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:39016 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbcFGNmi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 09:42:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2611B256B;
	Tue,  7 Jun 2016 15:42:35 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 73eEixnzv1Tz; Tue,  7 Jun 2016 15:42:35 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 15D6B2561;
	Tue,  7 Jun 2016 15:42:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 0F7AF2066;
	Tue,  7 Jun 2016 15:42:35 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B92Zjbsjv7ib; Tue,  7 Jun 2016 15:42:35 +0200 (CEST)
Received: from [130.190.32.141] (eduroam-032141.grenet.fr [130.190.32.141])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B33882064;
	Tue,  7 Jun 2016 15:42:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <2DE0829216C940168DCD804378CD18CC@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296679>



On 06/06/2016 18:29, Philip Oakley wrote:
>> + that each one tracks the remote branch pulled from. If a configuration
>> + already exists, it is overwriten. For example, with `git pull -u origin
>> + branch` the current branch will track `branch` from `origin`.
>> ++
>> +If two or more branches are pulled on the same local branch, only the
>> last one
>> +in arguments will be tracked.
>
> Is this specific to this pull --setupstream or a general worning ? i.e.
> that a second entry is created in the config file, or that only the last
> branch refspec will be added?

Only the last branch will be added. More precisely, its behavior is just 
like `git push --set-upstream`. If you do `git push --set-upstream 
master:master master:other`, git will change its configuration twice and 
will print out:

$ git push --set-upstream origin master:master master:other
[...]
Branch master set up to track remote branch master from origin.
Branch master set up to track remote branch other from origin.

And at the end, "master" will only track "other" from origin and both 
"branch.master.{merge, remote}" will be set once.
So for now, `git pull --set-upstream` does the same and for example, on 
master:

$ git pull --set-upstream origin master other
[...]
Branch master set up to track remote branch master from origin.
Branch master set up to track remote branch other from origin.
