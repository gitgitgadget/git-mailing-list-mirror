From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Sun, 10 Aug 2008 11:16:37 +0200
Message-ID: <2c6b72b30808100216j2c719bf2yb7dfba651db901e3@mail.gmail.com>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
	 <20080604192916.GB17327@sigill.intra.peff.net>
	 <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com>
	 <20080604230858.GA27136@sigill.intra.peff.net>
	 <2c6b72b30808060406u10d7b332g22ea28fe5470ddb1@mail.gmail.com>
	 <20080808211916.GA30583@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jean-Baptiste Quenot" <jbq@caraldi.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 10 11:18:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS74Z-0007zF-8l
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 11:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbYHJJQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 05:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYHJJQl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 05:16:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:26046 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYHJJQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 05:16:40 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1339642fkq.5
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZLyImaaEfdfLj9sQUY9VijGHe0r5O/32bU1MyLvTUYE=;
        b=QwACeb8S+JH+LhnsnmAmbVlTth0bLGVw2WgmRB9ovZcu+nkRvSuMT0bcNeECwzfWuv
         oVruBGRuu7TyFIbdTdfIm8eaEH+IF3/yXOqOs5eRnuzCd8CM+NoEh7kOBHnkuOZkKJ5r
         wstv+svB1ifVVnH0gyKLigniF67ZFElFOHYbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a7xYe7gX5Jrdzf07fJ+CIWxxEZhHSTjBSoLbynzXjnaPKh9y1zRJTPD5Fyc9e2c14T
         KchFutQ8PoPJIwOxyWEFZfuuVG6xX1sdJq2uo2pUWqqfokfziuB4Kfk+P/LL9qjqnHPC
         o6Y6c3xA2+6yY6VuYHltDmixAT4DpAUh3SYGA=
Received: by 10.180.217.1 with SMTP id p1mr1203198bkg.80.1218359797587;
        Sun, 10 Aug 2008 02:16:37 -0700 (PDT)
Received: by 10.125.73.6 with HTTP; Sun, 10 Aug 2008 02:16:37 -0700 (PDT)
In-Reply-To: <20080808211916.GA30583@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91824>

On Fri, Aug 8, 2008 at 23:19, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 06, 2008 at 01:06:51PM +0200, Jonas Fonseca wrote:
>> I actually added something that let's you alter the command executed
>> for each view. So here is another possibility that can be used:
>>
>> function tignowalk ()
>> {
>>    tmp=$(mktemp) # or .git/tigfiles or similar
>>    # Safe stuff from "stdin" and run tig with custom rev-list command
>>    cat > "$tmp
>>    TIG_MAIN_CMD="git rev-list --pretty=raw --no-walk --stdin < $tmp"
>> tig < /dev/tty
>>    rm "$tmp"
>> }
>
> Neat, if a bit hack-ish. :) You are missing a closing quotation mark
> after
>
>  cat > "$tmp
>
> and the line break between TIG_MAIN_CMD and tig is obviously problematic
> (presumably an artifact of the email, but it confused my cut and paste
> efforts for a minute). One other thing to note is that even though you
> try to handle a $tmp with whitespace in the cat and rm commands, I
> suspect it would fail when tig hands TIG_MAIN_CMD to the shell. That
> would require double-quoting.

Yes, this way to "hook" into tig is a bit hackish and gives some
problems with handling files. But then again, it is hidden away in
env. variables, which seems very effective in not getting it too
exposed. :)

> So here is my cut-and-pastable version:
>
>  tignowalk() {
>    tmp=$(mktemp)
>    cat >"$tmp"
>    TIG_MAIN_CMD="git rev-list --pretty=raw --no-walk --stdin <$tmp" \
>      tig </dev/tty
>    rm "$tmp"
>  }

Thanks for the fixed up version.

-- 
Jonas Fonseca
