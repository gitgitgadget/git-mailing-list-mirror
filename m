From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 22:11:35 +0100
Message-ID: <efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 
	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Christian Couder <chriscool@tuxfamily.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 27 23:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9QPr-0006cu-PL
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 23:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbZE0VL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 17:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbZE0VLz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 17:11:55 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:59745 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbZE0VLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 17:11:55 -0400
Received: by ewy24 with SMTP id 24so4711532ewy.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=C2BQTu944G5bnfJhXr1i7bjb44DFpg2Z9tSh4YzdKp4=;
        b=AMdn+86jcdzJP/O/Z+wYD3/YnDzuC/xK00DBReAsNo0nYGbAq+OPmWOpoQWgP0p/tk
         nvgK+Ptjt/Ub+NmVicS7/BLmPN3Awp6pN3eE+Ew4KAU3CNbJf7bPbFXh5yrSZXFWQtAV
         a7VsFARNEVlWs+zSup0jYXF/Orbq8HzZ7D5vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=t3ddKVM/pwG12xYRj6cB659Fwn6OnuqhI170CbLpclOL4UtGjA/JSjukYSpkomtbCv
         ouikKBt61X7mYdr/ouO5ZKcX8v6GhdT0AwTAuhF0MiunyC0eLBITev5VHAAchCIuJ5wx
         O58BJ5YU3R1uQ1QK4x9J4+w+UinVBtyoYpnuI=
Received: by 10.216.72.207 with SMTP id t57mr175620wed.158.1243458715144; Wed, 
	27 May 2009 14:11:55 -0700 (PDT)
In-Reply-To: <200905270726.59883.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120107>

>> Sam Vilain wrote:
>> > Oh, yes.  And another thing: 'git bisect run' / 'git bisect skip'
>> > doesn't do a very good job of skipping around broken commits (ie when
>> > the script returns 126).  It just seems to move to the next one; it
>> > would be much better IMHO to first try the commit 1/3rd of the way into
>> > the range, then if that fails, the commit 2/3rd of the way through it,
>> > etc.

As I understand it, the idea is that the probability that a commit is
broken is greater if it is close in the DAG to a known-broken commit.
I wonder if this can be made more concrete? Can we derive a formula
for, or collect empriical data on, these probabilities?

The reason I ask is that I am wondering how this feature might be
implemented in bbchop
(http://github.com/Ealdwulf/bbchop/tree/master) which is an extension
of git-bisect
to the case where the bug is intermittent. It works by calculating the
probability that the
bug was introduced at each commit, and asking about that commit which
has the largest
expected information gain. Currently if there is a skip I just set the
probability
for that commit to zero, so the algorithm is likely to ask next about
an adjacent one,
just as in git-bisect. A natural way to extend bbchop to this use case
would be for
the information gain calculation to take into account the probability
that a commit is broken.

So I would need some plausible way of calculating that probability. It
is not immediately
obvious to me what that would be, or what assumptions would be useful.

Ealdwulf
