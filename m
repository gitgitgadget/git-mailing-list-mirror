From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC 3/7] git-submodule: Fall back on .gitmodules if info not found in $GIT_DIR/config
Date: Sat, 12 Apr 2008 12:26:07 +0800
Message-ID: <46dff0320804112126l6ac3bcf4q8b7cc7b09e596479@mail.gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-4-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-6-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-7-git-send-email-pkufranky@gmail.com>
	 <7v1w5cotz2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junio@pobox.com>,
	"Roman Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 06:26:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkXKJ-0004yY-6G
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 06:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYDLE0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 00:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbYDLE0J
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 00:26:09 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:33517 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbYDLE0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 00:26:08 -0400
Received: by an-out-0708.google.com with SMTP id d31so181770and.103
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 21:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oFSV/2VDIC+X2n6fV53Bbj9YdX4iUJPzNVE1XWpsL/M=;
        b=MgGZVVHgvTCcoMfLHH6K0e7NmMn4ah6ly5pJNPGzFYZyw1RV1gktMAOMw0BWBmgoW+5yxlFuUnXMFvDn7WA6uwKbqmKnL7k8FbZiGF8BALHDvovsETOkD4cNRlR7D6p+shMlVBpgWJIlvZTteGOHdvbI92TkwNic4E1Em9wYlqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L781D52SsnTiNilsirea7Qz4ianuisG8tQ28Me2EbiwyKr/Mcj/jwo4rI1UZrIRmViX0237tk+BtZ5szD1Q3QGUGLKarcXC/bRRq60hrUGV0fcwzptx63Br018u8TP8PUKdasERiQZ4jptj+JdiGP8BMnjxWGvkBS57dtzS0S1E=
Received: by 10.100.10.11 with SMTP id 11mr6853649anj.109.1207974367113;
        Fri, 11 Apr 2008 21:26:07 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 11 Apr 2008 21:26:07 -0700 (PDT)
In-Reply-To: <7v1w5cotz2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79328>

On Sat, Apr 12, 2008 at 7:24 AM, Junio C Hamano <junio@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > Originally, the submodule workflow enforces 'git init' in the beginning
>  > which copies submodule config info from .gitmodules to $GIT_DIR/config.
>  > Then all subcommands except 'init' and 'add' fetch submodule info from
>  > $GIT_DIR/config and .gitmodules can be discarded.
>  >
>  > However, there may be inconsistence between .git/config and .gitmodules
>  > when always using 'git init' at first. If upstream .gitmodules changes,
>  > it is not easy to sync the changes to $GIT_DIR/config.
>
>
> Maybe you missed an earlier thread with Roman Shaposhnik where this issue
>  was discussed and a solution more in line with the original intent of the
>  design of the submodule system was mentioned (actually I should not take
>  credit for that suggestion as it was not mine but somebody else mentioned
>  it back when git-submodule command was initially being designed.  I only
>  recalled there was that one issue in the old discussion but there might
>  have been others)?

You mean use "hooks" to update $GIT_DIR/config with user interaction
when .gitmodules changes? Or give user hints when "git submodule
update" fails?

What you said in that thread is that the url in $GIT_DIR/config is
different from the one in .gitmodules (with protocol change perhaps)
originally, and then the url in .gitmodules changes. So when "git
submodule update" fails, it notices this change and tell the user.

What i mean here is another case. The url in $GIT_DIR/config is the
same as the one in .gitmodules, and then the url in .gitmodules
change. So this change can be synced automatically to $GIT_DIR/config.

However, when both cases happen in the same time, there is no way to
differentiate these two cases. So the command  can't do something
automatically and has to leave all choice to the user.

In an environment with central repositories, all submodule urls will
be the same between $GIT_DIR/config and .gitmodules. It is a little
annoying to give so many users this kind of uneccessary choice if the
submodule url changes in .gitmodules.



-- 
Ping Yin
