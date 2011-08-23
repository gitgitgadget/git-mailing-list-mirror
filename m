From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's the difference between `git show branch:file | diff -u
 - file` vs `git diff branch file`?
Date: Tue, 23 Aug 2011 12:03:28 +0200
Message-ID: <4E537AF0.9070604@drmicha.warpmail.net>
References: <loom.20110823T091132-107@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 12:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvnpY-0008Ms-HX
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 12:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab1HWKDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 06:03:32 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57850 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751022Ab1HWKDa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 06:03:30 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4CAE220B7E;
	Tue, 23 Aug 2011 06:03:30 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 23 Aug 2011 06:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4p8m05IlmtlT39cscHVhTh
	oBKpQ=; b=Wy7eWU7tTQbdKEWVTiGy6bD0C8JHVyMbeXWxLLTecfB9iGmtIfeqij
	jiBLiyt9iwGRkLupFYbkbtOTsNzvySaLrTOyPSisy67nihBvZDM7bAChxvSiUsgV
	VaX6VJGgtH2RSJzuDzKozGhYwYBoCxEt9cz727M/MWAS0CGVyKtp0=
X-Sasl-enc: VMiNoGNW/dIWDktyZTMHV7in4vDd2dmuha3MmAHTHyZP 1314093810
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B3B62901265;
	Tue, 23 Aug 2011 06:03:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <loom.20110823T091132-107@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179932>

Marat Radchenko venit, vidit, dixit 23.08.2011 09:25:
> $ time git show branch:file | diff -u - file > /dev/null 
> 
> real    0m0.003s
> user    0m0.000s
> sys     0m0.000s
> 
> $ time git diff branch -- file > /dev/null 
> 
> real    0m31.442s
> user    0m31.040s
> sys     0m0.380s
> 
> What does git diff do so it takes that much time? And is there any flag to git 
> diff so that it will work as fast as show + diff? I thought these two are 
> equivalent but from run time it is obvious that they aren't.
> 
> gprof output: http://slonopotamus.org/git-diff/git-diff-branch.gprof.txt
> 

Is that a very large tree or a very slow file system?

>From the gprof output, it would appear that we compare a lot of cache
entries (or rather: spent most time on...). Do we enumerate all
differing files and only then limit diff output by path??

Michael
