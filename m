From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 01:47:54 -0500
Message-ID: <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	 <20071205.204848.227521641.davem@davemloft.net>
	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	 <1196918132.10408.85.camel@brick>
	 <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Harvey Harrison" <harvey.harrison@gmail.com>,
	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Daniel Berlin" <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AWt-0003Rj-UM
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbXLFGr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbXLFGrz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:47:55 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:64959 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbXLFGrz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:47:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so264628wah
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 22:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c6DVAxuVRu/oeueRi7bolVurB86ORMebV7yFgb0C+Zs=;
        b=qNNfXohHgXKcoTfQCqg6jeA6koEZsqUub3vi9yVTp1Elrhaa0LNhJbOcdsIYAu8WJwcBxSHmCEaC9F8BQgrD3Om7QAWCaEKOdHBQwx8fLq27jKSR8gK8Jdb2vMLlOGld1bbF7MWB3ScxwCOC/PEj/9kIUkP02ictkFTD4bLsB3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bh6eOmbiMatmVHt07xIhevw2ugH9hHd3dNqPrhjPfV5Kbq23AcKKQXpHKRn7EtOYrhD1ccKSt9QVReJj/AgDS1I0XGmIjVGRJSjpd+60IpULp7549BV/wg2fOs5HQwfcwSispD/wO5ult8kBvYOPMav2q+ZvKRDnvW+exuRrILY=
Received: by 10.114.73.1 with SMTP id v1mr510151waa.1196923674468;
        Wed, 05 Dec 2007 22:47:54 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Wed, 5 Dec 2007 22:47:54 -0800 (PST)
In-Reply-To: <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67261>

On 12/6/07, Daniel Berlin <dberlin@dberlin.org> wrote:
> > While you won't get the git svn metadata if you clone the infradead
> > repo, it can be recreated on the fly by git svn if you want to start
> > commiting directly to gcc svn.
> >
> I will give this a try :)

Back when I was working on the Mozilla repository we were able to
convert the full 4GB CVS repository complete with all history into a
450MB pack file. That work is where the git-fastimport tool came from.
But it took a month of messing with the import tools to achieve this
and Mozilla still chose another VCS (mainly because of poor Windows
support in git).

Like Linus says, this type of command will yield the smallest pack file:
 git repack -a -d --depth=250 --window=250

I do agree that importing multi-gigabyte repositories is not a daily
occurrence nor a turn-key operation. There are significant issues when
translating from one VCS to another. The lack of global branch
tracking in CVS causes extreme problems on import. Hand editing of CVS
files also caused endless trouble.

The key to converting repositories of this size is RAM. 4GB minimum,
more would be better. git-repack is not multi-threaded. There were a
few attempts at making it multi-threaded but none were too successful.
If I remember right, with loads of RAM, a repack on a 450MB repository
was taking about five hours on a 2.8Ghz Core2. But this is something
you only have to do once for the import. Later repacks will reuse the
original deltas.

-- 
Jon Smirl
jonsmirl@gmail.com
