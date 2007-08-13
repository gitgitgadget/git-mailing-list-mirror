From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk - dont warn when deleting synonym for current head
Date: Sun, 12 Aug 2007 21:51:04 -0400
Message-ID: <46BFB908.7050000@gmail.com>
References: <1186952583887-git-send-email-mdl123@verizon.net> <18111.39773.231609.306547@cargo.ozlabs.ibm.com> <46BFAF8E.1000508@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 03:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKP5S-0004bV-0f
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 03:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764976AbXHMBvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763700AbXHMBvJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 21:51:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:39071 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760575AbXHMBvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 21:51:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1080512wxd
        for <git@vger.kernel.org>; Sun, 12 Aug 2007 18:51:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PLvXsScoCEmjSDPwRSJIgX0fsZKjspyUsDcr7M6iv3XSod1EO5rsG/Wq+uB33WDTVKcx9XkEcmThvFF03P4xXRpCGb2qQiAkenHXDSMK0TYFFThVJRjx/k81qx1bIKcWeLRQ1463YslZnT/sPmc6KfUpFtfX2aai2igX3DczVJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=poMYCOzuHx8AnxCeCVDKsffQVkPbP1uLGh2Mw1BOdAGhhd5ErujpPXJdir0hdmTv73z+RIau0xFteNTw5MyHPQiOte2+z+Qp8hSh0CKIqmEf0x8T8IUaLYj8yqCdtFnsoeBJT8euPXmqxrsVuFgkkszKzyif4W5ZBtMLpe67K1M=
Received: by 10.70.17.1 with SMTP id 1mr9464280wxq.1186969867953;
        Sun, 12 Aug 2007 18:51:07 -0700 (PDT)
Received: from ?192.168.100.117? ( [71.246.233.117])
        by mx.google.com with ESMTPS id i38sm10459616wxd.2007.08.12.18.51.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Aug 2007 18:51:06 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <46BFAF8E.1000508@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55739>

Mark Levedahl wrote:
> current checked out branch = master
> HEAD contains ref: refs/heads/master
> foo points to the same commit as master
> I attempted to delete foo.
>
> Note: the context menu does not allow deleting the currently checked 
> out branch, so the referenced check is irrelevant to that.
>
By the way, I'm not sure how gitk can usefully do the implied check 
without loading the full repository DAG. The check requires finding that 
the referenced commit is not reachable by anything in .git/refs/* except 
the branch head in question, yet in general gitk has not explored all of 
those refs, only those explicitly given on the command line (or HEAD by 
default). So, unless "delete branch" is going to require a variant of 
"git-rev-list --all", I think the choices are either a) do what the user 
requested, or b) offer a "Are you sure you want to do this?" dialog 
followed by doing what the user asked.

git-branch -d is similarly challenged: it complains unless the branch to 
delete is reachable from the current HEAD, and requires -D to delete 
anything else. It does not check to see if the commit is otherwise 
reachable from .git/refs/*.

Mark
