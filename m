From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 23 Jul 2008 04:14:45 +0400
Message-ID: <20080723001445.GO2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <20080722231153.GN2925@dpotapov.dyndns.org> <alpine.DEB.1.00.0807230019480.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLS1J-0005gK-JP
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbYGWAOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754552AbYGWAOx
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:14:53 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:35710 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbYGWAOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:14:52 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1504464fkq.5
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=udn0aoD5kabuQN+wc9Q+966E7Y6LeuK8FswcLpkG2fo=;
        b=qPu+C7xWCK/IGnUpjzl4TIl3GqO2Gf3HEkA614smjmyUCVwvR68gdZUh8+rGBlvLvs
         skwvR9kqbZXkm6mz302zjnrliaqUOY5BGNspxYnrrZfNYui8XqRSv30Ibm4lyxwcC3o/
         ZOlMkF1EfutFdyWIyHNAPiV8QQiDul2OxrU6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Kjf7FBtRbWcR+dteqAIHRNZSxaDyCEOfpbpwK+/Mi1KIA1tWowtnU6vTh1ofSF0Dq3
         SPg72WLzJBA3rqefyO08f8TgMY0HkrMR2u8xq5XDkshcqjnzGDY3AUIk0IkC/Mi/VP/F
         wl7kMNQtxQZT6eNIMr9xvCLhu+W/mH6ezNbkQ=
Received: by 10.181.14.13 with SMTP id r13mr3110751bki.23.1216772089280;
        Tue, 22 Jul 2008 17:14:49 -0700 (PDT)
Received: from localhost ( [85.140.170.138])
        by mx.google.com with ESMTPS id 22sm18830857fkr.4.2008.07.22.17.14.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jul 2008 17:14:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807230019480.8986@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89576>

On Wed, Jul 23, 2008 at 12:23:27AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 23 Jul 2008, Dmitry Potapov wrote:
> 
> > On Tue, Jul 22, 2008 at 10:56:04PM +0100, Johannes Schindelin wrote:
> > > 
> > > When a file's crlf attribute is explicitely set, it does not make 
> > > sense to ignore it, just because the config variable core.autocrlf has 
> > > not been set.
> > 
> > Hmm... About a week ago, I was about to propose the same change, but 
> > after reading documentation and some thinking I was not able to convince 
> > myself that this change would be the right thing to do.
> 
> Well, I have a shared repository, where I set the attribute.  Now, every 
> once in a while, people check in text _with_ CR/LF.  Yes, that is right, I 
> marked it explicitely as crlf, yet I am on the whim of the people choosing 
> to set the config variable or not.
> 
> And I could not care less what the documentation says: if it does not make 
> sense, it does not make sense.

If you think that the current documentation does not make sense, why
don't you write something that will make sense? Really, the current
behavior may not be the best one, but at least it is consistent with
documentation, while your change may confuse users, because they may
expect one behavior, but git will act differently.

If I understand your change correctly, you take into account the crlf
attribute unconditionally only in worktree-to-git conversion, while you
still ignore it if core.autocrlf=false on checkout. Is it correct?  If
so, I think your patch does make sense, and it should not break anything
too badly, because you still respect core.autocrlf on checkout, but you
should have said that in your commit message.

Dmitry
