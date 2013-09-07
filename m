From: =?ISO-8859-1?Q?J=F8rgen_Edelbo?= <jed@napatech.com>
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Sat, 7 Sep 2013 19:03:53 +0200
Message-ID: <522B5C79.3000107@napatech.com>
References: <20130906105022.0718C12156D@jed-dev-01.labnet> <CABURp0qL6CSmt87OnTpRjS4VFikfA3O+w7-HgfB9d6Kip46EpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, <patthoyts@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 19:13:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIM4y-000060-0s
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 19:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab3IGRNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 13:13:44 -0400
Received: from mail01.napatech.com ([188.120.77.121]:58306 "EHLO
	mail01.napatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab3IGRNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 13:13:43 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Sep 2013 13:13:43 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqIEACNcK1IK8AFC/2dsb2JhbABahBC/FYJzgTp0giUBAQU4HiIBEAsYCRYPCQMCAQIBRQYNAQcBAReHa8N+jjaBSgeEHQOIfZUkizqBOoFogig
X-IPAS-Result: AqIEACNcK1IK8AFC/2dsb2JhbABahBC/FYJzgTp0giUBAQU4HiIBEAsYCRYPCQMCAQIBRQYNAQcBAReHa8N+jjaBSgeEHQOIfZUkizqBOoFogig
Received: from [192.168.1.33] (90.184.201.20) by cph-gen-exch01.napatech.com
 (10.240.1.66) with Microsoft SMTP Server (TLS) id 14.1.438.0; Sat, 7 Sep 2013
 19:03:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CABURp0qL6CSmt87OnTpRjS4VFikfA3O+w7-HgfB9d6Kip46EpA@mail.gmail.com>
X-Originating-IP: [90.184.201.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234139>

On 06-09-2013 23:49, Phil Hord wrote:
> Can you think of a sane way to separate the "from" and the "to" branches in
> the GUI?  I mean, I would like to push "HEAD" and I would like it to
> go to "refs/for/frotz-2.0".

My first attemt at this change was to do do exactly that: always push 
HEAD, and being able to specify the destination branches. If it was a 
Gerrit review server, it would replace refs/heads/... with refs/for/...

However, it is now clear, that we have to support specifying the 
branches to push.

My next thought was: could we add an entry to the list of branches to 
push, meaning "omit the branch specs in the command". Then it should 
just perform a "git push <remote>". What was then pushed would depend
on the push configuration for the remote. In the Gerrit case we could 
then have:
   push = HEAD:refs/for/master, or whatever.

The drawback of this solution is that the UI is not so intuitive and it 
would not support the case where you would want to push your branch 
frotz to refs/for/master/frotz, which is the way you specify a topic in 
Gerrit. The current solution supports this.

What remains to support is the case where you work on a detached HEAD. 
Most of it should be straight forward. The gui knows we are in detached 
state, so in this case, a "HEAD" entry could be added to the list of 
branches. The question is just: to which branch to push to in the non 
Gerrit case? Perhaps the ref specs could just be left out in this case.
