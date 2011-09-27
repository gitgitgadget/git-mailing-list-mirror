From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Re: [PATCH] Docs: git checkout --orphan: `root commit' and
 `branch head'
Date: Tue, 27 Sep 2011 23:28:14 +0000
Message-ID: <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley> <20110927214213.GC5176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 28 01:28:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8h4z-0007QO-RI
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 01:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab1I0X2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 19:28:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52628 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1I0X2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 19:28:44 -0400
Received: by iaqq3 with SMTP id q3so6239945iaq.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IHvLCzizxYYKm+foCxgl/KczThEPFw3TPhq/YHZw224=;
        b=SDlrWtzIg5Fc5Eb+3q9I1iX03RNjUhUJ3yCg7tTAVt1OqVSgsuCHXxzFrNjHD86jOU
         3eMDf1F0TzG6nVR83V3KaEVkLJL8/7A2jTU1FmZAbYKjBiCNPTF7eRzElTUvz0sfmCq1
         tMDL5/Cq8md1i4r/si35qqfDI0ZVHYKadNd/c=
Received: by 10.42.18.74 with SMTP id w10mr6885583ica.164.1317166124111; Tue,
 27 Sep 2011 16:28:44 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Tue, 27 Sep 2011 16:28:14 -0700 (PDT)
In-Reply-To: <20110927214213.GC5176@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182274>

On Tue, Sep 27, 2011 at 21:42, Jeff King <peff@peff.net> wrote:

> Keep in mind that making it part of commit is potentially much more
> dangerous. With "checkout --orphan", you are making a _new_ branch that
> has no parents. Committing on it will make a disconnected history, but
> your original branch is still there.
>
> With "git commit --no-parent", you are disconnecting history on the
> _current_ branch. Which means you are throwing away the old history
> completely. I.e., it is about as dangerous as "git branch -d", which we
> usually protect with a "force" flag[1].

If I might be a bit more pedantic:

  With "checkout --orphan", you are setting up a new branch head
  to point to an as-yet-to-exist commit that will have no parents.
  Your original branch head is not changed.

  With "git commit --no-parent", you would be altering the current
  branch head, which means you are potentially leaving as a dangling
  commit the commit to which that branch head originally pointed.
  I.e., it is about as dangerous as "git reset --hard <new_root_commit>",
  something for which we do NOT provide any protection.

For instance, what if I want the current branch head to point to that
new root commit? The existing solution requires juggling branch names;
why can't git just do what I tell it to do (as with "git reset")?
After all, "git commit --no-parent" is pretty name explicit.
