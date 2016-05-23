From: Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
Subject: [RFC] Asymetric implementation
Date: Mon, 23 May 2016 17:09:25 +0200
Message-ID: <104FC79E-501B-4AA6-BE73-D0001D78F4B8@ensimag.grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Samuel Groot <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan Mathoniere <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 17:09:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4rU6-0008FP-KO
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 17:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbcEWPJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 11:09:30 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:52954 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877AbcEWPJa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 11:09:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 696E82111;
	Mon, 23 May 2016 17:09:26 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hPUr38nwyLmL; Mon, 23 May 2016 17:09:26 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 51E5B20FF;
	Mon, 23 May 2016 17:09:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 4BEA42077;
	Mon, 23 May 2016 17:09:26 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wB1-XUPH_rt0; Mon, 23 May 2016 17:09:26 +0200 (CEST)
Received: from eduroam-033182.grenet.fr (eduroam-033182.grenet.fr [130.190.33.182])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 329982066;
	Mon, 23 May 2016 17:09:26 +0200 (CEST)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295332>

Hi everyone, 

here is the fact, working with an asymetric workflow is not as easy as it could be. 
There are many options only setting by hands. And they are not easy to use, to understand and sometimes there are not suitable. 

This is an example of what git could do :
Environment : 
- You have the main repository -> A.
- You have the fork repository of A -> fA
- You have the clone of fA on your computer. 
- You want to work on fA/master and synchronize your branch A/branch1 with A/master

So, you need to link the pull request to A/master and the push request to fA/branchA. 

Configuration :
 - branch.branchA.remote with A
 - remote.pushDefault with fA or branch.branchA.pushRemote with fA
 - branch.branchA.merge with fA.

The steps to set those parameters are not user friendly, not complete and mistakes can happen(with --set-upstream for example)

We are working on it and have solutions about it. Please, tell me what is the best for you and why ?

Here is the solutions : 

1.
a. add the config var : remote.pullDefault
b. add the config var : branch.<name>.pullRemote
c. add `git pull --set-default` in order to set remote.pushDefault
d. add `git pull --set-remote` in order to set branch.<name>.pullRemote

With that solution, git will have a complete configuration with :
 - branch.<name.>remote, branch.<name>pullRemote and branch.<name>.pushRemote.
 - remote.pullDefault, remote.pushDefault


2.
a. add `git pull --set-default` in order to move branch.<name>.remote to remote.pushDefault
b. add git pull --set-remote` in order to move branch.<name>.remote to branch.<name>.pushRemote

With this solution, we only add options for commands and not in config file. 


You can add your solution. 


I think that the first one is the best for now and for the future. The second one seems to be the easy way to implement but not the best. 


What is your opinion ? 


Best Regards. 




Jordan DE GEA
ENSIMAG 2A - ISI
jordan.de-gea@ensimag.grenoble-inp.fr
