From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] git-send-email: parse all messages in mbox
Date: Thu, 14 May 2009 10:48:33 -0400
Message-ID: <76718490905140748n390d0e85t8349b69fc6debc2a@mail.gmail.com>
References: <873abbeoqc.wl%vmayatsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 16:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4cEj-0002pE-Tt
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 16:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbZENOsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZENOsd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 10:48:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:15243 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbZENOsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 10:48:33 -0400
Received: by yw-out-2324.google.com with SMTP id 5so740140ywb.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/49mFkz4gWNclvuDpwt7HhypckQh5lqBvpEdzRzVuAA=;
        b=CaRvEThyLoEKhwF+ssUffrXA/p7uZlEdfVO19iwhZpC1fhb1z/XhyJfz01IaiLTb0E
         wdliuzrx2HWrrTUd4Q4X2WmwIcUXj5/hPgWrz/n14klGC0V7yqd0sTrw7Ys3CajP86zb
         jpz1m60p9IKXi70/Sd5GnfOipPk2kjzp01F2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X6dLGXtnx1XKJ1lNi2YiZEoxFuHm8GtwD0j+erXc6EDcOuSZ37HHjd3RFz1O1yerC6
         NFbZoyaveYn4x8IlE5eU5tGc2LyF7E0H99fs3cnSvayMqYd/Iubl7/U0q6Yli3PKIkSL
         b0SQGCofSUc/QjqzcUiKcjMuL85nkUz8/ScaI=
Received: by 10.151.50.7 with SMTP id c7mr3704318ybk.110.1242312513912; Thu, 
	14 May 2009 07:48:33 -0700 (PDT)
In-Reply-To: <873abbeoqc.wl%vmayatsk@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119198>

On Mon, May 11, 2009 at 9:46 AM, Vitaly Mayatskikh
<v.mayatskih@gmail.com> wrote:
> Currently git-send-email sends all mbox in one email. This seems to be wrong,
> because mbox can contain several messages. For example,
> `git format-patch --stdout' forms mbox file with all patches in it.

Just out of curiosity, what is the motivation for this patch?

By default, format-patch generates a file per commit, which is what
send-email currently expects. You can also specify one or more commits
to send-email directly, in which case it runs format-patch on your
behalf. And, send-email cannot handle messages on stdin, so "git
format-patch | git send-email" is not a valid workflow, even after
this patch.

So the only way I can see this being useful is if you're doing something like:

$ git format-patch --stdout > mbox
$ git send-email mbox

Or you can combine those in bash with:

$ git send-email <(git format-patch --stdout)

But, why? The only way this patch would make any sense to me is if it
_also_ extended send-email to read its messages from stdin.

j.
