From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sat, 10 Mar 2007 11:14:13 -0500
Message-ID: <45F2D955.8050800@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net> <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 10 17:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ4D3-0007W0-Gv
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 17:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767860AbXCJQOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 11:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767859AbXCJQOL
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 11:14:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:29440 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767858AbXCJQOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 11:14:09 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1197424wxd
        for <git@vger.kernel.org>; Sat, 10 Mar 2007 08:14:09 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=txcx6YHDF03q3L3lGgVj8Va+ygS1D4pPKTvJqq6HcT8dIOGK8jWLtzlx47HJlLQE17Ely0DWlIu1bhQ7eEMDmTKqV97FA5vEG17EXtBXlT7w8DUljUgTbG7+KYDXCIL8vZpN2D17Lb2TBljS7tsUsJu+ZmA4v+ril9BscTrZFPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uDqYpD5IzmAUXetVPBdAInpUGTytNyxLn/j1sZWELuK0ebK6SGzf912wBIkvRk9AuqwzhNJCI6oqVVcZ303GeiSO/dFrzYZOUMvtY1RBJ+KXtgDbozQwwnxOrISiCcH967H0taxQWmzqsefT14/uHLMb0FCpausHSc8s1bAT28g=
Received: by 10.90.96.20 with SMTP id t20mr1042957agb.1173543249211;
        Sat, 10 Mar 2007 08:14:09 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id 20sm4347092agd.2007.03.10.08.14.08;
        Sat, 10 Mar 2007 08:14:08 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41867>

Johannes Schindelin wrote:
> Hi,
>   
> IMHO saying "master ^master" should blow into the user's face. If she says 
> "I want it" _and_ "I don't want it", she should sorta expect it not to 
> work.
>
> Ciao,
> Dscho
>
>   
The command
    git-bundle create foo next ^master

is legitimate, even if next points to the same commit as master. The 
current logic would reject this, and should not as we might want to push 
out the base of a new development branch in this manner. Consider that 
git-fetch <url> would happily update next in this case, git bundle / 
git-fetch should as well.

I think we should think of the git-bundle command as accepting two lists 
of rev-args
1 - the list of heads to define in the bundle (possibly --all, should 
also accept refs/heads/*)
2 - the list of commits to require as prerequisites for applying the 
bundle (possibly defined as --since=, possibly defined as a list of 
commits, etc).

As long as the lists are syntactically acceptable (all exist), we should 
just create the bundle with the given refs and prerequisites. The 
resulting bundle will apply cleanly and conforms to general git 
semantics. So, I think git-bundle should error out only if a ref does 
not exist or if no refs are defined. An empty pack file is legitimate.

Mark
