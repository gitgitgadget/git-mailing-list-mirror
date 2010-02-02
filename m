From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 16:56:30 -0500
Message-ID: <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 22:56:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQjc-000230-3p
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab0BBV4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 16:56:31 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:58728 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab0BBV4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 16:56:31 -0500
Received: by iwn39 with SMTP id 39so711924iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 13:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=igk+aDWA6rgAeo9bF9382hAkMP/0idw4C/wyLGNgTGs=;
        b=SWzAo5XO23SaQNy5USUUDl+CykW8ceWsooL7M0v75P3m3vtXA/pv4BfPS7BgKFBklO
         iQzrznoez4R2nhDbUX4jP1z3y9V5ltq9MFJDgxgJCkwTFZUIwqLaS1vmehyuMUPX597U
         AyeQFNP0VhV8VMtLW+4v9C3ZCib97lVsqVq0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XfYqrDrq/yNCh6jPDSC9MgOiBWNU7Ygn+61DjRgNpT2ZRBggYcy7X0ru7EIl629U4Z
         iNpMqlZDI1ticX4/BHnfoXykYIyi0/aAin5NJqBAMpbAI7w38pWuBd/5Qo6QSCphUBv2
         I/1jzNHLvsxqBRsC8mOh4Hojx1Y3kbvxthoF4=
Received: by 10.231.146.74 with SMTP id g10mr2908114ibv.98.1265147790193; Tue, 
	02 Feb 2010 13:56:30 -0800 (PST)
In-Reply-To: <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138763>

>
> As has already been pointed out, an extremely common workflow for "gi=
t
> commit --amend" is to include additional changes that were accidental=
ly
> overlooked =C2=A0in the initial commit, and no changes are made to th=
e commit
> message.
>
> Changing the behavior would break that perfectly reasonable,
> widely-practised workflow, and _that_ would be 100% not ok.

I'm not against that workflow - I'm not forcing anybody to change the
commit message. The thing I'm talking about is roughly that it should
NOT treat the result of command ":q" the same way as the command
":wq".

=46or example IF there is a variable somewhere where message is stored:
=46or new commit message it is NULL and when commit is ready it is set
up to "message". We check If it is not empty and not NULL (:wq
executed),  then we can commit.
=46or "prepopulated" messages this variable can be is set to "message"
from the beginning, so it doesn't matter if you're writing changes or
not the check will always be true, so we can commit.
If the implementation would be like this, then I would propose to
clean up this variable after the prepopulated message is populated, so
it won't use it blindly, but only after you're overwriting the message
(even if the message is not changed).
