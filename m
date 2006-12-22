From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 08:31:25 +0000
Message-ID: <200612220831.26497.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <20061221182102.906ad046.seanlkml@sympatico.ca> <7vvek492q1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 22 09:31:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfoV-0007KS-Oy
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945985AbWLVIbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945986AbWLVIbd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:31:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:28664 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945985AbWLVIbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:31:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2908024uga
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 00:31:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kGV9aaYQ+s9xq9f9nJw0HdmnXncsCUOu8PT5dwYdj1znGmEftqgRC1PZx3JkJF8TUnJc2g55Mnie7wo/833x75cj46baNJpNujEFeV4c2/7sZB2dVaBIrrAusQhPt90iWnpiYG4oGR9csoRfKKdFSTeH247QcpWw8py1khTs3mQ=
Received: by 10.67.119.9 with SMTP id w9mr422351ugm.1166776291185;
        Fri, 22 Dec 2006 00:31:31 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id 34sm12911167uga.2006.12.22.00.31.30;
        Fri, 22 Dec 2006 00:31:30 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vvek492q1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35145>

On Friday 2006 December 22 00:46, Junio C Hamano wrote:

> You can always say "git log refs/heads/next" even though you are
> allowed to say "git log next".  Maybe we should remove that
> shorthand to make it consistent?   I think not.

On a related subject - I'd like to remove all the "refs/" literals from git.  
All refs are always under "refs/", so prefixing everything with refs/ is just 
noise.

The place that makes it stand out that this is wrong is (I think) found in 
refs.c (excuse my abuse of syntax):

int for_each_ref(each_ref_fn fn, void *cb_data)
    return do_for_each_ref("refs/", fn, 0, cb_data);
int for_each_tag_ref(each_ref_fn fn, void *cb_data)
    return do_for_each_ref("refs/tags/", fn, 10, cb_data);
int for_each_branch_ref(each_ref_fn fn, void *cb_data)
    return do_for_each_ref("refs/heads/", fn, 11, cb_data);
int for_each_remote_ref(each_ref_fn fn, void *cb_data)
    return do_for_each_ref("refs/remotes/", fn, 13, cb_data);

What's significant is that it is only for_each_ref() that hands the prefix 
back.  The change I'd like to make is 
    return do_for_each_ref("refs/", fn, 5, cb_data);

Obviously, this will imply a lot of changes everywhere else; so I didn't want 
to dive into it without mentioning it here first.

Is this a sensible thing to want to do?  

As I'm talking about code cleanups, I'd also like to change all variables 
called "sha1" to "hash" (or similar).  The point being that the variables 
hold hashes not sha1's.

I don't say that the above are serious problems, I just like cleaning code :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
