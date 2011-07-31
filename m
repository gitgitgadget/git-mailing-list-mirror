From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: Automatically identifying the "split" point of a merged branch.
Date: Sat, 30 Jul 2011 23:08:25 -0700
Message-ID: <CAOTq_psXsjipBxcG+86bQvPwQj866iAf_c9nQJ=KvjCjYHtySg@mail.gmail.com>
References: <CAOTq_ptov+6ixvyVvK3iuDp4L-=9PtKES14O93kL9n6hUz0JHA@mail.gmail.com>
	<20110731055310.GA14384@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 31 08:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnPLB-0007rl-NV
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 08:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab1GaGI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 02:08:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59576 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab1GaGI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 02:08:26 -0400
Received: by gwaa12 with SMTP id a12so1030132gwa.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 23:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aNYTrwMcnjAc6y+QwyVH6g4ezslE7q24WNIJXzDTSzI=;
        b=VAkFVz2vonp5fNwI/18BSFGJ/0MfGD8HiNCGmm0Yn13R3OK4kzl2zmwymPW9yqgYyO
         BvqbpNvPkwe5jR24biTp4vEP7kivGmGvxsRgQs7eD1wKiFeP4vVDjXBGROx/Jc8c86Cv
         eCucKLsg5rPwVUlxANi3avFsx0AXa2NWKz3hw=
Received: by 10.236.190.98 with SMTP id d62mr1842095yhn.167.1312092506024;
 Sat, 30 Jul 2011 23:08:26 -0700 (PDT)
Received: by 10.236.109.131 with HTTP; Sat, 30 Jul 2011 23:08:25 -0700 (PDT)
In-Reply-To: <20110731055310.GA14384@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178229>

On Sat, Jul 30, 2011 at 10:53 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jul 30, 2011 at 05:54:59PM -0700, Conrad Irwin wrote:
>
> If you know M, then B is the merge-base of M^1 and M^2 (i.e., the
> parents of M). If you don't know M, but do know D, you can find it by
> walking backwards from "integration" until you find a merge commit with
> D as its second parent (e.g., by grepping "rev-list --parents").
>
> Make sense?

Yup. git rev-list was definitely the tool I was missing, thank you :).

Conrad

merge=$(git rev-list --parents integration |\
                 grep " $(git rev-parse topic)" | cut -d' ' -f 1)
split=$(git merge-base $merge^ $merge^2)
git rebase --onto master $split
git checkout master
git merge --no-ff topic
