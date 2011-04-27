From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh
 portability
Date: Wed, 27 Apr 2011 04:11:40 -0500
Message-ID: <20110427091140.GB14849@elie>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
 <20110427013534.GA14286@elie>
 <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
 <20110427064033.GB4226@elie>
 <BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:11:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0mm-0008CB-TY
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab1D0JLr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 05:11:47 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60464 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494Ab1D0JLq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 05:11:46 -0400
Received: by iyb14 with SMTP id 14so1194046iyb.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5Q8LrYTOsV0VOT6cPpd3ooYjqc4Lj1gAGMdxiOrSRR0=;
        b=NSvEe58k0gVHArYhTV+fFa1Wdc/PJfSZF87RRBtMJ8hPc9zrjVEanN0TMzvrXEbqwx
         wTav+1f2j2Ih7ISYiDeIguuxIexphP7xKyngPkGFJWbW607fK4HzKrFiz6Ipm30EshRN
         aECAhn/ht2Y2I42QQiG0sXMA0WkdmleXlUjrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Kl6DNdRMZVpJ35ogN1OJRjDJXY2PHl7gS5m2OJOwebwGfaAP3Q8Nq6T3bzhGMJtZc/
         2tmjRcWTQd/YXqs/LGkoq2HeKPPmhbcfiSYkFVrcbDYZUuNTXCLH8O2UOgnAqGqfacSt
         NJojrDyWGj4QpIwuU29gna3WC+VDPhm7YnACk=
Received: by 10.43.58.148 with SMTP id wk20mr2495530icb.242.1303895506006;
        Wed, 27 Apr 2011 02:11:46 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.ameritech.net [68.255.96.190])
        by mx.google.com with ESMTPS id a8sm259366ibg.14.2011.04.27.02.11.43
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 02:11:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172204>

=46elipe Contreras wrote:
> On Wed, Apr 27, 2011 at 9:40 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> Sorry, I got carried away (I am happy to see someone has made some
>> headway in investigating this old bug). =C2=A0How about this?
>
> What's wrong with my patch?

As mentioned at
http://thread.gmane.org/gmane.comp.version-control.git/172142/focus=3D1=
72157
it breaks the tab completion in the common case that the user uses
the standard bash completion library (usually provided at
/etc/bash_completion) and git uses its _get_comp_words_by_ref
function.  You can test like so:

	% bash
	$ . /etc/bash_completion
	$ . contrib/completion/git-completion.bash
	$ git fetch origin <TAB>

I also made a small cosmetic change which is less important (sorry, I
should have mentioned it before): the patch I sent spells out
comp_words instead of writing cwords to avoid a false analogy between
the array of all completion words (cwords) and the current word index
(cword).

>> There is still a "for unknown reasons" in the above explanation.
>
> I'm asking zsh guys:
> http://www.zsh.org/mla/workers/2011/msg00515.html

Thanks.  It looks like to get the semantics I expect from "local"
in zsh, one needs to use "typeset -h" (which bash does not support,
unfortunately).  Probably it is best to steer clear of zsh's special
variables anyway.
