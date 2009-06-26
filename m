From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-export: Add a --tag-of-filtered-object option for 
	newly dangling tags
Date: Thu, 25 Jun 2009 22:45:13 -0600
Message-ID: <51419b2c0906252145pe174d1diddee9ed81413af74@mail.gmail.com>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
	 <1245676001-14734-5-git-send-email-newren@gmail.com>
	 <7vd48wazhu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusmabite@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 06:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3Jf-0001vm-3j
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZFZEpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 00:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbZFZEpN
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:45:13 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:25864 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZFZEpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 00:45:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so371349and.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AEVXeDjG/Il1/yCntSkwew5LEUKATSVKCXNMkjanilE=;
        b=PzhI0gEfPSHaZQDwH4stAohHtI77HcSTn/sj/dIoILlaFYQmK1Yo1NsHSQmYiPZETR
         KC63RjAy7cVCaJE0QzCQey2j2YFclRaiY65/DqIhQOioYV3AhfhH3LS+ZlH4lIaoFrta
         ulxPT30uFEaiXBvFf+XmtgjCcea1mosjMoBIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gM5FkciOtSmcrWoypHLBvC5p0KI6w/hiv2WFkD3vnHJv+Opkk16vwCqUGbvTfTb/Ae
         G3IFADIAhR4gvcNaJ9mVhwcqDXwTdOUzr9LAlCh9OGSh5ZPSMY3SF4CYJP8z/zdoIip7
         1rA3rl9GH2LC7GbA/mIBJYokbskoi7QhJXwFc=
Received: by 10.101.71.3 with SMTP id y3mr4465960ank.62.1245991513547; Thu, 25 
	Jun 2009 21:45:13 -0700 (PDT)
In-Reply-To: <7vd48wazhu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122267>

Hi,

Thanks for the detailed feedback and suggestions.  I'll send a new
patch series shortly, which I believe addresses all your suggestions
and requests (and opens up a new issue), but there is one item in
particular I wanted to respond to...

On Mon, Jun 22, 2009 at 12:34 PM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Also, are you absolutely sure that your revs is always limited at thi=
s
> point? =C2=A0Otherwise, the parents of this commit are queued in rev-=
>list,
> expecting somebody else to later pick them up and further process, bu=
t
> there is nobody who does that in your codepath as far as I can see. =C2=
=A0What
> will happen to these parent commits?

revs was not limited, but should have been.  Inside setup_revisions,
revs->limited is set if revs->topo_order is, but unfortunately we
weren't setting revs->topo_order until after the call to
setup_revisions.  So, as you suggest, my code caused the parents of
the rewritten commit to needlessly get queued up and left around, with
no one to process them.  Oops.


Elijah
