From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Fri, 4 Dec 2015 08:52:46 +0100
Message-ID: <CACsJy8Bhz3hqTSnjGgpjLugpt1+87xuYGECU5V6ZKqO+tpWTww@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net> <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <xmqqio4j8iit.fsf@gitster.mtv.corp.google.com> <CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
 <CACsJy8CFCu4casNn25b1YPkV==-8kDy3wzYd5uf794R41M0Y9w@mail.gmail.com>
 <xmqqegf57sfe.fsf@gitster.mtv.corp.google.com> <xmqq7fkx7qsa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 08:53:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4lBS-0006Nz-J6
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 08:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbbLDHxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 02:53:18 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34889 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbLDHxR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 02:53:17 -0500
Received: by lfdl133 with SMTP id l133so106064017lfd.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 23:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=opIc4eOYOQ20GXcPGyopy87o+fTPjDRNEEu8otiXtUg=;
        b=T1F+qvb7gk9TdZUYjJ1EVOX1vpcSrMKoM0+UbQ09suPMaeY33l8yd/3ToNvPeEOBuY
         teyUOvUMCkqhjwMlpR0yLLTOBzQWYrMLO4s7MUhlB8/aQiQhxtxD2PvmW4djtxlO9v2m
         WLE+KYj5mPD3IbADvmkOySbl8I+zZRxR2rIqIqfGWLZe2dBdouCXlQm6RDihbalNddqL
         i4Vxh1JRVuPEkxAvogv5WozWL82OadGCQY7wKEU2i73leX4rS2I4SUBIENzuWo9YZeyT
         SxfnsOElpxQuoa0+09oIhxSgBzGcM0Hu5Ai2ZfOIldU6mo6bNgkoJhPEOpcyqsi2wDWM
         03CQ==
X-Received: by 10.25.137.84 with SMTP id l81mr7343920lfd.45.1449215596158;
 Thu, 03 Dec 2015 23:53:16 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 3 Dec 2015 23:52:46 -0800 (PST)
In-Reply-To: <xmqq7fkx7qsa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281978>

On Tue, Dec 1, 2015 at 11:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As to ${sign}, I was tempted to say an empty string might be
> sufficient (i.e. "do not use 40-hex as your branch name"), but it
> probably is a bad idea.  A single dot "." would be a possibility
> (i.e. a ref component cannot begin with a dot), but squating on it
> and saying "anything that begins with . must be followed by 40-hex
> (and in the future by an extended SHA-1)" would rob extensibility
> from us, so perhaps ".@c78f7b5ed9dc1c6edc8db06ac65860151d54fd07" or
> something?  That is leading "." denotes "this is an extended refspec"
> and the next character denotes what kind of extended refspec it is.
> For now we say that "@" denotes "exact object name is used instead
> of a(n abbreviated) refname".

How about @{something}? "something" could be "sha1" (or even
rev-parse). It's not as cryptic, gives plenty of room for extension,
and (to me) immediately connects to extended sha-1 syntax. Yeah we
don't support _extended_ syntax right away, but in future I think we
should. We can decide on a quick shortcut syntax later.
-- 
Duy
