From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Move worktree setup out of setup_git_directory*
Date: Mon, 25 Feb 2008 20:17:36 +0700
Message-ID: <fcaeb9bf0802250517x2192b51epf2a162b0a984e99c@mail.gmail.com>
References: <20080224044650.GA25343@laptop>
	 <7vr6f1sur3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 14:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTdDm-0005qZ-Ce
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 14:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbYBYNRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 08:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYBYNRl
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 08:17:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:45023 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbYBYNRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 08:17:40 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1325103fga.17
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nhSNxi2oFJud09BjaukG6vil92R6nyQ9By/tC/JTYmA=;
        b=GQe+Kk2dXxAL+I2skWTgxLLYzYLf/eFYmRkC1SrNNkcawML7hrBS7+bbtmZaIfzF6eob0uYAEK12Zfgo0zXtRkbBnM6Ja3a9ImRa1XRz8R963XFTbnXNczxTnkPdtRB1DmNSHdT/x+c/BFLklFOHXOuw2Sp/83p4+burCXr6jT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=stgpxmQeln9R5mYMtvDjc5klZ39phDDqgfVSU50wfUofelPG10qArnPveK+2ukrzjOkRcS9Z7OzL42DTYWGnruoohT16JqRYM1k86aaj6oX7Bx4S/Jbc3u9Jif0I1WWxD5pbNS4Fn3eZMbWCTQy923EvUx11lbvbspVgP0iWbbo=
Received: by 10.86.9.8 with SMTP id 8mr2897362fgi.70.1203945456106;
        Mon, 25 Feb 2008 05:17:36 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Mon, 25 Feb 2008 05:17:36 -0800 (PST)
In-Reply-To: <7vr6f1sur3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75025>

On Mon, Feb 25, 2008 at 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>   - At startup:
>
>    - If the command always need to run from a repository, call
>      setup_git_directory(), which would complain and die if you
>      are outside.
>
>    - If the command can optionally run in a repository, use
>      setup_git_directory_gently(&nongit_ok); it won't complain
>      but sets nongit_ok to true if run outside a repository.
>
>    In either case, they return prefix string to be used for
>    setup_work_tree() later.
>
>    In either case, there is no chdir() done at this point.

Interesting. It currently does chdir(). But it is pointless now as
worktree should not be accessed until setup_work_tree() is called.
setup_git_directory* should not return a prefix at all.

>   - After calling setup_git_directory(), or you made sure you are
>    in a repository after callilng setup_git_directory_gently(),
>    call setup_work_tree().  This will chdir to the top of the
>    work tree.
>
>   - When you need to know where $GIT_DIR is, call get_git_dir().
>    When you need to know where the work tree is, call
>    get_git_work_tree().  However, it is an error to call these
>    functions before calling setup_git_directory and
>    setup_work_tree.

I guess I just need to verify your statements and put them to
Doc/technical/api-setup.txt ;)
-- 
Duy
